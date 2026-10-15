Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B5BCCA464
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H9Yud6eTq1sATJAd3F30rxJtL46ZW8Kh6obL1SXs+uU=; b=Wh+FEwBQ+JO6+KZ1ueWA7r/k7T
	I77wgJiudy3R0elFbC6HUOc4DJiYgdq0+YvtCIbZ241nS1a7HwfNDl6ED9LtlUbnCmFZAz2T/B6/F
	EQjVk6LL0QobmxfyBsWbfFNuM9safGo+OOY/YePbnUR8ucKCT3hf2KjJTu54OXsK4kNOZJFt2ZYQK
	BT2lx+1AmsR+oLVfUbw+jeZiLqGnhZb6TjnAHulzTgTG0yv6gF21GsrmrAbNsbfRZXQ/9EeY1wiPl
	KHP1smmk1MxDkc1tAI7mV2mczT/ltUKhhThqQ+lyZ0qWcVGmwh2RRB1vW6MBJjGXxqRvyfQdpmrU9
	STEBuN1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHSIf-00000001Mgn-22kZ;
	Thu, 15 Oct 2026 20:43:41 +0000
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHSIb-00000001MgG-42Hf
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 20:43:39 +0000
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-5ea97b74acaso114124e0c.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 13:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792097017; x=1792701817; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H9Yud6eTq1sATJAd3F30rxJtL46ZW8Kh6obL1SXs+uU=;
        b=Wb6+/I/iXXlPZ6hPSBACnCUyTtUgsEUPdBxIbnbH2XlYKj3Tha2cXQPj9ZVKFlGUUA
         urnkewsa/tuHwlbyZG2r1Y5YSed/8FXGgZ9CWTkDlital9V1CZ7kpFTFhQt9K6JPAs5r
         cmVd+Fz0tRnJ3C5QtAyLjn8rpWTjLF4sNojY7A4aaweqP8KL3CjxknSU7Guuly3lLmqg
         YrJD81pCWAoPSMHzNOSARVVveYtPb+/nzcI2lPwrFm09k4XaKiV64SHj1SIUbFB5uuMB
         Oc32XNB5B5udtpwx23HL3IBh9NebHauCNrLHpEtVQQVJ16mG1PRV6LqRPjMibEnKN+wv
         ba0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097017; x=1792701817;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9Yud6eTq1sATJAd3F30rxJtL46ZW8Kh6obL1SXs+uU=;
        b=vcI4BRWUN0veTI0sTNT6puiCf1hvWEzJZ/T+6LwFHHLmQHBbBn2M9rl237nbTeE6t8
         /pu9WzSXPhBPkV8WG4cg6c5K25gZGuNlISNNbh4SSrw9urY5KU8Ox+Z6V1S7kVyxWAwk
         GVKpd7HWpPQVBLrgMFy+zTy1OxXnea/5lPO43Z/WPvJXqrYIdyA4zFAzDLNEAnv1qJLI
         RZ895SxI3R8R8xl0tXq6IpJ5Dxq45AyPqA6CulT4ZkjyHsmFfbB8zrjku4UJiTBLZWKq
         742lXBRb8dgBGxJYbpVHTZ0ANN09hSEMrPsYXx5I2M0XhkrA3ibFWnnXNzi+R2OD5hCh
         0uTg==
X-Forwarded-Encrypted: i=1; AKwUvByjCvFHWjY4yUUQn01GYaTjUkDDnBL5XvcCscfsrrJdi1avJ027ckTzUyXakRVPrvD6KBxDig==@lists.infradead.org
X-Gm-Message-State: AFq9FYKxvPrliaqobDgHbRPDVr0BqWP0PppufOcwHb7OqXCvVctfmp4x
	GHfn7q4h6wjTiuT3y21F1HiK3tJsI7/kleMPzQPNHtA91PspDqdw4EENTg3G/iRzfN4=
X-Gm-Gg: AYBFou1T2JqbGvI3lbbWDyJ5lWBVJokKewkURdF1JSESUI8T5zd4qYfim/uuo/wk3Y5
	HteI8M4L5rdhUgWdmFT1K+8T5bFyzcoPaEUVS2RvkUUcwGQeT8TFu8vYGFdXB/zerCXagSWoel4
	0H4gVTflYm1qhY8shjfSW6GIdWQEhbauSDYBb4aIfVmxe2i5z/EPZsLaWHu67zXOioAFr08ToTN
	tJaYqOYXTmmI1wonIc2pqhpHPL1NN0LDcgf5nmnPmvx7m56/a0pB1Yzmzh3JbCEo+pTbbeJR8y7
	PXcACVgSC6BWLxoznDhpC0bfWTHXEaVEMaYJiZICZkGWk3ps9XPzVnJxei/RNeXSPkKXZ8kHaKv
	+SLk7eNFHOlB3dkGHp2OjCe5tDbhqmGtxm/MINxXm0zwrD+pCP8Wl1znNIjPcv/jAKYzmGLC6Up
	KNGVSjrb1h6WUvwG1gFLRvsRp1oqPerttOX5DtasfxIAZGgjytUWCLVR8cUozxoWF6jIgWNOXl0
	3FvHtaMY/bHjfuIykmzVqaF23+06q1OZHF1U7HwmhjF0ErEdhWr5Xis409q87AYmK92F8ItU/o=
X-Received: by 2002:a05:6123:107:b0:5d7:7ee1:c678 with SMTP id 71dfb90a1353d-5e91f524633mr7258163e0c.16.1792097016575;
        Thu, 15 Oct 2026 13:43:36 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b4776b5sm114329e0c.3.2026.10.15.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:43:36 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:43:35 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: sashiko-bot@kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kees@kernel.org,
	rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com,
	tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com,
	vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev,
	tony.luck@intel.com, david@kernel.org, mingo@redhat.com,
	akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org,
	zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com,
	vinicius.gomes@intel.com, tj@kernel.org, vbabka@kernel.org,
	peterz@infradead.org, surenb@google.com, hpa@zytor.com,
	x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com,
	kexec@lists.infradead.org, pratyush@kernel.org,
	dave.hansen@linux.intel.com, rostedt@goodmis.org,
	gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de,
	graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev,
	longman@redhat.com, bsegall@google.com, hannes@cmpxchg.org,
	mkoutny@suse.com
Subject: Re: [PATCH v1 6/8] sched/deadline, topology: Avoid O(N^2) dl_server
 bandwidth walks during root_domain rebuilds
Message-ID: <atE69-tcZxHMmMp-@google.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-7-pasha.tatashin@soleen.com>
 <sashiko-outbox-173118@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-173118@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_134338_024138_5B5317BE 
X-CRM114-Status: GOOD (  24.37  )
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

On 10-15 15:57, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] sched/deadline: Concurrent sched_setattr() during dl_rebuild_rd_accounting() corrupts bandwidth (!CONFIG_CPUSETS)
> - [Medium] sched/deadline: root domain bandwidth leak for DEAD tasks on offline CPUs
> - [Medium] sched/deadline: lockless u64 write to extra_bw causes data race and torn reads
> --
> 
> commit 2fcbfb40fdf44ef2a7ddc6709657336b0c7fb178
> Author: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> sched/deadline, topology: Avoid O(N^2) dl_server bandwidth walks during root_domain rebuilds
> 
> This commit reduces the O(N^2) complexity of dl_server bandwidth walks during
> root_domain rebuilds by accumulating the total bandwidth in a single pass. It
> also introduces a !CONFIG_CPUSETS implementation of dl_rebuild_rd_accounting()
> to fix an issue where SCHED_DEADLINE task bandwidth was not accounted for on
> rebuilds.
> 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 857dbe3519a86..01f2f24e3b814 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> [ ... ]
> > @@ -3480,26 +3466,32 @@ static u64 dl_server_read_bw(int cpu)
> >  	return dl_bw;
> >  }
> >  
> > -void dl_clear_root_domain(struct root_domain *rd)
> > +static void dl_clear_root_domain(struct root_domain *rd)
> >  {
> > -	int i;
> > +	u64 total_bw = 0;
> > +	s64 extra_bw = 0;
> > +	int i, cpus;
> >  
> >  	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
> >  
> [ ... ]
> > +	rd->dl_bw.total_bw = total_bw;
> > +	for_each_cpu(i, rd->span) {
> > +		struct rq *rq = cpu_rq(i);
> > +
> > +		rq->dl.extra_bw = rq->dl.max_bw;
> > +		if (cpu_active(i))
> > +			rq->dl.extra_bw += extra_bw;
> 
> [Severity: Medium]
> Can this lockless u64 write to extra_bw cause a data race and torn reads with
> grub_reclaim()?
> 
> This updates rq->dl.extra_bw remotely holding only rd->dl_bw.lock. Concurrently,
> grub_reclaim() reads rq->dl.extra_bw while holding only the local rq->lock.
> 
> Because extra_bw is a u64 and can be a negative delta, 32-bit architectures
> process the write as two 32-bit stores. A torn read by grub_reclaim() could
> observe mismatched upper and lower halves, producing an incorrect bandwidth
> value that miscalculates DL task runtime.
> 
> Additionally, splitting the update into two distinct non-atomic assignments
> widens the race window.
> 
> > +	}
> >  }
> >  
> >  void dl_clear_root_domain_cpu(int cpu)
> [ ... ]
> > @@ -3507,6 +3499,33 @@ void dl_clear_root_domain_cpu(int cpu)
> >  	dl_clear_root_domain(cpu_rq(cpu)->rd);
> >  }
> >  
> > +#ifndef CONFIG_CPUSETS
> > +void dl_rebuild_rd_accounting(void)
> > +{
> > +	struct task_struct *g, *p;
> > +	u64 cookie = ++dl_cookie;
> > +	int cpu;
> > +
> > +	lockdep_assert_cpus_held();
> > +	lockdep_assert_held(&sched_domains_mutex);
> > +
> > +	rcu_read_lock();
> > +	for_each_possible_cpu(cpu) {
> > +		if (dl_bw_visited(cpu, cookie))
> > +			continue;
> > +
> > +		dl_clear_root_domain_cpu(cpu);
> > +	}
> > +	for_each_process_thread(g, p) {
> > +		/* Racy pre-check; dl_add_task_root_domain() rechecks under pi_lock. */
> > +		if (!dl_prio(READ_ONCE(p->prio)))
> > +			continue;
> > +		dl_add_task_root_domain(p);
> 
> [Severity: High]
> Does this allow a race with concurrent __sched_setscheduler()?
> 
> In a kernel without CONFIG_CPUSETS, cpuset_lock() is an empty no-op stub,
> leaving __sched_setscheduler() completely unsynchronized against this loop.
> 
> If sched_setattr() transitions a task to SCHED_DEADLINE concurrently,
> __sched_setscheduler() calls sched_dl_overflow() which acquires dl_b->lock
> and adds the task's bandwidth. Then this iteration loop could observe the new
> priority, call dl_add_task_root_domain(), and add the bandwidth a second time,
> corrupting rd->dl_bw.total_bw.
> 
> Similarly, a task transitioning from SCHED_DEADLINE to SCHED_OTHER could result
> in a bandwidth underflow because the rebuild clears the bandwidth, skips the
> task, and later inactive_task_timer() subtracts the bandwidth.
> 
> [Severity: Medium]
> Does this leak SCHED_DEADLINE bandwidth in the active root domain for DEAD tasks
> on offline CPUs?
> 
> This loop blindly iterates over all tasks, including TASK_DEAD zombies, without
> checking the task state. If a SCHED_DEADLINE task exits and enters TASK_DEAD
> state, its bandwidth is preserved until its 0-lag inactive timer fires.

Both bugs, are real, and I am going to address them in the next itiration, after
waiting for feedback on the series.

