Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87F8CD98F6
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 06:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uc01vIZYGfTIV3fdEG67Z2UKVAOKK7e6urfcQoWTPXs=; b=VPKkyFfJPPAEl/BoBcwgde2iIX
	NQwvZr2jji71WQKTJ3uXX4QHovHWZKGp0yyrGa/Je1hkvoCbYkKvXSpCl7UzpWIVRPxpMdxMfov+S
	pvnqgEr+PXu1OQKqlorL/kvlqilmNZ+Tfls8X1s19nTcSU2+cGB5Hb+25aYNBqpDsssidwC2zj4F8
	wjhocHY8k9G4C2Cwg9IsqLc6vvaShCpJWXk2IKnWgzk35ni4hvfb9TZmN4b2UGt7sQ3lm8Kq9KEg3
	am4J04M4eMlU7m7G8M/KtD7sJAX80y3WkQmjPJSLWO5FlMzbRF6U39bOiQUwhkRYQrEX8d8LbNmpk
	p6AXzaTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbXxK-00000004T7V-0TAl;
	Mon, 22 Jun 2026 06:16:26 +0000
Received: from out-172.mta0.migadu.com ([91.218.175.172])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbXxG-00000004T6e-1Jgg
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 06:16:24 +0000
Message-ID: <8c8f1849-86d3-4c69-be27-30bbdffdf616@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782108966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uc01vIZYGfTIV3fdEG67Z2UKVAOKK7e6urfcQoWTPXs=;
	b=t15fr1vSWPqYuOVx1/bxMEqBYsgHtm0lD1qKuOgL6xYl94f+kJLWMkDtNXA1O6oXS4NWrk
	UXfi4I4xGSapixdXs6K5v7yl7QxZTsj0xBO+b54oW8Z9JaKuiK5OobLxhWf+TcWH/AL++5
	EurPaDWOivYCOI4YE0QW4UrJN1dv49Y=
Date: Mon, 22 Jun 2026 14:15:01 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/7] Prepare mutable list iterators to cache cursor
 state
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Paul Moore <paul@paul-moore.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Howells <dhowells@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Randy Dunlap <rdunlap@infradead.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Philipp Stanner <phasta@kernel.org>, linux-block@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 linux-ntfs-dev@lists.sourceforge.net,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 io-uring <io-uring@vger.kernel.org>, audit@vger.kernel.org,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 dri-devel@lists.freedesktop.org,
 "linux-perf-use." <linux-perf-users@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 kexec@lists.infradead.org, live-patching@vger.kernel.org,
 linux-modules@vger.kernel.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Linux Power Management <linux-pm@vger.kernel.org>, rcu@vger.kernel.org,
 sched-ext@lists.linux.dev, linux-mm <linux-mm@kvack.org>,
 virtualization@lists.linux.dev, damon@lists.linux.dev,
 clang-built-linux <llvm@lists.linux.dev>,
 chengkaitao <chengkaitao@kylinos.cn>, Muchun Song <muchun.song@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
 <CAADnVQJmPWFT01b7DuLdtafv=8FyB84GYHNZ8zSTck+9Aw0JpA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <CAADnVQJmPWFT01b7DuLdtafv=8FyB84GYHNZ8zSTck+9Aw0JpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260621_231622_509926_AA7180EC 
X-CRM114-Status: GOOD (  23.71  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



在 2026/6/22 13:28, Alexei Starovoitov 写道:
> On Sun, Jun 21, 2026 at 9:06 PM Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
>>
>> From: chengkaitao <chengkaitao@kylinos.cn>
>>
>> The list_for_each*_safe() helpers are used when the loop body may remove
>> the current entry.  Their current interface, however, forces every caller
>> to define a temporary cursor outside the macro and pass it in, even when
>> the caller never uses that cursor directly.  For most call sites this
>> extra cursor is just boilerplate required by the macro implementation.
>>
>> This is awkward because the saved next pointer is an internal detail of
>> the iteration.  Callers that only remove or move the current entry do not
>> need to spell it out.
>>
>> The _safe() suffix has also caused confusion.  Christian Koenig pointed
>> out that the name is easy to read as a thread-safe variant, especially
>> for beginners, even though it only means that the iterator keeps enough
>> state to tolerate removal of the current entry.  He suggested _mutable()
>> as a clearer description of what the loop permits.
>>
>> Add *_mutable() iterator variants for list, hlist and llist.  The new
>> helpers are variadic and support both forms.  In the common case, the
>> caller omits the temporary cursor and the macro creates a unique internal
>> cursor with typeof(pos) and __UNIQUE_ID().  If a loop really needs an
>> explicit temporary cursor, the caller can still pass it and the helper
>> keeps the existing *_safe() behaviour.
>>
>> For example, a call site may use the shorter form:
>>
>>   list_for_each_entry_mutable(pos, head, member)
>>
>> or keep the explicit temporary cursor form:
>>
>>   list_for_each_entry_mutable(pos, tmp, head, member)
>>
>> The existing *_safe() helpers remain available for compatibility.  This
>> series only converts users in mm, block, kernel, init and io_uring.  If
>> this approach looks acceptable, the remaining users can be converted in
>> follow-up series.
>>
>> Changes in v3 (Christian König, Andy Shevchenko):
>> - Convert safe list walks to mutable iterators
>>
>> Changes in v2 (Muchun Song, Andy Shevchenko):
>> - Drop the list_for_each_entry_mutable*() helpers from v1 and make the
>>   cursor change directly in the existing list_for_each_entry*() helpers.
>> - Open-code special list walks that rely on updating the loop cursor in
>>   the body, preserving their existing traversal semantics.
>>
>> Link to v2:
>> https://lore.kernel.org/all/20260609061347.93688-1-kaitao.cheng@linux.dev/
>>
>> Link to v1:
>> https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev/
>>
>> Kaitao Cheng (7):
>>   list: Add mutable iterator variants
>>   llist: Add mutable iterator variants
>>   mm: Use mutable list iterators
>>   block: Use mutable list iterators
>>   kernel: Use mutable list iterators
>>   initramfs: Use mutable list iterator
>>   io_uring: Use mutable list iterators
>>
>>  block/bfq-iosched.c                 |  17 +-
>>  block/blk-cgroup.c                  |  12 +-
>>  block/blk-flush.c                   |   4 +-
>>  block/blk-iocost.c                  |  18 +-
>>  block/blk-mq.c                      |   8 +-
>>  block/blk-throttle.c                |   4 +-
>>  block/kyber-iosched.c               |   4 +-
>>  block/partitions/ldm.c              |   8 +-
>>  block/sed-opal.c                    |   4 +-
>>  include/linux/list.h                | 269 ++++++++++++++++++++++++----
>>  include/linux/llist.h               |  81 +++++++--
>>  init/initramfs.c                    |   5 +-
>>  io_uring/cancel.c                   |   6 +-
>>  io_uring/poll.c                     |   3 +-
>>  io_uring/rw.c                       |   4 +-
>>  io_uring/timeout.c                  |   8 +-
>>  io_uring/uring_cmd.c                |   3 +-
>>  kernel/audit_tree.c                 |   4 +-
>>  kernel/audit_watch.c                |  16 +-
>>  kernel/auditfilter.c                |   4 +-
>>  kernel/auditsc.c                    |   4 +-
>>  kernel/bpf/arena.c                  |  10 +-
>>  kernel/bpf/arraymap.c               |   8 +-
>>  kernel/bpf/bpf_local_storage.c      |   3 +-
>>  kernel/bpf/bpf_lru_list.c           |  25 ++-
>>  kernel/bpf/btf.c                    |  18 +-
>>  kernel/bpf/cgroup.c                 |   7 +-
>>  kernel/bpf/cpumap.c                 |   4 +-
>>  kernel/bpf/devmap.c                 |  10 +-
>>  kernel/bpf/helpers.c                |   8 +-
>>  kernel/bpf/local_storage.c          |   4 +-
>>  kernel/bpf/memalloc.c               |  16 +-
>>  kernel/bpf/offload.c                |   8 +-
>>  kernel/bpf/states.c                 |   4 +-
>>  kernel/bpf/stream.c                 |   4 +-
>>  kernel/bpf/verifier.c               |   6 +-
>>  kernel/cgroup/cgroup-v1.c           |   4 +-
>>  kernel/cgroup/cgroup.c              |  54 +++---
>>  kernel/cgroup/dmem.c                |  12 +-
>>  kernel/cgroup/rdma.c                |   8 +-
>>  kernel/events/core.c                |  44 +++--
>>  kernel/events/uprobes.c             |  12 +-
>>  kernel/exit.c                       |   8 +-
>>  kernel/fail_function.c              |   4 +-
>>  kernel/gcov/clang.c                 |   4 +-
>>  kernel/irq_work.c                   |   4 +-
>>  kernel/kexec_core.c                 |   4 +-
>>  kernel/kprobes.c                    |  16 +-
>>  kernel/livepatch/core.c             |   4 +-
>>  kernel/livepatch/core.h             |   4 +-
>>  kernel/liveupdate/kho_block.c       |   4 +-
>>  kernel/liveupdate/luo_flb.c         |   4 +-
>>  kernel/locking/rwsem.c              |   2 +-
>>  kernel/locking/test-ww_mutex.c      |   2 +-
>>  kernel/module/main.c                |  11 +-
>>  kernel/padata.c                     |   4 +-
>>  kernel/power/snapshot.c             |   8 +-
>>  kernel/power/wakelock.c             |   4 +-
>>  kernel/printk/printk.c              |  11 +-
>>  kernel/ptrace.c                     |   4 +-
>>  kernel/rcu/rcutorture.c             |   3 +-
>>  kernel/rcu/tasks.h                  |   9 +-
>>  kernel/rcu/tree.c                   |   6 +-
>>  kernel/resource.c                   |   4 +-
>>  kernel/sched/core.c                 |   4 +-
>>  kernel/sched/ext.c                  |  22 +--
>>  kernel/sched/fair.c                 |  28 +--
>>  kernel/sched/topology.c             |   4 +-
>>  kernel/sched/wait.c                 |   4 +-
>>  kernel/seccomp.c                    |   4 +-
>>  kernel/signal.c                     |  11 +-
>>  kernel/smp.c                        |   4 +-
>>  kernel/taskstats.c                  |   8 +-
>>  kernel/time/clockevents.c           |   6 +-
>>  kernel/time/clocksource.c           |   4 +-
>>  kernel/time/posix-cpu-timers.c      |   4 +-
>>  kernel/time/posix-timers.c          |   3 +-
>>  kernel/torture.c                    |   3 +-
>>  kernel/trace/bpf_trace.c            |   4 +-
>>  kernel/trace/ftrace.c               |  49 +++--
>>  kernel/trace/ring_buffer.c          |  25 ++-
>>  kernel/trace/trace.c                |  12 +-
>>  kernel/trace/trace_dynevent.c       |   6 +-
>>  kernel/trace/trace_dynevent.h       |   5 +-
>>  kernel/trace/trace_events.c         |  35 ++--
>>  kernel/trace/trace_events_filter.c  |   4 +-
>>  kernel/trace/trace_events_hist.c    |   8 +-
>>  kernel/trace/trace_events_trigger.c |  17 +-
>>  kernel/trace/trace_events_user.c    |  16 +-
>>  kernel/trace/trace_stat.c           |   4 +-
>>  kernel/user-return-notifier.c       |   3 +-
>>  kernel/workqueue.c                  |  16 +-
>>  mm/backing-dev.c                    |   8 +-
>>  mm/balloon.c                        |   8 +-
>>  mm/cma.c                            |   4 +-
>>  mm/compaction.c                     |   4 +-
>>  mm/damon/core.c                     |   4 +-
>>  mm/damon/sysfs-schemes.c            |   4 +-
>>  mm/dmapool.c                        |   4 +-
>>  mm/huge_memory.c                    |   8 +-
>>  mm/hugetlb.c                        |  56 +++---
>>  mm/hugetlb_vmemmap.c                |  16 +-
>>  mm/khugepaged.c                     |  14 +-
>>  mm/kmemleak.c                       |   7 +-
>>  mm/ksm.c                            |  25 +--
>>  mm/list_lru.c                       |   4 +-
>>  mm/memcontrol-v1.c                  |   8 +-
>>  mm/memory-failure.c                 |  12 +-
>>  mm/memory-tiers.c                   |   4 +-
>>  mm/migrate.c                        |  23 ++-
>>  mm/mmu_notifier.c                   |   9 +-
>>  mm/page_alloc.c                     |   8 +-
>>  mm/page_reporting.c                 |   2 +-
>>  mm/percpu.c                         |  11 +-
>>  mm/pgtable-generic.c                |   4 +-
>>  mm/rmap.c                           |  10 +-
>>  mm/shmem.c                          |   9 +-
>>  mm/slab_common.c                    |  14 +-
>>  mm/slub.c                           |  33 ++--
>>  mm/swapfile.c                       |   4 +-
>>  mm/userfaultfd.c                    |  12 +-
>>  mm/vmalloc.c                        |  24 +--
>>  mm/vmscan.c                         |   7 +-
>>  mm/zsmalloc.c                       |   4 +-
>>  124 files changed, 875 insertions(+), 681 deletions(-)
> 
> Not sure what you were thinking, but this diff stat
> is not landable.

[PATCH v3 1/7] and [PATCH v3 2/7] contain the main logic and can
be merged directly. They are also compatible with the old API.
[PATCH v3 3/7] through [PATCH v3 7/7] are just simple interface
replacements and do not change any functional logic. They can be
left unmerged for now; individual modules can pick them up later
if needed.

In v2, Andy Shevchenko mentioned: "If it's done by Linus himself
during the day when he prepares -rc1, it's fine." Even so, the
changes in this patch series are indeed quite large and touch
almost every subsystem. I have only converted part of them for
now, so I wanted to send this out first and see what people think.

-- 
Thanks
Kaitao Cheng


