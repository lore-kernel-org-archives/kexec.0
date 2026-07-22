Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFC6C4453A
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 20:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x293ZzMrdwwGA7tu452t0IeQFFYVojz/N+4Hljq7HO0=; b=U0bF6GrvjoOm23aEoDwIL4bXM0
	k1favY2uN/0XpEHtQ8CFL0da6qNWGGXop6/y9CSXyIEXlxQiO5EM/03rrACxNij04Z7pCBq7ucMts
	jQStmM8XPDizWUvKmc/P9qF6P9XX/YPMjSeLiVfbQRVLwOcKzeOJ2ncD74Uzb5l/jFKqb2xuzzo3u
	Ehd3Tsgqg3l5qAakP7H6CSpPWk4nBKPE2ZiUp/advqjdNhlKJAz7iKuQThusYaLzzqrjuDnCKfD4C
	4kxpH0hU5mNodO/pgGeE8kuWQWcBlDI6Mhs4qerQwXNCt/2XpeHiQvVg8/GwhhQcEH1h2Nk7DnAMt
	qQRs5qKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmdx6-0000000Cljj-045Z;
	Wed, 22 Jul 2026 20:54:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmdx5-0000000Cljc-0G30
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 20:54:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 66E8D43C4A;
	Wed, 22 Jul 2026 20:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491471F00A3A;
	Wed, 22 Jul 2026 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784753642;
	bh=x293ZzMrdwwGA7tu452t0IeQFFYVojz/N+4Hljq7HO0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=O731mYOx1Df7TdnCDlifP/uvf8+VkYHbwUQ2HPNyp9pGk9Lnigtj+DAuaWUjoF/Dc
	 tpwphTtgtDaeTVfnVmXSQlw7db+8GjM+qqlpEHyK+BnONQHVSRAkNQeB9X1WA4tOA3
	 iUj5murcwzttfjrut6q7DUhzyw/pKQN6VMHXXySdePV3OW+Fyui603HfeB05Oest3t
	 ZqKpMVVVyfSVfB7ThHLDO3H//+pGnd7LtexZvbXm7mV5rho+3s6GWzW2Vc1bRZLALH
	 CbU4GRfkUS3PLKXF9dTdbqpbPnPf9jqPj+B32zqVJv5MYepVdCFPbWrkneuGdv/+CT
	 dOdysGAB/me/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199A0380CED4;
	Wed, 22 Jul 2026 20:53:32 +0000 (UTC)
Subject: Re: [GIT PULL] liveupdate: a fix for v7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260722162524.1014269-1-rppt@kernel.org>
References: <20260722162524.1014269-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <kexec.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260722162524.1014269-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-fixes-2026-07-22
X-PR-Tracked-Commit-Id: 4416f8a9ed5f49256dc69c664f1386b496ca16a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4539944e515183668109bdf4d0c3d7d228383d88
Message-Id: <178475361064.2020310.10032407307261731137.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jul 2026 20:53:30 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Jackie Liu <liuyun01@kylinos.cn>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
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

The pull request you sent on Wed, 22 Jul 2026 19:25:07 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-fixes-2026-07-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4539944e515183668109bdf4d0c3d7d228383d88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

