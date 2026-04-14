Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D538F9D0CC
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XDNhYoEHCr9iBgF5kZ+2FPX074IIkg5lINW4SO+xfxs=; b=r4G+qUMtxblwsHVDZZmyRrYHcW
	2LgUYXS5gWM8pDzwXqkGf2zPEbLzXlgx7R5kNlieTyrbMp/34IsmkACaywaFyi4RYBR+//7hViF8p
	5orp4Rh2yJKiCLjouANjiOLgU77LEOqsYLVmGzUhDJCjo3JuWulEhW/zd+3n8C3D92YAdD7WPDSiI
	4bs34c9P03ltKgYvDzHjrd7fITiDDPyxh+XtKk7YkXsfapsW/fKtaEPlEelY0ZkS24Iy9rbqpawsi
	VV9u3+X9cuvjbLJI2ZOHSmoqyQbJY0YFzVxitQdF23mR6g4r+nvNAzbRZ1mS7y7QbCcojfhVxRSzr
	zdHXPgRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCciY-0000000HHw6-2a4a;
	Tue, 14 Apr 2026 12:18:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCciW-0000000HHv8-32LI
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 12:18:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 713D4409D3;
	Tue, 14 Apr 2026 12:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4107EC2BCB0;
	Tue, 14 Apr 2026 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776169088;
	bh=7YPA18L8fjFY1nJTSkWgelwEK1EqN1mPSRVgn6jl/YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UITAwoMFYDKlmLFClHtrJUImdu8sZ2LVZE0kZhndCJoJpW7Urem4RRmUGwrMv6ztU
	 aKC/BC7nMRPDx1c5Hlblqtv6HlBdJX9lLsSPdbRp1Ywwrc/ztp+yEvunYoBtXO7A0Y
	 Anm9NjV/9bdRsC9j+8MLmA6pB/ONADMaaHbn8bo/xy2ILnME+OmIyfEJTRLkogJAdM
	 Wt4umzLDOuM+D/RcRds38pZH5vgPzuDtRc3VZQYhyRBvQSg+7KRxS+oWMFJo8EkTLm
	 5HXH6PhZhWOL6+k7WpnlWPwPYraUCxnWHa1gRaBJkXRMKahN/0jv6KC1iM4tkEdyy0
	 f1Ug8Quq9MEfA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] MAINTAINERS: drop include/linux/kho/abi/ from KHO
Date: Tue, 14 Apr 2026 12:17:19 +0000
Message-ID: <20260414121752.1912847-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
In-Reply-To: <20260414121752.1912847-1-pratyush@kernel.org>
References: <20260414121752.1912847-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_051808_809276_741593F7 
X-CRM114-Status: UNSURE (   7.67  )
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

The KHO entry already includes include/linux/kho. Listing its
subdirectory is redundant.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97820188a600..c1e2cefb4493 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14121,7 +14121,6 @@ F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
 F:	include/linux/kho/
-F:	include/linux/kho/abi/
 F:	kernel/liveupdate/kexec_handover*
 F:	lib/test_kho.c
 F:	tools/testing/selftests/kho/
-- 
2.54.0.rc0.605.g598a273b03-goog


