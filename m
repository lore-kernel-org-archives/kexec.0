Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E903C433EF
	for <kexec@archiver.kernel.org>; Wed, 15 Jun 2022 05:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=V1Q4fjs23r7dNPc/53vIzCcAJ+30O+hVMssAqd0nBjA=; b=Oiw
	nIhTB2XWhazZ5k9Ycc/Rz8SS9okBOpdyzOACMqZENdi3lTVsQmFTFs60Ck2tTksxZBkO/lXFicjbO
	VZ0lMOgRoQJLEGOEr7jcDTdROXNXqldJ9Dk/ftl+jpD9YFsyWuJp0ZkPmJwvQ5Ssw5YE5FKtv7kpA
	lbIeA8/9j4Ov2zHFwDvqXP16pUmnE2Q3IiSBMtpPSLMIwZUDMBsgvQ/45VygJskuS+q7Pz7z6ZUlt
	M0hOp9dLrfJAaMtrJxsKtN1QK/bI+idzdZwLi26ty2OXUfH6AI+Xh3Nm9g/W3app2ROBxVlrKm29j
	qpuQb7dJxivB9LkJXzVPnabCbb+H5Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1LCn-00CbXZ-Fb; Wed, 15 Jun 2022 05:04:37 +0000
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1LCh-00CbVl-B9
	for kexec@lists.infradead.org; Wed, 15 Jun 2022 05:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1655269456; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GStgrThw5Q1PYhP2rqVOLN+xNONSuVpVddY5wEoNn17HWe9f2QpXEN4SDyOplftORljOEprEXaqOOv9nnr4IdtGU+l7aKVgm1W7d21TkgTTe9e15hzqGTBF/+VRnYbnLpAtJcF9Wt+uD/FG0emiBzjQhmeprMR7UMyPA9vNL15E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1655269456; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=6AXqsZRZTIdCcWnehBkb22k+2EJQJqXdSCOuqmc+0cA=; 
	b=HPPgmyMSpBa2cPCkImcJLax4TEinX1hjH1SKUomMbcEuHrt7GJqB0G1+oNuSVGqR61GkxyPVI9RjsI5bFKh88EDlXZolHOTTNzez4r9+mPz9pdTYuegcKSqa2/g1LCqHrUmTC077uTNVXfvCPHPcHHPUV8EhorjnaqPqjPbmEKY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1655269456;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=6AXqsZRZTIdCcWnehBkb22k+2EJQJqXdSCOuqmc+0cA=;
	b=EzFGn9ZZDInsOx6IO3038aT/FAhNsF8FNVmRFcFiZuIsEqFtzpZhhMS4rKA/KVNf
	Ab2AHkP/ig76zEKdscfU0ejtP/RPBRDGID4oGaWKX/Z/WUHCgSihZo0xW1jSB5wBfVr
	l3q3b2iWhxa5NnlGzBJVcsxaFqfKrlfVdexHezFw=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1655269454510361.39947610994113; Tue, 14 Jun 2022 22:04:14 -0700 (PDT)
Date: Tue, 14 Jun 2022 22:04:14 -0700
From: Li Chen <me@linux.beauty>
To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
	"Michael Ellerman" <mpe@ellerman.id.au>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Eric Biederman" <ebiederm@xmission.com>,
	"kexec" <kexec@lists.infradead.org>
Message-ID: <18165bf7271.d72aa7571639569.7041635736718062250@linux.beauty>
In-Reply-To: 
Subject: [PATCH] kexec: replace crash_mem_range with range
MIME-Version: 1.0
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_220431_487306_611754E4 
X-CRM114-Status: GOOD (  17.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Li Chen <lchen@ambarella.com>

We already have struct range, so just use it.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 arch/powerpc/kexec/file_load_64.c | 2 +-
 arch/powerpc/kexec/ranges.c       | 8 ++++----
 include/linux/kexec.h             | 7 ++-----
 kernel/kexec_file.c               | 2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index b4981b651d9a..583b7fc478f2 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -34,7 +34,7 @@ struct umem_info {
 
 	/* usable memory ranges to look up */
 	unsigned int nr_ranges;
-	const struct crash_mem_range *ranges;
+	const struct range *ranges;
 };
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 563e9989a5bf..5fc53a5fcfdf 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -33,7 +33,7 @@
 static inline unsigned int get_max_nr_ranges(size_t size)
 {
 	return ((size - sizeof(struct crash_mem)) /
-		sizeof(struct crash_mem_range));
+		sizeof(struct range));
 }
 
 /**
@@ -51,7 +51,7 @@ static inline size_t get_mem_rngs_size(struct crash_mem *mem_rngs)
 		return 0;
 
 	size = (sizeof(struct crash_mem) +
-		(mem_rngs->max_nr_ranges * sizeof(struct crash_mem_range)));
+		(mem_rngs->max_nr_ranges * sizeof(struct range)));
 
 	/*
 	 * Memory is allocated in size multiple of MEM_RANGE_CHUNK_SZ.
@@ -98,7 +98,7 @@ static int __add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
  */
 static void __merge_memory_ranges(struct crash_mem *mem_rngs)
 {
-	struct crash_mem_range *ranges;
+	struct range *ranges;
 	int i, idx;
 
 	if (!mem_rngs)
@@ -123,7 +123,7 @@ static void __merge_memory_ranges(struct crash_mem *mem_rngs)
 /* cmp_func_t callback to sort ranges with sort() */
 static int rngcmp(const void *_x, const void *_y)
 {
-	const struct crash_mem_range *x = _x, *y = _y;
+	const struct range *x = _x, *y = _y;
 
 	if (x->start > y->start)
 		return 1;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 58d1b58a971e..d7ab4ad4c619 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -17,6 +17,7 @@
 
 #include <linux/crash_core.h>
 #include <asm/io.h>
+#include <linux/range.h>
 
 #include <uapi/linux/kexec.h>
 
@@ -214,14 +215,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
-struct crash_mem_range {
-	u64 start, end;
-};
-
 struct crash_mem {
 	unsigned int max_nr_ranges;
 	unsigned int nr_ranges;
-	struct crash_mem_range ranges[];
+	struct range ranges[];
 };
 
 extern int crash_exclude_mem_range(struct crash_mem *mem,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..f2758af86b93 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1183,7 +1183,7 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 {
 	int i, j;
 	unsigned long long start, end, p_start, p_end;
-	struct crash_mem_range temp_range = {0, 0};
+	struct range temp_range = {0, 0};
 
 	for (i = 0; i < mem->nr_ranges; i++) {
 		start = mem->ranges[i].start;
-- 
2.36.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
