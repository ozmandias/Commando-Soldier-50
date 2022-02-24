function wait(seconds)
    starttime = os.time()
    repeat until os.time() > starttime+seconds
end