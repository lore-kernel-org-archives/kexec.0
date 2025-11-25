Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C235D0E6C6
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 11:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Wm+6M8LDE0X+0+aQHbYJCdauf2zkPM73itF+MPmgtrY=; b=oJ8dx7Iy7etQ3u4kCq4S7p1DwI
	49lH55mxBS0CpLnFl6O9AIRpX9fXZMAkllY+E+32S5pax7WlqTTkvuI2L+E4N0agnLbgr5U7oXEZO
	NOWzecOTCcJHW7Bxxah0Xw5yX1ICy8TSJuWBTw2kinu4/EJ1P0E5RidJIJBYiiNmhJvsI19h05AqN
	6c+Av7XCo9AEjRQW2rsABjwfeI2qYeDN7tLTOfae4NdjVLCZy1L+xDTkNsJf8XjnTvjAi4W1q8Goo
	ezFscBFMnHqtJJ+TWh+XZOUyyyA6Xv8+KLxSxPH1ISA3ooIOVHDF4GoCmMZTdmzr3Iwdkyk2OSHh7
	Si2J5e+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNqvF-0000000DBbA-2peE;
	Tue, 25 Nov 2025 11:09:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNqvE-0000000DBab-1HMJ
	for kexec@lists.infradead.org;
	Tue, 25 Nov 2025 11:09:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6FD1E60007;
	Tue, 25 Nov 2025 11:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE54CC4CEF1;
	Tue, 25 Nov 2025 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764068963;
	bh=4DYDMnA92UpIobCeJ2W3qbFQ8fEUSrxC8a7VpGT6HT8=;
	h=From:To:Cc:Subject:Date:From;
	b=RL/OtnymtiOv/8oA1itc+piZB+wYOpkgu3xLOj1e7E8nx80Cp+tgIlY4xyPnfY4Jz
	 9GK+D/XjhmJvMRg/XywuiWp8uN6EXr5xDsRbDuFtyl45ebV5zXU3IuyNHHH48UOMsr
	 NU+an4nUvUZ7i/mOBwYE76K13vWxU1OzjZtqnwk4E4Fu5svDQUcj0UTEZl7Snq14Vo
	 idyLYUbEZqZs6cjowTbN8VunrI+7/83feOGnTwfqs/tyB/XHj3jQAlZYC3g03Mtxf9
	 Gt8nuwURHbjepkEiXrB3XDeEIDOefYTRDSpTUxXiC/ujRloxwi8lLgdAbXSJ5XKP2m
	 3F+OM4y/2lu0g==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kho: fixes for vmalloc restoration
Date: Tue, 25 Nov 2025 13:09:15 +0200
Message-ID: <20251125110917.843744-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Pratyush reported off-list that when kho_restore_vmalloc() is used to
restore a vmalloc_huge() allocation it hits VM_BUG_ON() when we reconstruct
the struct pages in kho_restore_pages().

These patches fix the issue.

Mike Rapoport (Microsoft) (2):
  kho: kho_restore_vmalloc: fix initialization of pages array
  kho: fix restoring of contiguous ranges of order-0 pages

 kernel/liveupdate/kexec_handover.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.50.1


