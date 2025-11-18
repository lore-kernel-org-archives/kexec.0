Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E231CEE343
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KzLyoYUtaV7JmG91OXsljbaoJdcsWdUcTqfEyos/6Ws=; b=YjEx1umciHRxNso9DXv6mbp8H7
	JBDrYdoSTAgXEVbuJxU2srIQM3mqLtSSOl07KIEYBfq4izI+ZdPwvSsevVWzS1KErckMl+BwiLueb
	5volybzLyfkndDHTAueXs8GQGBJYjPs2sUjmTat23A/ZNhAEOjzOW80+VevaLg5Hlp1VUd9k+zpMT
	CFvqLPfL56oa8mYnQ+7OX3juL5SzGNXxTKR4rDDGHCy+qP6/MT0NySWSZbdSRwu5N9UJdECepmHQr
	h7HDD3Gck04rR6MdU8h9QABGEEKFVmctOSwFus6ODpQ8fvEw2qeqIofpvECN2jA1fSvicesgrGx9S
	+8TEW6lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQNN-00000000veG-26Js;
	Tue, 18 Nov 2025 18:24:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQNM-00000000ve0-1IxF
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 18:24:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A4A260129;
	Tue, 18 Nov 2025 18:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01115C4CEF1;
	Tue, 18 Nov 2025 18:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763490263;
	bh=fyLPAFBoJghiBCAB3NIk/qOCqx6vFu5htUaGPEmW1JU=;
	h=From:To:Cc:Subject:Date:From;
	b=Ud8H5qWjDYrgvHTvxseFOcZjgnjvjPGE1Fykjj2L3tZ23bYArNT/loOO2SCHFtK5P
	 w8elLHh/xQkRtb7pm9R/ENzwvEJ/Q4jdibfgTTbSUuxcoYp5161ptrIgl9lVTpfiKe
	 XAcBZjmcqoVSU4XlyyFhMLA5EQV3TzQRwtGMQFIa4w/oxdiBpJj3Ua7Tv8kx13dmTj
	 RKJ7Cd1LN20q19SqqR44PqI7P7ME7BLMvghYPQQxjJDdeLA8Q2Fl72kd7/E6EbBChw
	 B1pX3lxVWLtHFLwTLvQonK4zdPySJTLBVj4hTzXoKXOo4Lmb7uCB8hEvX5Xwq9VNKG
	 4wnNBXcBob2fw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add test_kho to KHO's entry
Date: Tue, 18 Nov 2025 19:24:15 +0100
Message-ID: <20251118182416.70660-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
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

Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
KHO maintainers can get patches for its test.

Cc: stable@vger.kernel.org
Fixes: b753522bed0b7 ("kho: add test for kexec handover")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05e336174ede5..b0873f8ebcda6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13799,6 +13799,7 @@ F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
 F:	kernel/liveupdate/kexec_handover*
+F:	lib/test_kho.c
 F:	tools/testing/selftests/kho/
 
 KEYS-ENCRYPTED
-- 
2.47.3


