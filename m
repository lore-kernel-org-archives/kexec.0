Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4B606A322
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WcqSQJEI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iud6+Tsz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SsagISxi0qI49SXgbaqHMJnTeQEJUrT8R+ZKkwxfnp0=; b=WcqSQJEI4Qa+t+266pFsjziLeR
	0yBikZawXn2ax5G28OYFA4TIg2bMgQ13q/YFYdswohcoqh5wPvHe/3vYQGZhzS+NWRuRrnE65ccwn
	V3AfVganB1uQuDrXSmP76lGmE0leLggFy5ZWhfsLF6qZAbvBYZyjN6cMAeOIMwOLj8eGOyFHa+OaP
	f/iCz66ZA6PPs5lV7N0JZ50Kwe1ZQdBnHl+ajpeKfRGu2FZfhhzJKCE2K5hmpvYSMj0mAdwmBHFOY
	MWTx39uLV8KOmKIYHMFVu9V81h1PdrgHP1mTAQGN2VPF5CbwQTqcJZZKybReQ78tN4u+7NiTMpjF3
	Ef/KIX3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLBfF-00000001gKB-2qvi;
	Mon, 26 Oct 2026 03:46:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLBfE-00000001gJm-0eWk
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 03:46:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9878360120;
	Mon, 26 Oct 2026 03:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1551F01825;
	Mon, 26 Oct 2026 03:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986383;
	bh=SsagISxi0qI49SXgbaqHMJnTeQEJUrT8R+ZKkwxfnp0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=iud6+TszJtUxwQspZzhQJExY2oUs0SRKiAVJRuYeyMY888SK4n1J/cPhayyEBa49Z
	 GzGvBSTRFNulBVdbYyW7iqx8xD3/CKxIollZV2+drt2bI0jJZon1z2RwNfE4vLfn5F
	 ruGwELzQTvN6dtpXXuDHIobBILCWZZBP9p81GptuiJtyLZKNWc9PLvj5Kk6LqKiA0v
	 MBZm+CtpiVK9102vqVPyc0Aslg6kzisyiKr13+QVNCB3FuopZOi95G3C3El+qD/++b
	 sdk7OwJ7f10ylC9KapC810uIq3HwTdv2vcsrC2Y9U8SjTb0xRwadD4p/lAo294umHC
	 bEpC0mYkM8YYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 447C939EA761;
	Mon, 26 Oct 2026 03:46:23 +0000 (UTC)
Subject: Re: [GIT PULL] liveupdate: updates for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261024112228.3384682-1-rppt@kernel.org>
References: <20261024112228.3384682-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <kexec.lists.infradead.org>
X-PR-Tracked-Message-Id: <20261024112228.3384682-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git liveupdate-v7.4-rc1
X-PR-Tracked-Commit-Id: 9a6a70aefe77f6fb9ff2b3037dcf87f6dff65c8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 126ad898a6e97fcb4c3fbe6d979829f72b8c348c
Message-Id: <179298638199.2442679.15503618075883442316.pr-tracker-bot@kernel.org>
Date: Mon, 26 Oct 2026 03:46:21 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Sat, 24 Oct 2026 14:22:27 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git liveupdate-v7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/126ad898a6e97fcb4c3fbe6d979829f72b8c348c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

