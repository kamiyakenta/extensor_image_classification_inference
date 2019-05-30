{application,extensor,
             [{applications,[kernel,stdlib,elixir,protobuf,google_protos]},
              {description,"Tensorflow bindings for inference in Elixir.\n"},
              {modules,['Elixir.Extensor.NIF','Elixir.Extensor.Session',
                        'Elixir.Extensor.Tensor',
                        'Elixir.Tensorflow.AllocationDescription',
                        'Elixir.Tensorflow.AllocationRecord',
                        'Elixir.Tensorflow.AllocatorMemoryUsed',
                        'Elixir.Tensorflow.ApiDef',
                        'Elixir.Tensorflow.ApiDef.Arg',
                        'Elixir.Tensorflow.ApiDef.Attr',
                        'Elixir.Tensorflow.ApiDef.Endpoint',
                        'Elixir.Tensorflow.ApiDef.Visibility',
                        'Elixir.Tensorflow.ApiDefs',
                        'Elixir.Tensorflow.AssetFileDef',
                        'Elixir.Tensorflow.AttrValue',
                        'Elixir.Tensorflow.AttrValue.ListValue',
                        'Elixir.Tensorflow.AutoParallelOptions',
                        'Elixir.Tensorflow.BundleEntryProto',
                        'Elixir.Tensorflow.BundleHeaderProto',
                        'Elixir.Tensorflow.BundleHeaderProto.Endianness',
                        'Elixir.Tensorflow.CallableOptions',
                        'Elixir.Tensorflow.CheckpointableObjectGraph',
                        'Elixir.Tensorflow.CheckpointableObjectGraph.CheckpointableObject',
                        'Elixir.Tensorflow.CheckpointableObjectGraph.CheckpointableObject.ObjectReference',
                        'Elixir.Tensorflow.CheckpointableObjectGraph.CheckpointableObject.SerializedTensor',
                        'Elixir.Tensorflow.CheckpointableObjectGraph.CheckpointableObject.SlotVariableReference',
                        'Elixir.Tensorflow.CleanupAllRequest',
                        'Elixir.Tensorflow.CleanupAllResponse',
                        'Elixir.Tensorflow.CleanupGraphRequest',
                        'Elixir.Tensorflow.CleanupGraphResponse',
                        'Elixir.Tensorflow.CloseSessionRequest',
                        'Elixir.Tensorflow.CloseSessionResponse',
                        'Elixir.Tensorflow.ClusterDef',
                        'Elixir.Tensorflow.CollectionDef',
                        'Elixir.Tensorflow.CollectionDef.AnyList',
                        'Elixir.Tensorflow.CollectionDef.BytesList',
                        'Elixir.Tensorflow.CollectionDef.FloatList',
                        'Elixir.Tensorflow.CollectionDef.Int64List',
                        'Elixir.Tensorflow.CollectionDef.NodeList',
                        'Elixir.Tensorflow.CompleteGroupRequest',
                        'Elixir.Tensorflow.CompleteGroupResponse',
                        'Elixir.Tensorflow.CompleteInstanceRequest',
                        'Elixir.Tensorflow.CompleteInstanceResponse',
                        'Elixir.Tensorflow.CondContextDef',
                        'Elixir.Tensorflow.ConfigProto',
                        'Elixir.Tensorflow.ConfigProto.DeviceCountEntry',
                        'Elixir.Tensorflow.ConfigProto.Experimental',
                        'Elixir.Tensorflow.ControlFlowContextDef',
                        'Elixir.Tensorflow.CostGraphDef',
                        'Elixir.Tensorflow.CostGraphDef.Node',
                        'Elixir.Tensorflow.CostGraphDef.Node.InputInfo',
                        'Elixir.Tensorflow.CostGraphDef.Node.OutputInfo',
                        'Elixir.Tensorflow.CreateSessionRequest',
                        'Elixir.Tensorflow.CreateSessionResponse',
                        'Elixir.Tensorflow.CreateWorkerSessionRequest',
                        'Elixir.Tensorflow.CreateWorkerSessionResponse',
                        'Elixir.Tensorflow.CriticalSectionDef',
                        'Elixir.Tensorflow.CriticalSectionExecutionDef',
                        'Elixir.Tensorflow.DataType',
                        'Elixir.Tensorflow.DebugOptions',
                        'Elixir.Tensorflow.DebugTensorWatch',
                        'Elixir.Tensorflow.DebuggedSourceFile',
                        'Elixir.Tensorflow.DebuggedSourceFiles',
                        'Elixir.Tensorflow.DeleteWorkerSessionRequest',
                        'Elixir.Tensorflow.DeleteWorkerSessionResponse',
                        'Elixir.Tensorflow.DeregisterGraphRequest',
                        'Elixir.Tensorflow.DeregisterGraphResponse',
                        'Elixir.Tensorflow.DeviceAttributes',
                        'Elixir.Tensorflow.DeviceLocality',
                        'Elixir.Tensorflow.DeviceProperties',
                        'Elixir.Tensorflow.DeviceProperties.EnvironmentEntry',
                        'Elixir.Tensorflow.DeviceStepStats',
                        'Elixir.Tensorflow.Eager.CloseContextRequest',
                        'Elixir.Tensorflow.Eager.CloseContextResponse',
                        'Elixir.Tensorflow.Eager.CreateContextRequest',
                        'Elixir.Tensorflow.Eager.CreateContextResponse',
                        'Elixir.Tensorflow.Eager.EnqueueRequest',
                        'Elixir.Tensorflow.Eager.EnqueueResponse',
                        'Elixir.Tensorflow.Eager.KeepAliveRequest',
                        'Elixir.Tensorflow.Eager.KeepAliveResponse',
                        'Elixir.Tensorflow.Eager.Operation',
                        'Elixir.Tensorflow.Eager.Operation.AttrsEntry',
                        'Elixir.Tensorflow.Eager.QueueItem',
                        'Elixir.Tensorflow.Eager.RegisterFunctionRequest',
                        'Elixir.Tensorflow.Eager.RegisterFunctionResponse',
                        'Elixir.Tensorflow.Eager.RemoteTensorHandle',
                        'Elixir.Tensorflow.Eager.WaitQueueDoneRequest',
                        'Elixir.Tensorflow.Eager.WaitQueueDoneResponse',
                        'Elixir.Tensorflow.ExecutorOpts',
                        'Elixir.Tensorflow.ExtendSessionRequest',
                        'Elixir.Tensorflow.ExtendSessionResponse',
                        'Elixir.Tensorflow.FunctionDef',
                        'Elixir.Tensorflow.FunctionDef.AttrEntry',
                        'Elixir.Tensorflow.FunctionDef.RetEntry',
                        'Elixir.Tensorflow.FunctionDefLibrary',
                        'Elixir.Tensorflow.GPUOptions',
                        'Elixir.Tensorflow.GPUOptions.Experimental',
                        'Elixir.Tensorflow.GPUOptions.Experimental.VirtualDevices',
                        'Elixir.Tensorflow.GetStatusRequest',
                        'Elixir.Tensorflow.GetStatusResponse',
                        'Elixir.Tensorflow.GetStepSequenceRequest',
                        'Elixir.Tensorflow.GetStepSequenceResponse',
                        'Elixir.Tensorflow.GradientDef',
                        'Elixir.Tensorflow.GraphDef',
                        'Elixir.Tensorflow.GraphOptions',
                        'Elixir.Tensorflow.GraphTransferConstNodeInfo',
                        'Elixir.Tensorflow.GraphTransferGraphInputNodeInfo',
                        'Elixir.Tensorflow.GraphTransferGraphOutputNodeInfo',
                        'Elixir.Tensorflow.GraphTransferInfo',
                        'Elixir.Tensorflow.GraphTransferInfo.Destination',
                        'Elixir.Tensorflow.GraphTransferNodeInfo',
                        'Elixir.Tensorflow.GraphTransferNodeInput',
                        'Elixir.Tensorflow.GraphTransferNodeInputInfo',
                        'Elixir.Tensorflow.GraphTransferNodeOutputInfo',
                        'Elixir.Tensorflow.HistogramProto',
                        'Elixir.Tensorflow.InterconnectLink',
                        'Elixir.Tensorflow.IteratorStateMetadata',
                        'Elixir.Tensorflow.JobDef',
                        'Elixir.Tensorflow.JobDef.TasksEntry',
                        'Elixir.Tensorflow.KernelDef',
                        'Elixir.Tensorflow.KernelDef.AttrConstraint',
                        'Elixir.Tensorflow.LabeledStepStats',
                        'Elixir.Tensorflow.ListDevicesRequest',
                        'Elixir.Tensorflow.ListDevicesResponse',
                        'Elixir.Tensorflow.LocalLinks',
                        'Elixir.Tensorflow.LoggingRequest',
                        'Elixir.Tensorflow.LoggingResponse',
                        'Elixir.Tensorflow.MakeCallableRequest',
                        'Elixir.Tensorflow.MakeCallableResponse',
                        'Elixir.Tensorflow.MemoryLogRawAllocation',
                        'Elixir.Tensorflow.MemoryLogRawDeallocation',
                        'Elixir.Tensorflow.MemoryLogStep',
                        'Elixir.Tensorflow.MemoryLogTensorAllocation',
                        'Elixir.Tensorflow.MemoryLogTensorDeallocation',
                        'Elixir.Tensorflow.MemoryLogTensorOutput',
                        'Elixir.Tensorflow.MemoryStats',
                        'Elixir.Tensorflow.MetaGraphDef',
                        'Elixir.Tensorflow.MetaGraphDef.CollectionDefEntry',
                        'Elixir.Tensorflow.MetaGraphDef.MetaInfoDef',
                        'Elixir.Tensorflow.MetaGraphDef.SignatureDefEntry',
                        'Elixir.Tensorflow.NameAttrList',
                        'Elixir.Tensorflow.NameAttrList.AttrEntry',
                        'Elixir.Tensorflow.NamedDevice',
                        'Elixir.Tensorflow.NamedTensorProto',
                        'Elixir.Tensorflow.NodeDef',
                        'Elixir.Tensorflow.NodeDef.AttrEntry',
                        'Elixir.Tensorflow.NodeExecStats',
                        'Elixir.Tensorflow.NodeOutput',
                        'Elixir.Tensorflow.OpDef',
                        'Elixir.Tensorflow.OpDef.ArgDef',
                        'Elixir.Tensorflow.OpDef.AttrDef',
                        'Elixir.Tensorflow.OpDeprecation',
                        'Elixir.Tensorflow.OpList',
                        'Elixir.Tensorflow.OptimizerOptions',
                        'Elixir.Tensorflow.OptimizerOptions.GlobalJitLevel',
                        'Elixir.Tensorflow.OptimizerOptions.Level',
                        'Elixir.Tensorflow.PartialRunSetupRequest',
                        'Elixir.Tensorflow.PartialRunSetupResponse',
                        'Elixir.Tensorflow.QueueRunnerDef',
                        'Elixir.Tensorflow.RPCOptions',
                        'Elixir.Tensorflow.ReaderBaseState',
                        'Elixir.Tensorflow.RecvBufRequest',
                        'Elixir.Tensorflow.RecvBufRespExtra',
                        'Elixir.Tensorflow.RecvBufResponse',
                        'Elixir.Tensorflow.RecvTensorRequest',
                        'Elixir.Tensorflow.RecvTensorResponse',
                        'Elixir.Tensorflow.RegisterGraphRequest',
                        'Elixir.Tensorflow.RegisterGraphResponse',
                        'Elixir.Tensorflow.ReleaseCallableRequest',
                        'Elixir.Tensorflow.ReleaseCallableResponse',
                        'Elixir.Tensorflow.RemoteFusedGraphExecuteInfo',
                        'Elixir.Tensorflow.RemoteFusedGraphExecuteInfo.TensorShapeTypeProto',
                        'Elixir.Tensorflow.ResetRequest',
                        'Elixir.Tensorflow.ResetResponse',
                        'Elixir.Tensorflow.ResourceHandleProto',
                        'Elixir.Tensorflow.RewriterConfig',
                        'Elixir.Tensorflow.RewriterConfig.CustomGraphOptimizer',
                        'Elixir.Tensorflow.RewriterConfig.CustomGraphOptimizer.ParameterMapEntry',
                        'Elixir.Tensorflow.RewriterConfig.MemOptType',
                        'Elixir.Tensorflow.RewriterConfig.NumIterationsType',
                        'Elixir.Tensorflow.RewriterConfig.Toggle',
                        'Elixir.Tensorflow.RunCallableRequest',
                        'Elixir.Tensorflow.RunCallableResponse',
                        'Elixir.Tensorflow.RunGraphRequest',
                        'Elixir.Tensorflow.RunGraphResponse',
                        'Elixir.Tensorflow.RunMetadata',
                        'Elixir.Tensorflow.RunOptions',
                        'Elixir.Tensorflow.RunOptions.Experimental',
                        'Elixir.Tensorflow.RunOptions.TraceLevel',
                        'Elixir.Tensorflow.RunStepRequest',
                        'Elixir.Tensorflow.RunStepResponse',
                        'Elixir.Tensorflow.SaveSliceInfoDef',
                        'Elixir.Tensorflow.SavedModel',
                        'Elixir.Tensorflow.SaverDef',
                        'Elixir.Tensorflow.SaverDef.CheckpointFormatVersion',
                        'Elixir.Tensorflow.ScopedAllocatorOptions',
                        'Elixir.Tensorflow.ServerDef',
                        'Elixir.Tensorflow.SignatureDef',
                        'Elixir.Tensorflow.SignatureDef.InputsEntry',
                        'Elixir.Tensorflow.SignatureDef.OutputsEntry',
                        'Elixir.Tensorflow.StepSequence',
                        'Elixir.Tensorflow.StepStats',
                        'Elixir.Tensorflow.Summary',
                        'Elixir.Tensorflow.Summary.Audio',
                        'Elixir.Tensorflow.Summary.Image',
                        'Elixir.Tensorflow.Summary.Value',
                        'Elixir.Tensorflow.SummaryDescription',
                        'Elixir.Tensorflow.SummaryMetadata',
                        'Elixir.Tensorflow.SummaryMetadata.PluginData',
                        'Elixir.Tensorflow.TensorConnection',
                        'Elixir.Tensorflow.TensorDescription',
                        'Elixir.Tensorflow.TensorInfo',
                        'Elixir.Tensorflow.TensorInfo.CooSparse',
                        'Elixir.Tensorflow.TensorProto',
                        'Elixir.Tensorflow.TensorShapeProto',
                        'Elixir.Tensorflow.TensorShapeProto.Dim',
                        'Elixir.Tensorflow.TensorSliceProto',
                        'Elixir.Tensorflow.TensorSliceProto.Extent',
                        'Elixir.Tensorflow.ThreadPoolOptionProto',
                        'Elixir.Tensorflow.TraceOpts',
                        'Elixir.Tensorflow.TracingRequest',
                        'Elixir.Tensorflow.TracingResponse',
                        'Elixir.Tensorflow.ValuesDef',
                        'Elixir.Tensorflow.ValuesDef.ExternalValuesEntry',
                        'Elixir.Tensorflow.VariableDef',
                        'Elixir.Tensorflow.VariantTensorDataProto',
                        'Elixir.Tensorflow.VersionDef',
                        'Elixir.Tensorflow.WhileContextDef']},
              {registered,[]},
              {vsn,"0.1.6"}]}.