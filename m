Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769CDE7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 11:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uxy6mePHA2mFbKxl3XRp7ln++RG16/GzEJG31dpj1nE=; b=A2/YwqcyUH19JXc9QtkbhfMXyR
	y1rpi8x+3hhqvqnOJYDSpBL+65G8y4q5NgrI+9w88SxcqLNktFI7mvNcSuzxgX65LQ+l2JQ+VSt5s
	CxqgALJ35VAXffm9HdNZIFFgl8NYy4KkJUKKktRcwsv6ZKzcRFjkLgXH8tkE4pmhFAvOMVnAgy/w3
	9x1gTq6UWsn+r9AFZhfyQznV/x25yT6rDEGQQ9NM8aZXJQItyHiDQaX0u2Zy6q5YbeR7FTKOz5t/P
	fCr/+03So4h4+uGV6KZga8Bjh2b3UTrUOqjq95yx+cQM7qKwcUn0Oo8DZ5/h94Y7oAN5EJh01pKg2
	7ixfIw5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3Yg-00000003Vxk-31He;
	Fri, 13 Dec 2024 11:10:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3Yd-00000003Vwd-4B99
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 11:10:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734088206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uxy6mePHA2mFbKxl3XRp7ln++RG16/GzEJG31dpj1nE=;
	b=FNvLDVTrsnfv8rZafCkk4tCTatkpkC0sfWPzgPCRI1lgcQ0QKnXUXLZMNOyNDi/+wAjfdJ
	/4tTcLn/5W2P5RXyqGR6bDnUFKVbzNBNcWM+VUFWt0uJtIE/wImibVmjwU5kYIgJdFZe+Q
	BV3EIbIkHteK6HI5liB8UIkWd6sECqs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-GML14rjxNomuNcIIJA4JxQ-1; Fri,
 13 Dec 2024 06:10:02 -0500
X-MC-Unique: GML14rjxNomuNcIIJA4JxQ-1
X-Mimecast-MFC-AGG-ID: GML14rjxNomuNcIIJA4JxQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73631195608E;
	Fri, 13 Dec 2024 11:09:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.91])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88A1D1956086;
	Fri, 13 Dec 2024 11:09:47 +0000 (UTC)
Date: Fri, 13 Dec 2024 19:09:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>,
	kexec <kexec@lists.infradead.org>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	eperezma <eperezma@redhat.com>, Paolo Bonzini <bonzini@redhat.com>,
	Petr Mladek <pmladek@suse.com>, John Ogness <jogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
Message-ID: <Z1wV9SsaVe3torbO@fedora>
References: <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pybamoc.ffs@tglx>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_031008_117322_D4C5826B 
X-CRM114-Status: GOOD (  15.74  )
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

On Fri, Dec 13, 2024 at 11:42:59AM +0100, Thomas Gleixner wrote:
> On Fri, Dec 13 2024 at 09:43, David Woodhouse wrote:
> > On Fri, 2024-12-13 at 09:31 +0000, David Woodhouse wrote:
> >> 
> >> (gdb) p sysrq_handle_showstate('t')
> >> 
> >> That didn't work. Maybe if I'd actually had no_console_suspend on this
> >> boot. Will try again.
> >
> > With your fix I get the same thing (both CPUs in idle thread). And with
> > no_console_suspend on the command line, 'p sysrq_handle_showstate('t')'
> > does work...
> >
> > [  113.462898] task:loadret         state:D stack:0     pid:707   tgid:707   ppid:531    flags:0x00004002
> > [  113.463615] Call Trace:
> > [  113.463841]  <TASK>
> > [  113.464029]  __schedule+0x502/0x1a10
> > [  113.464961]  schedule+0x3a/0x140
> > [  113.465234]  schedule_timeout+0xcc/0x110
> > [  113.465580]  __wait_for_common+0x91/0x1c0
> > [  113.466304]  cpuhp_kick_ap_work+0x13e/0x390
> > [  113.466657]  _cpu_down+0xd4/0x370
> > [  113.466936]  freeze_secondary_cpus.cold+0x3f/0xd4
> > [  113.467326]  kernel_kexec+0xa2/0x1a0
> 
> That's the control thread on CPU0. The hotplug thread on CPU1 is stuck
> here:
> 
>  task:cpuhp/1         state:D stack:0     pid:24    tgid:24    ppid:2      flags:0x00004000
>  Call Trace:
>   <TASK>
>   __schedule+0x51f/0x1a80
>   schedule+0x3a/0x140
>   schedule_timeout+0x90/0x110
>   msleep+0x2b/0x40
>   blk_mq_hctx_notify_offline+0x160/0x3a0
>   cpuhp_invoke_callback+0x2a8/0x6c0
>   cpuhp_thread_fun+0x1ed/0x270
>   smpboot_thread_fn+0xda/0x1d0
> 
> So something with those blk_mq fixes went sideways.

The cpuhp callback is just waiting for inflight IOs to be completed when
the irq is still live.

It looks same with the following report:

https://lore.kernel.org/linux-scsi/F991D40F7D096653+20241203211857.0291ab1b@john-PC/

Still triggered in case of kexec & qemu, which should be one qemu
problem.


Thanks, 
Ming


