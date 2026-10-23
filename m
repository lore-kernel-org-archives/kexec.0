Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1260A2608
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qmLx9Qte;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD1tIf3n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Cc:To:In-Reply-To:References:Message-Id:
	Content-Type:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TqWBuX3GkWGP/2S829O6/bcQM7hYnQwzva7iXxB47Xs=; b=qmLx9QteIIorLqMUtBBGgc9bn/
	SOrBPvJDuCASQ464lxijCzoR6GCIAYSTusZdIma3+90xLTjio+vgvfHQNRoY3bcakqY7fq0KHueOO
	qOK9vW+EInRy7+FlgOJBNV4vVw4E22sj8z/ShDLqxTMs55YtAe4V1KiTn0vY98cyEZzqSUUlTf2e5
	LjPH4DycEjIeVNfbh25YJw7rTyKT2MTtUhvwJ2zvlQM4PkvXYZIx/2rIzugsBHfirqxoqE6c/GNRV
	V3OlwYDgId42YGdn7bpVHMmw1v8s+I+berjipf+EQ3O8TGcmuVhpjsXTUEz4kzHLeAqSQkiZfYhae
	PQ/17Sig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9mF-0000000Fl84-2DoW;
	Fri, 23 Oct 2026 07:33:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9mD-0000000Fl4k-14NT;
	Fri, 23 Oct 2026 07:33:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ECE8D60A8D;
	Fri, 23 Oct 2026 07:33:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792740799;
	b=vImvJqo7sE0pBNam6V4RBQtlY7euOBza7q42KvHnAK17Qa+zYdoO6gTpZIE/6Mbl3NTD
	 IUSom/6qZ9NSkCmg69Lz9YJrLu90IXn5nNe7VB1fYZajCaahFDHw/82RrgmIIFi1MTmFo
	 CpxPBUGorLP6tm0X2ReXUtynJTktaMlMSzsqi6I0mFd/7ZqpTj0dXeTzvHJvhi/5fWsuw
	 NaOo0038lyvb8SRj2Z2M0vctAbiXnAxvHNF+atk3uPUdTh4YBI0nkCcudH9Kz94LvjJ2n
	 Kz36crH+OFE4YU2EEthNF8RppOVruu1uzsq/enva0zSqqI0eYb+/0zqwcoQPUG7cKug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792740799;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TqWBuX3GkWGP/2S829O6/bcQM7hYnQwzva7iXxB47Xs=;
	b=tRisIIKt2mYPuC58ew5CNw/04YNc5Z5zHomkaqb0HG5Mb8b8pYs861olefXkM0y0vCt9
	 GIYl7e0UrS0UuNsjT+ko7yo5nBnDeos6kmsPsLhNOGeABPzrh4aCcZqZBae/XPPyTlLQH
	 RUYdgGcO98bY5ZDZpq3T1B1+esBJ1LG9hsROHi6q8D0xsO9J5vxYgNR2uaueyDDKguB4d
	 rd+VGKOevj1Fiz/8BPnLn/us5QER+41GdwR5ZI2gfl34mdc8N9rYP9vFyI+qiZ3rz4IUT
	 Qyc2w6eyHhTIJ1bT+eJ1rq5z8IyP7hUnCItfq33lAOmCLXtLu+I73iDUomMeEWttfNg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 227361F031EB;
	Fri, 23 Oct 2026 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740799;
	bh=TqWBuX3GkWGP/2S829O6/bcQM7hYnQwzva7iXxB47Xs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KD1tIf3nDrP5rUHMNETwuKhDOPuLszJUP9brTrKVF/IehAakdyfwqtbBfVbyi89H/
	 24b61IMFdQ54mFXHJ8rHccvYgAFGJQ4IXuzL/rIAIn1Cxh7AtldorFi3R0O/66UAIP
	 Ijxtw0m5cU7oYJNPUtSrb6QYvjpVvFEPUSuN/tsiD3uZVpUpr4r5jsC/7lFyNzTADA
	 BpToTJWsocHWDaQgRG4MDzJST36yuXUsxBhjz/NPEGjIXMNSuqzjCyLt0e1NnV1f1G
	 zycRjxtCVSW3lbyJgUjn7GcNXwPo6n3gABMBAHCDNTvrRQTDB+AVKWPTm3ANU3BwJA
	 WdvyR9v8E4BPw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6D821443F6;
	Fri, 23 Oct 2026 07:33:17 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Fri, 23 Oct 2026 15:33:18 +0800
Subject: [PATCH 5/5] riscv: mm: Reserve the DTB before scanning reserved
 memory
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-riscv-kexec-cma-fixes-v1-5-825b90ea23c4@iscas.ac.cn>
References: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
In-Reply-To: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Yao Zi <me@ziyao.cc>
Cc: Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kexec@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792740795; l=1985;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=VzDY7dyAHKNfLvxVCMqMtt5zDiHGvSFYWd6M9xkmP3Q=;
 b=ynBWGFpdbYvy9nnbxS+RD2v0R24FuhHdVx/pA9FCO5SLszbXll6aF7o0YMqpG/cUfpt7vCaG6
 M/xMlmo/qUhDMflVxgs92GtOIBWgIfrlbCgqOjkxvuaz/kOdqlNapwe
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Content-Transfer-Encoding: 7bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: gaohan@iscas.ac.cn
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Han Gao <gaohan@iscas.ac.cn>

setup_bootmem() reserves the DTB only after
early_init_fdt_scan_reserved_mem() has allocated the dynamically placed
reserved-memory regions. A CMA pool described with size and alloc-ranges
can therefore be placed over the DTB, which is later handed to the page
allocator and overwritten.

This happens after kexec_file has put the DTB of the next kernel in CMA:
the next kernel reuses that range for its own pool, and a further
kexec_file_load() fails with -FDT_ERR_BADMAGIC.

Reserve the DTB first.

Fixes: ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap region")
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/mm/init.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fb37b0b67efe..1ca908bcc4c0 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -290,21 +290,23 @@ static void __init setup_bootmem(void)
 
 	reserve_initrd_mem();
 
-	/*
-	 * No allocation should be done before reserving the memory as defined
-	 * in the device tree, otherwise the allocation could end up in a
-	 * reserved region.
-	 */
-	early_init_fdt_scan_reserved_mem();
-
 	/*
 	 * If DTB is built in, no need to reserve its memblock.
 	 * Otherwise, do reserve it but avoid using
 	 * early_init_fdt_reserve_self() since __pa() does
-	 * not work for DTB pointers that are fixmap addresses
+	 * not work for DTB pointers that are fixmap addresses.
+	 * Reserve it before dynamically placed reserved-memory
+	 * regions, such as a CMA pool, are allocated.
 	 */
 	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
 		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
+
+	/*
+	 * No allocation should be done before reserving the memory as defined
+	 * in the device tree, otherwise the allocation could end up in a
+	 * reserved region.
+	 */
+	early_init_fdt_scan_reserved_mem();
 }
 
 #ifdef CONFIG_RELOCATABLE

-- 
2.55.0



