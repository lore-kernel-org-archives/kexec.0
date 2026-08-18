Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5844C5DF85
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EpQerXQbZSe4Wq320Dj3fwwzYb5xQfeYWcQSYz6oPP0=; b=xaSjnra2JQzA3ZPy23vwCUuthr
	TOW/1xLmEcHLhTSp3OJ0Lbb3wWV23C/wmVOM9w/q96vEXGa/NjA7I9qZJiC9FRW5N26wbzbjjZ9cb
	DCqWiy24nrMupuQjXb/Fr0TerWDBEjHI3qe3RslWAc5cTaqMytAxbHMvxlGdRFWRuu8JwnJNz55ba
	Fe5Q7BRBQlotDZaOCvFTbU0ujfy0UjboPJoejzUQDIh8S0FeKq51bVxCFUopmZCbMypGoV7LvZOYu
	FVmRMEYI6dBdzUFovCdRaQSMBINHtdR4VZgFxVpci1n6WkavvvQSaDRWeBj36zKANVxWRF3THh7bJ
	qMvB+fUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwPHZ-00000008ZXB-2pPW;
	Tue, 18 Aug 2026 19:15:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwPHX-00000008ZWt-3kVu
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 19:15:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 36B35409BC;
	Tue, 18 Aug 2026 19:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189E81F0155E;
	Tue, 18 Aug 2026 19:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080531;
	bh=EpQerXQbZSe4Wq320Dj3fwwzYb5xQfeYWcQSYz6oPP0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=AFdNSuQ6MPh39uTxiQkLnhUYzLFuGnHOaIFQ1aII4OoYMyPzmyw0ynmPCBGR9oR9A
	 c0yLs3lN1LOM8DSAcgUBb6+XSM9b5NIju/ZgNylyph0obJqrq+AXB+mvPtd9kO2I5T
	 nUQyHADKPTtftpfLCbrRib0jRoqoyvrpeSYExibo0Q4Md07AkHYE7ZS+3Jt/GQtBjl
	 D6UU+MhbxNliua4+/lebnmTirGUlWfr8TfH26ymoQlHoifJVf9CzBnBQKojoV7d38F
	 s8WHrqknJ3HgClf7WCct5WXG6nvmMfrnq3YlCuR/fHrHqxd7EkKwGNZovKx2KySH9Q
	 g2wWy0Rqw+qJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A103927051;
	Tue, 18 Aug 2026 19:14:43 +0000 (UTC)
Subject: Re: [GIT PULL] liveupdate: updates for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260813110815.2482807-1-rppt@kernel.org>
References: <20260813110815.2482807-1-rppt@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260813110815.2482807-1-rppt@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-v7.3-rc1
X-PR-Tracked-Commit-Id: bcf2a0b55e322a663c9602c9e773770b87d3e629
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b24dd46a70e94d8db83b50a04d46690fac216d0
Message-Id: <178708048250.2235733.8997074466118245465.pr-tracker-bot@kernel.org>
Date: Tue, 18 Aug 2026 19:14:42 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

The pull request you sent on Thu, 13 Aug 2026 14:07:58 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-v7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b24dd46a70e94d8db83b50a04d46690fac216d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

