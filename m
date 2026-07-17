Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6948BC4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 18:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/NQPDl+iUOtIp6BF6be8WuthAyrwkk8o5a4ZrIHXBb4=; b=gbqLLQg1tH5rtpyffCR+s2m/1U
	JJO/PFQisH38qGUZhnHTU4/U5FfCZ2W341xjIaU/TgnP3RMNDfcUyPXvxpy47hqwuivQufAJZdni2
	waBUGl7iKSivE04PuBGVuytiVmIE3+6V5/ZOGdar/bG9u17+PBQh53PRQaMWIGezXqjAhwwxFntCW
	YXKCqByI35WZ/Q+WPe8UEVpm+537ZriGiFDhJEF1kWcKEPZr0/0GGrhsKT8oB5p09qF7l5XQEfHx+
	Jl6ifsGg0d8opXFA/BTDGOEYLoSTjUrcu6sYKIy3UA2lbrBstx4vSsVOFhLHTPgAPJHY8aDxbzgYs
	UlRF655w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wknNn-000000031mv-11BZ;
	Fri, 17 Jul 2026 18:33:59 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wknNk-000000031mU-1NiW
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 18:33:57 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso74761116d6.3
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784313235; x=1784918035; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/NQPDl+iUOtIp6BF6be8WuthAyrwkk8o5a4ZrIHXBb4=;
        b=BdL+WmpYZ7dRlptx5AuWRNpi2lPMvCXPypp/XXcrQwdc0l0ZpZeK6K2ryOcLka3NOl
         BNIIMMv/YMkad0C/N5vVHIIz5dupkhRl/w62rcqIvPmSLFdZo+itbEgh0dgVzme8tIOM
         +izp24W7+AZzvB/kaPrL/QCs/m8eIyOTYA/boPipXK1QHqGlOiCAp5Ga6cufATWvnSRb
         3OfUmzSZrGNtlAoa+WWLQbOWDv4kyKB2XFZiRaPPsPJ3xn4Ps6q6sq5I+HFZ18XnxA32
         MF4d+mx0LmMAP/mduDLdrG1IyK30kO58GZ43jItftKpM+Hpu+/73Bf6Q0WEjH12DL9Pj
         7SfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313235; x=1784918035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/NQPDl+iUOtIp6BF6be8WuthAyrwkk8o5a4ZrIHXBb4=;
        b=B/xLg3qWDJkUjq/8FgG36nr6O76Pbri+13v3qCoEDarTVRsvAOSvhZ8pAi40Qji9hb
         M9+KQ2w4fcjRjsmIZYUpBayAzxvhaf2kfPr9FSfI0KmKrDKZ6YFH93upF0Xthq/X78J8
         fLGGLK2mt2kdxjVjm3VV03DyqLGivvUzcCYgaFcXFUg+1AtFgCW15Y7sKsfw7rPqazqe
         17YJ3h0/c1L7EVRK2EyWYrhjXLsqOeoTnNvfPubsSqfR5ZbbdsgPH4xaUfFzSXdek8kp
         WUXBOLnF+rZOzsKvfTPbPrhNetGeC9iGPhYgl4loP1VrEQFIDc0ysHwAd4yKqXQeZAdU
         5Pyw==
X-Forwarded-Encrypted: i=1; AHgh+RpSPF5owmmSaj3hOmQpVjmV10I/fsoRCgAZ5M9RjBbgFDCclHZtb53xM440QDJIIoAEa3hgEw==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywm7pMFic7sJJWhuZbOzE31hOLeCzGK/jyYn/Xcva6c0JdMX9Oo
	nsqRloLIKFwA75h42ULXzz9wZ35t2SWnCmJt3OiS6cvy8n9CIDbZHyCLdC2sT+hEMBg=
X-Gm-Gg: AfdE7clYN/g8zMWmTFgw4JiqnRmpSJJmdjuyWC5xqztNWtK172gsDmu8dZtGEDUI378
	s9j9arA5VdDeBYkZ2XayhyRs7uEzH4TnzJjULylhiNqhG6qBR15B++iymtjxAnstLie0rJeSWaj
	ZwrehasKjnS/8Ehm6JHrxpSNMtqJEHxxWcghBKxZY9uVxyrXgHT9sPCPT44yesS+vSNixXe3KBC
	CHt6TUmig8UDRLwjI2qawbl0DbLQnNQTqCjfF63MVq2BheBxDVj5uutW3i8LKqWE4VFS6U/KsDr
	lDj2xfIUsOGv4qeMBCPEmfg9cYDF6NfFaRAtx2mjw2uW75TGVKURtgWP0I8PL1IRv7s210GAVeH
	z7ewqsCxsDiC7TTR7OSHnv+EIrbdc2fx1gcsqa3Jsm8e8PM9HHkYuqFY1GxBMO9A1NQtY+xmlKN
	zhWkFZjphysR1K1QcbNyBbUCm8fwq9jxC48w7TB+0s
X-Received: by 2002:a05:6214:54c8:b0:8f0:8029:592c with SMTP id 6a1803df08f44-9077853fc7bmr42588146d6.50.1784313234646;
        Fri, 17 Jul 2026 11:33:54 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90778585048sm23392636d6.19.2026.07.17.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:33:54 -0700 (PDT)
Date: Fri, 17 Jul 2026 18:33:53 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, uca.boccassi@gmail.com
Subject: Re: [RFC PATCH] liveupdate: Allow multiple openers for
 /dev/liveupdate
Message-ID: <alpzJlpwBI8ou4UN@plex>
References: <20260714190356.190328-1-dmatlack@google.com>
 <2vxzy0fcicpi.fsf@kernel.org>
 <20260715172336.GC3775915@nvidia.com>
 <aljtXsr6xvI6FAmA@google.com>
 <2vxzh5lzhrgk.fsf@kernel.org>
 <alphOhGU2c90l_3m@google.com>
 <CALzav=eKcJiCoR+w0krwtFOFeBXXYPK7YsDEhk+v3ZqzAgp=WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=eKcJiCoR+w0krwtFOFeBXXYPK7YsDEhk+v3ZqzAgp=WQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_113356_431921_94D0F754 
X-CRM114-Status: GOOD (  53.80  )
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

On 07-17 11:07, David Matlack wrote:
> On Fri, Jul 17, 2026 at 10:07 AM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On 07-16 17:41, Pratyush Yadav wrote:
> > > On Thu, Jul 16 2026, Pasha Tatashin wrote:
> > >
> > > > On 07-15 14:23, Jason Gunthorpe wrote:
> > > >> On Wed, Jul 15, 2026 at 03:50:33PM +0200, Pratyush Yadav wrote:
> > > >> > Hi David,
> > > >> >
> > > >> > On Tue, Jul 14 2026, David Matlack wrote:
> > > >> >
> > > >> > > Remove the single-opener restriction for /dev/liveupdate by removing the
> > > >> > > atomic in_use tracking and the exclusive open check in luo_open() that
> > > >> > > returned -EBUSY. Protect luo_session_deserialize() with a mutex guard so
> > > >> > > that concurrent open attempts by multiple processes safely executes
> > > >> > > deserialization only once. Update liveupdate selftest to verify that
> > > >> > > multiple concurrent openers succeed.
> > > >> > >
> > > >> > > LUO does not inherently require a single opener. There is some
> > > >> > > documentation about it simplifying state management, but the only thing
> > > >> > > it actually protects is the session deserialization during first open,
> > > >> > > which can be easily handled with a mutex.
> > > >> > >
> > > >> > > Relaxing the single-opener requirement avoids the kernel forcing a
> > > >> > > design pattern on userspace that it itself does not require, e.g.
> > > >> > > allowing multiple userspace processes to create and manage sessions.
> > > >> >
> > > >> > Agreed. When the kernel had a global state machine in the early versions
> > > >> > of LUO, this might have been more relevant. With sessions, even if we
> > > >> > later add a state machine, it likely will be per-session instead of
> > > >> > being global. So I think letting userspace open /dev/liveupdate multiple
> > > >> > times makes a lot of sense.
> > > >> >
> > > >> > Also, today's systemd only supports preserving individual files, and
> > > >> > does not hand out sessions. To get sessions, userspace must open
> > > >
> > > > It should in the future, because of permissions issue, see below.
> > > >
> > > >> > /dev/liveupdate and create a session. This opens up room for one bad
> > > >> > process to block every other process from creating sessions. It also
> > > >> > imposes a need for userspace to add a polling/retry logic for getting
> > > >> > sessions and serializes their execution around this point.
> > > >>
> > > >> Shouldn't systemd open and own /dev/liveupdate? That was at least what
> > > >> I originally expected here, you'd talk to it and get a session FD
> > > >> through dbus.
> > > >>
> > > >> Moving to multi-opening /dev/liveupdate and removing visibility of
> > > >> what sessions are open from systemd is a different model
> > > >>
> > > >> Not saying this patch is wrong or anything, but that I don't really
> > > >> understand what kind of model you are going for now.
> > > >
> > > > CC ca for systemd's take.
> > > >
> > > > /dev/liveupdate should only be accessed by a privileged process, and
> > > > sessions should be accessed by whoever originally created them. While
> > > > this patch does not change the permissions, it paves the road for us to
> > > > move in the wrong direction: instead of having a privileged userspace
> > > > manager that distributes the sessions to their rightful owners, it
> > > > encourages userspace to work around the permissions so that VMMs access
> > > > /dev/liveupdate to retrieve or store their sessions directly. This would
> > > > also allow them to access sessions belonging to any other participant of
> > > > the live update.
> > >
> > > But you can still do all this. In fact, systemd's release notes suggest
> > > doing so [0]:
> > >
> > >     Units can also create their own LUO Sessions by talking to the
> > >     kernel directly, and store them in their FD Stores, and those will
> > >     also be preserved and passed down to the unit after kexec
> >
> > They should not. Ideally, systemd should be the sole entity
> > communicating directly with /dev/liveupdate.
> >
> > >
> > > Having a single opener does not in practice prevent userspace from
> > > creating sessions directly. All it does is to force them to turn the
> > > open into a polling loop. So I don't think single open achieves the goal
> >
> > That is a fragile design, and they should avoid it. To be clear, I do
> > not see any functional bugs in this patch, but I still do not understand
> > the underlying use case.
> >
> > LUO should rely on a single manager agent that interacts with clients to
> > create, preserve across reboots, and restore session IDs on their behalf.
> >
> > In fact, systemd is the only userspace process that AFAIK survives
> > across the reboot() boundary; all other processes are terminated before
> > reboot() is invoked. Relying on multiple independent LUO managers is
> > therefore architecturally, wrong as they will close sessionfds.
> >
> > While the kernel can technically allow multiple openers for
> > /dev/liveupdate, I do not see what problem this actually solves.
> > Instead, it seems to encourage bad architectural decisions in userspace.
> 
> > > you think it should. Userspace already works around this restriction.
> > >
> > > So as long as we keep access to /dev/liveupdate restricted to privileged
> > > processes, I don't see why single open is any better.
> >
> > What is the concrete use case for this patch, once we live in the world
> > where systemd is fully capable of creating, storing, and retrieving
> > sessions?
> 
> I guess I would flip the question around: What problem does the kernel
> requiring a single opener of /dev/liveupdate solve?

It establishes a secure baseline by forcing userspace to adopt a 
centralized management model.

If the kernel allows multiple openers, any process with sufficient 
privileges can open /dev/liveupdate and potentially access sessions 
belonging to other entities.

By enforcing a single opener, the kernel ensures that one trusted 
manager (like systemd) must take exclusive ownership of the device and 
securely distribute session FDs to their rightful owners, and also 
preserve them into the reboot syscall.

> If systemd wants to have a single opener model it can certainly
> enforce that itself without the kernel's help.

How is that possible? Once the kernel allows multiple processes to open 
/dev/liveupdate, luod/systemd loses the ability to guarantee exclusivity 
and prevent direct access by other privileged daemons.

> I'm not sure why the kernel needs to impose a restriction on userspace
> that it doesn't require itself.

To enforce a tighter security model. Preventing multiple daemons from 
independently managing /dev/liveupdate minimizes the risk of leaking 
preserved data to the wrong process.

Before we remove a constraint that encourages a secure, centralized 
design, I'm still hoping to understand the concrete use case.

Pasha

> 
> >
> > >
> > > [0] https://github.com/systemd/systemd/releases#release-v261
> > >
> > > >
> > > > Instead, sessions should be created and retrieved by a privileged
> > > > process that knows to send them back to their rightful owner after
> > > > retrieval.
> > > >
> > > > Also, as a minor concern, each userspace LUO manager needs its own
> > > > session to maintain state. This means that by allowing multiple
> > > > managers, they may run into naming conflicts for those state sessions.
> > >
> > > --
> > > Regards,
> > > Pratyush Yadav

