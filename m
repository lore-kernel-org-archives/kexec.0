Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59003E77180
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3bpvdWI+eL3zfkwy73QP27kFbbWD88VpQKD6hiA6hnM=; b=wBcaRwrhm3eeRo01gEimjTSCP9
	uvBuErTeu8RUlWmf9iWOp2tlplYfE+6dXzewOS/v+Dnhxc04JsvoQw99/uk5/ZOQq3MVqUcglyC92
	uih0x+B2GUZwTzouqaqamRnZqB4UuF5rvD0zvKLp7FYlqhHKadM3cdD9vW/g92WT38nck/grPI6cY
	C5i1AiB10YcG7Q18M8JALQWzEuarYZNc7ZUDE7Mbt0Bdt/Hu6Mrff+Zo0A4jrnTfaKNyZoHPuoXH9
	eseS8F2stemcy8+DqQWJFg2gitkffH+3LN5XFp3jZR23O3THqYt8n+GLAjAhsz4S+XmtR7lPEI7ek
	mRkDc2sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM9mb-00000004bxu-1aeL;
	Fri, 13 Dec 2024 17:48:57 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM9mZ-00000004bx1-21S9
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 17:48:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7E4BEA42D88
	for <kexec@lists.infradead.org>; Fri, 13 Dec 2024 17:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F367FC4AF09
	for <kexec@lists.infradead.org>; Fri, 13 Dec 2024 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734112134;
	bh=M7b7tnarEwfwtqSCYix3bezpHJTuYsFwpxXq61WSVIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vD+x9xI498336CXrIcipnGQtwPWE+Y8PtGBEoTA4qYZc1sEDVdhDhdeSVu2dH+7yh
	 POqVBPztBXeOs4yRsK8rgFr3HYOR0g3kt1+eyQb8ywyYTIStULKzhCAXJ9H5Y1izUw
	 8xfHxQDqeTm4KbpOE9lD2L+2qZTwrntOhIa3gHDt200F8v4O51jeFPlwHPweUdZwG6
	 00NXDJObSjW7SBHUmyHZC1ajrqKr2X9V6rLVsnLtjzsVBY306nlOty1OOzuo6voagU
	 udltc6zFfe3IkbfSKN37PDbXu4nWQgaVDNOD2oSwvhlzWC+2Xk1o8URkeHG5gXl4hC
	 DAtcpCJXfXE2A==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ea55a2a38bso1053980b6e.1
        for <kexec@lists.infradead.org>; Fri, 13 Dec 2024 09:48:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJtWSlH++KA+oSvfN46ZAycBUz2my3uJLc+Nbd9gf/t5LK0ZMiabK6qaedjolvAErMFm1rkA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyNCPhNshTww2rT2g2/nV3PkgFc/suLxUk9pJCeBQrRR8Q+wpYm
	tL23mu60Czw5NV1aN/dwSVHIyeqagdV8fSfLcuy/bx5n9dpzn4LSCsHkL6dQ1lQ70PiZvQVsICb
	rGacQ/WI/KihqRuE3edzeDqytntU=
X-Google-Smtp-Source: AGHT+IESFvKvWgj0dsEUDhhOZwimz3mooi2zlVcwYeEqdYKyZ7y1bibxTfBmH+X1npm8QzPhPSM3ze32YUu1NO+yIWo=
X-Received: by 2002:a05:6808:f01:b0:3eb:3b6e:a74b with SMTP id
 5614622812f47-3eba686b29dmr1982583b6e.17.1734112133232; Fri, 13 Dec 2024
 09:48:53 -0800 (PST)
MIME-Version: 1.0
References: <87ldwl9g93.ffs@tglx> <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx> <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx> <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx>
 <Z1wfF6NJRZh1jROz@fedora> <87pllv90ow.ffs@tglx> <1a7c126f3ab8ae75e755d01a6bf9bc06730dd239.camel@infradead.org>
 <87msgz8qes.ffs@tglx> <52850c8dbeb7c30d5bca007998f7ffd9a9b18d0f.camel@infradead.org>
In-Reply-To: <52850c8dbeb7c30d5bca007998f7ffd9a9b18d0f.camel@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 18:48:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hbWxKaVPM+sKqxj=bes1OqOEgFLXyWuzYUR9EHjHVf3A@mail.gmail.com>
Message-ID: <CAJZ5v0hbWxKaVPM+sKqxj=bes1OqOEgFLXyWuzYUR9EHjHVf3A@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>, 
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
X-CRM114-CacheID: sfid-20241213_094855_647658_73C2162C 
X-CRM114-Status: GOOD (  24.93  )
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

On Fri, Dec 13, 2024 at 6:17=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Fri, 2024-12-13 at 18:05 +0100, Thomas Gleixner wrote:
> >
> > > Agreed. The hacky proof of concept I posted earlier invoking
> > > machine_kexec() instead of suspend_ops->enter() works fine. I'll look
> > > at cleaning it up and making it not invoke all the ACPI hooks for
> > > *actual* suspend to RAM, etc.
> >
> > Something like the below? It survived an hour of loop testing.
>
> If I read that correctly, it's still invoking the standard platform
> (e.g. ACPI) hooks for suspend-to-RAM, when it probably shouldn't?
>
> I suspect it wants its *own* set of platform_suspend_ops, which are
> mostly empty apart from the ->enter() ?
>
> I started looking at that, but now my eyes are currently bleeding after
> seeing the existing platform_suspend_ops vs. platform_s2idle_ops
> structures, which are kind of similar but not the same. And the set of
> helper functions which invoke one or the other, from the barely
> tolerable platform_resume_end()...
>
> static void platform_resume_end(suspend_state_t state)
> {
>         if (state =3D=3D PM_SUSPEND_TO_IDLE && s2idle_ops && s2idle_ops->=
end)
>                 s2idle_ops->end();
>         else if (suspend_ops && suspend_ops->end)
>                 suspend_ops->end();
> }
>
> ... to the extra-special platform_resume_noirq() which is similar
> except that it needs three *different* names (_resume_noirq vs.
> restore_early vs. wake):
>
> static void platform_resume_noirq(suspend_state_t state)
> {
>         if (state =3D=3D PM_SUSPEND_TO_IDLE) {
>                 if (s2idle_ops && s2idle_ops->restore_early)
>                         s2idle_ops->restore_early();
>         } else if (suspend_ops->wake) {
>                 suspend_ops->wake();
>         }
> }
>
>
> I wonder if we end up wanting a *third* set there, for the kjump_ops?

No, no.

The "vision" behind kexec jump was to use it for implementing
hibernation, but that never happened.

It doesn't actually need any platform ops at all because everything it
does is to jump from one kernel to another, both residing in memory at
this point.  No firmware is involved.

> Except can we unify the structure definitions and then just *use* the
> appropriate one of the three, which is either passed down or selected
> using the 'state'?

That can be done I suppose, but it won't help much in the kexec jump case.

