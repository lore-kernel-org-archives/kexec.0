Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5653DCD4851
	for <kexec@archiver.kernel.org>; Wed, 13 May 2026 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iLlOdkfp7QSNnUgF2BNs1mDqIRB05WnP42VaWXM4hMo=; b=kyVlfWotGwV9SBn0NRkyBiczqk
	JNbNHM8O4uZFoQDZqNwlZ4JKUu+mt9zaSxQYHzmabvUq8l8gzKQVnaywL4yZXHzmJA/WP0WYhCZR7
	WbogoRK1g0IYT8IMRHPPvmMbxClX3A6PdJ3zOAdA2Xv0s/aKqjicwYWWNgX/QKANXzWw3zTPbJago
	08T9F9zWGLplEGV4Y/OaX9Tlj1RSw7UudncZU6xuTsGyVDL1fixKsUKUya/SMzMgB+xQREdfqf7ll
	7ESel2JE1HdCxIunlAQUHF0dVB5jlQMep8LQfGSO1ZFvVJJ4vEwkF+LTSRpd55/xAK7Pk5rmq4g4S
	jTRS7ytw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNBXS-000000035KZ-0BBG;
	Wed, 13 May 2026 15:30:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNBXQ-000000035Jv-06XN
	for kexec@lists.infradead.org;
	Wed, 13 May 2026 15:30:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4EA546012A;
	Wed, 13 May 2026 15:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC52C2BCB3;
	Wed, 13 May 2026 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778686189;
	bh=uI4vmPRYaOkKsG1dsiYOsQI9DoKlxqJpqxVwBQAaxqc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L+Vu+Jp+2FX8Qfuuzc7PzEh9i337pkhDzNUaHJTS40QaG1axFrmsId5eKwUx4NKSJ
	 hPO8m2k1uEC7VDwKB6wBsDIsV+A9jikvCKp1NHWKN6QXHoPjER8JFmRAAvuNzl3PaH
	 laDqsxGbMdeKqZDwFHuWcJ8YwCLT7GPKIvlNSPN6dLpWpDhYlnTTwA8UvRurYtjkJn
	 391iVlc8xvbsJBH3B+nOhXHUelKcm990h5bjxAehvfMRRYj0ycDVGDoKei4lY8IHWU
	 wEObrI7FRy4lXxl3QpfWEDYT/8KvQHQ7MmL1bav8ONi2na/NNHpbWA5SArxOtqrk05
	 H2xDZQg0oHurQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA16839301B5;
	Wed, 13 May 2026 15:28:55 +0000 (UTC)
Subject: Re: [GIT PULL] liveupdate updates for v7.1-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <agRQ2pV1vsO-MoTB@kernel.org>
References: <agRQ2pV1vsO-MoTB@kernel.org>
X-PR-Tracked-List-Id: <kexec.lists.infradead.org>
X-PR-Tracked-Message-Id: <agRQ2pV1vsO-MoTB@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/fixes-2026-05-13
X-PR-Tracked-Commit-Id: 7b0b68b2b95606e65594958686833e53423f58f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f63dd8ca0dc05a8272bb8155f643c691d29bb11
Message-Id: <177868613426.3700920.13576586222009152264.pr-tracker-bot@kernel.org>
Date: Wed, 13 May 2026 15:28:54 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, David Carlier <devnexen@gmail.com>, Evangelos Petrongonas <epetron@amazon.de>, Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

The pull request you sent on Wed, 13 May 2026 13:22:18 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/fixes-2026-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f63dd8ca0dc05a8272bb8155f643c691d29bb11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

