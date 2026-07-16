Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA14AC44511
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=itGbq07Nr/3aREyFCWeD5PlpGayUnNhMCz8RB3pMWi0=; b=QDLmDN30ycMm0EuK5akjD36Hs/
	DiCRuRFBxxR6wVbr+TJu9cc+ioozoac1Ync9hUaDklTwI1+LkBf7yH9ynCtE46t/WmXHKVuiUIxwZ
	QWKr9/F0zuBvBAuSUpITdIl13h5XUikSWqK4b2MO+S5wMpLAbFnTHicDssGG9euDOPjjY++QPzWMp
	W9oxAQU0j2jMn3GwYzUt6k8335ZTn0r5+8k8eTRQhcpseGhNjvomSpA0s8mUar0Bz+Kjia7tl4nK5
	r/koy9cjuIoSXaRvtPUI463lMtdBr45zTf9dg8tFK8gd/Z/cg0trpQ7s2GChYVajt+UZM6A8VMBr7
	sU7IUpJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkOUa-000000006BI-3aEb;
	Thu, 16 Jul 2026 15:59:20 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkOUY-000000006Af-0TVJ
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 15:59:19 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-81e6f2ee60bso5224367b3.1
        for <kexec@lists.infradead.org>; Thu, 16 Jul 2026 08:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784217556; cv=none;
        d=google.com; s=arc-20260327;
        b=faBIgfF81tFz8xWSLqoXlzURiVI9mf0rjA5isoWw4onatZ7cu+WCt7DTv7cxJP/r7q
         xpDerv5nFmCbW2hRRKe+yVqn7bnB5gOG0YzjizUoA8Um1dgDXEuM2vO2iYifC+S5X1/N
         uloYYVc5RSzA3c7OpBd8lvXqgSOECVrT+fWtFvdGFuHn99kdWhBd0JxMqAu+Bf6qbeoY
         lV6vXln1BP1DYz9SJoz264XsXQyYUeKkKHxocMNOzo6yptRGxzM2Pspba7MXqQZuC3Hm
         NT/plPE9UI6rzecrAa9YxLljJhOISub0UgFuRGIze+ejYKz3FZY3kCSS2TAw4kNzzvO2
         pozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=itGbq07Nr/3aREyFCWeD5PlpGayUnNhMCz8RB3pMWi0=;
        fh=ZZFSI0hKVoGm3f9N5wD+M+bkDCnuyo9/ZLKpAWrsRWY=;
        b=YrVBdiELi8Xw1fiXl7zpiddDvJxOixUBtf6YMqSe2cHaBAjuA2UB1WX6nCMrb5UH2M
         BhWzcJYM1C5oeNEGn4Isu2II799wkJ8JpxH9zFd8xXNLo/wTHH+fDCYHXoOyQoW3J4yp
         +RGxy+WjkBOby3bJSRRmPw/0+iO6eHC5XYDfzxOzKLt4I3CjY3ouDc+3ziF/lXlFYL8U
         5tcDW1kRc7z0bKAJ+a/TuvEa35F/rz/AynHmJI6T3yHiTvkS+r4JrQOHyd59JUtZppoe
         SUJU9S/96qq2RgmAEu0pSJvycqos5NFHcNDYWhKhiNwuhqqi9e8EnVWfVTRWGbToR+BI
         1XlQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784217556; x=1784822356; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itGbq07Nr/3aREyFCWeD5PlpGayUnNhMCz8RB3pMWi0=;
        b=hjvbx1SnqWKAv1zImnYyBSrHkmyGiWLR0Zx9EOzdzSRQ7Q64OapNefUwbjd1a7aRZz
         UCMqS8psJblfFRbTAUTlTK8oDRUM60j9dWaVh/j5IYaTi+OdAOS8yzmw0wVfrdlhINeE
         815/JZec3iBGYcBwomqPpv2OFGMbeyL4XpQuOrddshqaWefeovCswxMmNNHvQ9eJH0T/
         dabD2EbYCqcVa1V5Kzq3fBuBfG33bUJov5rWbEYcVJRqIWUB38o9Y9CW3Y3nyRRMthhs
         71KcVMQCtX12E3QR/K0+3ucrVU/3PCulw3zjFRiccEH8WunhPznmqkfAWBQYmmlfGrh+
         ffkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784217556; x=1784822356;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=itGbq07Nr/3aREyFCWeD5PlpGayUnNhMCz8RB3pMWi0=;
        b=KCDb8Z+D2BpI+lYb/qVmxkEFQ4mxbSJKLYHGLFl4OYDktbDyGqeAtWD+CMSpWZuFqP
         /DAP07EVKz/eEAZ2e1F5TB2NfWK2hVVyVTdXvjxLLVBx6rYuPPoZwZ5h3XApzPD6pArq
         we9qexJRemH0zqOKCmmIXlxoSyuAfza3tUIYzCDhnxEbU8UmstZ2Xi8acAXgPXJmkdMV
         VdxRUjtuqtRK4pMOqh3OBwHb98chOSaje1UGWOo5uy94fnjoEIcdfP00ulUFt3hlA7Tn
         chtnTsG/2QUZDxIHXoWYWmTonomBGOnqhP5+ifAyDjJdRYruavnmCl6SUR+9ZtcMejcX
         i7mQ==
X-Forwarded-Encrypted: i=1; AHgh+RozjQA/fcYa9MOk9xEi6LBcwx1ZqF0gOXCpL+4ZW/2ZpcxaPt6qczG6po0HOKPywscX6NF23A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwcvB42RtV4d0TgS8f7wRRD484cuuv/hxrvxl67/+QShJLNcyQ1
	6HbafEvqjm9hOxJREfBgcTmb7Jyn0CUhR55AdOh1wny6JmFHurviYKzughQPLpGdopKjuOZHd04
	4blxGzhNnMudTEUD/q6RqBaB45/fI+3A=
X-Gm-Gg: AfdE7clDxKep70rHABWY+gs344NwxjE+olPa5fK59TDNOuEkLGPog0XyY1BLFhdCx9b
	O7DXJj+ltpzZqdR5Vec2/BuJjbf/z49vpmTVj/li4/JeTtRja+QVaUOvQRxGf0bYmyoe0ONEzoR
	23h4c77XoebvS07GkCrs3ZODOpFt0ugISl1LlAHMdMDlD4sw4UyA/EehExWpSJkbEaTkS1Wg95H
	/n0m/bOzRA1F3yrGHbtV/JdKolO90od81XHvm4Esz1GHEVRdIx+G7qFqKg2fpCKx0Pi/ztgNMMO
	rirpyL2ACwS80Y1qpE7+Q5dnOppxLrM=
X-Received: by 2002:a05:690c:7283:b0:81e:bc7a:df50 with SMTP id
 00721157ae682-81ee27da338mr22708687b3.3.1784217556404; Thu, 16 Jul 2026
 08:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260714190356.190328-1-dmatlack@google.com> <2vxzy0fcicpi.fsf@kernel.org>
 <20260715172336.GC3775915@nvidia.com> <2vxzldbbhsb4.fsf@kernel.org>
In-Reply-To: <2vxzldbbhsb4.fsf@kernel.org>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Thu, 16 Jul 2026 16:59:04 +0100
X-Gm-Features: AUfX_mzDCiilD7YNKNL42B1YJ1d5u9iOC0w12NRZaSOyWnithGXUwP5aTZQILLU
Message-ID: <CAMw=ZnSCzUY=RWVqK6WxDx5F08ReOpnpyrksZiCLOYFXi0uxXA@mail.gmail.com>
Subject: Re: [RFC PATCH] liveupdate: Allow multiple openers for /dev/liveupdate
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_085918_187116_0C19F6DB 
X-CRM114-Status: GOOD (  25.72  )
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

On Thu, 16 Jul 2026 at 16:23, Pratyush Yadav <pratyush@kernel.org> wrote:
>
> On Wed, Jul 15 2026, Jason Gunthorpe wrote:
>
> > On Wed, Jul 15, 2026 at 03:50:33PM +0200, Pratyush Yadav wrote:
> >> Hi David,
> >>
> >> On Tue, Jul 14 2026, David Matlack wrote:
> >>
> >> > Remove the single-opener restriction for /dev/liveupdate by removing the
> >> > atomic in_use tracking and the exclusive open check in luo_open() that
> >> > returned -EBUSY. Protect luo_session_deserialize() with a mutex guard so
> >> > that concurrent open attempts by multiple processes safely executes
> >> > deserialization only once. Update liveupdate selftest to verify that
> >> > multiple concurrent openers succeed.
> >> >
> >> > LUO does not inherently require a single opener. There is some
> >> > documentation about it simplifying state management, but the only thing
> >> > it actually protects is the session deserialization during first open,
> >> > which can be easily handled with a mutex.
> >> >
> >> > Relaxing the single-opener requirement avoids the kernel forcing a
> >> > design pattern on userspace that it itself does not require, e.g.
> >> > allowing multiple userspace processes to create and manage sessions.
> >>
> >> Agreed. When the kernel had a global state machine in the early versions
> >> of LUO, this might have been more relevant. With sessions, even if we
> >> later add a state machine, it likely will be per-session instead of
> >> being global. So I think letting userspace open /dev/liveupdate multiple
> >> times makes a lot of sense.
> >>
> >> Also, today's systemd only supports preserving individual files, and
> >> does not hand out sessions. To get sessions, userspace must open
> >> /dev/liveupdate and create a session. This opens up room for one bad
> >> process to block every other process from creating sessions. It also
> >> imposes a need for userspace to add a polling/retry logic for getting
> >> sessions and serializes their execution around this point.
> >
> > Shouldn't systemd open and own /dev/liveupdate? That was at least what
> > I originally expected here, you'd talk to it and get a session FD
> > through dbus.
>
> AFAIK I doesn't do so today. You can either create FDs and save them via
> FDStore, and systemd will put them in its global session, or you grab a
> session directly from /dev/liveupdate and save the session via FDStore.
> Maybe in the future it will add the capability to vend out sessions
> through dbus as well, but at least today it doesn't do so.

I've added it after Pasha asked for it, will be in the next release:

https://www.freedesktop.org/software/systemd/man/devel/systemd.service.html#LUOSession=

