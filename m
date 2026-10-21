Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A50606A31D
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aHRGnbBI;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2wPFaw0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=093JJqrrOxUj2abNMLhbp+4Uc4OaHt2/cWwMxdwN2F8=; b=aHRGnbBIsLBJnd
	8+4zQdhmT7C2tYj3tmuQ41lbnIkd7O1N3yE5wnmvIFgQ2UrpCctYj/ze+N3M8zLkLEzGlSxaTJwAA
	isuQAgzP5/QhTdGPSBY6xnThZ8kLt6V7oMjg6g+4i4kPJ3FF9eF71OrJB23bWLZT9xVs5yrRuBQWh
	EM7zJ9VzyfZd7u0nDtGoTTW2ODxUPxXkkjDU3qKLCnB4EB1diz9/a+3AD7R0I4qsQHMlYpu8WoZ/c
	OwLHdxfppK3RGO0exAEiznqui8uMUrTekYahVgCaLHhsclprscLzuG+B1IvNzrKGvp+0Dkd1R7L6P
	85F0p7ceSDP9tQmPZ/gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdab-0000000Cu5V-2s6t;
	Wed, 21 Oct 2026 21:11:13 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdaY-0000000Cu4P-3KAK
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 21:11:11 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so9886935e9.0
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792617069; x=1793221869; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=093JJqrrOxUj2abNMLhbp+4Uc4OaHt2/cWwMxdwN2F8=;
        b=X2wPFaw0TK5v1QchrOBys69DHo+NW9SVgqoWXT42YolhAFvqkGCY4dc4D3x/vw5o6B
         MzOTvTYnZ02ofoRBI9dZePHjT+N0hVY+qzHChUEzjz1nHqwsg+ED6OjzsFMe0A/qI3nR
         5fF6e4Fcs5+An7Yxt2IImuiZljBHiA1+BKre/DUPSnxgp0hrhBRNmnr5mntXCUV5rXgG
         jLG2vuij/NwyXZxOrIWTXvWjCiL1EgGkePciqGjjgwVRveJ8o9DYkzwo8lhCNSod9WNR
         lHC5WoTlo66hNv8iMi5vGYO86fUAo71QDlEDm2/F26nzuymAXpJrxMIw7CJ27ZaBmC0F
         KHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617069; x=1793221869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=093JJqrrOxUj2abNMLhbp+4Uc4OaHt2/cWwMxdwN2F8=;
        b=Rr2RQzSgCerlXzR0X3T8uRjGvIGhn9uYor2bYaKyHD+TT3k7qhVOE9x5ZmwdLSL9wf
         lljX5VS9h+LYr33QlsLIpBtvQVYKbcmgXxJiWvJUOkl62LcEKUfw3U5qRA7MFGdNE2KN
         Klmqwj4yDGAdzVAzO9FN22Zjjm8lqhOVSZfK92e81TV95COQpxuSldKGhkvLuo1fybtO
         eg/l3hyEl2S9eQp7juu+6/raef3RDShZRk/vBGmwmRBK1zSWM/+jo0LPanD68plbeF3T
         0uI1mE5ZuNLBc7oIgFgcre/aooGyByXVpRUFa8By4NDWhpckQXHSDCrhEmdNwUWnKA97
         Rr8w==
X-Forwarded-Encrypted: i=1; AKwUvBzcMScIz5iX0a2SrPXWZgp+QvqTgPyNmF8nt29pskZoka4FUfQNBv3znvINgsW6FfXw3gGOwg==@lists.infradead.org
X-Gm-Message-State: AFq9FYKi0Zw/5su0CSjgxupuf+i/AUuPXXFZ3Px1JmMj4qvrbEOja12c
	657kjMnV0tBgx/96e3G0wrcICX/JCgmjjzaJNMYMhiX4HZl4R97VoCMv
X-Gm-Gg: AYBFou12xI/EZjocYQLMkcHgYmBfWOA+/jUKGr1CfGrdWlW3DRIyFPlJiKLqxRYj3zz
	LadItU67ADp9whgB1lWvnjQabXp+0PDX1MhXv/YU3nKNohTiPKgcl4Bm9kAkXkK/q68qSa6mkub
	tZZGEdJ74/7qo5RmgrmYjBW8xhh2MTNNm3GBL3+cxgi/snh9dCYLmNrOtaDzXnC9iPO4oa5tamE
	z3zrAimnnowOftQ/ia7xlhMsIJFPT3nIVgqZi/QUEzkwpxqS0D06Tr3eqryP7lLvr3Alq2LC91x
	CP17Vg+bVzbkoB8s1cbH29K5/n08FTe4dYRz0OPnuZVERnaKtfDD4VEguNaQ9OKT60ochKb9U0S
	ZO/7Pl4EbYqzr/qJmEtfW9cVjeTTIupGXzJzGFh5KnXZNsYY3DKr6SDuzwPhcoMn41HmIfTJ6Xz
	6Kkp6kFN+60t3EnE7T1sHQVavGBF5A/hJNmieQ5ljUkKIRSQDMDClAAtGfYSvE7dc3PgZwrSthW
	cK9bEAcq4fM9jOMmWA8ZYWphQD9P+H5DYYb9mQo
X-Received: by 2002:a05:600c:46c3:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4a1fd8cd9f5mr69945755e9.2.1792617068708;
        Wed, 21 Oct 2026 14:11:08 -0700 (PDT)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a25fb5sm22891525e9.6.2026.10.21.14.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:11:08 -0700 (PDT)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>
Subject: [RFC PATCH 1/2] memblock: factor out the KHO bootmem check from memblock_alloc_hugetlb()
Date: Wed, 21 Oct 2026 23:10:45 +0200
Message-ID: <20261021211058.83483-2-azpijr@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021211058.83483-1-azpijr@gmail.com>
References: <20261021211058.83483-1-azpijr@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_141110_869077_FEDEDAD6 
X-CRM114-Status: GOOD (  16.78  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

reserve_mem regions are preserved with KHO too, and need the same search
that keeps HugeTLB pages out of KHO bootmem. Move it into a helper.

No functional change intended.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 mm/memblock.c | 70 ++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index a450092a80fb..f43659688681 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1744,6 +1744,31 @@ void * __init memblock_alloc_try_nid_raw(
 	return memblock_alloc_internal(size, align, min_addr, max_addr, nid);
 }
 
+/*
+ * Memory that can be preserved with KHO can't be in KHO bootmem, since the
+ * next kernel boots out of it. Bootmem areas are normally not very large, so
+ * this shouldn't take too many retries.
+ */
+static phys_addr_t __init memblock_find_outside_kho_bootmem(phys_addr_t size,
+					phys_addr_t align, int nid,
+					enum memblock_flags flags)
+{
+	phys_addr_t addr, start = 0, end = MEMBLOCK_ALLOC_ACCESSIBLE;
+
+	while ((addr = memblock_find_in_range_node(size, align, start, end,
+						   nid, flags))) {
+		if (!kho_bootmem_overlap(addr, size))
+			break;
+
+		if (memblock_bottom_up())
+			start = addr + size;
+		else
+			end = addr;
+	}
+
+	return addr;
+}
+
 /**
  * memblock_alloc_hugetlb - allocate boot memory for HugeTLB pages
  * @size:      size of the memory to be allocated in bytes
@@ -1761,52 +1786,29 @@ void * __init memblock_alloc_try_nid_raw(
 void * __init memblock_alloc_hugetlb(phys_addr_t size, int nid, bool exact_nid)
 {
 	enum memblock_flags flags = choose_memblock_flags();
-	phys_addr_t addr, start = 0, end = MEMBLOCK_ALLOC_ACCESSIBLE;
+	phys_addr_t addr;
 
 	memblock_dbg("%s: %llu bytes, nid=%d, exact_nid=%d %pS\n", __func__,
 		     (u64)size, nid, exact_nid, (void *)_RET_IP_);
 
 	/* Don't waste mirrored memory on HugeTLB pages. */
 	flags &= ~MEMBLOCK_MIRROR;
-retry:
-	/* HugeTLB pages are always aligned by their size. */
-	addr = memblock_find_in_range_node(size, size, start, end, nid, flags);
-	if (addr)
-		goto found;
+
+	/*
+	 * HugeTLB pages are always aligned by their size, and can be preserved
+	 * with KHO.
+	 */
+	addr = memblock_find_outside_kho_bootmem(size, size, nid, flags);
 
 	/* Try all nodes if allowed. */
-	if (numa_valid_node(nid) && !exact_nid) {
+	if (!addr && numa_valid_node(nid) && !exact_nid) {
 		nid = NUMA_NO_NODE;
-		/*
-		 * If a previous candidate overlapped with KHO bootmem, it would
-		 * update start or end. Now that the search is opening to all
-		 * nodes, reset them.
-		 */
-		start = 0;
-		end = MEMBLOCK_ALLOC_ACCESSIBLE;
-
-		goto retry;
+		addr = memblock_find_outside_kho_bootmem(size, size, nid, flags);
 	}
 
 	/* Found nothing... :-( */
-	return NULL;
-
-found:
-	/*
-	 * HugeTLB pages can be preserved with KHO and no preserved memory can
-	 * be in bootmem. So retry if found address overlaps with bootmem.
-	 *
-	 * Bootmem areas are normally not very large, so this shouldn't take too
-	 * many retries.
-	 */
-	if (kho_bootmem_overlap(addr, size)) {
-		if (memblock_bottom_up())
-			start = addr + size;
-		else
-			end = addr;
-
-		goto retry;
-	}
+	if (!addr)
+		return NULL;
 
 	if (__memblock_reserve(addr, size, nid, MEMBLOCK_RSRV_KERN | MEMBLOCK_RSRV_HUGETLB))
 		return NULL;
-- 
2.55.0


