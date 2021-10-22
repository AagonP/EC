class Receipt(object):
    def __init__(self, amount, is_processed):
        self.amount = amount
        self.is_processed = is_processed

    @staticmethod
    def from_dict(source):
        # ...
        pass

    def to_dict(self):
        # ...
        pass

    def __repr__(self):
        return(
            f'Receipt(\
                amount={self.amount}, \
                is_processed={self.is_processed}, \
            )'
        )