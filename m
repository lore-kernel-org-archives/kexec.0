Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16A2FF885D
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 12:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LoHauB0aNDClHjbqEf5BAwuhOPLpZPLJG/TketrMVSU=; b=gkFiQkz8aR/OjQJoywtAjQEP4G
	diePPR5bEOemoMSnjbUpuqAA6MzTCktEtEZbQbmvULeutI6fYWVUfO0HX8iUG73vfVDBhCB4OqYoF
	uFlXRD89rV2CWO8bIxsDWaxE5pnF166SPP0s7+9LdfdLcWOu8PmeSHTPL84Mj6MBSlAAfltH6P0jA
	mjtfbQXlv1eoexAkAdz9BP189fgCWyZ9mx6SFkywsNYVLRoPlwIGETJ+7N9Ml247hdTvA4BP1JK98
	pXWgpPyAH9sT6W/U/GUNnPq6R7KimrMy52zTjuOYxi2BGbBLma51+Ottn7d0H7L6qL/zY77a85uez
	PtPxRA6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhmt-00000001SFG-3xVU;
	Tue, 28 Apr 2026 12:43:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhms-00000001SEr-2fzC
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 12:43:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B00076132F;
	Tue, 28 Apr 2026 12:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD76C2BCAF;
	Tue, 28 Apr 2026 12:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777380217;
	bh=XA/hR8vGDtkQcnxAa7Wf9ciY6ktlRZfPEn8Qv3ob+8M=;
	h=From:To:Cc:Subject:Date:From;
	b=XVAHdLN4NCDGZ6CRXZMuo6K45PrNy8VREQO9d3SWKayaxzpYg6ubiQbmoFm6TzOrs
	 oTI8Xdb1C0EJ6fPB88QKwHGHgKx2gpJYI3BQzaFMv/fxJb4kX12qWIjTbL0dpCC0NY
	 lbh3/c3iDsr42dAPfPCguDSiJB7udvHlEpaVWD6YGSEnp0/9pWeRIevKTNZnBmnl5I
	 xbLEpZ6LCvLTW0Prbl+wB0ubNK9R+GqImWoLCvGiokLfPJx9bTF+BKArvqdxzr+DWa
	 +KzVy563xyhfbD0nuIh9imSFNFvtyAW7b1oJxGDz6M4qJPtu89t0oR4mbnchD/QLXs
	 kpqxRU1J92Q7A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add kexec list to LIVE UPDATE
Date: Tue, 28 Apr 2026 14:43:20 +0200
Message-ID: <20260428124325.4189486-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

We plan to use the kexec list to track live update patches. Make sure it
gets Cced.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..e0859f186864 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14893,6 +14893,7 @@ LIVE UPDATE
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 M:	Mike Rapoport <rppt@kernel.org>
 M:	Pratyush Yadav <pratyush@kernel.org>
+L:	kexec@lists.infradead.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
-- 
2.54.0.545.g6539524ca2-goog


