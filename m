Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A15606A882
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SLF3Ymoh;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0Wksski
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aXEWzZe6OnLHlf8VjTALCLu1A7VUqMKhDTtQNvf/NyI=; b=SLF3YmohS37rdQd0Iabvw5Ykah
	us77UXjrpb8LNxe3iA7WVn974DG8qeatUvG0llZisdjsZt6jaHF1ocR1oy6b36t9jMuPpVvJLqcL5
	t5JvTlhYQ5h7J3TirVue5IFOaShNBIItJimTD/gefftUaZm303wRE73YOFMy+rfZfLPm8+aO/JEqe
	wJ6hMoN/Addmal19Pl+qP9/D5txm6TdIeUHRkU853bK8uP6dEVusarwJkY1vatafV281L03tQzhDq
	7yZtt8aIMqfBUfNmPWQHWE6G15n5QnyOdRyH7s9BWEicgM7wG0fROcGNO1/9JscEIAo32NUGTgkGV
	nzzA/tKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSf4p-00000000L6Q-2ugu;
	Sun, 15 Nov 2026 18:35:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSf4o-00000000L6J-2AaJ
	for kexec@lists.infradead.org;
	Sun, 15 Nov 2026 18:35:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5087560DB0;
	Sun, 15 Nov 2026 18:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0747D1F000C4;
	Sun, 15 Nov 2026 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794767741;
	bh=aXEWzZe6OnLHlf8VjTALCLu1A7VUqMKhDTtQNvf/NyI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=J0WksskipE3SIqYo2ZaZlSFptKQyfDLSaxMBWtQB2BDDpOwM3QS/f8sYTSmqxOSJx
	 55JO2lKP8Aqkbvwc1IHYuUc2iY7iXYD5KfYzLG0VeFXFulMsWIYQSJpsw9pvNqy5zl
	 Dxb+hPQh6yYdsVDAoX/KNma1YM/UMauGLBFhQg8mqSRleWBB4h2QcJY4PdiHwTzKzA
	 z5C3aZJKk7CBZkhDwKWqL0DmGFZJYqXzma1zmsrsU21nYAG5ItIto/kVK644f50nqh
	 njVzCjlunow76K8ZBW9e+kywlpbf+6qvzNnLmCoxevG/yl3GfRkt3Xc0JAk09m4HEB
	 snco3NI2X3lSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16F1380822F;
	Sun, 15 Nov 2026 18:35:40 +0000 (UTC)
Subject: Re: [GIT PULL] kexec: MAINTAINERS update
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261115050200.1847508-1-rppt@kernel.org>
References: <20261115050200.1847508-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20261115050200.1847508-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/kexec-fixes-2026-11-15
X-PR-Tracked-Commit-Id: ab75132e99eb0b7dcd3a1882e35519f8229a669e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfac855a820c3a32219779e4fb44804e8f81977d
Message-Id: <179476773966.2691368.5009607276514482536.pr-tracker-bot@kernel.org>
Date: Sun, 15 Nov 2026 18:35:39 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Sun, 15 Nov 2026 07:01:59 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/kexec-fixes-2026-11-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfac855a820c3a32219779e4fb44804e8f81977d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

