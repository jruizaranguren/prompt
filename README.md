# prompt
ChatGPT Prompt Engineering for Developers by Deeplearning Course Tests

Course can be found here: https://www.deeplearning.ai/short-courses/chatgpt-prompt-engineering-for-developers/

Resource to launch notebook: https://mybinder.org/

## Running the code

You will need a working version of `direnv`. A script is provided and compatibility tested for Ubuntu 20 and 22:

```bash
source setup_direnv.sh
```

Then, create the virtual environment through:

```bash
make setup
```

In order to test the notebooks, you need to set the following environment variable:

```bash
OPENAI_API_KEY=<your key>
```

## Summary

* Write clear and specific instructions
    * Use delimiters to clearly indicate distinct parts of the input
    * Look for structure output
    * Ask the model to check whether conditions are satisfied
    * Provide some samples to guide the model
* Give the model time to think
    * Specify the steps required to complete a task
    * Instruct the model to work out its own solution before rushing to a conclusion
* Beware model limits:
    * hallucinations
    * it tend to lose the critical thinking parts
* Use an iterative process
* When summarizing try to hint:
    * number of work/sentence/character limits
    * intended audience
    * the desired tone
    * extract instead of summarize
