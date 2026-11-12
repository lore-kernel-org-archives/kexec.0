Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C4606A321
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s3X/g4W/;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aM3mzmKI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cz2r/Y2RPzkO+j+uVzXdreXvdepgECgH9EKrVQJEg7Q=; b=s3X/g4W/bL0Duh
	IrNGa1WQC+PNvPwIM2D6BZl2ODBPcNyTSotQIA+3Tkc6zAu9yIs/gUBFQKa3H1O7jusvBawdldnFC
	b/dKfsltVAiUmeyke4GWREhl1scpXaUwG2XGYu0uW7dyXtOZ0IuBeoI+gUe190gH6ChU26XgMHGwb
	HVWLYCZomc/8wvnGTwZHkyO/XgniZ52u+EIIkflupXR8/QqfJ6UIeuniw59Wts70DoaAtIj4BF2E/
	ZGStmAJTTO+mMob0+BFqJa3x8smD2eW0lmwR96KuWtVgXLgr0RdgQ43hb3nQqfT6exIMqQUK78RqW
	JRB4wvjCokULnvxTH99g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSDG-00000009YT5-3Wel;
	Thu, 12 Nov 2026 10:39:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSDF-00000009YRx-2aCX
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 10:39:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C1267473F1;
	Thu, 12 Nov 2026 10:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A6C1F00A06;
	Thu, 12 Nov 2026 10:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479964;
	bh=cz2r/Y2RPzkO+j+uVzXdreXvdepgECgH9EKrVQJEg7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aM3mzmKI0GmlyxQCwRqIdTeDtT0/EkcRgXJqO8ZBSxOztx0GD3kM7pxCxTvuI6bWL
	 MAKSxVbRYHVhlIvlXkKUKAAfZyvvr+Ydf0POkAqRJf7LOKPxy8YakB9NQK4bUKrK90
	 vTfKz89aFtB9W2vtJhdgPijQChR/2aNFBgW0zCJ58q8xOyLwnNLj9Qcqy9FGSacTy1
	 DpUmPBZEEqnDVIu9K8UwDTpwAiycuDEh2XnUj+LHjMN/vWv0HAu+Akq6EIQUbHtG8n
	 aSlHPG19OlhtCa8az5aDP76zrHzt2H+/GoUaj0qUBw+C2HWU9vCt48hdNRe4zjs0BJ
	 cDAuDWQHAJFEg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 12 Nov 2026 12:38:57 +0200
Subject: [PATCH v3 5/5] kho: docs: update description of bootmem regions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kho-bootmem-sizing-v3-5-f0c8d00295d5@kernel.org>
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
In-Reply-To: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>, 
 Kexin Liu <liukexin@kylinos.cn>, Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The description of the boot memory regions does not mention the low
memory region and claims there is always a region per node plus a global
region, while the low memory and the global regions are not allocated
when they would be empty.

List all types of the boot memory regions and describe when they are not
allocated.

While on it, fix grammar and split the description of the regions size
and of the CMA usage into separate paragraphs.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 Documentation/core-api/kho/index.rst | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index e78a2bbe2be1d..ce2bf9cf66514 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -52,17 +52,26 @@ allocations before during boot up to the initialization of the page allocator.
 
 We guarantee that we always have such regions through the boot memory regions:
 On first boot KHO allocates several physically contiguous memory regions. Since
-after kexec these regions will be used by early memory allocations, there is a
-boot memory region per NUMA node plus a boot memory region to satisfy
-allocations requests that do not require particular NUMA node assignment. By
-default, size of the boot memory region is calculated based on amount of memory
-allocated during boot. The ``kho_bootmem`` kernel command line option may be
-used to explicitly define size of the boot memory regions. The boot memory
-regions are declared as CMA when page allocator is initialized so that their
-memory can be used during system lifetime. CMA gives us the guarantee that no
-handover pages land in that region, because handover pages must be at a static
-physical memory location and CMA enforces that only movable pages can be located
-inside.
+after kexec these regions will be used by early memory allocations, there are
+several types of such regions to ensure that all boot-time allocations work:
+
+* a low memory region for allocations below ``ARCH_LOW_ADDRESS_LIMIT``
+* a region per NUMA node
+* a global region for allocations that do not require a particular NUMA node
+
+Regions that would be empty are not allocated. For example, there is no low
+memory region when ``ARCH_LOW_ADDRESS_LIMIT`` covers all memory, and there is
+no global region when ``CONFIG_NUMA`` is disabled.
+
+By default, the size of the boot memory regions is calculated based on the
+amount of memory allocated during boot. The ``kho_bootmem`` kernel command line
+option may be used to explicitly define the size of the boot memory regions.
+
+The boot memory regions are declared as CMA when the page allocator is
+initialized so that their memory can be used during system lifetime. CMA gives
+us the guarantee that no handover pages land in that region, because handover
+pages must be at a static physical memory location and CMA enforces that only
+movable pages can be located inside.
 
 After KHO kexec, we ignore the ``kho_bootmem`` kernel command line option and
 instead reuse the exact same region that was originally allocated. This allows

-- 
2.53.0


