Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49533606A321
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RQ+2Z57O;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1cg3drI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8PA9GkfQf2cFoS0ayw2916W2lJqjiT1U9quZNhALY7M=; b=RQ+2Z57OV/nCSioeifDncnphGD
	dL7XgR8rODg3qTxmYVjkR4iwPYmHokoT/YhEfcqmGx50I0aksVVBXqt5JAwUzQ3ybpAIkohkHGxKi
	cw6J9w/o2S/UJdkP824Agm4nw1mm+A058TCd47i5+lfV7XYqjVyGYUmGmgcTOO1ev2PQOokIVl5o/
	aXbuM8SBlbzuOBHTrDVrU3eybx0DD8/G2zqf+IuaBNNL3ccTmJhTAF+4eaSXhYAfruLtxdk9Vx9CP
	jXiUCgaBU6PYBrpJlGyES4Ef8Ii9jR+oT1Epf12DxLJ3YisbXuuFl8IjknLdHPDdjP2SmXJ8Z5oxL
	XqVVbNqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLBfD-00000001gJd-2PAD;
	Mon, 26 Oct 2026 03:46:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLBfC-00000001gJG-1uWg
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 03:46:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 96D58600CB;
	Mon, 26 Oct 2026 03:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D72A1F01825;
	Mon, 26 Oct 2026 03:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986381;
	bh=8PA9GkfQf2cFoS0ayw2916W2lJqjiT1U9quZNhALY7M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=m1cg3drIxo1khfwcePEIMT5l54AnUfXw6BRWhRgw1NG5ndhvC/r5UpDepyry8rOta
	 R+pUN+PZhVp2p2JnPF6Yqa2LQi0EppKeoOAdk36FWrUHiYD7qgwfFxy4dMzRwTe30x
	 QDO5Y+oqDMuQAL6JKCHkOL/TSxQ7MIRq2uxSQ/PXXMz+xSpDegkYvlBcdZ8VD7MoW8
	 ErRwqUfdp6LUuSktyi2VzqBIH/ipDlNLYxhrdeMqecBImbdqeUCwrY9g2s171zVsCF
	 xUR4XAZmJ/vD6duPwS96tL67qTrhGB8FPGiUGxixrzQH8ozdC5yw9/0vrd2zKMP00J
	 p9P/duBXu+KXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4463439EA761;
	Mon, 26 Oct 2026 03:46:21 +0000 (UTC)
Subject: Re: [GIT PULL] kexec: updates for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261024112155.3384616-1-rppt@kernel.org>
References: <20261024112155.3384616-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <kexec.lists.infradead.org>
X-PR-Tracked-Message-Id: <20261024112155.3384616-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/kexec-v7.4-rc1
X-PR-Tracked-Commit-Id: 833d2b79ed9520e77c5d83eb11644e5239b2c5bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3593aba315322d875f295eef8b1a19e24658ba6
Message-Id: <179298637979.2442679.15289838186801073122.pr-tracker-bot@kernel.org>
Date: Mon, 26 Oct 2026 03:46:19 +0000
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

The pull request you sent on Sat, 24 Oct 2026 14:21:54 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/kexec-v7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3593aba315322d875f295eef8b1a19e24658ba6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

