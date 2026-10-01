Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBCACA5FCE
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 19:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jr2HHAis+JrPprJQk8TG5Nc3ZhtLMDG+6rLemDdLy40=; b=HPBwNfHfRzeEKR3SxfrVvg9BSZ
	QmDy1QDfRbfzcEU04sQzn9XjWyOYpcMlhETJOq7bOR6rKC1OdmemZk0c7z/lgKXRyKPkFi8JS/5Ln
	xCstC69iSjP8pmGxYzmitYlb+IWmLRlOM4HiGJDM9OD6ZDRA/f+kfFOOcNdMx8k2PTk94j+JvJEIu
	UOacdJqHaSyf9EB26Hzh8MJEMe1otg2NBFr3mXbv7XiRyETlfIaY5GyF8GXrGj1t0nD/ErY5ZYFSb
	oajTucZF1YaRLSPKw4yiGwzK7pIIJJRaYSlFrJU0qETP2oP3ExkGUH8rvATtCbBqFkzoO7VLbYIf5
	8yzdhAwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCMl2-0000000A6ja-3xuM;
	Thu, 01 Oct 2026 19:47:56 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCMl1-0000000A6jP-2i4t
	for kexec@lists.infradead.org;
	Thu, 01 Oct 2026 19:47:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B2A2D601FE;
	Thu,  1 Oct 2026 19:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF051F000FF;
	Thu,  1 Oct 2026 19:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790884074;
	bh=jr2HHAis+JrPprJQk8TG5Nc3ZhtLMDG+6rLemDdLy40=;
	h=From:To:Cc:Subject:Date;
	b=Ye0H359AGeuz4xmAkOLZHpClAxFY2CbDHWZ9KrfJsfl2K9Xa1tiJj5POr2cLaKlx0
	 ZKDFV20s08ZgWkOMwm8OYfo0RfiT2DCAFJ/JJwtub6RNc5bm8I8RGsVJU9fEHgWGr4
	 Cj34luQ+YihJVwU6tSD3kGOKFTmvTSDrzENFPuRaslj3gPRhk2K94tUUqUXuXuzhGG
	 vBuiwwmhA9QfX4D7/nWT5bd7OhSazT667LKqLmv5ZZ5ishHqkgJhZCy/ndRUze7JIx
	 etK8dSkUraSljbcIyVUoB/PBmFTWO9czupvh0X9AWUeTkr0Db9rsMjiJsTvDBnrDCt
	 ZxcYdkGewTrmw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Logan Odell <loganodell@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, Pratyush Yadav <pratyush@kernel.org>
Subject: [ANNOUNCE] Live Update BoF at LPC 2026
Date: Thu, 01 Oct 2026 21:47:50 +0200
Message-ID: <2vxzh5j5kxsp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi all,

The proposal for a Live Update BoF has been accepted. The BoF is
scheduled on Monday October 5th at 12:00. Event link:
https://lpc.events/event/20/contributions/2641/

The primary topic of discussion will be LUO/KHO ABI and what type of
backwards and forwards compatibility should be guaranteed for the ABI.
There are different opinions from various parts of the community and
this would be a chance to bring out all views and come to an agreement.
More context can be found at these mailing list threads: [0][1].

Other list of potential topics, time permitting:

- TMPFS preservation [2][3].
- Getting rid of scratch/bootmem areas.
- KHO enablement on different architectures like Loongarch or PowerPC.
- Making KHO work with crash reservations and KASAN.

This list is open to suggestions.

Hope to see you there!

[0] https://lore.kernel.org/kexec/2vxzik5f311e.fsf@kernel.org/#r
[1] https://lore.kernel.org/kexec/20260904160009.GV4157646@nvidia.com/#r
[2] https://lore.kernel.org/kexec/20260923224408.3745689-1-pratyush@kernel.org/T/#u
[3] https://lore.kernel.org/kexec/20260901180713.4185641-1-dmatlack@google.com/T/#u

-- 
Regards,
Pratyush Yadav

