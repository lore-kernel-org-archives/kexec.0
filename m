Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CEAC531CB
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 10:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbG5Zbe2/oNmFZCOJFeMni1C89ckmgEXVtceIhLmvg4=; b=Y/gmB+SlV+IrUlofXxt7V2XkBs
	Lx8CdqK3ryInDpcUz1iqMpBefUn5WiJwqvXaF/zxO3aO536jV171RLbswCu/mVepoTK3hpLC0kYtm
	fE797bo8EdVT+2qp2q6riv2HL13rDsIh7FSG+s54akmdWaEMFWQSH3wKWpIRgFpcRdX/tP1Qjzkgz
	/3qeyyiYQBh2VCTd/LvPWgybEFrhHIV0mAv8+p2S/G5mV2N6SKw/1ZE+EhuElids4Ong3rR2IS2Fv
	hh2Em+xfZOb01ov9TW1I1QFW7hUmbBGw16ItRVj9kZLosW6rsAGklU2szpXlEKAzaDEx7G0ADricn
	YRDRgRqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmr3n-0000000E4oL-2CTC;
	Thu, 23 Jul 2026 10:53:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmr3m-0000000E4o6-1h3M
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 10:53:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E9EB941B15;
	Thu, 23 Jul 2026 10:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E95E1F00A3A;
	Thu, 23 Jul 2026 10:53:46 +0000 (UTC)
From: Pratyush Yadav <pratyush@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,  Jackie Liu <liuyun01@kylinos.cn>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] liveupdate: a fix for v7.2-rc5
In-Reply-To: <CAHk-=whyYBFw+o9RRyGXvfS+ipQgGAM1oHFL9KXFoCCkRvrTfA@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 22 Jul 2026 11:48:28 -0700")
References: <20260722162524.1014269-1-rppt@kernel.org>
	<CAHk-=whyYBFw+o9RRyGXvfS+ipQgGAM1oHFL9KXFoCCkRvrTfA@mail.gmail.com>
Date: Thu, 23 Jul 2026 12:53:44 +0200
Message-ID: <2vxzzezigeo7.fsf@kernel.org>
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

On Wed, Jul 22 2026, Linus Torvalds wrote:

> On Wed, 22 Jul 2026 at 09:25, Mike Rapoport <rppt@kernel.org> wrote:
>>
>> * Fix validation of LIVEUPDATE_SESSION_GET_NAME ioctl argument caused by a
>>   wrong resolution of a merge conflict during the last merge window
>
> Hmm. I tried to figure this one out, and there's no "Fixes" tag on this commit.
>
> It would seem to appear that the "merge conflict" wasn't actually a
> merge conflict, it was in fact a bad rebase (which in turn was due to
> a merge conflict in linux-next).
>
> People really should be extra careful about rebases like this. They
> destroy history, and when bugs happen, it's really hard to see *why*
> the bug happened because the actual cause of the bug has disappeared
> and no longer exists after the rebase.
>
> I *think* this commit should have a
>
>    Fixes: 507e3b479f9c ("liveupdate: validate session type before
> performing operation")
>
> but I'm not familiar with this code, so somebody should check that.

Yep, that's the one. The patch for this commit [0] was based on the v7.1
fixes branch, and at that point LIVEUPDATE_SESSION_GET_NAME didn't
exist. LIVEUPDATE_SESSION_GET_NAME went in via v7.2-rc1. So original
patch did the right thing and didn't have this bug.

But the patch was sent around v7.1-rc6 and you complained at the time
about rcs being too big. This bug doesn't cause anything bad, only
warning messages, so we decided to move it to the next branch targeting
v7.2-rc1. The next branch had the new LIVEUPDATE_SESSION_GET_NAME ioctl.
The move from fixes to next caused a conflict, and that conflict was not
fixed correctly.

I did go and read the commit after the rebase to make sure everything
was good, but apparently I am blind and completely missed this.

Unfortunately for this case I don't think there is much we could have
done to avoid the rebasing. When you move a commit from one branch to
another, you have to lose the history.

But in general, I get your point. We are merging our fixes branch into
next instead of rebasing next on top of it, so we would at least not
lose history when something in fixes conflicts with next.

[0] https://lore.kernel.org/all/20260519122428.2378446-1-pratyush@kernel.org/

>
> I really would like to see "Fixes" tags in general - but
> *particularly* for something like this because it's marked for stable
> (apparently because the bad rebase was marked for stable).

Yes, it should have the Fixes tag, and I missed that. But this patch
shouldn't go into stable. 507e3b479f9c ("liveupdate: validate session
type before performing operation") needs to go into stable but without
the LIVEUPDATE_SESSION_GET_NAME bits, because that's a new uAPI and has
no business being backported to stable. So the backport, if done right,
should not have this bug.

And Sasha did do the right thing with [1], so I think stable is already
in a good state.

[1] https://lore.kernel.org/stable/20260721004514.3421718-1-sashal@kernel.org/

-- 
Regards,
Pratyush Yadav

