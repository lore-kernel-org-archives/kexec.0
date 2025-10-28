Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A03CCF9EA
	for <kexec@archiver.kernel.org>; Tue, 28 Oct 2025 23:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9tfwn81Gw2zSBfVesGPseRf2iXXkDn+JM7FBY3kOAts=; b=1aHF9LNqwlSqZcoy+TDIf+x4v6
	kkz2WmWi+qK735P6kLOcgP7d1H4ZkANIoY/SMxzYXSgDozTRNPa/Ep7v3bjl+NveBI+N+5h0ihwvp
	NwIMlUbe0263p98YnJACMJJMt2sDEMLJIv1qv/ikEGvzuS0bfrEN0XOneFvxrMbabtg941XYdbtAr
	A++vlTrEqwHIfcTWifXHspWALSj1lTdHhPH4G7PayBD/0J4RsQTuKRwhUEkmC04DDsQAd3ITHBpNs
	Ot5XKh3n/vE/64+qtv6Xuxdj06sgdeWD4LnLZ9CZWuzYXpt+Sat8NgifUrIF3h4uheuGUKO0Qdm1P
	kMzYnQDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDtHY-0000000Go3d-0zXv;
	Tue, 28 Oct 2025 23:39:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDtHV-0000000Go2x-0ZwQ
	for kexec@lists.infradead.org;
	Tue, 28 Oct 2025 23:39:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1313A43909;
	Tue, 28 Oct 2025 23:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E54DC4CEE7;
	Tue, 28 Oct 2025 23:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761694751;
	bh=5GOr6CFcvQVLTSWnlw4oFuFdRMFyQY3rQjMr0c6iFrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xzE135tJWZlIHxt4/fZlEUeYUN/78QoOQOgFUmv/hi4tt2wkbjCOeUGqpGq8P1sV7
	 QNRW4QT3KseLxawe2K4W0JD+VBIeYbbrNp1BRP2BjB+aZMRffRuD5NiWo8j1Qq8IdJ
	 C0UfbpCZP1fR6QDTzILYHaFJS5h828cYbECq5Ivs=
Date: Tue, 28 Oct 2025 16:39:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Waiman Long
 <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Baoquan
 He <bhe@redhat.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider
 <vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Joel Granados <joel.granados@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCHv2 2/2] kernel/kexec: Stop all userspace deadline tasks
Message-Id: <20251028163911.98990cbf1516d1c6d221f92b@linux-foundation.org>
In-Reply-To: <20251028030914.9520-3-piliu@redhat.com>
References: <20251028030914.9520-1-piliu@redhat.com>
	<20251028030914.9520-3-piliu@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_163913_207940_7899F100 
X-CRM114-Status: GOOD (  18.65  )
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

On Tue, 28 Oct 2025 11:09:14 +0800 Pingfan Liu <piliu@redhat.com> wrote:

> Now that the deadline bandwidth check has been skipped, there is nothing
> to prevent CPUs from being unplugged. But as deadline tasks are crowded
> onto the remaining CPUs, they may starve normal tasks, especially the
> hotplug kthreads. As a result, the kexec process will hang indefinitely.
> 
> Send SIGSTOP to all userspace deadline tasks at the beginning of kexec
> to allow other tasks to run as CPUs are unplugged.

This all looks a bit hacky.

What's special about kexec?  If many CPUs are being unplugged via other
means, won't the kernel still hit the very problems which are being
addressed here for kexec?  If so, we should seek a general fix for these
issues rather than a kexec-specific one?

> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1132,6 +1132,18 @@ bool kexec_load_permitted(int kexec_image_type)
>  	return true;
>  }
>  
> +static void stop_user_deadline_tasks(void)
> +{
> +	struct task_struct *task;
> +
> +	rcu_read_lock();
> +	for_each_process(task) {
> +		if (task->policy == SCHED_DEADLINE && task->mm)
> +			send_sig(SIGSTOP, task, 1);
> +	}
> +	rcu_read_unlock();
> +}

If we can safely stop all SCHED_DEADLINE user tasks then presumably we
can safely stop all user tasks.  Why not do that?

>  /*
>   * Move into place and start executing a preloaded standalone
>   * executable.  If nothing was preloaded return an error.
> @@ -1190,6 +1202,11 @@ int kernel_kexec(void)
>  		cpu_hotplug_disable();
>  		kexec_in_progress = true;
>  		cpu_hotplug_enable();
> +		/*
> +		 * As CPU hot-removal, the crowed deadline task may starve other
> +		 * tasks. So stop them.
> +		 */
> +		stop_user_deadline_tasks();
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
>  		syscore_shutdown();
y

