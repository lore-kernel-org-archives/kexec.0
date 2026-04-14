Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999C1F9D0FB
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PB1ZrnX1wzcdV4SqB2hSk+Rpdz0bGVbCMYiVJYC88mc=; b=F4zep7p+YOoyIrlCJRyEkFsVzB
	zRewcDYhC4bUs/F4/zy+x5aD7pJuXUNStgP3eTTMk1HVp+dhkU4jhpCyRl0Sb0h+Q1kNT3+xbks2v
	33etIhcsLckCCe7k9YAF8zMsQSpiZB5AXMQQbXhjVwrNHAyhaxC4DQK/OW4VMJNLNUKLZ/kxnZF2Z
	37oLG25KXllRNxPFQar0n4UIGecI72Eul1YgZwtaqW64kQPcmDobETM6zZijTQHqA+qIl3woaLmf1
	5yzrNUdZj2V4IusCQkiFQ/MmafbWCeCGeiHUx1dYsE7kQf10L33MgPFWxdOkIn1MUTSH+kAKlVy7z
	FrVQKgfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCnBu-00000000Khf-2pHB;
	Tue, 14 Apr 2026 23:29:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCnBt-00000000KhX-0t9v
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 23:29:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A6F2960018;
	Tue, 14 Apr 2026 23:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07234C19425;
	Tue, 14 Apr 2026 23:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776209347;
	bh=QfX+V1cAThBrIvA4drqcN16V2A/xpxvUcCAxE9nKwEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4uizB50aarC3jb24UXF+kP3viMzz2i/OCRUF1r5KS1P6vHD7QwqrT0BB9EG8+9Lc
	 3SlCZ5JdcqQOWY9AKdpqeBeMASttzItn6ffdMR3eyMnxeXgXYkKo05PYHKIx7bDdWP
	 8tDxCv2xYy85YgGgM83wRsV+nRIwYg6Fcw/UpBx+k31Is4AxN8Bn9FsSHx983VlQWB
	 xo6rFmdXZAhJerXvbwkEwaZbPfTBSXSDQiYtjmXvn549FKMBG/y0xXOMAKOGDGXzyK
	 2rfWZLIrpXj9x2hNoq/ncnLz0glHMtnili5BsaePK9sOqlpD1Cj+p/h3C3pFYEDfgN
	 LpXZF2hf1lAuA==
From: SeongJae Park <sj@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: drop include/linux/liveupdate from LIVE UPDATE
Date: Tue, 14 Apr 2026 16:29:03 -0700
Message-ID: <20260414232903.97446-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414121752.1912847-4-pratyush@kernel.org>
References: 
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

On Tue, 14 Apr 2026 12:17:20 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:

> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The directory does not exist any more.

This gives me an impression that it existed before, but from a time it was
removed but MAINTAINERS file was not appropriately updated.  But seems it
didn't exist in the mainline at all.

    $ git log v7.0 -- include/linux/liveupdate
    $

How about making the fact clarified?

> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Other than the above trivial one,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

