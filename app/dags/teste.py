from datetime import timedelta, datetime
from airflow import DAG #type: ignore
from airflow.operators.python import PythonOperator #type: ignore
from airflow.utils.dates import days_ago #type: ignore
from airflow.models import Param #type: ignore
from airflow.hooks.base import BaseHook #type: ignore
import datetime as dt

def teste_func():
    print("teste OK!")

default_args = {
    "owner": "JC",
    "retries": 3,
    "retry_delay": timedelta(minutes=1)
}

with DAG(
    dag_id="teste",
    default_args=default_args,
    start_date=datetime(year=2025, month=3, day=19, hour=0),
    schedule_interval="0 12 5 * *",
    dagrun_timeout=timedelta(minutes=15),
    catchup=False,
    max_active_tasks=3

) as dag:     
    


    teste_ = PythonOperator(
        task_id = "carga_da_tabela_tb",
        python_callable=teste_func

        )
        

    
    teste_