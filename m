Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205A7C4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dSNYl8Tp/9qUdH5Q7cjRfYFqP/b1gMhyNsAj6RU4JXA=; b=EiT4lF1sFQNQDKw45kEsgKMDxU
	j+BWcn6MKsacAcNuFSmUZ7PkmUpLfDq9AetQmqx87qrbS13rd7dAFAetK5at6sUa4cEPFGK+ce94G
	S9A2ZyzmANJu7K9qDYzOoxoywtyu0PN3DArrrrA0NQvb8vfcOOmpwU2w1jVpGKWagw/21wj2jVpZa
	Ix3kCw8hzaJiD/Y1CCgjfSQwnpnF+kOpAIWZXU6bwS/yCgjYFLxAqv1qI0adbfm8B6TIBg7fZmeUl
	+k7jU6svNa4Xb6S2bTsJ9lM09rJILFm9jb9wKfFxjoAsWZo+UzRDXOwYDYIQi4BhWkAsIQsIfFVNr
	pdkbK/FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkm1w-00000002pBN-0jfF;
	Fri, 17 Jul 2026 17:07:20 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkm1s-00000002p8d-3vXO
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 17:07:19 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-81e69a2db34so30578127b3.0
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 10:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784308036; x=1784912836; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dSNYl8Tp/9qUdH5Q7cjRfYFqP/b1gMhyNsAj6RU4JXA=;
        b=ESgboq7xO1aG8AYbZbBRYS9ZZfSsk6uFBoezqVPEN0FigyqjH5ifPVbLjpHmwBibFU
         z422cQUfXbwhxpRCyOIGWwwOCtDMMd46sCyfiX4UN+3LMM8TG5hEDfB/njs7LoRlN09Z
         ZDfASCgSFQ3faX4GStTPuRn8kLc59FbbgAoPqEntqsEvUhxXQLKYpENOwgJRg6EV2rq9
         OMp83Ne5dib/PR1xJsTlu+QO29fX471Mw2u541Cb/adXTCK1zoZexYWaDfG8sESQDHUi
         odBYvFbL1do0HwY6wLDAZR6XB75TymfF7xfVamSF5tNapLld+uTd7ncoSW8hCnzA58R1
         UYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784308036; x=1784912836;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSNYl8Tp/9qUdH5Q7cjRfYFqP/b1gMhyNsAj6RU4JXA=;
        b=Sk/cQdV5v1/lFf4ihLiY4sLKZ9z1nVsyxCqZC6956p+GsgU4pRwNaMGjaSEVRtOFoT
         9XYWkJTz4zd3dex7/MgtDh/C5Kz/tOj/PgOxNaKsNkidqCRI75T4uuQDrqooMyYuD76l
         vWQ+YnYkPiUnV3pplBlgYnqz/bHyFYBpiPmDJXx90Yhb9mwFFcs6ZxMnjS3wDtch3G2p
         +dN4M04PDNFY/emLnoyFnivJR/B7G6yjH4whr8v+WIVXDFzDHyd1y5aJM60/h9I136CP
         IEvHRZDfREBjQNxYtN1O+4Q3SW+nlUh0omvibTaWp6w65AtH4x+2AM4Mz+kWH80OUXCw
         /V0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp5Atmn4TrwoWfWxskrahATHzRgUZmr2ZDjg6IzrmYNDUowhHezy0tlu03bsSaqiN4qXdiLGA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyqtwi3VvZgvtYTLpnin/oHtpwUNlsUisXalSNVupBs0mwuWEBM
	w8BBlrt9xr4GD+uGWp4YOYVKXQGoeQJMnc7Cf/zVFCWIW9591awaCheDCgjyuULKMO4=
X-Gm-Gg: AfdE7ckRvleMsL1rGbtYV1D2GQFHaBdMnumXNlYngFUpPVEWY9CW+nUzLPCImcvWpbc
	i+MQC4ni6ZZaN9VsX1bBwy3a7vB2wbFGN1adU0rqi/GE6QY5suTZUP41KOfvAaenhK6DTYJu1Zn
	D+YTB0hbMPNRFgcc8pzNbAUaktZ4lTIL42P/BzdYqGgajVG2bQmRxaLPw2drVMTkG/IpuICg8BJ
	c4VHdOdkV6WaQ3xPVwz8yFbmWvZue+w17L166hNlwnAbwtPd14AlNN+bkar+BtHYdJPkWEgnMeA
	90Q6Truxe8/nDNSrl5rLMnJLTNpETD+Mcl9hxkKC6pJ0LW13BYiorQlX1RR8teA41nR0kUrl6l0
	L/LjLMotPY8IPb0nDvNctX3Yt/iNudYqGAzdBJspc3XYBVrtktHcxAH6X/Ks+B7LG9MEMdareFe
	pWcj96MpJSS2+RKE+xx5cMrA9b9V7lf7ap+rlo3yXHFClT9dOAEP2aqZdsmKimLYzZCc+Qy44md
	c4uc2qCDWT4
X-Received: by 2002:a05:690c:600a:b0:81e:a471:e8b2 with SMTP id 00721157ae682-81ef2735e55mr13299087b3.2.1784308027486;
        Fri, 17 Jul 2026 10:07:07 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42eb72asm14759947b3.47.2026.07.17.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:07:07 -0700 (PDT)
Date: Fri, 17 Jul 2026 13:07:06 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, uca.boccassi@gmail.com
Subject: Re: [RFC PATCH] liveupdate: Allow multiple openers for
 /dev/liveupdate
Message-ID: <alphOhGU2c90l_3m@google.com>
References: <20260714190356.190328-1-dmatlack@google.com>
 <2vxzy0fcicpi.fsf@kernel.org>
 <20260715172336.GC3775915@nvidia.com>
 <aljtXsr6xvI6FAmA@google.com>
 <2vxzh5lzhrgk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzh5lzhrgk.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_100716_993398_85395DF2 
X-CRM114-Status: GOOD (  41.58  )
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

On 07-16 17:41, Pratyush Yadav wrote:
> On Thu, Jul 16 2026, Pasha Tatashin wrote:
> 
> > On 07-15 14:23, Jason Gunthorpe wrote:
> >> On Wed, Jul 15, 2026 at 03:50:33PM +0200, Pratyush Yadav wrote:
> >> > Hi David,
> >> > 
> >> > On Tue, Jul 14 2026, David Matlack wrote:
> >> > 
> >> > > Remove the single-opener restriction for /dev/liveupdate by removing the
> >> > > atomic in_use tracking and the exclusive open check in luo_open() that
> >> > > returned -EBUSY. Protect luo_session_deserialize() with a mutex guard so
> >> > > that concurrent open attempts by multiple processes safely executes
> >> > > deserialization only once. Update liveupdate selftest to verify that
> >> > > multiple concurrent openers succeed.
> >> > >
> >> > > LUO does not inherently require a single opener. There is some
> >> > > documentation about it simplifying state management, but the only thing
> >> > > it actually protects is the session deserialization during first open,
> >> > > which can be easily handled with a mutex.
> >> > >
> >> > > Relaxing the single-opener requirement avoids the kernel forcing a
> >> > > design pattern on userspace that it itself does not require, e.g.
> >> > > allowing multiple userspace processes to create and manage sessions.
> >> > 
> >> > Agreed. When the kernel had a global state machine in the early versions
> >> > of LUO, this might have been more relevant. With sessions, even if we
> >> > later add a state machine, it likely will be per-session instead of
> >> > being global. So I think letting userspace open /dev/liveupdate multiple
> >> > times makes a lot of sense.
> >> > 
> >> > Also, today's systemd only supports preserving individual files, and
> >> > does not hand out sessions. To get sessions, userspace must open
> >
> > It should in the future, because of permissions issue, see below.
> >
> >> > /dev/liveupdate and create a session. This opens up room for one bad
> >> > process to block every other process from creating sessions. It also
> >> > imposes a need for userspace to add a polling/retry logic for getting
> >> > sessions and serializes their execution around this point.
> >> 
> >> Shouldn't systemd open and own /dev/liveupdate? That was at least what
> >> I originally expected here, you'd talk to it and get a session FD
> >> through dbus.
> >> 
> >> Moving to multi-opening /dev/liveupdate and removing visibility of
> >> what sessions are open from systemd is a different model
> >> 
> >> Not saying this patch is wrong or anything, but that I don't really
> >> understand what kind of model you are going for now.
> >
> > CC ca for systemd's take.
> >
> > /dev/liveupdate should only be accessed by a privileged process, and 
> > sessions should be accessed by whoever originally created them. While 
> > this patch does not change the permissions, it paves the road for us to 
> > move in the wrong direction: instead of having a privileged userspace 
> > manager that distributes the sessions to their rightful owners, it 
> > encourages userspace to work around the permissions so that VMMs access 
> > /dev/liveupdate to retrieve or store their sessions directly. This would 
> > also allow them to access sessions belonging to any other participant of 
> > the live update.
> 
> But you can still do all this. In fact, systemd's release notes suggest
> doing so [0]:
> 
>     Units can also create their own LUO Sessions by talking to the
>     kernel directly, and store them in their FD Stores, and those will
>     also be preserved and passed down to the unit after kexec

They should not. Ideally, systemd should be the sole entity 
communicating directly with /dev/liveupdate.

> 
> Having a single opener does not in practice prevent userspace from
> creating sessions directly. All it does is to force them to turn the
> open into a polling loop. So I don't think single open achieves the goal

That is a fragile design, and they should avoid it. To be clear, I do 
not see any functional bugs in this patch, but I still do not understand 
the underlying use case.

LUO should rely on a single manager agent that interacts with clients to 
create, preserve across reboots, and restore session IDs on their behalf.

In fact, systemd is the only userspace process that AFAIK survives 
across the reboot() boundary; all other processes are terminated before 
reboot() is invoked. Relying on multiple independent LUO managers is 
therefore architecturally, wrong as they will close sessionfds.

While the kernel can technically allow multiple openers for 
/dev/liveupdate, I do not see what problem this actually solves. 
Instead, it seems to encourage bad architectural decisions in userspace.

> you think it should. Userspace already works around this restriction.
> 
> So as long as we keep access to /dev/liveupdate restricted to privileged
> processes, I don't see why single open is any better.

What is the concrete use case for this patch, once we live in the world 
where systemd is fully capable of creating, storing, and retrieving 
sessions?

> 
> [0] https://github.com/systemd/systemd/releases#release-v261
> 
> >
> > Instead, sessions should be created and retrieved by a privileged 
> > process that knows to send them back to their rightful owner after 
> > retrieval.
> >
> > Also, as a minor concern, each userspace LUO manager needs its own 
> > session to maintain state. This means that by allowing multiple 
> > managers, they may run into naming conflicts for those state sessions.
> 
> -- 
> Regards,
> Pratyush Yadav

