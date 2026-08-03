Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAD0C55822
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u67MFJ5FLnRVSbiIEDmYJf9NPMdfoQaVK0z5ljtrlrY=; b=tbZWNDBgvhw5zzd5vtQLMfZGYZ
	aG1mkKIiKpk8EeX85EBcbWVfuWj/8w9avbbpjs5lOBRT+NvV65K4iNIZd7hH1SHvujxba54ESwnho
	f/dJNuFneP+XbPAZvGccgjz9kJz6qjt6kZnNuGH2BQRCxsyGreLm5NZhpW5AuutN0dFk4ZlqALXY+
	/XWHMs8j0s6T4+OxT9VnXKtSgsm6lyy9SWQf+iFEkwSirMBrNQYBHhHwAz5OxEKhha5wZHE50SlF3
	/fUgCiyVfhTq91QlzHFszX3V9c2Yjcf4GfYilM4kI2iBhwqBma4xhbAA2bqm1sV4j8VfstWfHJPNF
	moGbXrzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqxdT-00000000OED-2BHi;
	Mon, 03 Aug 2026 18:43:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqxdR-00000000ODt-2m77
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 18:43:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5BCF260AB3;
	Mon,  3 Aug 2026 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE031F00A3A;
	Mon,  3 Aug 2026 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782616;
	bh=u67MFJ5FLnRVSbiIEDmYJf9NPMdfoQaVK0z5ljtrlrY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Tlu3I/E6kpYl9xxxdR3zBQLqkPRzmDrg3ChuEKQgxSz8Z5CHOtYyBAkAJIGCulCp3
	 0MoxysjXfsa80+1fiKJsULDcfF+56yeFsfC7cCTo41imQUi+st30JHfcBzQGDVjQH3
	 I+xUdWd5aVE663OtdlEIDb07PpfNLNJYp7rsd1jwk8I5wvkvSsiGMA+cmvWlvscTMm
	 V/Odg8zARCU8SjBYhXLX/2fOq6XS1x3kWgBkXjgduAhTgS9+BCufqhFK0ly0FzZAJd
	 6EoB1xfeWtahdxWU/JtD5QFU4c8zkReQCbWG3g9aQ30c8yiup7qGg9bjKKfuapZRnM
	 ZejPJsyfooGQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569993924441;
	Mon,  3 Aug 2026 18:42:58 +0000 (UTC)
Subject: Re: [GIT PULL] liveupdate: a fix for v7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260803112452.1793120-1-rppt@kernel.org>
References: <20260803112452.1793120-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260803112452.1793120-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-fixes-2026-08-03
X-PR-Tracked-Commit-Id: 797fe91e50d6927f90f0c3b4444277c2c7c8b42b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8e0d43058e6aaaf198e418a1d28a8da6e2dda69
Message-Id: <178578257691.2780879.12109163148620218018.pr-tracker-bot@kernel.org>
Date: Mon, 03 Aug 2026 18:42:56 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, Michal Clapinski <mclapinski@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

The pull request you sent on Mon,  3 Aug 2026 14:24:51 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-fixes-2026-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8e0d43058e6aaaf198e418a1d28a8da6e2dda69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

