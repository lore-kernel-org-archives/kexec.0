Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E64ECC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wP/OleXvUOPC82wVeHxQZamyYTbsnAEJ57bgkI6UGjg=; b=mgSrRqvUkRlbkuJKbOn2YJKwOz
	XPQ94A3dD9hHZrNdGgtUjZN8P6Nn5TuXK5oJsMQMKZiIAAez/jZ853OE+zPgiKWoFY38/e0BUFibO
	gjLyu2bPgRCBgBXf9n15Ra5z65HPHPziO9X9wi7Rl5cP3JfKikqZR4I7jMuQfQTlV0rANPXHmYwYG
	SHbT5jTWcauL9rd5M6MSsu1RHmYXLcmumncwEIF4fJo+uLhKE/US+X2rdDtGOxV/hMiveTp6DTSJO
	h1hAU3GyrNdaTPgsDaKhfsi0BDeJTRDapwNGJgBMeRoXmPWlnLdJkfhat6FlQ7cz/4/hopvOwU/Pq
	doHZDYHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNpl-00000000dMS-0TK6;
	Thu, 15 Oct 2026 15:57:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNpj-00000000dMD-1qDK
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:57:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3191B60120;
	Thu, 15 Oct 2026 15:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF241F000C5;
	Thu, 15 Oct 2026 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792079849;
	bh=wP/OleXvUOPC82wVeHxQZamyYTbsnAEJ57bgkI6UGjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvXomQEPlVW/8vQI/MVWw8mMdjtTMG8Hsz6xdMk2IDpoAk91t6WSFxlZ3JslTN9Ob
	 SeQRXvN509c5zvuMdUEJBxcEG5OtY06FRSQt8KKgJhdtstGGrSsOUxgIYjF/7FMkn4
	 SGU11AUzTbXSHR5UKCQ/eZdxDv3hBiY9cbLoi4GIaMVUvloqjvDX4s83D4EXsIVE6J
	 eTB7OUSJuju0RJ6g4rlUcoUGIryAgapkYtMAP65C4Hv3vGtH3mGNoK6D/UAA+ed+Am
	 orDI1rJMbjFrsGIF7UgZr+z9HuxRI0mZc5SgYrCBglypshXxoEZQWU4WyZyunK7k0T
	 9evgnxO8+GZyA==
Message-ID: <sashiko-outbox-173118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/8] sched/deadline, topology: Avoid O(N^2) dl_server
 bandwidth walks during root_domain rebuilds
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, longman@redhat.com, bsegall@google.com
Cc: hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261015153331.1872641-7-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-7-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:57:27 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] sched/deadline: Concurrent sched_setattr() during dl_rebuild_rd_ac=
counting() corrupts bandwidth (!CONFIG_CPUSETS)
- [Medium] sched/deadline: root domain bandwidth leak for DEAD tasks on off=
line CPUs
- [Medium] sched/deadline: lockless u64 write to extra_bw causes data race =
and torn reads
--

commit 2fcbfb40fdf44ef2a7ddc6709657336b0c7fb178
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

sched/deadline, topology: Avoid O(N^2) dl_server bandwidth walks during roo=
t_domain rebuilds

This commit reduces the O(N^2) complexity of dl_server bandwidth walks duri=
ng
root_domain rebuilds by accumulating the total bandwidth in a single pass. =
It
also introduces a !CONFIG_CPUSETS implementation of dl_rebuild_rd_accountin=
g()
to fix an issue where SCHED_DEADLINE task bandwidth was not accounted for on
rebuilds.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 857dbe3519a86..01f2f24e3b814 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -3480,26 +3466,32 @@ static u64 dl_server_read_bw(int cpu)
>  	return dl_bw;
>  }
> =20
> -void dl_clear_root_domain(struct root_domain *rd)
> +static void dl_clear_root_domain(struct root_domain *rd)
>  {
> -	int i;
> +	u64 total_bw =3D 0;
> +	s64 extra_bw =3D 0;
> +	int i, cpus;
> =20
>  	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
> =20
[ ... ]
> +	rd->dl_bw.total_bw =3D total_bw;
> +	for_each_cpu(i, rd->span) {
> +		struct rq *rq =3D cpu_rq(i);
> +
> +		rq->dl.extra_bw =3D rq->dl.max_bw;
> +		if (cpu_active(i))
> +			rq->dl.extra_bw +=3D extra_bw;

[Severity: Medium]
Can this lockless u64 write to extra_bw cause a data race and torn reads wi=
th
grub_reclaim()?

This updates rq->dl.extra_bw remotely holding only rd->dl_bw.lock. Concurre=
ntly,
grub_reclaim() reads rq->dl.extra_bw while holding only the local rq->lock.

Because extra_bw is a u64 and can be a negative delta, 32-bit architectures
process the write as two 32-bit stores. A torn read by grub_reclaim() could
observe mismatched upper and lower halves, producing an incorrect bandwidth
value that miscalculates DL task runtime.

Additionally, splitting the update into two distinct non-atomic assignments
widens the race window.

> +	}
>  }
> =20
>  void dl_clear_root_domain_cpu(int cpu)
[ ... ]
> @@ -3507,6 +3499,33 @@ void dl_clear_root_domain_cpu(int cpu)
>  	dl_clear_root_domain(cpu_rq(cpu)->rd);
>  }
> =20
> +#ifndef CONFIG_CPUSETS
> +void dl_rebuild_rd_accounting(void)
> +{
> +	struct task_struct *g, *p;
> +	u64 cookie =3D ++dl_cookie;
> +	int cpu;
> +
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&sched_domains_mutex);
> +
> +	rcu_read_lock();
> +	for_each_possible_cpu(cpu) {
> +		if (dl_bw_visited(cpu, cookie))
> +			continue;
> +
> +		dl_clear_root_domain_cpu(cpu);
> +	}
> +	for_each_process_thread(g, p) {
> +		/* Racy pre-check; dl_add_task_root_domain() rechecks under pi_lock. */
> +		if (!dl_prio(READ_ONCE(p->prio)))
> +			continue;
> +		dl_add_task_root_domain(p);

[Severity: High]
Does this allow a race with concurrent __sched_setscheduler()?

In a kernel without CONFIG_CPUSETS, cpuset_lock() is an empty no-op stub,
leaving __sched_setscheduler() completely unsynchronized against this loop.

If sched_setattr() transitions a task to SCHED_DEADLINE concurrently,
__sched_setscheduler() calls sched_dl_overflow() which acquires dl_b->lock
and adds the task's bandwidth. Then this iteration loop could observe the n=
ew
priority, call dl_add_task_root_domain(), and add the bandwidth a second ti=
me,
corrupting rd->dl_bw.total_bw.

Similarly, a task transitioning from SCHED_DEADLINE to SCHED_OTHER could re=
sult
in a bandwidth underflow because the rebuild clears the bandwidth, skips the
task, and later inactive_task_timer() subtracts the bandwidth.

[Severity: Medium]
Does this leak SCHED_DEADLINE bandwidth in the active root domain for DEAD =
tasks
on offline CPUs?

This loop blindly iterates over all tasks, including TASK_DEAD zombies, wit=
hout
checking the task state. If a SCHED_DEADLINE task exits and enters TASK_DEAD
state, its bandwidth is preserved until its 0-lag inactive timer fires.

If its original CPU is hotplugged offline before the timer fires, CPU hotpl=
ug
triggers this domain rebuild. Because the task's original CPU is offline,
dl_add_task_root_domain() picks a new active CPU and adds the task's bandwi=
dth
to the new active root domain.

When the 0-lag timer eventually fires, inactive_task_timer() subtracts the
bandwidth from task_cpu(p)'s root domain (the def_root_domain, since it was
never migrated), permanently leaking the bandwidth in the active root domai=
n.

> +	}
> +	rcu_read_unlock();
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015153331.1872=
641-1-pasha.tatashin@soleen.com?part=3D6

