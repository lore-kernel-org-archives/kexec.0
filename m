Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868B4C44515
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P87ycojfEV8HoQxWRUMV9y0/pRLCBbuPJRqYvb1+Ggw=; b=VE5PplccO3OToZO8ynanR7+nwB
	y76TX1nTX6wE0wzt3g5yuD4g47G7oX6bTz406zkhG+qtINuC8C9FdGnSQKPBBkQfanbB8uAQONf4V
	dAHmDVuIKO64dOqzGLG/cNYqhHLp7/WhYq072IT11LREA5Mn+2UvHUmuHxZ0qaSCsv+hx5daShOHI
	CrqBort8FohkCuAqV/F8t0K9696RyLi4LbSCtacny4jUeC3rraFamDsZ1DU8VFaJPER1/OJIMEUUx
	rs2zwP4wc5PgqNl2aUT1W/H/6hr5X0N6PM0uSE+VJ3pYG3PUMkFUvWCEyeEJWNc1qcvxahGwpCeAO
	ER4TRimw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlqPV-00000007I4n-1RFE;
	Mon, 20 Jul 2026 16:00:05 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlqPS-00000007I3U-0nfO
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 16:00:03 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2340314a91.2
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 09:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784563200; cv=none;
        d=google.com; s=arc-20260327;
        b=Hb884+3Z3Yrf/hMJVNcjLBomIkmTf1BH99SX/3dk8PELqFscMlZqjQ/QFH8jAPIsaV
         TVnW3tyaB+D6OqOXL3EL8PcWMS4kMpTfDEMxFnsw9T5RRT0BvT/zpsz6q+Gtwes0CsDI
         RvhPe9AHI97VCMZrXIdCaS2cxrZHD2Lzpz56Gyxf+H1gS5kkHy+RTL1kE4TGCTaGT846
         TsDPcJA21VnClVX4LzoWzpQyCPrDGL4mCysQC9P5yy97ajYfey0HjKF9U9Rw6q5iIcP1
         OZ0Tv8vXFnxEU1RNzBhjWfJGmsUNkhQO2d+HI/nvLjizusLjOPX+NJN87GRvmzm1j7Dh
         V2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P87ycojfEV8HoQxWRUMV9y0/pRLCBbuPJRqYvb1+Ggw=;
        fh=FnC+FzPwppcF35o6Du7CL8gYCMzAWofiR4d+9ZE1B44=;
        b=JOgFuC5UTa6FEK5ACUywLgH8DY0afpNlDgsl6o8mGikd1vI9GW5J8jrDrHYNyrzLTt
         fFQICWCS+pA4GeFgEhbysHk+pJJt87R4WFQg2XZHOFrkXVe4ewg13tij9UHZOKDm/bBu
         +otULcnWOysfckl/bef82ddGhnIuLWmkkkMWS/DqfEmqcReJTH3t31gi88doihEpElx/
         3FUe8h/5Rsu0o4LxJn5ZxzUyhOwIkDpVLBtqDGzedO1kdoybjU3k1CKOkkXpkdfd96lI
         EF3yaqwb397byrMLn23bSksqQIMiqzZN2SHm447RHQU7lFYQUvmdg+rxgeDBXAIvasP4
         rhnQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784563200; x=1785168000; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P87ycojfEV8HoQxWRUMV9y0/pRLCBbuPJRqYvb1+Ggw=;
        b=BFdnC8B0C5n+IapvEFDjytbqvbw/K9ReR6G2tNfrSDEs5V+Ja/azhetxPKBaHb3NTz
         4/r22kd30iPHvSxcBgT2reYeE90WkQ1swlCxSSWOikQgeEkQFKlULcmwsHsK7CTbubGT
         aZcHb4IdEV5d+YSVbcQhqBzP4Z3j4lIPS1H6I0+JNIn2Xu02soLKGUtoZiXegEyyexbp
         +2fcTStc9ir5oBBH5obhScoeWf+snJBzY08GVDT9yQ5CnCYxvZmJSyfq2zDe1VdiCUF7
         eXq0fm70/ehObbY+qtjnHhKJD4IG2C9d6WHFXn7J4+fQo834mYMSJeWgnfJhm3DrXhH7
         8Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563200; x=1785168000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P87ycojfEV8HoQxWRUMV9y0/pRLCBbuPJRqYvb1+Ggw=;
        b=PcSlbtvfwTELarlPxIP9sckOOfPiExW8UlFOQcWXQ5X6ullwmT6apXweNSfH1mwjnf
         zTPYQ0D7EupdFC4R2nnXmEX0UIfmu5g1YQiozSHNjC8ahiqZgs1/E/gJYSlRFXy4FUDS
         qhEEczQ0goGZvlfkqkwFATdbA7X5DvhDCot8TFw3Yu4RC5c1zmW4d1ACKP0GzNpMnk4I
         B1LO2jkOH7yc16YATGmBdQXYRCIE7YQylFFoAhIXCojJC71LJI/Wq7lWOW2F6mbctQaU
         lrAtNkbRkNxrbi4R6MAoPRP7DnPRIvY/tEtxc6DKwVLwvvbTTHyTkNSvnD5yhJ5nqjy/
         NYKw==
X-Forwarded-Encrypted: i=1; AHgh+RpncUKCZSuXWfhebp2d6baPs8sN1BICdR02yt3ZhgAOgw+tAK4e3LkhM4/XmyOpdmLcVTExyQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxtMc8BFQU42VJwKl5w6NSd7czdN0seOZsZyM2POcwFAchf4LRh
	Zd5t31qSoT1BGbBt/zLwd+iaXdyHMW2ErR9Lh9iWfv42amqV9DyoMpSeTK6VQEHJUyQueSWcuGp
	dNFVNynL95u1n0sYEwijRpziA6TnnalIQTah12dbA
X-Gm-Gg: AR+sD11zBUJ9ZG+vdUhr2ySccoKhwY9VUDwaMd11gZQBtXZNl8ea5TTf6RRw7vLbUun
	UacupfW1VLSo/y5c4j62DUL0eY4WFX8WaX43nhoK9w4qg5WrOc56FhiedntE159Oo6ZFR0qc7Ki
	xLw8cqBd/yjfEXYVz07dR7dkocwoETpQ8RncSPOJzWQXgRqQZyPxBWSMS6hUCurpqxyEo1KEKAZ
	Fp5kdazdwcZ7fccKjdJN0+1qSTlPTL5LyWeH/7e/l2x7xkhoZS4jhex42d5xQ==
X-Received: by 2002:a17:90b:2dc1:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-38e4b3e1424mr14861878a91.2.1784563199709; Mon, 20 Jul 2026
 08:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260714190356.190328-1-dmatlack@google.com> <2vxzy0fcicpi.fsf@kernel.org>
 <20260715172336.GC3775915@nvidia.com> <aljtXsr6xvI6FAmA@google.com>
 <2vxzh5lzhrgk.fsf@kernel.org> <alphOhGU2c90l_3m@google.com>
 <CALzav=eKcJiCoR+w0krwtFOFeBXXYPK7YsDEhk+v3ZqzAgp=WQ@mail.gmail.com> <alpzJlpwBI8ou4UN@plex>
In-Reply-To: <alpzJlpwBI8ou4UN@plex>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 08:59:31 -0700
X-Gm-Features: AUfX_mxw-SD40qAv9zGI1JtjIzLiRnzBLl6URA6ig4QtctIHN2ZOaaM-MXL0Ibg
Message-ID: <CALzav=f+jNEb1g1fPfwdKh+r-MEek5KE2GzWm1wyqXA4L94mFg@mail.gmail.com>
Subject: Re: [RFC PATCH] liveupdate: Allow multiple openers for /dev/liveupdate
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mike Rapoport <rppt@kernel.org>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	uca.boccassi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_090002_248079_5404FFCB 
X-CRM114-Status: GOOD (  56.39  )
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

On Fri, Jul 17, 2026 at 11:33=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 07-17 11:07, David Matlack wrote:
> > On Fri, Jul 17, 2026 at 10:07=E2=80=AFAM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > On 07-16 17:41, Pratyush Yadav wrote:
> > > > On Thu, Jul 16 2026, Pasha Tatashin wrote:
> > > >
> > > > > On 07-15 14:23, Jason Gunthorpe wrote:
> > > > >> On Wed, Jul 15, 2026 at 03:50:33PM +0200, Pratyush Yadav wrote:
> > > > >> > Hi David,
> > > > >> >
> > > > >> > On Tue, Jul 14 2026, David Matlack wrote:
> > > > >> >
> > > > >> > > Remove the single-opener restriction for /dev/liveupdate by =
removing the
> > > > >> > > atomic in_use tracking and the exclusive open check in luo_o=
pen() that
> > > > >> > > returned -EBUSY. Protect luo_session_deserialize() with a mu=
tex guard so
> > > > >> > > that concurrent open attempts by multiple processes safely e=
xecutes
> > > > >> > > deserialization only once. Update liveupdate selftest to ver=
ify that
> > > > >> > > multiple concurrent openers succeed.
> > > > >> > >
> > > > >> > > LUO does not inherently require a single opener. There is so=
me
> > > > >> > > documentation about it simplifying state management, but the=
 only thing
> > > > >> > > it actually protects is the session deserialization during f=
irst open,
> > > > >> > > which can be easily handled with a mutex.
> > > > >> > >
> > > > >> > > Relaxing the single-opener requirement avoids the kernel for=
cing a
> > > > >> > > design pattern on userspace that it itself does not require,=
 e.g.
> > > > >> > > allowing multiple userspace processes to create and manage s=
essions.
> > > > >> >
> > > > >> > Agreed. When the kernel had a global state machine in the earl=
y versions
> > > > >> > of LUO, this might have been more relevant. With sessions, eve=
n if we
> > > > >> > later add a state machine, it likely will be per-session inste=
ad of
> > > > >> > being global. So I think letting userspace open /dev/liveupdat=
e multiple
> > > > >> > times makes a lot of sense.
> > > > >> >
> > > > >> > Also, today's systemd only supports preserving individual file=
s, and
> > > > >> > does not hand out sessions. To get sessions, userspace must op=
en
> > > > >
> > > > > It should in the future, because of permissions issue, see below.
> > > > >
> > > > >> > /dev/liveupdate and create a session. This opens up room for o=
ne bad
> > > > >> > process to block every other process from creating sessions. I=
t also
> > > > >> > imposes a need for userspace to add a polling/retry logic for =
getting
> > > > >> > sessions and serializes their execution around this point.
> > > > >>
> > > > >> Shouldn't systemd open and own /dev/liveupdate? That was at leas=
t what
> > > > >> I originally expected here, you'd talk to it and get a session F=
D
> > > > >> through dbus.
> > > > >>
> > > > >> Moving to multi-opening /dev/liveupdate and removing visibility =
of
> > > > >> what sessions are open from systemd is a different model
> > > > >>
> > > > >> Not saying this patch is wrong or anything, but that I don't rea=
lly
> > > > >> understand what kind of model you are going for now.
> > > > >
> > > > > CC ca for systemd's take.
> > > > >
> > > > > /dev/liveupdate should only be accessed by a privileged process, =
and
> > > > > sessions should be accessed by whoever originally created them. W=
hile
> > > > > this patch does not change the permissions, it paves the road for=
 us to
> > > > > move in the wrong direction: instead of having a privileged users=
pace
> > > > > manager that distributes the sessions to their rightful owners, i=
t
> > > > > encourages userspace to work around the permissions so that VMMs =
access
> > > > > /dev/liveupdate to retrieve or store their sessions directly. Thi=
s would
> > > > > also allow them to access sessions belonging to any other partici=
pant of
> > > > > the live update.
> > > >
> > > > But you can still do all this. In fact, systemd's release notes sug=
gest
> > > > doing so [0]:
> > > >
> > > >     Units can also create their own LUO Sessions by talking to the
> > > >     kernel directly, and store them in their FD Stores, and those w=
ill
> > > >     also be preserved and passed down to the unit after kexec
> > >
> > > They should not. Ideally, systemd should be the sole entity
> > > communicating directly with /dev/liveupdate.
> > >
> > > >
> > > > Having a single opener does not in practice prevent userspace from
> > > > creating sessions directly. All it does is to force them to turn th=
e
> > > > open into a polling loop. So I don't think single open achieves the=
 goal
> > >
> > > That is a fragile design, and they should avoid it. To be clear, I do
> > > not see any functional bugs in this patch, but I still do not underst=
and
> > > the underlying use case.
> > >
> > > LUO should rely on a single manager agent that interacts with clients=
 to
> > > create, preserve across reboots, and restore session IDs on their beh=
alf.
> > >
> > > In fact, systemd is the only userspace process that AFAIK survives
> > > across the reboot() boundary; all other processes are terminated befo=
re
> > > reboot() is invoked. Relying on multiple independent LUO managers is
> > > therefore architecturally, wrong as they will close sessionfds.
> > >
> > > While the kernel can technically allow multiple openers for
> > > /dev/liveupdate, I do not see what problem this actually solves.
> > > Instead, it seems to encourage bad architectural decisions in userspa=
ce.
> >
> > > > you think it should. Userspace already works around this restrictio=
n.
> > > >
> > > > So as long as we keep access to /dev/liveupdate restricted to privi=
leged
> > > > processes, I don't see why single open is any better.
> > >
> > > What is the concrete use case for this patch, once we live in the wor=
ld
> > > where systemd is fully capable of creating, storing, and retrieving
> > > sessions?
> >
> > I guess I would flip the question around: What problem does the kernel
> > requiring a single opener of /dev/liveupdate solve?
>
> It establishes a secure baseline by forcing userspace to adopt a
> centralized management model.
>
> If the kernel allows multiple openers, any process with sufficient
> privileges can open /dev/liveupdate and potentially access sessions
> belonging to other entities.
>
> By enforcing a single opener, the kernel ensures that one trusted
> manager (like systemd) must take exclusive ownership of the device and
> securely distribute session FDs to their rightful owners, and also
> preserve them into the reboot syscall.

I agree it forces this on userspace. But there's no reason to force
this on userspace. The kernel does not depend on or care in any way if
one process or multiple processes create sessions.

> > If systemd wants to have a single opener model it can certainly
> > enforce that itself without the kernel's help.
>
> How is that possible? Once the kernel allows multiple processes to open
> /dev/liveupdate, luod/systemd loses the ability to guarantee exclusivity
> and prevent direct access by other privileged daemons.

Why are file permissions not sufficient? I don't see what is so
special about /dev/liveupdate.

> > I'm not sure why the kernel needs to impose a restriction on userspace
> > that it doesn't require itself.
>
> To enforce a tighter security model. Preventing multiple daemons from
> independently managing /dev/liveupdate minimizes the risk of leaking
> preserved data to the wrong process.
>
> Before we remove a constraint that encourages a secure, centralized
> design, I'm still hoping to understand the concrete use case.

Yeah I understand. Unfortunately, IMO, it would have been better to
merge LUO without this restriction, and only introduce it when
necessary (i.e. when someone proves that standard techniques like file
permissions are insufficient). But I understand that relaxing this
requirement now without a concrete use case (which I do not have)
doesn't seem like a good idea.

>
> Pasha
>
> >
> > >
> > > >
> > > > [0] https://github.com/systemd/systemd/releases#release-v261
> > > >
> > > > >
> > > > > Instead, sessions should be created and retrieved by a privileged
> > > > > process that knows to send them back to their rightful owner afte=
r
> > > > > retrieval.
> > > > >
> > > > > Also, as a minor concern, each userspace LUO manager needs its ow=
n
> > > > > session to maintain state. This means that by allowing multiple
> > > > > managers, they may run into naming conflicts for those state sess=
ions.
> > > >
> > > > --
> > > > Regards,
> > > > Pratyush Yadav

