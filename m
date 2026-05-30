Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18569CD6E49
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AqHHEDBCPx6eeTdQuLTbUwe3Ba19PriW4VAa7ABkIPE=; b=1nxx5r88qrAETnLvBcJDsXl5DS
	bWjfAP/akYW8i3w+V/4N110Is/738QB03N/TWfS70M+tc5+Qn8GpQITJcYtzvcNJxDVXIHc8k/tIV
	fSWxW7oM2uj804YzZmc5Izage/okPwqxe6enmb0C9PLUgzbjcCbLOxfQJLf4L9FEfR/+gQnVdtU0o
	Ko4K21EVgdAwKyaJD/7flgJDltyS3jDfKMLPpDZpoS4c62Pfdq8wwIxa8OO5f6sp+KTniWj/mBPEo
	mGVrj0dSFETEdgk6/coB0PDFHtZblnVDbnimDHbu1+yvcKVPLugspv8RbU+oIPWn83g4XCzEszjwN
	+cxBUExw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTSPD-000000096qe-23hF;
	Sat, 30 May 2026 22:43:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTSPA-000000096qJ-29OJ
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:43:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 475804419B;
	Sat, 30 May 2026 22:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AEF1F00893;
	Sat, 30 May 2026 22:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780181023;
	bh=AqHHEDBCPx6eeTdQuLTbUwe3Ba19PriW4VAa7ABkIPE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HUVdjpm55vVXCd/rXrwyIjaRGzI/fs2NJX0EBQ6KrxBOOuvU6xnttiGhlUzfLbCXd
	 5P1LCXQH84oX1vvDDO27joomvFYSw8kj7jpAuZxWwlCvZ7WEf3DnmvQAWKGn9VrEDz
	 JpHeZRtDluioBAlJ06fdEtZSdjJkYED9uPjWXinXSlCvOIonez1GpaBvVFJarWq7Mj
	 BfW5wXs7pI7DnKmuHrzCoayfxEOE/i4/qPQPlmnx7a2mwwBmOEKlDpL8ta609wtPG6
	 4T/gtosrA9PX4gervwVl8jpkRy6ODC9KCHAIUjC7Jz+xDgon3BpCHf5L/u04D/WHBB
	 1PegnMM4Kecuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393739302C0;
	Sat, 30 May 2026 22:43:47 +0000 (UTC)
Subject: Re: [GIT PULL] liveupdate: kho: two regression fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260530171420.1430298-1-rppt@kernel.org>
References: <20260530171420.1430298-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260530171420.1430298-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-fixes-2026-05-30
X-PR-Tracked-Commit-Id: 8fd2f26fa2a33cfe8ac043f976137ecf5b567f03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d87d0fc8c8e0a2a2b5026a169db2f270b4828c1
Message-Id: <178018102619.2731103.8401182140479584451.pr-tracker-bot@kernel.org>
Date: Sat, 30 May 2026 22:43:46 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_154344_596693_046FA75F 
X-CRM114-Status: UNSURE (   3.94  )
X-CRM114-Notice: Please train this message.
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

The pull request you sent on Sat, 30 May 2026 20:14:20 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-fixes-2026-05-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d87d0fc8c8e0a2a2b5026a169db2f270b4828c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

