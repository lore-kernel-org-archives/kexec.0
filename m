Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F06FF885D
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kx4Z9S7Bpa9HQO0cTr3r0xlBexxh+B79sMRxGg6I3tc=; b=SOJomjLBXksHM2dEKNDEId5og9
	nDZYMhD+lRn28N355jB/Jd+2a7QqD1as1UBFu2H1cj8G/yARmnJVHH0DWJzwoZXve5UELct/MlHKo
	xKyyHqFMC14xJf0g/pf7H8ioJf8/Wgz1yjuvpxE6itJvk3Z3gNFu95VIyUFLznfSnOiX4ECmUQk+c
	9hExKOg/o/IeEmV9PMdAUw+jvANAVrR2g4cmpVrp2O3Y3WYBqho9UzORk/cIn6rfwpvK/Z1D7qZHc
	a4TDx6O/pMNZJYJhF/6aEEBgDaaS8jbcqYNe5ydrWk9EDW9it5q3OgwupZ2wbPJy0jQMOL15b3ISt
	9DjA1Fog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhro-00000001So0-0HuC;
	Tue, 28 Apr 2026 12:48:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhrk-00000001SnY-2n3C
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 12:48:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B00143F50;
	Tue, 28 Apr 2026 12:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB479C2BCAF;
	Tue, 28 Apr 2026 12:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777380519;
	bh=9s6njrQfVXz8FNQXaWepEeYdK9+qlp8ItB6D7QszUrc=;
	h=From:To:Cc:Subject:Date:From;
	b=IuT5nf+2hiV14doqDZdjDBHZT3I6iUautGjelvnuZFZyaEeIxRepTX2T8YcxzZ82c
	 vU1W7PfbG0tC4YP7Dl/WBH1zdGjV+a/zFE9fVV+9tnU8ipy4ffVImqj5/HRiTEF8hj
	 I35mAJE2byTwZOr0ym6FN016VM46mO1V4nEsUZB4fDqGW9tNDDIBvIMeLOlrzVt+3y
	 WDquhwQgq+sI+7uMX8+QVXVbGq0YTtGU7S7Xm3TzENcSeEtxKK4s2p3tHZo+B6IFZk
	 2TVfTvkHIqNuXX21a+065EHMJlYkkHDhKW2BmhHNIrkMTtdGqiDrXOMApZrFD3zDHl
	 N6NNkOZGOEL3w==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MAINTAINERS: update KEXEC, KDUMP and LIVE UPDATE
Date: Tue, 28 Apr 2026 15:48:31 +0300
Message-ID: <20260428124833.1903302-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_054840_725728_B1E1C552 
X-CRM114-Status: UNSURE (   6.49  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

KHO and LiveUpdate team is going to pick kdump and kexec patches to
their tree at
    
https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git

Update MAINTAINERS to reflect this change and add kexec@ list to LIVE
UPDATE entry.
   
Mike Rapoport (Microsoft) (2):
  MAINTAINERS: add tree for KDUMP and KEXEC
  MAINTAINERS: add kexec@ list to LIVE UPDATE ENTRY

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0


