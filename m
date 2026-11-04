Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24268606A32E
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t4EDg4Z7;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZ8G9hjc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=olZhh7KhDNcSAx3uv+MHZHd+XJ6Y2NBJSt9S/teet50=; b=t4EDg4Z7OXxxpZ2yvnd+uv2NSq
	rlyFA2xTJBJhTIGeBqJVaGb7bDDhPYQEgaAU+DMJwAwYaLWKb6JYXmDTsdC1r3Kn79VFaMdv7+rLw
	t9T8iBi8StGetTPfMHvBNhWCIHTJIilyWbnycOrBSq2663his6LfpWvB86qZdr2UaUVEteSx6u58Z
	ZMGTIyWWy+ibk37hlGJUJSTfQhm7gwScVHPooD8MLkNt433Qn2PAgFTBI9q+I+CycCIgVC/w26cEt
	jyxBJji1zq7BQAECAl1eeWL70aZjxWidkh0IyZFSILRX4Hh5SXas0n4E3QHA/Pryn4DPU1rETKMFl
	rLACxNzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOR41-00000004CuB-3YWe;
	Wed, 04 Nov 2026 02:49:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOR40-00000004Cso-29l3
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 02:49:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E9DCF601F6;
	Wed,  4 Nov 2026 02:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B808A1F0093A;
	Wed,  4 Nov 2026 02:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760563;
	bh=olZhh7KhDNcSAx3uv+MHZHd+XJ6Y2NBJSt9S/teet50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HZ8G9hjcgEzXEhEtYdEVwDvslVTaFOYV5Oq5m8pOGhHflRTfEc2aXUQxJFrBuJAEi
	 Vg0TRUfMJSUm/VENKMD+ntt2lq4xE8rBMYRqNIl7fqIUBKTGZAu4lYGHFt5VTY1WRW
	 6ZLok5vXty+/5BJNnQuWVjIE1XoP1DQIqmkP2j6afJoNsUNLiyyVCe8DLYS+h4MVso
	 S9Mm2OAiQi8ZQuvIGgV44tfmZx8a4+zmdfb9xeldE5qYV/fjx6U708SN6q56zLSatu
	 aRbMJEnIeGkwHcajAbIrbrN6vKQ9JQH4yLF5bzwRMvfgGSUKIBiEkbGV7EOE5uGXzX
	 B+VduoxsiIQ0w==
Message-ID: <sashiko-outbox-196526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/5] timers: Avoid blocking on hrtimer_cpu_base
 lock during Oops or panic
To: "Aaron Tomlin" <atomlin@atomlin.com>, pmladek@suse.com, john.ogness@linutronix.de, rostedt@goodmis.org, senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261103024453.922373-4-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:49:21 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] timers: incomplete !CONFIG_SMP guard in print_active_timers()
--

commit 8e788faa0cf2d16ee117d7196f09432346eeda90
Author: Aaron Tomlin <atomlin@atomlin.com>

timers: Avoid blocking on hrtimer_cpu_base lock during Oops or panic

This commit switches sysrq_timer_list_show() to use ktime_get_mono_fast_ns()
and updates print_active_timers() to use raw_spin_trylock_irqsave() on
base->cpu_base->lock when in NMI, Oops, or panic contexts so that dumping
timer state does not deadlock if a CPU is holding a timekeeping or hrtimer
base lock.

> diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
> index 0406bf4488e9f..4973650c4ae5a 100644
> --- a/kernel/time/timer_list.c
> +++ b/kernel/time/timer_list.c
> @@ -68,7 +68,15 @@ static void print_active_timers(struct seq_file *m, st=
ruct hrtimer_clock_base *b
> =20
>  	touch_nmi_watchdog();
> =20
> -	raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
> +	if (in_nmi() || oops_in_progress || panic_in_progress()) {
> +		if ((!IS_ENABLED(CONFIG_SMP) && in_nmi()) ||
> +		    !raw_spin_trylock_irqsave(&base->cpu_base->lock, flags)) {
> +			SEQ_printf(m, "  [cpu_base lock contended]\n");
> +			return;
> +		}
> +	} else {
> +		raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
> +	}

[Severity: High]
In print_active_timers(), the outer check enters this branch when in_nmi(),
oops_in_progress, or panic_in_progress() is true, but the inner !CONFIG_SMP
check only tests in_nmi(). What happens on a !CONFIG_SMP build if an Oops or
panic occurs in non-NMI context while the CPU already holds
base->cpu_base->lock (for example, inside enqueue_hrtimer() or
__remove_hrtimer())?

When CONFIG_SMP=3Dn and CONFIG_DEBUG_SPINLOCK=3Dn, _raw_spin_trylock_irqsav=
e()
unconditionally returns 1:

include/linux/spinlock_api_up.h:_raw_spin_trylock_irqsave() {
	__LOCK_IRQSAVE(lock, *(flags));
	return 1;
}

Wouldn't that allow print_active_timers() to re-enter the critical section
and walk base->active while the timerqueue is in a partially modified state?

And when CONFIG_SMP=3Dn and CONFIG_DEBUG_SPINLOCK=3Dy, since vpanic() invok=
es
sys_info() before debug_locks_off():

kernel/panic.c:vpanic() {
	...
	sys_info(panic_print);

	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);

	if (_crash_kexec_post_notifiers)
		__crash_kexec(NULL);

	console_unblank();

	debug_locks_off();
	...
}

wouldn't do_raw_spin_trylock() hit SPIN_BUG_ON(!ret, lock, "trylock failure
on UP") when base->cpu_base->lock is already held?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103024453.9223=
73-1-atomlin@atomlin.com?part=3D3

