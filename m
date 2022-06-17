Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC58CCA479
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bsiFCZO2NzhrvYThU78+p9eOISrSp/Czx4sTZMxqIik=; b=20LfYgL4k54n2C
	Uvygw8+02wrtT/f8vbatlJVMQWNAJOtLNcuGmGFmOPbD8D2RbsTrYjX68GYRZVW4Haq/GxBCnc6HO
	Ki7w2WkOl1B8lJp8U7LTblJ0FB867ffr6l9oEuBuNn2uFclR7/KYwb33FQSgsn0ILWtgZZjK+ZAqJ
	Aty0Uw7JNXifdEKbdPaC+GCea2QVqmcNjkbDNdjocfmnyvYptaHMoTdP16rYan+RlKe1pwrZ/9DLP
	yX0+J0oNlLP95lTCbB6dTqO/8leBO7QVuoYC2KqHJ0A9iuCJsaB/5+BAbHj09REuW7CERyn9nwTFd
	UwNJm7IUp79Vwj/s9T6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2COt-007sFC-MB; Fri, 17 Jun 2022 13:52:39 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2COq-007sEd-PR
	for kexec@lists.infradead.org; Fri, 17 Jun 2022 13:52:38 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id EF39121DA1;
	Fri, 17 Jun 2022 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1655473950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1THTVu8jsvNWfYRgAb3JbU5dAAvtESDUxIyAXq6VH0=;
	b=ZruHASuJWkYRWTXGUZK85EK1c2rCRi6u/ea2V1Xaju6kf537/p+6XgRLlQJzSioBoJNQwF
	U1LqDOQcvtBm+JsMVeVtH5gNXUx4oiOhAxKTpx+ERTsaIO3ifeD369svwTH1+PorMfCSCC
	cQfWK1DxwF3MVA+ZSLSitKv/W56CBbw=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 91CD52C141;
	Fri, 17 Jun 2022 13:52:30 +0000 (UTC)
Date: Fri, 17 Jun 2022 15:52:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Tao Zhou <tao.zhou@linux.dev>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
Message-ID: <YqyHGxPCgiXuep3/@alley>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <Yqxaf6V+hvCSXQSM@geo.homenetwork>
 <xhsmhh74j7biy.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <xhsmhh74j7biy.mognet@vschneid.remote.csb>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_065237_009179_CFF047C1 
X-CRM114-Status: GOOD (  27.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri 2022-06-17 12:52:05, Valentin Schneider wrote:
> Hi Tao,
> 
> On 17/06/22 18:42, Tao Zhou wrote:
> > Hi Valentin,
> >
> > On Thu, Jun 16, 2022 at 01:37:09PM +0100, Valentin Schneider wrote:
> >> @@ -964,24 +966,31 @@ late_initcall(kexec_core_sysctl_init);
> >>   */
> >>  void __noclone __crash_kexec(struct pt_regs *regs)
> >>  {
> >> -	/* Take the kexec_mutex here to prevent sys_kexec_load
> >> -	 * running on one cpu from replacing the crash kernel
> >> -	 * we are using after a panic on a different cpu.
> >> +	/*
> >> +	 * This should be taking kexec_mutex before doing anything with the
> >> +	 * kexec_crash_image, but this code can be run in NMI context which
> >> +	 * means we can't even trylock.
> >>  	 *
> >> -	 * If the crash kernel was not located in a fixed area
> >> -	 * of memory the xchg(&kexec_crash_image) would be
> >> -	 * sufficient.  But since I reuse the memory...
> >> +	 * Pairs with smp_mb() in do_kexec_load() and sys_kexec_file_load()
> >>  	 */
> >> -	if (mutex_trylock(&kexec_mutex)) {
> >> -		if (kexec_crash_image) {
> >> -			struct pt_regs fixed_regs;
> >> -
> >> -			crash_setup_regs(&fixed_regs, regs);
> >> -			crash_save_vmcoreinfo();
> >> -			machine_crash_shutdown(&fixed_regs);
> >> -			machine_kexec(kexec_crash_image);
> >> -		}
> >> -		mutex_unlock(&kexec_mutex);
> >> +	WRITE_ONCE(panic_wants_kexec, true);
> >> +	smp_mb();
> >> +	/*
> >> +	 * If we're panic'ing while someone else is messing with the crash
> >> +	 * kernel, this isn't going to end well.
> >> +	 */
> >> +	if (READ_ONCE(kexec_loading)) {
> >> +		WRITE_ONCE(panic_wants_kexec, false);
> >> +		return;
> >> +	}
> >
> > So this is from NMI. The mutex guarantee that kexec_file_load() or 
> > do_kexec_load() just one of them beat on cpu. NMI can happen on more
> > than one cpu. That means that here be cumulativity here IMHO.
> >
> 
> If you look at __crash_kexec() in isolation yes, but if you look at panic()
> and nmi_panic() only a single NMI can get in there. I think that is also
> true for invocations via crash_kexec().

It is true that panic() could be called only once, see this code
in panic():

	 * Only one CPU is allowed to execute the panic code from here. For
	this_cpu = raw_smp_processor_id();
	old_cpu  = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);

	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
		panic_smp_self_stop();


One the other hand, the aproach with two variables is strage
and brings exactly these questions.

If a trylock is enough that the mutex can be replaced by two
simple atomic operations. The mutex would be needed only
when a user really would need to wait for another one.


	atomic_t crash_kexec_lock;

	/* trylock part */
	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1) != 0)
		return -EBUSY;

	/* do anything guarded by crash_kexec_lock */

	/* release lock */
	atomic_set_release(&crash_kexec_lock, 0);

The _acquire, _release variants will do the barriers correctly.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
