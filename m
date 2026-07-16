Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4934BC44512
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PdAQBjl6KIVuMXkLxfPCPz4km/w/VDTC9FDAj//7F9c=; b=rkoWbjNKNukkMhgqa8NjkyjOWV
	LQ0mZPAb70BWIfdxNevNd7BTwfjwuUF7+FdSbrYSIgEugAHcFSXadu9mBgSP4B5Dg3VziS5ORgY3l
	B6g6OwojRDUXmSv5S0xOmGoY/0x8yi0pXuBjcQrt3TW0Scwivkt9QfsBSG+51bbv1aWCN0H4DKxhk
	yKUBumOEvssrsp9YeLROMFJAqGl/Nc4iCqgVPLG3pB0T/hzTGBKjvtfrkBf7foKLm2lUIvieGmnnZ
	ePuQb9ZeE7YXMjur+71IR8gELgVrStmVDO98c6IIUSrcwAPOXOv4BeEgjlULPwi7vPsePNIY0vfrX
	Lh04SM6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkODf-000000004oO-3SxV;
	Thu, 16 Jul 2026 15:41:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkODf-000000004oH-0D5i
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 15:41:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 839DE4122F;
	Thu, 16 Jul 2026 15:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E1F1F000E9;
	Thu, 16 Jul 2026 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216510;
	bh=PdAQBjl6KIVuMXkLxfPCPz4km/w/VDTC9FDAj//7F9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=C0kSG70RD57+n3a8nYGV2jjyNQofE32NmBi47BgzORKYiuPhMC6sNJnhij9QhYqRU
	 F0LfVD4orlJ2chw7mmCmfzqFfze/cukcis4jBTg/U+x/sjKzEAC7kXWuhqTCh33XyT
	 gHiSaVoj8bpNDKk7g0UQTdm7Y2sD1AGiMjLiYKVckefAXVkdz5CBBiQNQRi+YAHl3v
	 SpKYp6aYTvCiTLStZBy3gRuFdDDZLDpx22bt4R5BF06BZGgTIOAOH+MxpejaeALpc0
	 /Fc0pkZbprcYZKcQuJ+sb6q97KBW3AUIlwLu8Csy6jC8eJlC06BLD4sgrKe7CMCpR5
	 TABO1PLlbxjyw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,  Pratyush Yadav <pratyush@kernel.org>,
  David Matlack <dmatlack@google.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,  Mike
 Rapoport <rppt@kernel.org>,  Samiullah Khawaja <skhawaja@google.com>,
  Shuah Khan <shuah@kernel.org>,  luca.boccassi@gmail.com
Subject: Re: [RFC PATCH] liveupdate: Allow multiple openers for /dev/liveupdate
In-Reply-To: <aljtXsr6xvI6FAmA@google.com> (Pasha Tatashin's message of "Thu,
	16 Jul 2026 10:40:30 -0400")
References: <20260714190356.190328-1-dmatlack@google.com>
	<2vxzy0fcicpi.fsf@kernel.org> <20260715172336.GC3775915@nvidia.com>
	<aljtXsr6xvI6FAmA@google.com>
Date: Thu, 16 Jul 2026 17:41:47 +0200
Message-ID: <2vxzh5lzhrgk.fsf@kernel.org>
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

On Thu, Jul 16 2026, Pasha Tatashin wrote:

> On 07-15 14:23, Jason Gunthorpe wrote:
>> On Wed, Jul 15, 2026 at 03:50:33PM +0200, Pratyush Yadav wrote:
>> > Hi David,
>> > 
>> > On Tue, Jul 14 2026, David Matlack wrote:
>> > 
>> > > Remove the single-opener restriction for /dev/liveupdate by removing the
>> > > atomic in_use tracking and the exclusive open check in luo_open() that
>> > > returned -EBUSY. Protect luo_session_deserialize() with a mutex guard so
>> > > that concurrent open attempts by multiple processes safely executes
>> > > deserialization only once. Update liveupdate selftest to verify that
>> > > multiple concurrent openers succeed.
>> > >
>> > > LUO does not inherently require a single opener. There is some
>> > > documentation about it simplifying state management, but the only thing
>> > > it actually protects is the session deserialization during first open,
>> > > which can be easily handled with a mutex.
>> > >
>> > > Relaxing the single-opener requirement avoids the kernel forcing a
>> > > design pattern on userspace that it itself does not require, e.g.
>> > > allowing multiple userspace processes to create and manage sessions.
>> > 
>> > Agreed. When the kernel had a global state machine in the early versions
>> > of LUO, this might have been more relevant. With sessions, even if we
>> > later add a state machine, it likely will be per-session instead of
>> > being global. So I think letting userspace open /dev/liveupdate multiple
>> > times makes a lot of sense.
>> > 
>> > Also, today's systemd only supports preserving individual files, and
>> > does not hand out sessions. To get sessions, userspace must open
>
> It should in the future, because of permissions issue, see below.
>
>> > /dev/liveupdate and create a session. This opens up room for one bad
>> > process to block every other process from creating sessions. It also
>> > imposes a need for userspace to add a polling/retry logic for getting
>> > sessions and serializes their execution around this point.
>> 
>> Shouldn't systemd open and own /dev/liveupdate? That was at least what
>> I originally expected here, you'd talk to it and get a session FD
>> through dbus.
>> 
>> Moving to multi-opening /dev/liveupdate and removing visibility of
>> what sessions are open from systemd is a different model
>> 
>> Not saying this patch is wrong or anything, but that I don't really
>> understand what kind of model you are going for now.
>
> CC Luca for systemd's take.
>
> /dev/liveupdate should only be accessed by a privileged process, and 
> sessions should be accessed by whoever originally created them. While 
> this patch does not change the permissions, it paves the road for us to 
> move in the wrong direction: instead of having a privileged userspace 
> manager that distributes the sessions to their rightful owners, it 
> encourages userspace to work around the permissions so that VMMs access 
> /dev/liveupdate to retrieve or store their sessions directly. This would 
> also allow them to access sessions belonging to any other participant of 
> the live update.

But you can still do all this. In fact, systemd's release notes suggest
doing so [0]:

    Units can also create their own LUO Sessions by talking to the
    kernel directly, and store them in their FD Stores, and those will
    also be preserved and passed down to the unit after kexec

Having a single opener does not in practice prevent userspace from
creating sessions directly. All it does is to force them to turn the
open into a polling loop. So I don't think single open achieves the goal
you think it should. Userspace already works around this restriction.

So as long as we keep access to /dev/liveupdate restricted to privileged
processes, I don't see why single open is any better.

[0] https://github.com/systemd/systemd/releases#release-v261

>
> Instead, sessions should be created and retrieved by a privileged 
> process that knows to send them back to their rightful owner after 
> retrieval.
>
> Also, as a minor concern, each userspace LUO manager needs its own 
> session to maintain state. This means that by allowing multiple 
> managers, they may run into naming conflicts for those state sessions.

-- 
Regards,
Pratyush Yadav

