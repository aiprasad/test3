#import all the required libraries
import torch
from flask import Flask, render_template, request
from instruct_pipeline import InstructionTextGenerationPipeline
from transformers import AutoTokenizer, AutoModelForCausalLM

app = Flask(__name__)

#initialize tokenizer and model
tokenizer = AutoTokenizer.from_pretrained("databricks/dolly-v2-3b", padding_side="left")
model = AutoModelForCausalLM.from_pretrained("databricks/dolly-v2-3b", device_map="auto", torch_dtype=torch.bfloat16)

#create a text generation pipeline
generate_text = InstructionTextGenerationPipeline(model=model, tokenizer=tokenizer)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/generate')
def generate():
    #prompt from the request arguments
    prompt = request.args.get('prompt')
    if not prompt:
        return render_template('index.html')
    #generates text based on the prompt
    generated_text = generate_text(prompt)
    return render_template('index.html', prompt=prompt, generated_text=generated_text)

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=80)





