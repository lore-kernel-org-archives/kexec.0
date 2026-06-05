Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40584CD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a3fjsrZVTPw1aYZ68MOZRhjvWhbqU4WKMYbQM6/kGaw=; b=GDPAc+px3wCIex62Ph2e/6zeRp
	nfOv8c4C5g0YGLymIHJVVJONTSOWlgvqprWua0JuwBHKexz3JLwkzhSG3e7xXmsLml28Mop94BnVS
	06tyqJoVA5P/N+jjsuUUmSQlHN/2zUnpi44T2EvQCLKECnO3VTKyI+Iy3tapdR6fr/4I3YR+s88pi
	mMvLsGTPnIh+n6pXmmEedjjW8XzC/fJ8HBBeEfuy3TRyuGnmm6EKkV+Twng6hpVB6vTvmwrDt12Ix
	8MkP159/nFqjDFsPIHUODlU2lq4MyNsIjwL6rpuvEsCOdVPU0QMRQiJ6lR3VCoUCFv1bO/xWhP2Fn
	dPuokgYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVX4U-00000000shE-1mFj;
	Fri, 05 Jun 2026 16:06:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVX4T-00000000sh5-1HBI
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 16:06:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 99F2243E84;
	Fri,  5 Jun 2026 16:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFAE1F00899;
	Fri,  5 Jun 2026 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780675616;
	bh=a3fjsrZVTPw1aYZ68MOZRhjvWhbqU4WKMYbQM6/kGaw=;
	h=From:To:Cc:Subject:Date;
	b=Kz9mMRVcZz92zZUMcK6kxzN4odPq1f1//hDJhb0psL2PVfB4ZrTpTN7o/h7/cXxb6
	 zIJos6d9BiwKXpgnTCycLVfFfmxmTTlCA0TX3xy10eYh4+RXZRgTw044U4kOORp2P3
	 sc0zQftcqpo2y7nOMN2wudqSXN4gUgM5AB9CxVZay6/f7NM+fnxDOwKeF0K2XCx6T3
	 8E235iZ7PyFotYwS/OJkPYCJAmlFXXTIPl4IMPC8vL0wB1SGd6JbzeABJV7Zf4l1yZ
	 NpbFRDV9mq4cvDDKe5MVd02GjQ9yrYP42VYq4rChYdgmoVpBGnnK8kfYMcowlkctHJ
	 oOjbrhEDcD6YA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: memfd_preservation: fix rendering of ABI documentation
Date: Fri,  5 Jun 2026 18:06:44 +0200
Message-ID: <20260605160645.3650271-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
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

The "memfd Live Update ABI" section in include/linux/kho/abi/memfd.h
currently does not render in the exported documentation. This is because
it should not include the "DOC:" in its reference. Drop it to ensure
correct rendering. Tested by running make htmldocs.

Fixes: 15fc11bb2cb6 ("docs: add documentation for memfd preservation via LUO")
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    Mike/Pasha, I reckon this can still go in liveupdate/next. But if you
    think it is too late, we can probably take it via -rc1 fixes as well.

 Documentation/mm/memfd_preservation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/memfd_preservation.rst
index a8a5b476afd3..c908a12dffa7 100644
--- a/Documentation/mm/memfd_preservation.rst
+++ b/Documentation/mm/memfd_preservation.rst
@@ -11,7 +11,7 @@ Memfd Preservation ABI
 ======================
 
 .. kernel-doc:: include/linux/kho/abi/memfd.h
-   :doc: DOC: memfd Live Update ABI
+   :doc: memfd Live Update ABI
 
 .. kernel-doc:: include/linux/kho/abi/memfd.h
    :internal:

base-commit: 2935777b418d2bfcbfe96705bb2c0fa6c0d94e18
-- 
2.54.0.1032.g2f8565e1d1-goog


