Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5D606A31D
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XnJYRvJt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ua++PlLt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BQvSITIRJIq/LrCuYDWL3zvl98iDwr6EHjhrxtx22pw=; b=XnJYRvJtkPwfNxJSqlfnREE0LR
	vq+2Bfp8UhmVM/3nHTez6ZQ+vBzg8HbV44HR+eXZasC4TTDT/EIV0eZ8cxSrW3tWvBemXY7nprTsL
	pQ90KQEoG3bRF7a2NH708u8gA4RrewE4JbIO0Xxjo/4YogEc6M2ANmjhnw6mb55QwcMuwTpAjjNBc
	OUmyhK6MCFYPiHA5kB2gKT70uk8hV81ssa+gKz8AqbkDa8rZZ+/tTo8eAmEUPVRh+ra5vkagBIyQJ
	4k0WF4RVr7bYQaTV1f76+VtWoxWGqUadjBac++VW9kkSo46MhgzUFrCoAPE/BwHBQL1JGep2ooAUk
	zTZm/yyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSf4u-00000000L8S-3Dj4;
	Sun, 15 Nov 2026 18:35:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSf4q-00000000L6V-1gXF
	for kexec@lists.infradead.org;
	Sun, 15 Nov 2026 18:35:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8EE5060DB0;
	Sun, 15 Nov 2026 18:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452A71F000C4;
	Sun, 15 Nov 2026 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794767743;
	bh=BQvSITIRJIq/LrCuYDWL3zvl98iDwr6EHjhrxtx22pw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Ua++PlLtLWLZp1cN9wx76saG2RJjl0oPwiOJJj65PqGTgHhAYxz1lfxb4fLbzCxwC
	 ZNk6HTvSU60a8fxZp/F/4BxgrNhNiLCT9HUpVGQXL98h/g86twvKIE/t8z4823WWwE
	 M5y5cJg7cZngWUUunoolUKaatPUBelwpRgOdgKfucyR6s58DnFkZgxYYOw5xWwd+sX
	 VWlvcYigvzcPS6jI9re1Ar1xtDV/jq/qk8y/VIBtI76jSYiwd+4dej6h17e9VvA/5t
	 CazCqm0UD9/+zFBsZ2H1MCn2G7n7w3pIITYfkGdsy7Tda8e4x/K5Xntipbz7a2Fc8a
	 Gsg2F0NPK+ruA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A225380822F;
	Sun, 15 Nov 2026 18:35:43 +0000 (UTC)
Subject: Re: [GIT PULL] liveupdate: fixes for 7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261115050300.1847760-1-rppt@kernel.org>
References: <20261115050300.1847760-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20261115050300.1847760-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/fixes-2026-11-15
X-PR-Tracked-Commit-Id: 58c5852ca96c58cdfdb9646870b217fc54d06a97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04da1a14b9eae1dbc2ccc007b54f46771f9cb529
Message-Id: <179476774173.2691368.12556780418749677537.pr-tracker-bot@kernel.org>
Date: Sun, 15 Nov 2026 18:35:41 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Sun, 15 Nov 2026 07:02:58 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/fixes-2026-11-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04da1a14b9eae1dbc2ccc007b54f46771f9cb529

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

