Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF644C4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oHggWXBEHwEkm7E6ec3wMUq0bi8f7fhVcVQVAKiXHao=; b=2kda4y3dOTi5QrH0Zma0FdbnNE
	JClvuL2PkFtyIO6clsxZh49NABhwwfUm+d3qlZSFq0Q9o1PVKlknSKHAzq4D6BBEKSYTwevXYhNvK
	PH9uMPVOlxnYWvu3LXqNQmGQR8YRwd6GYigRLpKtWz95uRcwPhIe7pnNjqvMLu/65m3MOv4Q7c1q/
	ux7KoLNskZwL7HbJb5WacMRy1egAUYU6+3d4zTfNCbdmCKZIMuTO2xksd8JfQBoMhz/G2F4S+mGp5
	REMIYTfsIU2fpEhzVVlUeFjjq6Jq+RipY5wYKB37/zHdONoGf/FicxFEkTNwA0g01MekgZK50N0D/
	dOfU55Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkmyd-00000002xuj-2AVA;
	Fri, 17 Jul 2026 18:07:59 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkmyb-00000002xs4-0V44
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 18:07:58 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so6158456a91.0
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 11:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784311675; cv=none;
        d=google.com; s=arc-20260327;
        b=XbtiCu5sb8Ip+AaPvPfrkQIvKm4xyA3QVTybZVpp0IqcYw//fZb970pSLOHsCtOiNZ
         RrY5ycTbeuXmtJ659Pv6FYRr62/iuEqG/sYqXmO2BarnNDl8EkEQeU02V5/OtNPQiYo7
         3sr/EFQbcgQOwv3ARRrgybeIEsyRjGjd7LpjGAblHq+j0gYIW9aFQdGiVfiAfbBK9Hcl
         1ipx9ZWPPNJPR8mXAWHXqHIFSOjtcNAXDMrPISKHqidvHtvrBdhxlKfQHyZj4+d4GJml
         HLBM45HRvHd0eIEaG45B/ik9ayB9yR9jo9zjgsRWsHm+6zhuiFUeMDYD6JMAFi7o6877
         Ao+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oHggWXBEHwEkm7E6ec3wMUq0bi8f7fhVcVQVAKiXHao=;
        fh=jDgKnRc40Qxv/owbldm2k3ANV64Hh8JhaSHDk3/06ww=;
        b=JLs56JRGVBxtCCBsHHycWfeoKn9xBwYLU+pID6JR3onfjxOMvEHYpb6fJhTQkdmSX2
         hBCKihEIUiduYEFEl2qNoIF1/JEbe4u8GjXX1m5Rzx5TrIEZRSR2EwffHt4tLRvbrEw4
         Vo5l4I9dZ/19+xnuHlU3MK3t4kWAH/oqpOVUbcp+mEZ1P7qaZmiGD0iRCYkdQqRVxIhh
         7+x4NVWiRvogs+LWPeF8EOkRE6Rl7ig2HHbTbUd/MlB1DfUmZveBDL3rWEMP7oSHph3j
         atLLaiRQ7ERjNdgt9FqZBjEbMKsp2pKXFPU6U6dUxeBjXbumxhsQfBklWYTQ9gDaO33y
         4B2Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784311675; x=1784916475; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oHggWXBEHwEkm7E6ec3wMUq0bi8f7fhVcVQVAKiXHao=;
        b=cTCdSi8sBpAumTFgBj7VBF8cL41ytYHXZt5yuUsAwcp8Auceb8yyDmpIiM0fSryKRO
         oQKXnvK5AyiVznoi4OnrYGPKZX8uxcDEUcQR3zvjaRPR8MkieUAPE4+h/IThPm+r8Wz0
         QB9Wv9cKscbDtFbdjJ/shxGpVQxVNjyUIC65I+r/UtRkrPFNdEMk1fYNTHzrL9pkhjWc
         UxflgrrJh40o/iO5bK8IwWVCgVPSGH/q/u5pz3yuNuD9AjWJUjWhgnShW9YVGZihILI1
         7RRN1MCLG0aEI8HaT02z7+dXYUBi4z9npeGiHxx1TGaIsYcfAkdznQupLyPIHLO+NedH
         IKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784311675; x=1784916475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHggWXBEHwEkm7E6ec3wMUq0bi8f7fhVcVQVAKiXHao=;
        b=dXfuocRDv1QjdgByAtivV+Hlj8bOWEp6jPgAv66KI7I8eZs+SsWHHSuBvTfqAF6lpQ
         D4DcGlL5t9M0FOm9uoTSejnyOaPTSzTorzgXh/eSSKxjSqJ9TbMUbQOiIzv6ROffOgi7
         2Hp1Cskd4ocYLrTrGlMVjq1e8TRiCang3Hxq74fRrsxUbGUoX4yPFf92eMeLAQ6vHTWI
         qO6BoYnvpaTeSnGgRKk/p+pP4bfJa+bgMr3/5jtteg+EyUUch/gIrHU12iaJeFAxGeph
         XHLyxWy3Rw84EsU5LiBQMihNxKzcO9UguaMYggdjSFwNI1afGvP2xGMqKTZReN8NZf8S
         X0FA==
X-Forwarded-Encrypted: i=1; AHgh+Rr28+8rPGfOYKiwgOs3bkhS8ocsgi4pkWS6+GgAh5LB9+nXjuQ8WBH6af/DLqO2DDihGKdd9g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyjJIavfS8XBVU2wD+WQDqpNRCccd4mYUGGZ9dqW5ZBTkiWe0Eh
	YIvkpKYMfjrzEWjWwUPcsX4ZveYu12BV3U7NApUOT2e4V7LQDTMXt2WR7yy7oz2U3nFM5jw1xI1
	eNBBirrPVI/AOOnOlokvunlNGeE1rZ4JMnCvPosul
X-Gm-Gg: AfdE7clyPjKyEH82E1TngO/0q1tiLfWAlz5DKejR5hq3s2miJNe4W4q9dYAyi65pPe2
	h/+N2dYbVwauwcgftIwMOGKTRmJKWjDN9uYQZ1M0X16yJc56b107VksHzbFah4RBip3FcLQXIzr
	Pc9354w//g+0x9ZJunJq7OiDz9SJlZefx8bip6lKCbwKEU9thMg+V+LUvy90LRHzMwJ6mPzZXOk
	iDZj55acWo5AHc3qpI4ydn/1iCVPO4eoJgO8yaNzebn97KuXkzylgZkMzRlrw==
X-Received: by 2002:a17:90b:1e44:b0:38e:584f:2515 with SMTP id
 98e67ed59e1d1-38e584f25c6mr761804a91.37.1784311674411; Fri, 17 Jul 2026
 11:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260714190356.190328-1-dmatlack@google.com> <2vxzy0fcicpi.fsf@kernel.org>
 <20260715172336.GC3775915@nvidia.com> <aljtXsr6xvI6FAmA@google.com>
 <2vxzh5lzhrgk.fsf@kernel.org> <alphOhGU2c90l_3m@google.com>
In-Reply-To: <alphOhGU2c90l_3m@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 17 Jul 2026 11:07:27 -0700
X-Gm-Features: AUfX_mzfx9OYJHTdyoObAAgLGZ66H2glYXt1USO9ylzsx0cIDR5QQ0HWu7nHJrA
Message-ID: <CALzav=eKcJiCoR+w0krwtFOFeBXXYPK7YsDEhk+v3ZqzAgp=WQ@mail.gmail.com>
Subject: Re: [RFC PATCH] liveupdate: Allow multiple openers for /dev/liveupdate
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mike Rapoport <rppt@kernel.org>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	uca.boccassi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_110757_175640_14161E12 
X-CRM114-Status: GOOD (  47.53  )
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

On Fri, Jul 17, 2026 at 10:07=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 07-16 17:41, Pratyush Yadav wrote:
> > On Thu, Jul 16 2026, Pasha Tatashin wrote:
> >
> > > On 07-15 14:23, Jason Gunthorpe wrote:
> > >> On Wed, Jul 15, 2026 at 03:50:33PM +0200, Pratyush Yadav wrote:
> > >> > Hi David,
> > >> >
> > >> > On Tue, Jul 14 2026, David Matlack wrote:
> > >> >
> > >> > > Remove the single-opener restriction for /dev/liveupdate by remo=
ving the
> > >> > > atomic in_use tracking and the exclusive open check in luo_open(=
) that
> > >> > > returned -EBUSY. Protect luo_session_deserialize() with a mutex =
guard so
> > >> > > that concurrent open attempts by multiple processes safely execu=
tes
> > >> > > deserialization only once. Update liveupdate selftest to verify =
that
> > >> > > multiple concurrent openers succeed.
> > >> > >
> > >> > > LUO does not inherently require a single opener. There is some
> > >> > > documentation about it simplifying state management, but the onl=
y thing
> > >> > > it actually protects is the session deserialization during first=
 open,
> > >> > > which can be easily handled with a mutex.
> > >> > >
> > >> > > Relaxing the single-opener requirement avoids the kernel forcing=
 a
> > >> > > design pattern on userspace that it itself does not require, e.g=
.
> > >> > > allowing multiple userspace processes to create and manage sessi=
ons.
> > >> >
> > >> > Agreed. When the kernel had a global state machine in the early ve=
rsions
> > >> > of LUO, this might have been more relevant. With sessions, even if=
 we
> > >> > later add a state machine, it likely will be per-session instead o=
f
> > >> > being global. So I think letting userspace open /dev/liveupdate mu=
ltiple
> > >> > times makes a lot of sense.
> > >> >
> > >> > Also, today's systemd only supports preserving individual files, a=
nd
> > >> > does not hand out sessions. To get sessions, userspace must open
> > >
> > > It should in the future, because of permissions issue, see below.
> > >
> > >> > /dev/liveupdate and create a session. This opens up room for one b=
ad
> > >> > process to block every other process from creating sessions. It al=
so
> > >> > imposes a need for userspace to add a polling/retry logic for gett=
ing
> > >> > sessions and serializes their execution around this point.
> > >>
> > >> Shouldn't systemd open and own /dev/liveupdate? That was at least wh=
at
> > >> I originally expected here, you'd talk to it and get a session FD
> > >> through dbus.
> > >>
> > >> Moving to multi-opening /dev/liveupdate and removing visibility of
> > >> what sessions are open from systemd is a different model
> > >>
> > >> Not saying this patch is wrong or anything, but that I don't really
> > >> understand what kind of model you are going for now.
> > >
> > > CC ca for systemd's take.
> > >
> > > /dev/liveupdate should only be accessed by a privileged process, and
> > > sessions should be accessed by whoever originally created them. While
> > > this patch does not change the permissions, it paves the road for us =
to
> > > move in the wrong direction: instead of having a privileged userspace
> > > manager that distributes the sessions to their rightful owners, it
> > > encourages userspace to work around the permissions so that VMMs acce=
ss
> > > /dev/liveupdate to retrieve or store their sessions directly. This wo=
uld
> > > also allow them to access sessions belonging to any other participant=
 of
> > > the live update.
> >
> > But you can still do all this. In fact, systemd's release notes suggest
> > doing so [0]:
> >
> >     Units can also create their own LUO Sessions by talking to the
> >     kernel directly, and store them in their FD Stores, and those will
> >     also be preserved and passed down to the unit after kexec
>
> They should not. Ideally, systemd should be the sole entity
> communicating directly with /dev/liveupdate.
>
> >
> > Having a single opener does not in practice prevent userspace from
> > creating sessions directly. All it does is to force them to turn the
> > open into a polling loop. So I don't think single open achieves the goa=
l
>
> That is a fragile design, and they should avoid it. To be clear, I do
> not see any functional bugs in this patch, but I still do not understand
> the underlying use case.
>
> LUO should rely on a single manager agent that interacts with clients to
> create, preserve across reboots, and restore session IDs on their behalf.
>
> In fact, systemd is the only userspace process that AFAIK survives
> across the reboot() boundary; all other processes are terminated before
> reboot() is invoked. Relying on multiple independent LUO managers is
> therefore architecturally, wrong as they will close sessionfds.
>
> While the kernel can technically allow multiple openers for
> /dev/liveupdate, I do not see what problem this actually solves.
> Instead, it seems to encourage bad architectural decisions in userspace.

> > you think it should. Userspace already works around this restriction.
> >
> > So as long as we keep access to /dev/liveupdate restricted to privilege=
d
> > processes, I don't see why single open is any better.
>
> What is the concrete use case for this patch, once we live in the world
> where systemd is fully capable of creating, storing, and retrieving
> sessions?

I guess I would flip the question around: What problem does the kernel
requiring a single opener of /dev/liveupdate solve?

If systemd wants to have a single opener model it can certainly
enforce that itself without the kernel's help.

I'm not sure why the kernel needs to impose a restriction on userspace
that it doesn't require itself.

>
> >
> > [0] https://github.com/systemd/systemd/releases#release-v261
> >
> > >
> > > Instead, sessions should be created and retrieved by a privileged
> > > process that knows to send them back to their rightful owner after
> > > retrieval.
> > >
> > > Also, as a minor concern, each userspace LUO manager needs its own
> > > session to maintain state. This means that by allowing multiple
> > > managers, they may run into naming conflicts for those state sessions=
.
> >
> > --
> > Regards,
> > Pratyush Yadav

