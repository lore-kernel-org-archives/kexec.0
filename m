Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD1DE7717F
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tTLtkHzy12odtnIO1vKXAuWcEdu57bgB/Jv6GnuDHv8=; b=NtXI/84TnxuTIC+3TUtQxmsSi2
	GKmkcno3DijGm2edSGig5fL3RM46+8DpWjUQaNT0wDPaNcBbzZ11u9ke40Z5x5jXTBIIqd7xisoAO
	ziAGo+RLKK0HttBEodEVG7cjYVyBvcGprcglLFiyb1Vr2uaK1GZ8UPyUi4bX3mRcMGZ/umoJB3Z5O
	js5ZvCxmWRFpqXXBBrX4VjXexL/CskHMS43QqBQy4ftYvsxVE15gzWFhvnfmpXWNBzptTafdg0L0v
	o9z3PRyAJ5LHm5ZFWmOXM20UDb57QA92+zKoaweUEX9LVN7NT67V9NccNk0nU7VuF41SKQNVqO5r1
	LIJL7yMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3tJ-00000003ZLd-1nVr;
	Fri, 13 Dec 2024 11:31:29 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3tG-00000003ZJb-2V9m
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 11:31:27 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734089485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTLtkHzy12odtnIO1vKXAuWcEdu57bgB/Jv6GnuDHv8=;
	b=VywlZE7Op2Oh8h+Qlwj9/jXaq+/RyeLicQk7Cq7agGYzio/IP444cZ0fqTF4crgtZeKEiQ
	WhibYjTmNouqzSDV+dtuyrxRoRBMoX6r9ZlJ/eTidYA3HuKAf2knJvM/QDjKoo+GC06QWg
	lEDuKIWbHtvcugxjWd2Juscycw6ixuUL3kU/63GRN2KsvzRJE/DuNKEY3ojFsGrdtatOVd
	//p7WDMdMQSnv817KZcjy8Wyra596mrxLMiR+asbRc2zoA/8cTQnSByAhHSjwNYqxRCsQi
	L4h/rawJ6TV2WgdFbHWGHzSibCpKSI7H1NuHHPgXGUoDD1Oi5bvvAtqrJFn0QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734089485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTLtkHzy12odtnIO1vKXAuWcEdu57bgB/Jv6GnuDHv8=;
	b=+x5pgMyGr+foe7ZajdaaP14Qe3MGcUj0dv86Jw9Nzc8gz6PaSG+97PvZOjrqYUiGnAzc02
	x2Z4VBjRu+Gh8JAw==
To: Ming Lei <ming.lei@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, "x86@kernel.org"
 <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, kexec
 <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, Paolo Bonzini
 <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, John Ogness
 <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Jens Axboe
 <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
In-Reply-To: <Z1wV9SsaVe3torbO@fedora>
References: <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora>
Date: Fri, 13 Dec 2024 12:31:24 +0100
Message-ID: <87y10j95v7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_033126_770719_EBBCE578 
X-CRM114-Status: GOOD (  15.30  )
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

On Fri, Dec 13 2024 at 19:09, Ming Lei wrote:
> On Fri, Dec 13, 2024 at 11:42:59AM +0100, Thomas Gleixner wrote:
>> That's the control thread on CPU0. The hotplug thread on CPU1 is stuck
>> here:
>> 
>>  task:cpuhp/1         state:D stack:0     pid:24    tgid:24    ppid:2      flags:0x00004000
>>  Call Trace:
>>   <TASK>
>>   __schedule+0x51f/0x1a80
>>   schedule+0x3a/0x140
>>   schedule_timeout+0x90/0x110
>>   msleep+0x2b/0x40
>>   blk_mq_hctx_notify_offline+0x160/0x3a0
>>   cpuhp_invoke_callback+0x2a8/0x6c0
>>   cpuhp_thread_fun+0x1ed/0x270
>>   smpboot_thread_fn+0xda/0x1d0
>> 
>> So something with those blk_mq fixes went sideways.
>
> The cpuhp callback is just waiting for inflight IOs to be completed when
> the irq is still live.
>
> It looks same with the following report:
>
> https://lore.kernel.org/linux-scsi/F991D40F7D096653+20241203211857.0291ab1b@john-PC/
>
> Still triggered in case of kexec & qemu, which should be one qemu
> problem.

I'd rather say, that's a kexec problem. On the same instance a loop test
of suspend to ram with pm_test=core just works fine. That's equivalent
to the kexec scenario. It goes down to syscore_suspend() and skips the
actual suspend low level magic. It then resumes with syscore_resume()
and brings the machine back up.

That runs for 2 hours now, while the kexec muck dies within 2
minutes....

And if you look at the difference of these implementations, you might
notice that kexec just implemented some rudimentary version of the
actual suspend logic. Based on let's hope it works that way.

This is just insane and should be rewritten to actually reuse the suspend
mechanism, which is way better tested than this kexec jump muck.

Thanks,

        tglx

