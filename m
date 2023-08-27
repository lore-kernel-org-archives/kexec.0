Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A79C83F11
	for <kexec@archiver.kernel.org>; Sun, 27 Aug 2023 10:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ftGnvqrvvF43RnzNbIieEHjdposcfqjOXysHg5zzU8=; b=nhPsYNTe2ES2WE
	mI8U13TLwZRATMuMRKMZ/BpdGeusrC7Z2qQyEdEdUh0d2BGZ7mNHCQwYW9h3mxDKm4tDw8GGE1tAF
	7U+8y9NDsnOd142tR//LVsqzaDuuqPH2TMshAyQuWxKz8H99MsnHQV/0k4iNPS1bQkiWnEDdRxW9q
	AZbN5Q+KHgfK08HVMYpi25MM54GENahpelTl+EVCgw1Qc7JfDNu5Qhn0W4GyLiaqZfFlGpITO13Fl
	R9qmuquQS3u9S6kqOzWeVcT3FJPZIL8h/KYpsZr148aXRZnF8beYq4ZJF1TI/XqJ4N7a+3LlgV4bk
	JhNqlDEPk1FpXlwcUBmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaCke-007omf-2A;
	Sun, 27 Aug 2023 10:12:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaCkI-007oQR-1n
	for kexec@lists.infradead.org;
	Sun, 27 Aug 2023 10:11:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693131109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YK7T85vx8iCEMaXbCChNlA1g9PhGLEkKTHdrd3z3JaA=;
	b=Iegsw7mT+HnCYZCgX03P19G6J2aHCIo4Qh0gpJ0akwZ7d90W8zIdedzmJeUlR340AWuTKv
	tfk+FNbrfLeGVfk65vZqXOdWLMnZ34gFOmh7mpJgiUvyw02nYGrwLzNrBLxW6T0Pc+uksI
	5O5f/jm11oZHsKqC5NrqxUSAAQ14A0I=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-lTvJkyeNO62CNkI-e2tH1g-1; Sun, 27 Aug 2023 06:11:46 -0400
X-MC-Unique: lTvJkyeNO62CNkI-e2tH1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77EB63806630;
	Sun, 27 Aug 2023 10:11:45 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2BA8A2166B25;
	Sun, 27 Aug 2023 10:11:40 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	thunder.leizhen@huawei.com,
	dyoung@redhat.com,
	prudo@redhat.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/8] crash_core: change the prototype of function parse_crashkernel()
Date: Sun, 27 Aug 2023 18:11:21 +0800
Message-ID: <20230827101128.70931-3-bhe@redhat.com>
In-Reply-To: <20230827101128.70931-1-bhe@redhat.com>
References: <20230827101128.70931-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230827_031150_689714_2F679BAF 
X-CRM114-Status: GOOD (  16.31  )
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

Add two parameters 'low_size' and 'high' to function parse_crashkernel(),
later crashkernel=,high|low parsing will be added. Make adjustments in all
call sites of parse_crashkernel() in arch.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/kernel/setup.c              |  3 ++-
 arch/arm64/mm/init.c                 |  2 +-
 arch/ia64/kernel/setup.c             |  2 +-
 arch/loongarch/kernel/setup.c        |  4 +++-
 arch/mips/kernel/setup.c             |  3 ++-
 arch/powerpc/kernel/fadump.c         |  2 +-
 arch/powerpc/kexec/core.c            |  2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c |  2 +-
 arch/riscv/mm/init.c                 |  2 +-
 arch/s390/kernel/setup.c             |  4 ++--
 arch/sh/kernel/machine_kexec.c       |  2 +-
 arch/x86/kernel/setup.c              |  3 ++-
 include/linux/crash_core.h           |  3 ++-
 kernel/crash_core.c                  | 15 ++++++++++++---
 14 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c66b560562b3..e2bb7afd0683 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1010,7 +1010,8 @@ static void __init reserve_crashkernel(void)
 
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base);
+				&crash_size, &crash_base,
+				NULL, NULL);
 	/* invalid value specified or crashkernel=0 */
 	if (ret || !crash_size)
 		return;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d31c3a9290c5..36967b82c150 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -115,7 +115,7 @@ static void __init reserve_crashkernel(void)
 
 	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
+				&crash_size, &crash_base, NULL, NULL);
 	if (ret == -ENOENT) {
 		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
 		if (ret || !crash_size)
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 5a55ac82c13a..4faea2d2cf07 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -277,7 +277,7 @@ static void __init setup_crashkernel(unsigned long total, int *n)
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, total,
-			&size, &base);
+			&size, &base, NULL, NULL);
 	if (ret == 0 && size > 0) {
 		if (!base) {
 			sort_regions(rsvd_region, *n);
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 9d830ab4e302..776a068d8718 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -267,7 +267,9 @@ static void __init arch_parse_crashkernel(void)
 	unsigned long long crash_base, crash_size;
 
 	total_mem = memblock_phys_mem_size();
-	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
+	ret = parse_crashkernel(boot_command_line, total_mem,
+				&crash_size, &crash_base,
+				NULL, NULL);
 	if (ret < 0 || crash_size <= 0)
 		return;
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index cb871eb784a7..08321c945ac4 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -460,7 +460,8 @@ static void __init mips_parse_crashkernel(void)
 
 	total_mem = memblock_phys_mem_size();
 	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base);
+				&crash_size, &crash_base,
+				NULL, NULL);
 	if (ret != 0 || crash_size <= 0)
 		return;
 
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ea0a073abd96..7dbdeba56e74 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -313,7 +313,7 @@ static __init u64 fadump_calculate_reserve_size(void)
 	 * memory at a predefined offset.
 	 */
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&size, &base);
+				&size, &base, NULL, NULL);
 	if (ret == 0 && size > 0) {
 		unsigned long max_size;
 
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index de64c7962991..9346c960b296 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -109,7 +109,7 @@ void __init reserve_crashkernel(void)
 	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
 	/* use common parsing */
 	ret = parse_crashkernel(boot_command_line, total_mem_sz,
-			&crash_size, &crash_base);
+			&crash_size, &crash_base, NULL, NULL);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 2fb3edafe9ab..b4f2786a7d2b 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -178,7 +178,7 @@ static void __init get_crash_kernel(void *fdt, unsigned long size)
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, size, &crash_size,
-				&crash_base);
+				&crash_base, NULL, NULL);
 	if (ret != 0 || crash_size == 0)
 		return;
 	if (crash_base == 0)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e4c35ac2357f..a9ef0824f905 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1332,7 +1332,7 @@ static void __init reserve_crashkernel(void)
 	}
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
+				&crash_size, &crash_base, NULL, NULL);
 	if (ret || !crash_size)
 		return;
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 00d76448319d..386a36181ceb 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -625,8 +625,8 @@ static void __init reserve_crashkernel(void)
 	phys_addr_t low, high;
 	int rc;
 
-	rc = parse_crashkernel(boot_command_line, ident_map_size, &crash_size,
-			       &crash_base);
+	rc = parse_crashkernel(boot_command_line, ident_map_size,
+			       &crash_size, &crash_base, NULL, NULL);
 
 	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
 	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 223c14f44af7..fa3a7b36190a 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -154,7 +154,7 @@ void __init reserve_crashkernel(void)
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-			&crash_size, &crash_base);
+			&crash_size, &crash_base, NULL, NULL);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index fd975a4a5200..382c66d2cf71 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -558,7 +558,8 @@ static void __init reserve_crashkernel(void)
 	total_mem = memblock_phys_mem_size();
 
 	/* crashkernel=XM */
-	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
+	ret = parse_crashkernel(boot_command_line, total_mem,
+				&crash_size, &crash_base, NULL, NULL);
 	if (ret != 0 || crash_size <= 0) {
 		/* crashkernel=X,high */
 		ret = parse_crashkernel_high(boot_command_line, total_mem,
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..2e76289699ff 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -78,7 +78,8 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 void final_note(Elf_Word *buf);
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
+		unsigned long long *crash_size, unsigned long long *crash_base,
+		unsigned long long *low_size, bool *high);
 int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index f27b4e45d410..f6a5c219e2e1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -280,10 +280,19 @@ static int __init __parse_crashkernel(char *cmdline,
 int __init parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+			     unsigned long long *crash_base,
+			     unsigned long long *low_size,
+			     bool *high)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				NULL);
+	int ret;
+
+	/* crashkernel=X[@offset] */
+	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
+				crash_base, NULL);
+	if (!high)
+		return ret;
+
+	return 0;
 }
 
 int __init parse_crashkernel_high(char *cmdline,
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
