Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A2CCDB46F
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NCyqgOn/EsE21R3mLuqcUgbV6oo6AJhAXamoQT+ptD8=; b=YhXfiBfa1v21Exc62foG7OPZv9
	cA+8BXQttRlqssK20gMZCZ69+z5trY8DuLay7UGKWddiV1kDLK8Xp2Ut3/H/wznVwTwMvi/jlyRQO
	gmQopR5b2IBpjoe4wwFQoWGIh9Fia1HtznODuqAR2vFqYlBWle1FfqE0mCn52BEM4OacF9HBbudQ6
	/NPqNlm4kuaYHyAMwmqRBpnwPFXmaFQuVn+N0+c5HxbvgtEXJZ850LKsnrZDLqJpgXsM3znll7Cc2
	HOTOiWtcbet+jPifQraXnzaEIoYHFmzlfKDhy95NCQphFOf7q/maV0pIzqFm2UlWj9ODUfXL+0YZT
	Yum4v8PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbcCl-00000004rEl-1GBz;
	Mon, 22 Jun 2026 10:48:39 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbcCi-00000004r69-1wUS
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 10:48:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782125316; x=1813661316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/hKgAevfumO8x7LfebeUyLh/erlFr2Hmr9kpKNVbH0Q=;
  b=fmAMstiafiK1KBtyxG2AcdAT3lKP5YBPAbXwhuX8p0/OjsMtcpKLdjyo
   mvkC0FZ1d/wMIjDASwnVJm47eM+15RkVgqfCdwNnlZH5BhwliBImYOaDL
   dlAurrIM+IhAV2Y/ImXy1Dp3l5qzxMH6JHx+03PMp+Zr1nS5Dagh4SgaT
   IiFQ7jvfkhK9IjCaj3PsN5zoEMvdBt6GIXjfWOzFtU2nYnwo5uH1+Q1jy
   sbNkTIsFrZfZowI5ZcXaK16/KEbPgmiGpxbqWOczJDVRVlnbTuJ3bjwDN
   KtQv56LVqQ8cpW8t0KsnBwy2uO0KEZxROiy6GMiwjv/7bu4FNI3oIvy/c
   Q==;
X-CSE-ConnectionGUID: R/cG8KcnQBKOgEJCrXrtMw==
X-CSE-MsgGUID: WjvVrdmeR4GVxUHYGwjuew==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93506237"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="93506237"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:46:35 -0700
X-CSE-ConnectionGUID: xNR2+KjtQLGBpSv9fyyNaQ==
X-CSE-MsgGUID: i0RzaMPlRGCEVMh1muYCuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="253099713"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.152])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:46:25 -0700
Date: Mon, 22 Jun 2026 13:46:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Paul Moore <paul@paul-moore.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Howells <dhowells@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Randy Dunlap <rdunlap@infradead.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Philipp Stanner <phasta@kernel.org>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	linux-ntfs-dev@lists.sourceforge.net,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	io-uring <io-uring@vger.kernel.org>, audit@vger.kernel.org,
	bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	dri-devel@lists.freedesktop.org,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	kexec@lists.infradead.org, live-patching@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	rcu@vger.kernel.org, sched-ext@lists.linux.dev,
	linux-mm <linux-mm@kvack.org>, virtualization@lists.linux.dev,
	damon@lists.linux.dev, clang-built-linux <llvm@lists.linux.dev>,
	chengkaitao <chengkaitao@kylinos.cn>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 0/7] Prepare mutable list iterators to cache cursor
 state
Message-ID: <ajkSftEbdGoiJXYs@ashevche-desk.local>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
 <CAADnVQJmPWFT01b7DuLdtafv=8FyB84GYHNZ8zSTck+9Aw0JpA@mail.gmail.com>
 <8c8f1849-86d3-4c69-be27-30bbdffdf616@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c8f1849-86d3-4c69-be27-30bbdffdf616@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_034836_520075_2616DA66 
X-CRM114-Status: GOOD (  20.30  )
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

On Mon, Jun 22, 2026 at 02:15:01PM +0800, Kaitao Cheng wrote:
> 在 2026/6/22 13:28, Alexei Starovoitov 写道:
> > On Sun, Jun 21, 2026 at 9:06 PM Kaitao Cheng <kaitao.cheng@linux.dev> wrote:

...

> >>  block/bfq-iosched.c                 |  17 +-
> >>  block/blk-cgroup.c                  |  12 +-
> >>  block/blk-flush.c                   |   4 +-
> >>  block/blk-iocost.c                  |  18 +-
> >>  block/blk-mq.c                      |   8 +-
> >>  block/blk-throttle.c                |   4 +-
> >>  block/kyber-iosched.c               |   4 +-
> >>  block/partitions/ldm.c              |   8 +-
> >>  block/sed-opal.c                    |   4 +-
> >>  include/linux/list.h                | 269 ++++++++++++++++++++++++----
> >>  include/linux/llist.h               |  81 +++++++--
> >>  init/initramfs.c                    |   5 +-
> >>  io_uring/cancel.c                   |   6 +-
> >>  io_uring/poll.c                     |   3 +-
> >>  io_uring/rw.c                       |   4 +-
> >>  io_uring/timeout.c                  |   8 +-
> >>  io_uring/uring_cmd.c                |   3 +-
> >>  kernel/audit_tree.c                 |   4 +-
> >>  kernel/audit_watch.c                |  16 +-
> >>  kernel/auditfilter.c                |   4 +-
> >>  kernel/auditsc.c                    |   4 +-
> >>  kernel/bpf/arena.c                  |  10 +-
> >>  kernel/bpf/arraymap.c               |   8 +-
> >>  kernel/bpf/bpf_local_storage.c      |   3 +-
> >>  kernel/bpf/bpf_lru_list.c           |  25 ++-
> >>  kernel/bpf/btf.c                    |  18 +-
> >>  kernel/bpf/cgroup.c                 |   7 +-
> >>  kernel/bpf/cpumap.c                 |   4 +-
> >>  kernel/bpf/devmap.c                 |  10 +-
> >>  kernel/bpf/helpers.c                |   8 +-
> >>  kernel/bpf/local_storage.c          |   4 +-
> >>  kernel/bpf/memalloc.c               |  16 +-
> >>  kernel/bpf/offload.c                |   8 +-
> >>  kernel/bpf/states.c                 |   4 +-
> >>  kernel/bpf/stream.c                 |   4 +-
> >>  kernel/bpf/verifier.c               |   6 +-
> >>  kernel/cgroup/cgroup-v1.c           |   4 +-
> >>  kernel/cgroup/cgroup.c              |  54 +++---
> >>  kernel/cgroup/dmem.c                |  12 +-
> >>  kernel/cgroup/rdma.c                |   8 +-
> >>  kernel/events/core.c                |  44 +++--
> >>  kernel/events/uprobes.c             |  12 +-
> >>  kernel/exit.c                       |   8 +-
> >>  kernel/fail_function.c              |   4 +-
> >>  kernel/gcov/clang.c                 |   4 +-
> >>  kernel/irq_work.c                   |   4 +-
> >>  kernel/kexec_core.c                 |   4 +-
> >>  kernel/kprobes.c                    |  16 +-
> >>  kernel/livepatch/core.c             |   4 +-
> >>  kernel/livepatch/core.h             |   4 +-
> >>  kernel/liveupdate/kho_block.c       |   4 +-
> >>  kernel/liveupdate/luo_flb.c         |   4 +-
> >>  kernel/locking/rwsem.c              |   2 +-
> >>  kernel/locking/test-ww_mutex.c      |   2 +-
> >>  kernel/module/main.c                |  11 +-
> >>  kernel/padata.c                     |   4 +-
> >>  kernel/power/snapshot.c             |   8 +-
> >>  kernel/power/wakelock.c             |   4 +-
> >>  kernel/printk/printk.c              |  11 +-
> >>  kernel/ptrace.c                     |   4 +-
> >>  kernel/rcu/rcutorture.c             |   3 +-
> >>  kernel/rcu/tasks.h                  |   9 +-
> >>  kernel/rcu/tree.c                   |   6 +-
> >>  kernel/resource.c                   |   4 +-
> >>  kernel/sched/core.c                 |   4 +-
> >>  kernel/sched/ext.c                  |  22 +--
> >>  kernel/sched/fair.c                 |  28 +--
> >>  kernel/sched/topology.c             |   4 +-
> >>  kernel/sched/wait.c                 |   4 +-
> >>  kernel/seccomp.c                    |   4 +-
> >>  kernel/signal.c                     |  11 +-
> >>  kernel/smp.c                        |   4 +-
> >>  kernel/taskstats.c                  |   8 +-
> >>  kernel/time/clockevents.c           |   6 +-
> >>  kernel/time/clocksource.c           |   4 +-
> >>  kernel/time/posix-cpu-timers.c      |   4 +-
> >>  kernel/time/posix-timers.c          |   3 +-
> >>  kernel/torture.c                    |   3 +-
> >>  kernel/trace/bpf_trace.c            |   4 +-
> >>  kernel/trace/ftrace.c               |  49 +++--
> >>  kernel/trace/ring_buffer.c          |  25 ++-
> >>  kernel/trace/trace.c                |  12 +-
> >>  kernel/trace/trace_dynevent.c       |   6 +-
> >>  kernel/trace/trace_dynevent.h       |   5 +-
> >>  kernel/trace/trace_events.c         |  35 ++--
> >>  kernel/trace/trace_events_filter.c  |   4 +-
> >>  kernel/trace/trace_events_hist.c    |   8 +-
> >>  kernel/trace/trace_events_trigger.c |  17 +-
> >>  kernel/trace/trace_events_user.c    |  16 +-
> >>  kernel/trace/trace_stat.c           |   4 +-
> >>  kernel/user-return-notifier.c       |   3 +-
> >>  kernel/workqueue.c                  |  16 +-
> >>  mm/backing-dev.c                    |   8 +-
> >>  mm/balloon.c                        |   8 +-
> >>  mm/cma.c                            |   4 +-
> >>  mm/compaction.c                     |   4 +-
> >>  mm/damon/core.c                     |   4 +-
> >>  mm/damon/sysfs-schemes.c            |   4 +-
> >>  mm/dmapool.c                        |   4 +-
> >>  mm/huge_memory.c                    |   8 +-
> >>  mm/hugetlb.c                        |  56 +++---
> >>  mm/hugetlb_vmemmap.c                |  16 +-
> >>  mm/khugepaged.c                     |  14 +-
> >>  mm/kmemleak.c                       |   7 +-
> >>  mm/ksm.c                            |  25 +--
> >>  mm/list_lru.c                       |   4 +-
> >>  mm/memcontrol-v1.c                  |   8 +-
> >>  mm/memory-failure.c                 |  12 +-
> >>  mm/memory-tiers.c                   |   4 +-
> >>  mm/migrate.c                        |  23 ++-
> >>  mm/mmu_notifier.c                   |   9 +-
> >>  mm/page_alloc.c                     |   8 +-
> >>  mm/page_reporting.c                 |   2 +-
> >>  mm/percpu.c                         |  11 +-
> >>  mm/pgtable-generic.c                |   4 +-
> >>  mm/rmap.c                           |  10 +-
> >>  mm/shmem.c                          |   9 +-
> >>  mm/slab_common.c                    |  14 +-
> >>  mm/slub.c                           |  33 ++--
> >>  mm/swapfile.c                       |   4 +-
> >>  mm/userfaultfd.c                    |  12 +-
> >>  mm/vmalloc.c                        |  24 +--
> >>  mm/vmscan.c                         |   7 +-
> >>  mm/zsmalloc.c                       |   4 +-
> >>  124 files changed, 875 insertions(+), 681 deletions(-)
> > 
> > Not sure what you were thinking, but this diff stat
> > is not landable.
> 
> [PATCH v3 1/7] and [PATCH v3 2/7] contain the main logic and can
> be merged directly. They are also compatible with the old API.
> [PATCH v3 3/7] through [PATCH v3 7/7] are just simple interface
> replacements and do not change any functional logic. They can be
> left unmerged for now; individual modules can pick them up later
> if needed.
> 
> In v2, Andy Shevchenko mentioned: "If it's done by Linus himself
> during the day when he prepares -rc1, it's fine."

Yes, but you need to get his blessing first to go with this.
Have you communicated with him on this?

> Even so, the
> changes in this patch series are indeed quite large and touch
> almost every subsystem. I have only converted part of them for
> now, so I wanted to send this out first and see what people think.

That's why it's better to provide a script to convert (e.g., coccinelle)
instead of tons of patches.

-- 
With Best Regards,
Andy Shevchenko



