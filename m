Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7ABC5DF86
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SpoSj4tU+X3QHpr3w3MNXi2l71I5f/zXzqZBVHIg5YE=; b=cb/IA58gytWij3czg2UxNzr27w
	ng70J2Bz5Tp3QJLLNwU2AlXxeWaOttUUvPsVU5qBQsLa1Oime6hGsdr+H+6iYAL3hrn3JS1D4u97a
	TDiUIn4pr8pyYIpkTg+ix4ME0m3YmwNGHUkGU3AXLVonqoszvSK7EUrqdIoS9epcZT/89ocqaldxZ
	vfK+Xe3Z705Q6as/0TeV7e5l9+OfvbaBGagvZrpUNiO5Z3Rfb25sjLoofLm9306qPp+6ePb+f17Wc
	FdyBs0j0AVon5JSG0sasaQ10jf1pI9/WK2RxJ1vDG1p4AfdnmG5r9x9oXOOue6ghAYkrp0CwM9hRt
	S6ZMWiwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwPHX-00000008ZWw-2Xir;
	Tue, 18 Aug 2026 19:15:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwPHW-00000008ZWa-1DJB
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 19:15:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AEC06408F6;
	Tue, 18 Aug 2026 19:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C831F0155B;
	Tue, 18 Aug 2026 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080529;
	bh=SpoSj4tU+X3QHpr3w3MNXi2l71I5f/zXzqZBVHIg5YE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=o2w305xVRMFsnAj2/k1GZWKmYJQFBjvJ27LPIY93XrlFDryST6PF1nlaJ/xMASfUp
	 N1PoTjYYfjbWnsPkIC5nUCgdEtRbHYagFVWCF/JK1flNYExDszahFeTz/oGYJFbGaA
	 h6lVeoyEllpHmmr5JrFYgeEbY85/ZW5+1VY+mcfzWmWe3TEMMU2HffF8XnLz1//fq7
	 Hcx7ONbX57DX2kPjbdMG4U1p8tZVmDO1APoaUF332IEmEHKH84Q411nHxpbr+8htZG
	 GM4BsFc0fBLh9SAULzyJ3vtPA9+9GVcQugrDmsw2uFAVbM8EXC+vsB7pz8XLVNx8IM
	 VmW+ji0OIwDiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F53927051;
	Tue, 18 Aug 2026 19:14:42 +0000 (UTC)
Subject: Re: [GIT PULL] kexec: updates for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260813110738.2482772-1-rppt@kernel.org>
References: <20260813110738.2482772-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260813110738.2482772-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/kexec-v7.3-rc1
X-PR-Tracked-Commit-Id: 9d50f7c5ad5b4b031c9b85f9a43c626d8268ab51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba24659b1dbee90d4ce7ffc7577e299f085533a1
Message-Id: <178708048100.2235733.13294323554923248674.pr-tracker-bot@kernel.org>
Date: Tue, 18 Aug 2026 19:14:41 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
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

The pull request you sent on Thu, 13 Aug 2026 14:07:23 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/kexec-v7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba24659b1dbee90d4ce7ffc7577e299f085533a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

