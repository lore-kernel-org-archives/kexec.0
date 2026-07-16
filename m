Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EE1C44512
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8yxtYzVJC/YQcgDQF17z4a4o6jbAXtuLmTRsrhHqBRs=; b=BJ6EOZ6Phfm+05jOJw2IJGKCHt
	1ZFyDTohMmMx4EFXuKAXHpo5QpEVQw+fFTHt0CJPKfiwrZDd9Na/Jvis0zuFbsYgGUwyWZXT4Bi/c
	Nkb31YiKee85YAF5ieLCPmivtJlN1i241ok5ApEfbsO50eIxOi/mklYaGH2qDkaxlWm1jm93IKGBE
	HvASZEnuACEScl099ZHgw1NOkzVO8BkW8yaEyESLOYB0G45ZRgoFDnPPkuch4L0g0DzlaQQ3F/bkt
	BCkzgiuiuyHB2hkPtiiptIxw4ftAwDMR2f+1hNXwKNr4wh8i6M5Mf/E5cbbprWCxX9Tft1SUlWzcz
	AG9MM1WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNvv-000000002Hn-43Ub;
	Thu, 16 Jul 2026 15:23:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNvu-000000002HY-31Ja
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 15:23:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 78DA34129D;
	Thu, 16 Jul 2026 15:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DBB1F000E9;
	Thu, 16 Jul 2026 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215410;
	bh=8yxtYzVJC/YQcgDQF17z4a4o6jbAXtuLmTRsrhHqBRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lRwM5aElMnpptEKmPpsPm1KyQJGAq302EL1cLrYDGvERvDwNmNdD4AOS9blZMuHoJ
	 XKOKwaSv6K17LiZNgA6Mnnn8pgW8WBW1BusLynbaFhZzXO8ws1nnyhsW79Yc+b4h5Y
	 EkQOGPkf+OMichonv2QhGwUXKBlrW19C4bSyf5ex+YqAKv/KB8yaJvS9u5dOw6IIZn
	 cdPI/zytfWIsbiPwjJtH3hIhcjoWjtoUVMRID5JlpOiYV7O76H8CZCce0VrMMwvYUv
	 45StT8TROgpnXAVCVOQDmNI8+Bn5TYDR1CSz++77v9W7opfAYbjD5yR0f/WMOWB2tj
	 rY/6dUR7wUWDg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	David Matlack <dmatlack@google.com>,  kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Luca Boccassi <luca.boccassi@gmail.com>
Subject: Re: [RFC PATCH] liveupdate: Allow multiple openers for /dev/liveupdate
In-Reply-To: <20260715172336.GC3775915@nvidia.com> (Jason Gunthorpe's message
	of "Wed, 15 Jul 2026 14:23:36 -0300")
References: <20260714190356.190328-1-dmatlack@google.com>
	<2vxzy0fcicpi.fsf@kernel.org> <20260715172336.GC3775915@nvidia.com>
Date: Thu, 16 Jul 2026 17:23:27 +0200
Message-ID: <2vxzldbbhsb4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Jul 15 2026, Jason Gunthorpe wrote:

> On Wed, Jul 15, 2026 at 03:50:33PM +0200, Pratyush Yadav wrote:
>> Hi David,
>> 
>> On Tue, Jul 14 2026, David Matlack wrote:
>> 
>> > Remove the single-opener restriction for /dev/liveupdate by removing the
>> > atomic in_use tracking and the exclusive open check in luo_open() that
>> > returned -EBUSY. Protect luo_session_deserialize() with a mutex guard so
>> > that concurrent open attempts by multiple processes safely executes
>> > deserialization only once. Update liveupdate selftest to verify that
>> > multiple concurrent openers succeed.
>> >
>> > LUO does not inherently require a single opener. There is some
>> > documentation about it simplifying state management, but the only thing
>> > it actually protects is the session deserialization during first open,
>> > which can be easily handled with a mutex.
>> >
>> > Relaxing the single-opener requirement avoids the kernel forcing a
>> > design pattern on userspace that it itself does not require, e.g.
>> > allowing multiple userspace processes to create and manage sessions.
>> 
>> Agreed. When the kernel had a global state machine in the early versions
>> of LUO, this might have been more relevant. With sessions, even if we
>> later add a state machine, it likely will be per-session instead of
>> being global. So I think letting userspace open /dev/liveupdate multiple
>> times makes a lot of sense.
>> 
>> Also, today's systemd only supports preserving individual files, and
>> does not hand out sessions. To get sessions, userspace must open
>> /dev/liveupdate and create a session. This opens up room for one bad
>> process to block every other process from creating sessions. It also
>> imposes a need for userspace to add a polling/retry logic for getting
>> sessions and serializes their execution around this point.
>
> Shouldn't systemd open and own /dev/liveupdate? That was at least what
> I originally expected here, you'd talk to it and get a session FD
> through dbus.

AFAIK I doesn't do so today. You can either create FDs and save them via
FDStore, and systemd will put them in its global session, or you grab a
session directly from /dev/liveupdate and save the session via FDStore.
Maybe in the future it will add the capability to vend out sessions
through dbus as well, but at least today it doesn't do so.

>
> Moving to multi-opening /dev/liveupdate and removing visibility of
> what sessions are open from systemd is a different model
>
> Not saying this patch is wrong or anything, but that I don't really
> understand what kind of model you are going for now.

My main idea is that I don't think it is the kernel's business to
enforce either of those models. There are no technical or architectural
reasons for doing so. If systemd wants to be the sole owner of
/dev/liveupdate and vend out sessions, it is free to not expose it to
its daemons by setting the right permissions on the file.

-- 
Regards,
Pratyush Yadav

