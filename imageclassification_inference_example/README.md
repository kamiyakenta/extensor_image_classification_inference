# Imageclassification Inference Example
This is an experimental repository that runs using the [Imageclassification Inference](https://github.com/ghelia/deep-alchemy/imageclassification_inference) library.


## How to Use this Repository

1.Prepare imageclasiffication model and setup tensorflow for c.
> It is written in [README.md](https://github.com/ghelia/deep-alchemy/imageclassification_inference#imageclassificationinference) of ImageclassificationInference.

2.Get dependencies and build.
```
mix deps.get
mix compile
```

3.Run main function.
```
iex -S mix
iex(1)> ImageclassificationInferenceExample.execute_inference()
```
