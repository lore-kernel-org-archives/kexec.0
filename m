Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3658C5DF9D
	for <kexec@archiver.kernel.org>; Sun, 23 Aug 2026 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QsDNIrgg21IWpYyBuhXQ4f5JQxGbAnh20UiPJbJBuDY=; b=bgTC9iOTrMlxYJR4+BqgPhHEUB
	ogSPPgWX4Y4DzeNanvCB/TwZjrI8tvUdLUo8xep5c7a33sgzM81eTWi2NNOqBY4KTSFw3HVQ38Vxa
	E4ULBDvlOwicKAANOp4/d5gKO17T7p5Uoa9QMe2TBIfJMagHv1tMuobPNoWWVeVPNyBgi7MTLEMwa
	jYWioQKSCO30iw5Pz/nwOkdRZAgwe83pFvvOp+HlOhc42E6b0AIoLrfaEXmBz+yQAbi6vhLSNYqHD
	1KpuzWfxP58Hi9HGWxMISR4pts5iu8VHln2PGmbfA601ZoUFGLDMflEEj55LUuhYt1Gsev+SXEbqw
	HIxwu96A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyB66-0000000FU3j-3Zo0;
	Sun, 23 Aug 2026 16:31:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyB65-0000000FU3d-48Rt
	for kexec@lists.infradead.org;
	Sun, 23 Aug 2026 16:31:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B8C040196;
	Sun, 23 Aug 2026 16:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6718B1F01564;
	Sun, 23 Aug 2026 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787502660;
	bh=QsDNIrgg21IWpYyBuhXQ4f5JQxGbAnh20UiPJbJBuDY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=SRAAjVlEN20R3dSf6E/eCUZXkegG51hHZaAIDYRP+kHVVQeoqCcQHCS1ZXDbPpyPZ
	 30HAdphU0Is0lnMIc8gU6EaJD2dpcf9vhYUt8omKgSCWXj6cknV+ddERVghXDey014
	 SlBCGC+/BEtDSmLFr/Py9jQnsCvQm7IqSUeon4L5Vt2hg67FIImehuyA2PlVS/aKUJ
	 MUnwW4T00IsNhUJr57UpyhZVXlkWJTSJSPcTaMfSKWNnwEPYCXRwUv+dgJqz/OhIry
	 j0c3Lflh2bV1JryZyE59eKR9juJjzsKsCj45XB6kji/p+eqwrNDVFNrbn3Clrl8Gex
	 L0T/2y/ZjFduA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D156D380AA78;
	Sun, 23 Aug 2026 16:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] liveupdate: updates for 7.3-rc1, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260823133634.3570153-1-rppt@kernel.org>
References: <20260823133634.3570153-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20260823133634.3570153-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-v7.3-rc1-20260823
X-PR-Tracked-Commit-Id: bc0f793c5c41601b273a2ca64c768adca1d447f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91959a31a3990073b55b506af044eda09c359fb4
Message-Id: <178750260860.2078512.2539370660916433944.pr-tracker-bot@kernel.org>
Date: Sun, 23 Aug 2026 16:30:08 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

The pull request you sent on Sun, 23 Aug 2026 16:36:32 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-v7.3-rc1-20260823

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91959a31a3990073b55b506af044eda09c359fb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

