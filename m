Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EF4E7717F
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+U2cB2AR6c3PWXFbRG1BRKzFnatFei3DSH4V4HnGDdU=; b=o9LpiqPrvECh/VJ7aeNmeHTKld
	/YEWE2fRq99g9T1qJNTyw9rQxzEXTQGnO4r5v0RegUYYcMcY6+Sc6yytPLVZKNglPRucVpzi4O4Q5
	VGjy/eoNIObk0iwCtFiM543hXo3kZV+f77Fb7ARnkg3MI2DuNuSRXqw+KDB3att0dQnJVYs9TzUqG
	gcDLP7ZftNSglyv97gkdY6nqNZb7k1FTum7K+CkjxYEV4UtWJmjz7oMMzXAs9hUb1DFOZh1XTr3yo
	SwrhoJ8KeS2l5dNcLhH3Qr5VGviS431K1NmWIPksCBJGWomO+n/ZaWl/KCjOmRhProM9CRMQnW/MH
	JWbj1eUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tN9zp-00000009wSn-1hB3;
	Mon, 16 Dec 2024 12:14:45 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tN9zm-00000009wRR-2GYt
	for kexec@lists.infradead.org;
	Mon, 16 Dec 2024 12:14:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E5D24A40F67
	for <kexec@lists.infradead.org>; Mon, 16 Dec 2024 12:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1A9C4AF09
	for <kexec@lists.infradead.org>; Mon, 16 Dec 2024 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734351281;
	bh=I8BRA+E+7sIy/PeX8Wl+oBzLMGuM9Kf3XA5Fd7iH730=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YQj3weIs3D0RsxFOU/sVgtLeEdSz667AUOEk+xDN2Rt5+CQ5obHd+6BZ+BI3Oqi5d
	 F8dUx6PBKhU/nCkpczkCgMi88tJl12LYcJd7/6YK1nXFETpZI2qb+nvOS60oawk04W
	 mNnpl4RtDPzZk+eKGgcdblBDtdHhywW59U4SA45xT62imOuhCDcHjHxXUTh8Q0oTSW
	 0JpM2fdGooco3+Y41nNqTbKB9emnqa6AW37N4ayDXEOtKwpSro0ffBzpA9mqH/WRyX
	 Leb6xYOctNK1ONLf9zc5rBWUlfsdWz3xUASV+3QzIitrmI6nzMvopeLLE9bGUufQU0
	 dDUgf9CwcX8YQ==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb790888c6so1182652b6e.2
        for <kexec@lists.infradead.org>; Mon, 16 Dec 2024 04:14:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGNjgG6oTpo8ZZtQjCIb0F1SJrTdT1T7u6h/IfuYkn5RvTvYohRBcDyZG6GDYMpEV1293dPw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3dbQ0v6YYbU0VI68ql36cvzfDNZfBfzq7hG4xz4k9LYJAf9td
	+DLRMNwD+9CDQIr6qrFrS5h/9+1XMy2e5EonnR8J8WqQ5jYwR/rt/84bC17PDmj70pVsz0W2DU+
	J9+gpK3gYzTO4w1o+g0bi999+uYE=
X-Google-Smtp-Source: AGHT+IEhIKzcP+ystGs9qCnC3kW6RLBVF8CarVw7viRsnLYJ5LXOeqEfGVxJYtIBVsNYGyJ3I71rnEn8fd++4R7Silg=
X-Received: by 2002:a05:6808:201a:b0:3e8:1ed7:e6cf with SMTP id
 5614622812f47-3eba67fec07mr6100991b6e.7.1734351280709; Mon, 16 Dec 2024
 04:14:40 -0800 (PST)
MIME-Version: 1.0
References: <87ldwl9g93.ffs@tglx> <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx> <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx> <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx>
 <Z1wfF6NJRZh1jROz@fedora> <87pllv90ow.ffs@tglx> <1a7c126f3ab8ae75e755d01a6bf9bc06730dd239.camel@infradead.org>
 <87msgz8qes.ffs@tglx> <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com>
 <CAJZ5v0hBUgOB4QhhwjusRcP+jksWFL-upR5En58g9RD5+n70JA@mail.gmail.com>
 <73E84E2B-001B-48D6-9BB4-B104D43F8FBF@infradead.org> <febd10dae881f29fa8236f3e2d6ad77a8f094d72.camel@infradead.org>
In-Reply-To: <febd10dae881f29fa8236f3e2d6ad77a8f094d72.camel@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 13:14:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jcOCffvfB3558eJxv39aMog1BtiJ1PQG0v-sJAPuV6JQ@mail.gmail.com>
Message-ID: <CAJZ5v0jcOCffvfB3558eJxv39aMog1BtiJ1PQG0v-sJAPuV6JQ@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ming Lei <ming.lei@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, 
	dyoung <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_041442_702409_C0A37FE5 
X-CRM114-Status: GOOD (  25.56  )
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

On Sat, Dec 14, 2024 at 10:57=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On Fri, 2024-12-13 at 20:16 +0000, David Woodhouse wrote:
> >
> > > As discussed with Dave over IRC, the current implementation isn't
> > > actually that bad.  It might use PMSG_THAW instead of PMSG_RESTORE in
> > > kernel_kexec(), but other than this it reflects the code flow around
> > > the jump from the restore kernel to the image one during resume from
> > > hibernation.
> > >
> > > This means that hibernation and kexec jump could be unified somewhat.
> >
> > Fair enough. I'm happy to do whatever cleanups or consolidation make
> > sense, if we have a consensus.
> >
> > There remains the question of why the blk-mq thing explodes on the
> > way down for both kjump and, apparently, even the plain kexec case.
>
> In case it's of any use, here's a test case I put together recently for
> kexec stress testing.
>
>  http://david.woodhou.se/kexec.initramfs
>
> It's just an initrd I boot in qemu with '-initrd kexec.initramfs' and
> it builds a copy of itself, then kexecs back into the same kernel with
> the same initrd. You'll need to drop your own bzImage into it.
>
> It was designed to run without a block device, but to trigger the
> blk-mq thing or the one at
> https://lore.kernel.org/linux-scsi/F991D40F7D096653+20241203211857.0291ab=
1b@john-PC/

Which BTW includes some quite convincing analysis of what's going on.

> we'd probably need to actually mount something and maybe do some disk
> I/O.

If I'm not mistaken, this should be also reproducible by echoing
"core" into /sys/power/pm_test and running "echo disk >
/sys/power/state" in a loop after that, unless the ksys_sync()
triggered by hibernate() makes it extremely unlikely.

