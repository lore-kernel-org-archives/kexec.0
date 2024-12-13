Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46D8E7717F
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 17:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DoswppzT137TkvIaOOQZiZQXry7ujA07zt08bI1jF6Y=; b=ckwX+PeuJnYdInzSCXwvBRF+Aa
	2Oer8v1RY9FEbTSpU9aOKB+G9JRpL35Ng71O0rV7EH6vt6dwJV7jORyIIDDTv8D/DsOyuztlhZVvc
	iRomLvsE4IX/g0c2j8NzJ8rWSJ9g0qcPMLoeSi2904XbdjW8Shytl4a/eKhYjpwgIXE4QuyBNa/p/
	zMONT81+dMe2NKjALcL2XzwhiQzsp4/B+tlUmSEQ1/B2UcHpzPqTklbUPHvNGl3s9VsuXlXnt++gw
	h/5u8kwMDDlw97vnRekUDx/MLgki0WRyRFcTCRnP+p4hh32t7BhMnApvKbu1/dXXWHy/k3UYm7YHa
	wyH6PrbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM9Wj-00000004ZMC-0yQn;
	Fri, 13 Dec 2024 17:32:33 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM9Wh-00000004ZLb-0z13
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 17:32:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 62AF5A42B4E
	for <kexec@lists.infradead.org>; Fri, 13 Dec 2024 17:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3600AC4CED0
	for <kexec@lists.infradead.org>; Fri, 13 Dec 2024 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734111150;
	bh=CF08WCO9YuKQC0mJOaDTgK7Du1Q7g3g6IhdZFvpLNno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lzD1SE58v5Nq1phH9HPogH7xmQLl/dCGklMKO3/58GDI0MvboFYcgBFi98kO2Nli4
	 Wfo7RRfmxb/GP//4cYGOXGqG8ZPuA4dvwq+s33Arf3naJwvH/jdPa2to92PUe8PJRd
	 zAq8sz9uLiEg9APQN7FwHPrQlbsI4bT/abS5egdugOmhNE7nCWx4oMle2vOYq8UHLx
	 uobSz9H1dzmhzqIJpS+Ran9mccZ0rFgK/hnxmlm/VU1rGpIlbdosJkfm3x3JZEDsng
	 bQqWnm61RGqPrTU0nXxnsKBp1JLx/AFKneEMvkEjuSj+YVSImKJM0ugXQh7B+hwOJb
	 hzzsHLF1Nw8mw==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb6210742aso1016984b6e.1
        for <kexec@lists.infradead.org>; Fri, 13 Dec 2024 09:32:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXryzqpZmRyMPEtVo816BVKU6g8yZuZilbdE0SAUfGV6plq82QMr1mhp2y3dzBk008uZgr6Ng==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywkv7gA8TxhfW7dWHwwJbVDVGcyIfdzwxLD57C1fEqmidUkWUoc
	IJeM/WpEUrwZ2OlfQAN95jJGTF9jYMqO4KgvNZbgOwVIgY0gsyvTwNJRuXAMN+SOedj3ysSuDAJ
	8JecsCvrAP5nQU2PmmMCMmf6uJHs=
X-Google-Smtp-Source: AGHT+IGiXZt+WBiBE09BAmIkicVAdGZ3SDRVxvwU9UwpvBHBwlc8M1ZEhUTEOrlND9qAksD/X38mvCXH2Lr/v3RQBGk=
X-Received: by 2002:a05:6808:152c:b0:3e5:f7c1:757b with SMTP id
 5614622812f47-3eb94ecaccfmr4706039b6e.9.1734111149525; Fri, 13 Dec 2024
 09:32:29 -0800 (PST)
MIME-Version: 1.0
References: <87ldwl9g93.ffs@tglx> <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx> <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx> <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx>
 <Z1wfF6NJRZh1jROz@fedora> <87pllv90ow.ffs@tglx> <1a7c126f3ab8ae75e755d01a6bf9bc06730dd239.camel@infradead.org>
 <87msgz8qes.ffs@tglx>
In-Reply-To: <87msgz8qes.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 18:32:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com>
Message-ID: <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Ming Lei <ming.lei@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, 
	kexec <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_093231_336359_AD426855 
X-CRM114-Status: GOOD (  28.51  )
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

On Fri, Dec 13, 2024 at 6:05=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Fri, Dec 13 2024 at 14:07, David Woodhouse wrote:
> > On Fri, 2024-12-13 at 14:23 +0100, Thomas Gleixner wrote:
> >> That's only true for the case where the new kernel takes over.
> >>
> >> In the case KEXEC_JUMP=3Dn and kexec_image->preserve_context =3D=3D tr=
ue, then
> >> it is supposed to align with suspend/resume and if you look at the cod=
e
> >> then it actually mimics suspend/resume in the most dilettanteish way.
> >
> > Did you mean KEXEC_JUMP=3Dy there?
>
> Yes, of course.
>
> > I spent a while the other week trying to understand the case where
> > CONFIG_KEXEC_JUMP=3Dn and kexec_image->preserve_context=3Dtrue, and cam=
e to
> > the conclusion that it was a mirage. Userspace can't *actually* set the
> > KEXEC_PRESERVE_CONTEXT bit when setting up the image, if KEXEC_JUMP=3Dn=
.
> >
> > The whole of the code path for that case is dead code. It's confusing
> > because as discussed elsewhere, we don't just #ifdef out the whole of
> > that dead code path, but only the bits which don't actually *compile*
> > (like references to restore_processor_state() etc.).
>
> Yes, I had to stare at it quite a while. :)
>
> >> It's a patently bad idea to clobber the kernel with kexec jump "fixes"
> >> instead of using the well tested and established suspend/resume
> >> machinery.
> >>
> >> All it takes is to:
> >>
> >>     1) disable the wakeup logic
> >>
> >>     2) provide a mechanism to invoke machine_kexec() instead of the
> >>        actual suspend mechanism.
> >>
> >> No?
> >
> > Agreed. The hacky proof of concept I posted earlier invoking
> > machine_kexec() instead of suspend_ops->enter() works fine. I'll look
> > at cleaning it up and making it not invoke all the ACPI hooks for
> > *actual* suspend to RAM, etc.
>
> Something like the below? It survived an hour of loop testing.

I think that this KEXEC_JUMP thing can be dropped entirely and forgotten.

I'm not aware of anyone actually using it.

