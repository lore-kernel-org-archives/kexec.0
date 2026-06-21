Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1434CD98F2
	for <kexec@archiver.kernel.org>; Sun, 21 Jun 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KGD7mDxUZH+Nw51w9aNh5WD3F2QLUljexbQ4imIVMLg=; b=qnSrgkZF0hFSdiDsQKMtU+HBko
	m6fSubrOXUOvcL88nbE8g3pq/8WZgWm9UAe+XpM7FfI2X9a0zDnaaBSyYZH6RXzIX9NhEs8sBbjBd
	aOs4FzewNeLc+Bj6eIuJnH4X0I3cigsWJ0PDnKyDMektKPaJZj6pUvp/lzS8MsKrK9zs2lz2mRhNi
	RR1E1TlU3OBzfwDoGKLJis6k7yxT9fdbfEjQW5KRn7UKxac4dhIgPN4qLOAk76ljFqaC/oADXPrgl
	4/cw2CHC7sf9OGskbCJsbrrqQvF9NeTftHUhgou/TJy7RDCuM9HYrh+UClzd0XLRspp1R6yHPBVh7
	FaC8eRpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbLwL-000000045FU-1hRO;
	Sun, 21 Jun 2026 17:26:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbLwJ-000000045F7-1t38
	for kexec@lists.infradead.org;
	Sun, 21 Jun 2026 17:26:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AC4CA60051;
	Sun, 21 Jun 2026 17:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6389C1F000E9;
	Sun, 21 Jun 2026 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782062793;
	bh=KGD7mDxUZH+Nw51w9aNh5WD3F2QLUljexbQ4imIVMLg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=l+KkXvZe5UEW0CegXZ26QjOZZijO13UbBSQXPsqSQZVmUr6mBc1sG+t7EKDJISGIr
	 BX3JwgMkytNYLqWJA7RDusXrRl0Sj+09Xb+289P+WDkY3XsPj/V55yk6lnBbbYAhuU
	 8w66kl+0u3HPsmxLiYhx6sbBvaJleBfYiT3f2JG9uD0FhLSlIXdUVzPOSUA3pWVzEn
	 NACJXXaRzGRtsAYnT/ac6fouWsOhsT+TRzuhUeE3F1kzHfbJ7Rl6Om/JNhH6UzfnfQ
	 6oAB2Gv0mdGXZlCyYABUi6cCLZ1UiX0oSju5dW4pksMU916NRVqEcNPyqoE/StOgQT
	 fBcQW9NmPAGyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A203AAA6E4;
	Sun, 21 Jun 2026 17:26:26 +0000 (UTC)
Subject: Re: [GIT PULL] liveupdate: updates for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260621123807.2873974-1-rppt@kernel.org>
References: <20260621123807.2873974-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <kexec.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260621123807.2873974-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-v7.2-rc1
X-PR-Tracked-Commit-Id: e98a9c61721c14bcd29f11f4802e52e908701f7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d639d9fa162aadec1ae9980c4dcf6e50bd2f8290
Message-Id: <178206278451.447873.7313645435005519416.pr-tracker-bot@kernel.org>
Date: Sun, 21 Jun 2026 17:26:24 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
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

The pull request you sent on Sun, 21 Jun 2026 15:38:04 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-v7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d639d9fa162aadec1ae9980c4dcf6e50bd2f8290

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

