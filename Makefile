.PHONY: all
all: s5tg-02-full.jsonl s5tg-03-full.jsonl s5tg-04-full.jsonl s5tg-05-full.jsonl

.SECONDARY:

s5tg-%-full.jsonl: s5tg-%-repeat.jsonl s5tg-%-tail.jsonl
	cat $^ |  jq -rc '{prb_id, timestamp, stored_timestamp, dst:(.dst_addr + ":" + .dst_port), from, cert_len:(.cert|length), cert:(.cert[0])}' | env LC_ALL=C sort >$@

%-repeat.jsonl : %-repeat-20.jsonl %-repeat-21.jsonl
	cat $^ >$@
%-tail.jsonl : %-tail-20.jsonl %-tail-21.jsonl
	cat $^ >$@

%-20.jsonl:
	./fetch "$@"
%-21.jsonl:
	./fetch "$@"
