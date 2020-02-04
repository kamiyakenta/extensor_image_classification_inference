# ImageclassificationInference
This is a repository for image classification.
When the model is loaded first, it can be used many times in the order of image loading, inference.


## Prepare imageclasiffication model and setup tensorflow for c.
```
./prepare_models.sh
. ./setup_tensorflow.sh
```


## Usage
```
ImageclassificationInference.load_model("path/to/model.pb", "path/to/labels.txt", "path/to/io.json")
#=> :ok

ImageclassificationInference.load_image("giraffe.png")
#=> :ok

ImageclassificationInference.inference()
#=> %{name: "084.giraffe", score: 0.9985604882240295}
```
