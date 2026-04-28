Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FE8FF886D
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 12:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SaYkhtIf8uCy4S4m99sp7NZ8D56a7mMdSX80a5X82MQ=; b=FJb9VpkMwX/79f/GEp31znQhog
	yzqurpOuIMHEXv8Gj0DrmIkRL9MPuI7GO8tH8PWIeIycvYR/PwYjHvnl745P+r8uNnSYNTBzcE9Zy
	msoisNcU80H1QZD76mVANYplpHEYnZv0UOw3VzEUcl8JrWg8D0rznsFcQafy4rev5vQgHZWWtIrXz
	/XpGLWnHIxEj9N9ayb0Y2a19CnPjQBVjY4LCt6O3sXCpjTKUfOxKrvEWLRWHgzZ+l19ZYwbCchYy8
	fvJkSVIEYvePthAdzSSTUsJRoy+BKGdiGkuIHLfsG04utBkc0TSsTAPi9P5a8bV6zGpkg08yRrOM/
	XAXHYT1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhrp-00000001SoO-1Npj;
	Tue, 28 Apr 2026 12:48:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhrn-00000001Sns-2qkf
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 12:48:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CF74861333;
	Tue, 28 Apr 2026 12:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C751C2BCB5;
	Tue, 28 Apr 2026 12:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777380522;
	bh=n5wCm15+K3+O44nSoPI+pxf4Moq6WiC8pN5zqLPu6y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBYDFTqgY74W3Nx4q4t4eeLXg0fv06ArwPH8T3Lpm3nQfZpI/p9jOTRkxVQYbU4nm
	 cjDZwTjRSOc2KM2HqbZluQsumaLCCERATaE47SwFCOUx3CjQ5ZY/S3ZVAqwV9Q18a1
	 yhEWMNINnZicNm4hETuhbi6V1wOsfqJIjr0/hFNLF5uTd3lDEvjKTg/uLGzfVAas1r
	 QDN/zAImaFFPtbO78SVoGcvCnkl1mGmkHrkuhjF6rokTXZ296qVm1uTmWNKYPkyfl+
	 QO+f3Pmk9fMawYShQFwrH8M40VegvRZ3kjdvPLlhJ6f51UIYxP7/WCm/fiBcAfRMZF
	 yIS92dCWcwy/g==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: add tree for KDUMP and KEXEC
Date: Tue, 28 Apr 2026 15:48:32 +0300
Message-ID: <20260428124833.1903302-2-rppt@kernel.org>
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

KHO and LiveUpdate team is going to pick kdump and kexec patches to
their tree at

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git

Update MAINTAINERS to reflect it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..2685cbf89b5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13861,6 +13861,7 @@ R:	Dave Young <ruirui.yang@linux.dev>
 L:	kexec@lists.infradead.org
 S:	Maintained
 W:	http://lse.sourceforge.net/kdump/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	Documentation/admin-guide/kdump/
 F:	fs/proc/vmcore.c
 F:	include/linux/crash_core.h
@@ -14177,6 +14178,7 @@ M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 M:	Pratyush Yadav <pratyush@kernel.org>
 L:	kexec@lists.infradead.org
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
 F:	kernel/kexec*
-- 
2.53.0


