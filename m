Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8530FF8870
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pxkuLRI0ubo6TvpPnU2fVvQJqaMV6b0I2+eekUjorzA=; b=uZ7jwSKwL64hM+iy7i0yox2yE5
	TIOAAp3zPQYtOw9JViQ01NwuWyesbSbkDBh2lnjgEC/dAt7uDDVXUYdBC0GLQZYd8h0vV750u/0/N
	vJ54QPBF3bRhwvPOc9Co+7mwJTFeF0Liwg7hElV8QynqPGSGIqxtDnCY+ydFldno15uS5E89jxiKY
	4HrKKvNbzpyUlSAgm07rzMz/leqRVsSFc037hOITZwAzRkNiEotm7O7z6T15WNe9MFDYWKlp4iFtX
	RbWkkSBEyQ9bz7TX148eh/LsPWSkTF7bXdTj7AkHGNQudAVP1HFXxbJ57byvmiV0MwoIHLOxtt6Nd
	WTWdN1sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhrq-00000001SpU-2XOL;
	Tue, 28 Apr 2026 12:48:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhrq-00000001Sos-0EvN
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 12:48:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D24E61145;
	Tue, 28 Apr 2026 12:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB8FC2BCAF;
	Tue, 28 Apr 2026 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777380525;
	bh=FZ6xkUHLBITG8WYxD3KjH9rWhUasExFuO4K2uhNQNo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsEyFBOse5CEbA7nsVG1i86huBtrK5U2CssR3zByW/5+P0ktsA29ySUKayUHtF7nG
	 w+dfHv4LoPxI2QiAE2HBGpPb6/gyaSoj3eX55abk1EZpeSfh2qzoZttkop8+SPGdLH
	 tcEzCe3XFvHvwh3bTjx/Yuye+UoBocCCYjpvaIsEKlF9kiY8RAkSW4bnAtGDD7DYKb
	 cUF9WT+nEbZXmiXOjb/LLapGRUXQCDLxOaZ4MoBPrzB5oLxL63XPYt9JEpcwwIMXs8
	 r1Yjuvam1ytFB30jhRRF2NwueKCK45tM9pqzq0ZiQ/dp0jAhVpKyoVvmPT0t/8t6Rv
	 0InYaFWI+4rhQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: add kexec@ list to LIVE UPDATE ENTRY
Date: Tue, 28 Apr 2026 15:48:33 +0300
Message-ID: <20260428124833.1903302-3-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428124833.1903302-1-rppt@kernel.org>
References: <20260428124833.1903302-1-rppt@kernel.org>
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

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2685cbf89b5e..1be7d97bdd8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14895,6 +14895,7 @@ LIVE UPDATE
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 M:	Mike Rapoport <rppt@kernel.org>
 M:	Pratyush Yadav <pratyush@kernel.org>
+L:	kexec@lists.infradead.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
-- 
2.53.0


