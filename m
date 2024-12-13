Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCB7E7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dv3t7bZUI3+tqYgjemQqhW+HuqlPgsCuhawdU9w0NMo=; b=Y+PaBN7r/clzQdiT1T3VGpySeo
	/oPNx5q6uuEyi7XiKxVa6MIuN0VvcOKIrux/hXVtBWtZh/gylXxP1jdURkZiXULG3RD5hT5gqeox8
	6iSKry1UQfztbokXxOOnuNIMijFyU+jzu4tfJVdJlSqMtVsZaZx2e7LZboQYTgQAdUKEV33M+sob1
	YEI+rpcuWQlKM206PjYBFt7pwaHc5vF4m4mHZBEuzs8S3CBo44ypbz5Hh6PcRzEWC8LP/2LIZzo0b
	oUd71C04O0Oz1fxcn+gS9y7QKL2pIvLP3SzmTYyaQ9GEOgufWOOcD3r7rthGw0R+tbcxhccQsLGG5
	ZTBVQ0LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM4AL-00000003czx-3fKd;
	Fri, 13 Dec 2024 11:49:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM4AI-00000003cyZ-3EPN
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 11:49:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734090541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dv3t7bZUI3+tqYgjemQqhW+HuqlPgsCuhawdU9w0NMo=;
	b=HXcUB8qQK/1UVIDRsMnc8V6E7IjSw/1KtabYmEW+I6okWPeT4Hch6GOkoKX8DzLP7zF8qN
	KXWMm7eqMMk6EkuNfvQTPElaC35vxu6gKlXrGvyTO3VD+spJuGj2jlEN1fihChGOA+EpgB
	nGKa8RY+rRuP486K9KYfbIeclqgepuY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-JM6VGjjpNjCfIaQUCLIzbA-1; Fri,
 13 Dec 2024 06:48:58 -0500
X-MC-Unique: JM6VGjjpNjCfIaQUCLIzbA-1
X-Mimecast-MFC-AGG-ID: JM6VGjjpNjCfIaQUCLIzbA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 202E2195604F;
	Fri, 13 Dec 2024 11:48:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7702300FA98;
	Fri, 13 Dec 2024 11:48:44 +0000 (UTC)
Date: Fri, 13 Dec 2024 19:48:39 +0800
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
	Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
Message-ID: <Z1wfF6NJRZh1jROz@fedora>
References: <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx>
 <Z1wV9SsaVe3torbO@fedora>
 <87y10j95v7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y10j95v7.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_034902_886467_63D9842B 
X-CRM114-Status: GOOD (  23.18  )
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

On Fri, Dec 13, 2024 at 12:31:24PM +0100, Thomas Gleixner wrote:
> On Fri, Dec 13 2024 at 19:09, Ming Lei wrote:
> > On Fri, Dec 13, 2024 at 11:42:59AM +0100, Thomas Gleixner wrote:
> >> That's the control thread on CPU0. The hotplug thread on CPU1 is stuck
> >> here:
> >> 
> >>  task:cpuhp/1         state:D stack:0     pid:24    tgid:24    ppid:2      flags:0x00004000
> >>  Call Trace:
> >>   <TASK>
> >>   __schedule+0x51f/0x1a80
> >>   schedule+0x3a/0x140
> >>   schedule_timeout+0x90/0x110
> >>   msleep+0x2b/0x40
> >>   blk_mq_hctx_notify_offline+0x160/0x3a0
> >>   cpuhp_invoke_callback+0x2a8/0x6c0
> >>   cpuhp_thread_fun+0x1ed/0x270
> >>   smpboot_thread_fn+0xda/0x1d0
> >> 
> >> So something with those blk_mq fixes went sideways.
> >
> > The cpuhp callback is just waiting for inflight IOs to be completed when
> > the irq is still live.
> >
> > It looks same with the following report:
> >
> > https://lore.kernel.org/linux-scsi/F991D40F7D096653+20241203211857.0291ab1b@john-PC/
> >
> > Still triggered in case of kexec & qemu, which should be one qemu
> > problem.
> 
> I'd rather say, that's a kexec problem. On the same instance a loop test
> of suspend to ram with pm_test=core just works fine. That's equivalent
> to the kexec scenario. It goes down to syscore_suspend() and skips the
> actual suspend low level magic. It then resumes with syscore_resume()
> and brings the machine back up.
> 
> That runs for 2 hours now, while the kexec muck dies within 2
> minutes....
> 
> And if you look at the difference of these implementations, you might
> notice that kexec just implemented some rudimentary version of the
> actual suspend logic. Based on let's hope it works that way.
> 
> This is just insane and should be rewritten to actually reuse the suspend
> mechanism, which is way better tested than this kexec jump muck.

But kexec is supposed to align with reboot/shutdown, instead of suspend,
and it is calling ->shutdown() for notifying driver & device.

Thanks,
Ming


