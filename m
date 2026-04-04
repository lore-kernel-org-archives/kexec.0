Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF725E88D8B
	for <kexec@archiver.kernel.org>; Sat,  4 Apr 2026 07:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zVuyuZWPEacFSdtZ4/rdPo2ZTR7RDfdP3BpyB0CT/YE=; b=Le6nyjtjbREWFne2Lwq00HhwGf
	wOl/A5SbECrQqbMSaC8Y9QSr95vIvmt9MFs40RCsjJODVdRISnqrGeLvwld6Mm3DfRw2lAtmCulD2
	VbCfxO2owQVuAcxln9f6FTjBvjkHjnPFvKdB7AvufZJRppU4UOs3r1F5LXboKNXTcWwqhtCGij+2f
	+2GA37jtpDfsPTgbBIoG2E0lA+Olo0kc+TZIrKbiABMTahCrKj3jWt36uvUyX93dUYVWvYpaGbcuE
	H4steuBpAYnIh3C2h0SJ/XqJUK+GVoXQJBOZB4qSiGy6OJNmFgK8LyjtqiLsbswBbL9L9gcRfBedE
	CSCIHEOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8veI-00000003Fwv-1Wrr;
	Sat, 04 Apr 2026 07:42:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8veD-00000003Fwo-3HdP
	for kexec@bombadil.infradead.org;
	Sat, 04 Apr 2026 07:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zVuyuZWPEacFSdtZ4/rdPo2ZTR7RDfdP3BpyB0CT/YE=; b=Z8h3qpueo/1/21YYrxtYqtm7BB
	F/9kBb41aiGKPwSqbRbKJZUY/oIwKWNlXIh5o+EdvNW6RlMRxbUHXjsc6hYNi6atVk7riPq28Qs/5
	POaPiTqXWAlpc1POt0rUA15+vtTTuuHbnw57XSQhNcHPd8JcvQgTRhFotqUoxTXkqUEmvd4ekToNj
	IQDkwWD5nfMCtppqSJ6vdaJXnJmz9hKaaeQVfRfezUkUUVp0Sv1OwmvdaHbFjuwh2KA9c9Fq7clm5
	5tTEElb/6cAHcdzPvuDnFLLB0NFpT96WMK116ys/uD2fkWNGWv4MRk/QaecoWMXqC3zMgwr4mjCuV
	YHYjbIcg==;
Received: from out-182.mta1.migadu.com ([95.215.58.182])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8veA-000000056Xs-3YJC
	for kexec@lists.infradead.org;
	Sat, 04 Apr 2026 07:42:24 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775288527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zVuyuZWPEacFSdtZ4/rdPo2ZTR7RDfdP3BpyB0CT/YE=;
	b=dxbtbL1bskq8RWMNIzElKYR1ejUPl3iSCrsVzm9L2lgnTj85qp31lBNZsJ2NWa62PdDW2c
	OSoKGbN0weVgseDjjowry2AM4FnIRMyUe5IqxHPaVVpx/NmszhVr971maYVLuT7UfaFqsL
	JfIgQfBLHXQG2/U5orIsq8tDe+DkqjU=
From: Youling Tang <youling.tang@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] crash: Support high memory reservation for range syntax
Date: Sat,  4 Apr 2026 15:41:03 +0800
Message-ID: <20260404074103.506793-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_084222_955471_BC9DBBDA 
X-CRM114-Status: GOOD (  18.96  )
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

From: Youling Tang <tangyouling@kylinos.cn>

The crashkernel range syntax (range1:size1[,range2:size2,...]) allows
automatic size selection based on system RAM, but it always reserves
from low memory. When a large crashkernel is selected, this can
consume most of the low memory, causing subsequent hardware
hotplug or drivers requiring low memory to fail due to allocation
failures.

Add a new optional conditional suffix ",>boundary" to the crashkernel
range syntax. When the selected crashkernel size exceeds the specified
boundary, the kernel will automatically apply the same reservation
policy as "crashkernel=size,high" - preferring high memory first
and reserving the default low memory area.

Syntax:
    crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset],>boundary

Example:
    crashkernel=2G-16G:512M,16G-:1G,>512M

This means:
  - For 2G-16G RAM: reserve 512M normally
  - For >16G RAM: reserve 1G with high memory preference (since 1G > 512M)

For systems with >16G RAM, 1G is selected which exceeds 512M, so it
will be reserved from high memory instead of consuming 1G of
precious low memory.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 Documentation/admin-guide/kdump/kdump.rst     | 25 ++++++++-
 .../admin-guide/kernel-parameters.txt         |  2 +-
 kernel/crash_reserve.c                        | 56 ++++++++++++++++---
 3 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 7587caadbae1..b5ae4556e9ca 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -293,7 +293,28 @@ crashkernel syntax
        2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
        3) if the RAM size is larger than 2G, then reserve 128M
 
-3) crashkernel=size,high and crashkernel=size,low
+3) range1:size1[,range2:size2,...][@offset],>boundary
+   Optionally, the range list can be followed by a conditional suffix
+   `,>boundary`. When the selected crashkernel size matches the
+   condition, the kernel will reserve memory using the same policy as
+   `crashkernel=size,high` (i.e. prefer high memory first and reserve the
+   default low memory area).
+
+   The syntax is::
+
+        crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset],>boundary
+        range=start-[end]
+
+   For example::
+
+        crashkernel=2G-16G:512M,16G-:1G,>512M
+
+   This would mean:
+       1) if the RAM size is between 2G and 16G (exclusive), then reserve 512M.
+       2) if the RAM size is larger than 16G, allocation will behave like
+          `crashkernel=1G,high`.
+
+4) crashkernel=size,high and crashkernel=size,low
 
    If memory above 4G is preferred, crashkernel=size,high can be used to
    fulfill that. With it, physical memory is allowed to be allocated from top,
@@ -311,7 +332,7 @@ crashkernel syntax
 
             crashkernel=0,low
 
-4) crashkernel=size,cma
+5) crashkernel=size,cma
 
 	Reserve additional crash kernel memory from CMA. This reservation is
 	usable by the first system's userspace memory and kernel movable
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a550630644..b2e1892ab4d8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1087,7 +1087,7 @@ Kernel parameters
 			4G when '@offset' hasn't been specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
 
-	crashkernel=range1:size1[,range2:size2,...][@offset]
+	crashkernel=range1:size1[,range2:size2,...][@offset][,>boundary]
 			[KNL] Same as above, but depends on the memory
 			in the running system. The syntax of range is
 			start-[end] where start and end are both
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 62e60e0223cf..917738412390 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -254,15 +254,47 @@ static __init char *get_last_crashkernel(char *cmdline,
 	return ck_cmdline;
 }
 
+/*
+ * This function parses command lines in the format
+ *
+ *   crashkernel=ramsize-range:size[,...][@offset],>boundary
+ */
+static void __init parse_crashkernel_boundary(char *ck_cmdline,
+					unsigned long long *boundary)
+{
+	char *cur = ck_cmdline, *next;
+	char *first_gt = false;
+
+	first_gt = strchr(cur, '>');
+	if (!first_gt)
+		return;
+
+	cur = first_gt + 1;
+	if (*cur == '\0' || *cur == ' ' || *cur == ',') {
+		pr_warn("crashkernel: '>' specified without boundary size, ignoring\n");
+		return;
+	}
+
+	*boundary = memparse(cur, &next);
+	if (cur == next) {
+		pr_warn("crashkernel: invalid boundary size after '>'\n");
+		return;
+	}
+}
+
 static int __init __parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base,
-			     const char *suffix)
+			     const char *suffix,
+			     bool *high,
+			     unsigned long long *low_size)
 {
 	char *first_colon, *first_space;
 	char *ck_cmdline;
 	char *name = "crashkernel=";
+	unsigned long long boundary = 0;
+	int ret;
 
 	BUG_ON(!crash_size || !crash_base);
 	*crash_size = 0;
@@ -283,10 +315,20 @@ static int __init __parse_crashkernel(char *cmdline,
 	 */
 	first_colon = strchr(ck_cmdline, ':');
 	first_space = strchr(ck_cmdline, ' ');
-	if (first_colon && (!first_space || first_colon < first_space))
-		return parse_crashkernel_mem(ck_cmdline, system_ram,
+	if (first_colon && (!first_space || first_colon < first_space)) {
+		ret = parse_crashkernel_mem(ck_cmdline, system_ram,
 				crash_size, crash_base);
 
+		/* Handle optional ',>boundary' condition for range ':' syntax only. */
+		parse_crashkernel_boundary(ck_cmdline, &boundary);
+		if (!ret && *crash_size > boundary) {
+			*high = true;
+			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+		}
+
+		return ret;
+	}
+
 	return parse_crashkernel_simple(ck_cmdline, crash_size, crash_base);
 }
 
@@ -310,7 +352,7 @@ int __init parse_crashkernel(char *cmdline,
 
 	/* crashkernel=X[@offset] */
 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
-				crash_base, NULL);
+				crash_base, NULL, high, low_size);
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	/*
 	 * If non-NULL 'high' passed in and no normal crashkernel
@@ -318,7 +360,7 @@ int __init parse_crashkernel(char *cmdline,
 	 */
 	if (high && ret == -ENOENT) {
 		ret = __parse_crashkernel(cmdline, 0, crash_size,
-				crash_base, suffix_tbl[SUFFIX_HIGH]);
+				crash_base, suffix_tbl[SUFFIX_HIGH], high, low_size);
 		if (ret || !*crash_size)
 			return -EINVAL;
 
@@ -327,7 +369,7 @@ int __init parse_crashkernel(char *cmdline,
 		 * is not allowed.
 		 */
 		ret = __parse_crashkernel(cmdline, 0, low_size,
-				crash_base, suffix_tbl[SUFFIX_LOW]);
+				crash_base, suffix_tbl[SUFFIX_LOW], high, low_size);
 		if (ret == -ENOENT) {
 			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
 			ret = 0;
@@ -344,7 +386,7 @@ int __init parse_crashkernel(char *cmdline,
 	 */
 	if (cma_size)
 		__parse_crashkernel(cmdline, 0, cma_size,
-			&cma_base, suffix_tbl[SUFFIX_CMA]);
+			&cma_base, suffix_tbl[SUFFIX_CMA], high, low_size);
 #endif
 	if (!*crash_size)
 		ret = -EINVAL;
-- 
2.43.0


