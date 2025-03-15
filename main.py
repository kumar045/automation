import os
import asyncio
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_groq import ChatGroq
from browser_use import Agent
from dotenv import load_dotenv
import playwright

load_dotenv()

app = FastAPI()

# Enable CORS for all origins (*)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

llm = ChatGoogleGenerativeAI(
    model="gemini-1.5-flash",
    max_retries=5,
)

grog_llm = ChatGroq(
    model_name="deepseek-r1-distill-qwen-32b",
)

planner_llm = ChatGoogleGenerativeAI(
    model="gemini-1.5-flash",
    max_retries=5,
)

class TaskRequest(BaseModel):
    task: str

async def run_agent(task: str):
    agent = Agent(task=task, llm=llm, use_vision=True)
    return await agent.run()

@app.post("/run-task/")
async def run_task(request: TaskRequest):
    result = await run_agent(request.task)
    return {"task": request.task, "result": result}
    
