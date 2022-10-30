from typing import List


class Object:
    def __init__(self, n: str, w: float, v: float) -> None:
        self.n = n
        self.w = w
        self.v = v


objects = [
    Object(n='Centenarios', w=2.5, v=750000.00),
    Object(n='Billetes de 1k', w=1.0, v=500000.00),
    Object(n='Joyero gde', w=6.0, v=2750000.00),
    Object(n='Joyero ch', w=2.5, v=950000.00),
    Object(n='Estampillas', w=1.5, v=1850000.00),
    Object(n='Obra de arte', w=3.0, v=3250000.00),
    Object(n='Pisapapeles', w=5.0, v=3950000.00),
]

max_w = 10.0
objects_count = len(objects)


def knapsack(X: List) -> float:
    vSum = sum([X[index] * objects[index].v for index in range(objects_count)])
    wSum = sum([X[index] * objects[index].w for index in range(objects_count)])
    return vSum if wSum < max_w else 0
