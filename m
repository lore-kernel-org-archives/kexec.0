Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F456E7717F
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eUAYbttyFID//0HTKVjVEhpBY+NVi8GKFtPcgNCpaOk=; b=CvACO4bCuPCrkuDmGSJd7mEW5n
	STl8AhbIUIGv0CdmZ4hwKIjnVz8HorxJDP4mz67I8ELi47Qsx4aO0S5B5yQUe4EccDh/axB51uCaC
	PmKsKvUUymaOwY9uqGALeiDkE1zSS0Fuz3feeFmT5Q7FEdqNSXDhWa2e8ybPjVCZ9qVhndnnzW3Se
	xk+M6Q831Aka0Biot2jDEOXERjx52tgyx9HdWUz3Jup5jWWzoiBCKqEcnVhK7B7+cFSt1+/uh0WQR
	uCKVFirG2+G6G3M5ZGM/Ta0tUbkqzjpxP9Bd7kMhdUj8cXOVnp0GgmwbWINBGw4joJ840UbSvafYb
	TpTDKsQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMB0H-00000004kdT-1Bof;
	Fri, 13 Dec 2024 19:07:09 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMB0E-00000004kcU-2xXK
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 19:07:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AED89A42DBB
	for <kexec@lists.infradead.org>; Fri, 13 Dec 2024 19:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43857C4CEE1
	for <kexec@lists.infradead.org>; Fri, 13 Dec 2024 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734116825;
	bh=JcLKws40yFdRTtJnXA+ZbB/1F7xJ4hkgw1EMwlWdgg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LMEBZwT+2QZrFWy8zFqPbM0WI52tOTRx+dAZwzonn0BRdAUAfgy4p4m2W0kYBgMe5
	 wtt+w7WMdfhUSyK93uYQJOiYAjft7DT17ZwmrmZyLJcyQml3MIpk3AlZJRBcS3q2dc
	 nkEZ7OtfFPFctNc+ZbQhMqKqpD19sIakDElH+Gh9Zu9IqXwpApbNWcL7458TRo3qtU
	 /DQV48tek5/6cf0TBT34vkqh9gEJMSEtc1mDSBKmo8I09tprpEn1jdXdSfgVnOp/qL
	 8IVRAAlHJ1z6MKwHso56StCj7jzdsGOMH3DgIDojyqD9irZN6UF182zbFdZ2r+kgyb
	 yEZOTzBBqfpXg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29fae583cc8so1024093fac.1
        for <kexec@lists.infradead.org>; Fri, 13 Dec 2024 11:07:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9NG6Ju054+IJlDTDHl1KsCuK32Ct3NEECC0FHA/E5kmon96tA6fIwQlgQAujsIjPY19FCZw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0AKLSWJGdG9v2po30C8XZHaLac/emUzntrfVv4HaihwIyRkZ0
	GZnJP9Lv+SrjqLzQnTcocRs2AYJXAu3LZI1XrRrssab0pkr6L4oKTc4hPQocMezvQ/gHvOSZhUY
	hhn8bBVR5/o1BWtFVDcKfWpz+Y28=
X-Google-Smtp-Source: AGHT+IHFYlygRpUxhmDvsnKstQkQrdlDutDXvlyZYpQ3L20ftrb+3paxMS/AwESygHPU6Bu20IY9ZwiVsLsOqAgeuTc=
X-Received: by 2002:a05:6808:2191:b0:3ea:4b5c:60a8 with SMTP id
 5614622812f47-3eba6be35aamr1891339b6e.17.1734116824374; Fri, 13 Dec 2024
 11:07:04 -0800 (PST)
MIME-Version: 1.0
References: <87ldwl9g93.ffs@tglx> <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx> <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx> <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx>
 <Z1wfF6NJRZh1jROz@fedora> <87pllv90ow.ffs@tglx> <1a7c126f3ab8ae75e755d01a6bf9bc06730dd239.camel@infradead.org>
 <87msgz8qes.ffs@tglx> <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 20:06:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hBUgOB4QhhwjusRcP+jksWFL-upR5En58g9RD5+n70JA@mail.gmail.com>
Message-ID: <CAJZ5v0hBUgOB4QhhwjusRcP+jksWFL-upR5En58g9RD5+n70JA@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, 
	dyoung <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_110706_865647_2E9847F1 
X-CRM114-Status: GOOD (  31.64  )
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

On Fri, Dec 13, 2024 at 6:32=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Dec 13, 2024 at 6:05=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> >
> > On Fri, Dec 13 2024 at 14:07, David Woodhouse wrote:
> > > On Fri, 2024-12-13 at 14:23 +0100, Thomas Gleixner wrote:
> > >> That's only true for the case where the new kernel takes over.
> > >>
> > >> In the case KEXEC_JUMP=3Dn and kexec_image->preserve_context =3D=3D =
true, then
> > >> it is supposed to align with suspend/resume and if you look at the c=
ode
> > >> then it actually mimics suspend/resume in the most dilettanteish way=
.
> > >
> > > Did you mean KEXEC_JUMP=3Dy there?
> >
> > Yes, of course.
> >
> > > I spent a while the other week trying to understand the case where
> > > CONFIG_KEXEC_JUMP=3Dn and kexec_image->preserve_context=3Dtrue, and c=
ame to
> > > the conclusion that it was a mirage. Userspace can't *actually* set t=
he
> > > KEXEC_PRESERVE_CONTEXT bit when setting up the image, if KEXEC_JUMP=
=3Dn.
> > >
> > > The whole of the code path for that case is dead code. It's confusing
> > > because as discussed elsewhere, we don't just #ifdef out the whole of
> > > that dead code path, but only the bits which don't actually *compile*
> > > (like references to restore_processor_state() etc.).
> >
> > Yes, I had to stare at it quite a while. :)
> >
> > >> It's a patently bad idea to clobber the kernel with kexec jump "fixe=
s"
> > >> instead of using the well tested and established suspend/resume
> > >> machinery.
> > >>
> > >> All it takes is to:
> > >>
> > >>     1) disable the wakeup logic
> > >>
> > >>     2) provide a mechanism to invoke machine_kexec() instead of the
> > >>        actual suspend mechanism.
> > >>
> > >> No?
> > >
> > > Agreed. The hacky proof of concept I posted earlier invoking
> > > machine_kexec() instead of suspend_ops->enter() works fine. I'll look
> > > at cleaning it up and making it not invoke all the ACPI hooks for
> > > *actual* suspend to RAM, etc.
> >
> > Something like the below? It survived an hour of loop testing.
>
> I think that this KEXEC_JUMP thing can be dropped entirely and forgotten.
>
> I'm not aware of anyone actually using it.

And now I've been made aware that it's used.  Oh well.

As discussed with Dave over IRC, the current implementation isn't
actually that bad.  It might use PMSG_THAW instead of PMSG_RESTORE in
kernel_kexec(), but other than this it reflects the code flow around
the jump from the restore kernel to the image one during resume from
hibernation.

This means that hibernation and kexec jump could be unified somewhat.

