Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB8CECAAD3
	for <kexec@archiver.kernel.org>; Mon, 19 Sep 2022 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XRVzavKzK8SCtXtzDyLA4GIpsmXG+3Q1X9mLHS2RIsg=; b=iE+MoVOC/Whd5c
	ygKZvvP5neBfiqQXxSRc7Pc8SQWhUHWY2MBRJ98VeWEIHOJvL6pZXbRXfr3Hq60xEVk992KyI4Mtr
	W7J+SET6q3Rc7g2QtuCd+A5+iI8UPtmazo6r8NybGhvLZD/1vOl1GSEgDZhtDkDO3+wLlQbPxX/yp
	l0+kqEHpMT5hjn3WJc0n35A+SaG6ER8Qo6D1f+fiYOA78p0ZEf5Ye9dHx/5sdPz4kgYeFxBKhGpgb
	kSqZSxio4Qp3M4Mxz17wr5ZJJ7QZeeLZ/4kSBG0jjXWymrKep4IcIh62GoqW/8HmcHv9XiRW3mdxn
	5m2HgnbRHmHC8d3OMmmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaGMp-00Bm4f-KF; Mon, 19 Sep 2022 12:59:19 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZv2T-00GtN1-40
	for kexec@lists.infradead.org; Sun, 18 Sep 2022 14:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vgMvcabAponECpj7LkBelpsJYBmHvShrlJGOD0sG9pE=; b=TTCkZr67oCPEg4W6TAiKui93RE
	zGjwqVg2v7U28Zq7BmtnJIFeyKD3RT6oaLMZytqo0SmjtEi4xnnUZqEBIbo/sn14Qf049AyKT6vg+
	qUbhrl6Ky7sFlpcv9Vb6f5aUY6b6Bx1pNiCwBOZ8OP0fTxR/8WA7ez8BWfoMquFKgo8U+n+Yf9GPd
	Ma9bQpq2RIHh0j96uScSPjHqUWY76MvQPZs/tqV0JGBh+7TxIEM4PTR3LajWg0nZipmu/MTHquGn4
	HYm5FoWXA1hIeNeFC4M3jrSlTjfoWBmKP+f1HGX54rU4kAEWX4QGbCqjXseT9yyCLWET4dvJcyPXF
	oWj2nxOQ==;
Received: from 201-27-35-168.dsl.telesp.net.br ([201.27.35.168] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oZv2N-0081tk-VV; Sun, 18 Sep 2022 16:12:48 +0200
Message-ID: <89f8fb2d-3f39-4591-190c-f134c4c173a6@igalia.com>
Date: Sun, 18 Sep 2022 11:12:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 09/11] video/hyperv_fb: Avoid taking busy spinlock on
 panic path
Content-Language: en-US
To: linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Cc: kexec@lists.infradead.org, pmladek@suse.com, bhe@redhat.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 gregkh@linuxfoundation.org, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com,
 vkuznets@redhat.com, will@kernel.org, xuqiang36@huawei.com,
 Andrea Parri <parri.andrea@gmail.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Wei Liu <wei.liu@kernel.org>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-10-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-10-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_071253_260176_57FA34FA 
X-CRM114-Status: GOOD (  13.91  )
X-Mailman-Approved-At: Mon, 19 Sep 2022 05:59:14 -0700
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

On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
> The Hyper-V framebuffer code registers a panic notifier in order
> to try updating its fbdev if the kernel crashed. The notifier
> callback is straightforward, but it calls the vmbus_sendpacket()
> routine eventually, and such function takes a spinlock for the
> ring buffer operations.
> 
> Panic path runs in atomic context, with local interrupts and
> preemption disabled, and all secondary CPUs shutdown. That said,
> taking a spinlock might cause a lockup if a secondary CPU was
> disabled with such lock taken. Fix it here by checking if the
> ring buffer spinlock is busy on Hyper-V framebuffer panic notifier;
> if so, bail-out avoiding the potential lockup scenario.
> 
> Cc: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Tested-by: Fabio A M Martins <fabiomirmar@gmail.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - simplified the code based on Michael's suggestion - thanks!
> 
> V2:
> - new patch, based on the discussion in [0].
> [0] https://lore.kernel.org/lkml/2787b476-6366-1c83-db80-0393da417497@igalia.com/
> 
> 
>  drivers/hv/ring_buffer.c        | 13 +++++++++++++
>  drivers/video/fbdev/hyperv_fb.c |  8 +++++++-
>  include/linux/hyperv.h          |  2 ++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> [...]

Hi Michael, apologies for the ping.
Any reviews/comments on this one are greatly appreciated!

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
