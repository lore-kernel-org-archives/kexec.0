Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BDA606A32F
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qCJYvRwn;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Og4qFrdD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=v4J18lKuKOIC+R1cR1tFexi0oiMBhzyNL127DHXVUEY=; b=qCJYvRwnW3FgwP8wFoQi357iIO
	wW8fEXFlFiCctQCEmQrUGorvY48KXIcHo9aMuS6oqJyVVCHkqQkIYWPoKEQNqDJR9B8uzeel6Bi5w
	LCbEz5lfuPupm4WPNXK8HveI5TyTtQxPsFug3FcF9uhB6giNWpYtjsqz3ZQPBk383rTmPLAA6FJNq
	tdcRPmbtG4bxVNke/EXMIB6sZiRb4MjA1PpiRZggLd/kLp2uTa7dJ2Cw8+yGeSoBE1reOrS4+dZ0B
	VFuW6V+W6nC0vfLehd1Fdo9bE9NDBZ1vc2q+whFyk+AoLcE+SdXLaUZFCtveM0xmzfwwRUFxFrPQi
	JpttPmIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP53z-0000000AkEQ-1bmw;
	Thu, 05 Nov 2026 21:32:03 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP53w-0000000AkD3-0nyl
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 21:32:01 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so113305e9.1
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793914318; x=1794519118; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v4J18lKuKOIC+R1cR1tFexi0oiMBhzyNL127DHXVUEY=;
        b=Og4qFrdDtazSLsTuy30+TTWsdkGDaREW/jhUGVN11xT8zZ/kBqiI6ioDms6UPgAc2w
         af59RwuyveffALwkdwlHctyiACuo0eERbia06l6jUp7mCTZnfUcHGqLeZvMhwBR3A4Vz
         88Q3lGzuN5OUSdjmL1TSQFBTmi7d9DYFRKk2rXinYVsPTY57X3zjlaPwoNTMk1Zl3xJN
         FrlTVYOqRLig57qxI/JRIbj5IrLxCcdiiSLRELhpC5ntWJcVWTDf6MOlDSJt+8GtiSFN
         ra8+v/PRIVsLhIhPPpcZHAqqlAZwohJ35Jype7fS09AHgUr8l5SayXoa4QnQqTlwCcYV
         Bc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914318; x=1794519118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4J18lKuKOIC+R1cR1tFexi0oiMBhzyNL127DHXVUEY=;
        b=c0ZN9KSxGJtMnPfAfzel8f84Mc+oAYrpPkB/e3AQQ3tliN3a1WT2NLo/aPz7aijosn
         35OXpJhxtyVkbn9ebZAMjeIrWZI0KQZM6wTZmfDneQEAT7uQH0eTMHjQFt3dCxdlCa8C
         Y2fiTGts/9OhXTO5inVMHxt8c7sR4pi+y0LE7EtfrUHHBkVdpTnKyVIIbHNSAEat+O75
         8b/q4wzpMZDDLTfOk3FX0OF82FKh6aZ8d5IVOIfSkpc7UtkkZQAMLVZOicxwQz6IOsRP
         jJPtmm3LI+jYezmUINx5hEBmaGj/8Z8qCCHf+9NhAyPgsZzDEGLciN8n8X3FqtE1KxBh
         sYwg==
X-Forwarded-Encrypted: i=1; AKwUvBwz4rd3v8dc6UdW/iZ0jlwK2SCI2OxBwyE+4sVqsEbryVWsa4mAbiLbFryBY6/yEzlqZLkN1A==@lists.infradead.org
X-Gm-Message-State: APuU4Z/mSQIGoUrzQZiksEGYxj78j1HEtsBKdFExX3P6DOHdJ6Ge/Pep
	mLLR0/h173T1S9+HFVrmY/JRZR+nCU9xLSxUFmzT5k+OJpv3OzxdyTVA
X-Gm-Gg: AYBFou27hPJUKyISv/1Sah03Z3Ysv8ajzOVXGLIV0PEXRiJNSBYXQhYMz59sS1T0OqR
	h0o79hT1okHXm0kkdvs3zgVts8Xu1dGKniiZKkkOOrjG6YNbylaVl4FwP7dKvvf7JMM221F1IcF
	1iORosO48GKVhhXowiPduatl6dFgVG8tg0V2+YuH4Y3No6omQQAyUe5zMoh0DCC5PQ7ws1YMaIT
	lLt/bLbXKKGvC1MUDA9Xzas/j/4ZgSJ3h8hTLvnA2CQqwg5rsKU/qOPMy8oZfKxbuOeDE0FoCpZ
	Xa/TE548DaJuCS3307q6TE+h7SDEtEjwARgr9OMIiS5huFXVfyoQtxkGpdlUhACZMKXPuDzvSeC
	/pRdAesPj1GuBedfQk0ii/RmgvUEo/4JMkENBoYP/9QgzrzGxOshY9/bhc5hJrS4u/XTqBnfd81
	KG7f1QnBHv51/b28LbQmqaRLEV6ZuxWHCbImLzFkVYIf8+SYNtg9KDwaeridT2YkZ2jv4WptIIr
	EZeF6R4RuigW+iDAXhAJFkA8bSWkAGi1bYINRS5fhIxp+6wz556ctzryn2k4RPMTt55n+EuxRX7
	tdOqsiael1Lurg==
X-Received: by 2002:a05:600c:46d1:b0:4a1:df52:3e36 with SMTP id 5b1f17b1804b1-4b6dfe8f4dfmr6379295e9.27.1793914317723;
        Thu, 05 Nov 2026 13:31:57 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6e28cce1fsm7654035e9.15.2026.11.05.13.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:31:57 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>
Subject: [PATCH v3] memblock: don't allocate new reserve_mem regions on a KHO boot
Date: Thu,  5 Nov 2026 22:31:49 +0100
Message-ID: <20261105213153.9572-1-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_133200_246159_986722A0 
X-CRM114-Status: GOOD (  15.09  )
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

On a KHO boot, a reserve_mem region that can't be revived is allocated
from KHO_NOPRSRV memory, which includes the bootmem the next kernel
boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG, preserving the region
then fails:

  WARNING: kernel/liveupdate/kexec_handover.c:1245 at kho_preserve_pages+0x168/0x180
  failed to prepare memblock FDT for KHO: -22

Without it, the next kernel puts its memmap on top of the region and
the ramoops records in it are lost.

There is no use case for adding regions across a live update, so fail
instead of allocating, and drop the TODO.

Add an is_kho_boot() stub so the memblock tests still build.

Fixes: f99230780211 ("memblock: add KHO support for reserve_mem")
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v3:
- add an is_kho_boot() stub to the memblock tests (Mike).
- add Pasha's Reviewed-by.

Changes in v2:
- fail on a KHO boot instead of allocating outside bootmem, as agreed
  with Pratyush [1]. this drops v1's patch 1.
- not an RFC anymore.
- based on v7.4-rc1.

v2: https://lore.kernel.org/all/20261104204235.9066-1-azpijr@gmail.com/
v1: https://lore.kernel.org/all/20261021211058.83483-3-azpijr@gmail.com/

[1] https://lore.kernel.org/all/2vxzfqxglrg6.fsf@kernel.org/

 mm/memblock.c                     | 11 ++++++++++-
 tools/testing/memblock/internal.h |  5 +++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index a450092a80fb..e325e0542c9a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2827,7 +2827,16 @@ static int __init reserve_mem(char *p)
 	if (reserve_mem_kho_revive(name, size, align))
 		return 1;
 
-	/* TODO: Allocation must be outside of KHO_NOPRSRV region */
+	/*
+	 * On a KHO boot memblock only allocates from KHO_NOPRSRV memory here,
+	 * which includes the bootmem the next kernel boots out of. Only regions
+	 * handed over by the previous kernel are supported.
+	 */
+	if (is_kho_boot()) {
+		pr_err("reserve_mem: can't allocate \"%s\" on a KHO boot\n", name);
+		return -EOPNOTSUPP;
+	}
+
 	start = memblock_phys_alloc(size, align);
 	if (!start) {
 		pr_err("reserve_mem: memblock allocation failed\n");
diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index ba4d1c02fde5..84f22a964510 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -51,4 +51,9 @@ static inline bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
 	return false;
 }
 
+static inline bool is_kho_boot(void)
+{
+	return false;
+}
+
 #endif

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0


