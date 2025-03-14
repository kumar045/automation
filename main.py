import os
import asyncio
from fastapi import FastAPI
from pydantic import BaseModel
from langchain_google_genai import ChatGoogleGenerativeAI
from browser_use import Agent
from dotenv import load_dotenv

load_dotenv()

app = FastAPI()

llm = ChatGoogleGenerativeAI(
    model="gemini-1.5-pro",
    temperature=0,
    max_tokens=None,
    timeout=None,
    max_retries=2,
)

class TaskRequest(BaseModel):
    task: str

async def run_agent(task: str):
    agent = Agent(task=task, llm=llm)
    return await agent.run()

@app.post("/run-task/")
async def run_task(request: TaskRequest):
    result = await run_agent(request.task)
    return {"task": request.task, "result": result}
  
