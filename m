Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C51E7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4v7iI7NsdR7W7wI3JpdV5vWmxBirJALp5sc+8kyw1GU=; b=4w/jEbgKPqLfOQpjvDly9rPg2q
	+OAD7Dvcf3LAwRLmJ4pt2IWZyI9V9pK8NlAbfodxV2O3Q7dpbK1ZpOAOBxr3ezocxloVwKKV9ENn8
	T+uPvAemo55ESDSRamKcjuvsbADVcpmKFj+Rju9nQvy4BgR7iamvhnpTjOnHXVlcU4L9NPPctgIkN
	kp0vHWbo6gre3XvULD6WbbkYKhKDfcGtdYjfrTf4sNQ0Xw0BfAJ/xLU7lx1V5QViq5p+yuo9A7jww
	1WmzDmRX4oo4/dcNXpLZvuDsoro1nZt9sdd9aXU5NHJEj6j/sW+BzTHLHBEulmtWqgYhh124SyNhb
	T9bQ7ryw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM38T-00000003Saq-0RoG;
	Fri, 13 Dec 2024 10:43:05 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM38Q-00000003SZz-1lkZ
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 10:43:03 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734086580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4v7iI7NsdR7W7wI3JpdV5vWmxBirJALp5sc+8kyw1GU=;
	b=tv/3FauS2tZFkNX+Xpf41e+97r2jY578h6xXIgjIaO8Zruqbjmkfo1vHnlwLLZI4Ns1vzL
	GdwAdoutp8GrLb7Eu88I8AdeorE6IFPJlcsy8p7GnQnc9DAiSnLxysXrrHDcR5AvQJAQZb
	Xcdi/bO6jzIi7xfnUgq/xT8p+sP1qIKTWZXZ8lGnFcA1wx8uTHfoeRMcMfv1wTyOFJY+pS
	hUnHMu4QOC/Aj9CcR/BAR+yRWqhRD9V4wjIqgXPgk7VqgqPRYQTmJbphTH7PmDRnGiPSKM
	50iZF9FSRAes1Po49/+Q3wn2aLLxlSUrEuHBGqeU4keFP6VwQ/8jXn6dM8FzUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734086580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4v7iI7NsdR7W7wI3JpdV5vWmxBirJALp5sc+8kyw1GU=;
	b=ksx2RuHKHeyUpzrATTiczcoFIxOazBpzr/wc5/beWTteLjyDwIqhB846HZIPvkd+/rVDWO
	LuDwNdF5bwh3evDA==
To: David Woodhouse <dwmw2@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung
 <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, linux-ext4
 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>, ming.lei@redhat.com, Petr Mladek
 <pmladek@suse.com>, John Ogness <jogness@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
In-Reply-To: <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
Date: Fri, 13 Dec 2024 11:42:59 +0100
Message-ID: <871pybamoc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_024302_596967_9D5ED78B 
X-CRM114-Status: UNSURE (   8.52  )
X-CRM114-Notice: Please train this message.
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

On Fri, Dec 13 2024 at 09:43, David Woodhouse wrote:
> On Fri, 2024-12-13 at 09:31 +0000, David Woodhouse wrote:
>> 
>> (gdb) p sysrq_handle_showstate('t')
>> 
>> That didn't work. Maybe if I'd actually had no_console_suspend on this
>> boot. Will try again.
>
> With your fix I get the same thing (both CPUs in idle thread). And with
> no_console_suspend on the command line, 'p sysrq_handle_showstate('t')'
> does work...
>
> [  113.462898] task:loadret         state:D stack:0     pid:707   tgid:707   ppid:531    flags:0x00004002
> [  113.463615] Call Trace:
> [  113.463841]  <TASK>
> [  113.464029]  __schedule+0x502/0x1a10
> [  113.464961]  schedule+0x3a/0x140
> [  113.465234]  schedule_timeout+0xcc/0x110
> [  113.465580]  __wait_for_common+0x91/0x1c0
> [  113.466304]  cpuhp_kick_ap_work+0x13e/0x390
> [  113.466657]  _cpu_down+0xd4/0x370
> [  113.466936]  freeze_secondary_cpus.cold+0x3f/0xd4
> [  113.467326]  kernel_kexec+0xa2/0x1a0

That's the control thread on CPU0. The hotplug thread on CPU1 is stuck
here:

 task:cpuhp/1         state:D stack:0     pid:24    tgid:24    ppid:2      flags:0x00004000
 Call Trace:
  <TASK>
  __schedule+0x51f/0x1a80
  schedule+0x3a/0x140
  schedule_timeout+0x90/0x110
  msleep+0x2b/0x40
  blk_mq_hctx_notify_offline+0x160/0x3a0
  cpuhp_invoke_callback+0x2a8/0x6c0
  cpuhp_thread_fun+0x1ed/0x270
  smpboot_thread_fn+0xda/0x1d0

So something with those blk_mq fixes went sideways.

Thanks,

        tglx

