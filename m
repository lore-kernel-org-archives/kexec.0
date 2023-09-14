Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8798CA0ECE
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 03:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BM1ZFVQZJFMeFJiu3uTBekAH1NkW9Ic+bhYkcmS9n/U=; b=q9h49NPnywEgM6
	I0hAOSQB07Zp5s4sepjhugXKjSmCEEXF3/Hkot533JXzu4WLiOFA/K6/vM1X11/TO8IEZZF7rELfh
	R0N57PWw4RCxMj02DlLXZDaS2IiMm4EpJQWmPxe0Nz2Qmq38klWtMGhslsbY5e5G8sjZUKzl0uYyI
	zWWjjwWvrs/JskS2FAx8jgY12W2wXOY94fdmUGiFX5terpihQCDigyN2UPnocSsqcgXe5MnVV5p1X
	gvKzV/U88dtOTDb9sUkR8WMEBqn8+0XscYOxbIxcqGIL8AMcRiSq4hzn3GEbM98jFP/WiiNYIqrYq
	cc4dfJdjbbUkhsi/Pcew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd5Y-007Fnx-05;
	Thu, 14 Sep 2023 03:32:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd5R-007Fgv-0G
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 03:32:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694662332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c37WYjsZ/25+JQq+3PPCgPysxJgJiK+If7YGjQWl54Y=;
	b=Luu6rhnK8TOrbyleoJ/G5hJd/iO4Jj9Baqgu3mYCh6utGyFXn+vhDFklDGcW95IgY2n1F9
	wKQ1Gb4DL6H6vg7MX959D1+mVJOzcQCd6VRhTS2T667AdvKAOEVMa18/vHzm8FNmZGM5f7
	GHCpQw6QhZV0+Es1hiFoA4Eg2gRxknM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-vN3z3-IlMkSes_HJAuDZYw-1; Wed, 13 Sep 2023 23:32:08 -0400
X-MC-Unique: vN3z3-IlMkSes_HJAuDZYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F24B8011AD;
	Thu, 14 Sep 2023 03:32:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2A44910085C0;
	Thu, 14 Sep 2023 03:32:03 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	thunder.leizhen@huawei.com,
	catalin.marinas@arm.com,
	chenjiahao16@huawei.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 4/9] crash_core: add generic function to do reservation
Date: Thu, 14 Sep 2023 11:31:37 +0800
Message-ID: <20230914033142.676708-5-bhe@redhat.com>
In-Reply-To: <20230914033142.676708-1-bhe@redhat.com>
References: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_203213_200994_71FC768A 
X-CRM114-Status: GOOD (  21.19  )
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

In architecture like x86_64, arm64 and riscv, they have vast virtual
address space and usually have huge physical memory RAM. Their
crashkernel reservation doesn't have to be limited under 4G RAM,
but can be extended to the whole physical memory via crashkernel=,high
support.

Now add function reserve_crashkernel_generic() to reserve crashkernel
memory if users specify any case of kernel pamameters, like
crashkernel=xM[@offset] or crashkernel=,high|low.

This is preparation to simplify code of crashkernel=,high support
in architecutures.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |  28 ++++++++++
 kernel/crash_core.c        | 107 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index d8050a7eab01..4dbd6565e0ff 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -93,6 +93,34 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
+#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
+#endif
+#ifndef CRASH_ALIGN
+#define CRASH_ALIGN			SZ_2M
+#endif
+#ifndef CRASH_ADDR_LOW_MAX
+#define CRASH_ADDR_LOW_MAX		SZ_4G
+#endif
+#ifndef CRASH_ADDR_HIGH_MAX
+#define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
+#endif
+
+void __init reserve_crashkernel_generic(char *cmdline,
+		unsigned long long crash_size,
+		unsigned long long crash_base,
+		unsigned long long crash_low_size,
+		bool high);
+#else
+static inline void __init reserve_crashkernel_generic(char *cmdline,
+		unsigned long long crash_size,
+		unsigned long long crash_base,
+		unsigned long long crash_low_size,
+		bool high)
+{}
+#endif
+
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index dce2f5874fea..ca66b5f41dc7 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/buildid.h>
-#include <linux/crash_core.h>
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
@@ -13,6 +12,9 @@
 #include <linux/kexec.h>
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
+#include <linux/memblock.h>
+#include <linux/kexec.h>
+#include <linux/kmemleak.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -360,6 +362,109 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+static int __init reserve_crashkernel_low(unsigned long long low_size)
+{
+#ifdef CONFIG_64BIT
+	unsigned long long low_base;
+
+	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
+	if (!low_base) {
+		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
+		return -ENOMEM;
+	}
+
+	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
+		low_base, low_base + low_size, low_size >> 20);
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end   = low_base + low_size - 1;
+	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
+	return 0;
+}
+
+void __init reserve_crashkernel_generic(char *cmdline,
+			     unsigned long long crash_size,
+			     unsigned long long crash_base,
+			     unsigned long long crash_low_size,
+			     bool high)
+{
+	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
+	bool fixed_base = false;
+
+	/* User specifies base address explicitly. */
+	if (crash_base) {
+		fixed_base = true;
+		search_base = crash_base;
+		search_end = crash_base + crash_size;
+	} else if (high) {
+		search_base = CRASH_ADDR_LOW_MAX;
+		search_end = CRASH_ADDR_HIGH_MAX;
+	}
+
+retry:
+	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
+					       search_base, search_end);
+	if (!crash_base) {
+		/*
+		 * For crashkernel=size[KMG]@offset[KMG], print out failure
+		 * message if can't reserve the specified region.
+		 */
+		if (fixed_base) {
+			pr_warn("crashkernel reservation failed - memory is in use.\n");
+			return;
+		}
+
+		/*
+		 * For crashkernel=size[KMG], if the first attempt was for
+		 * low memory, fall back to high memory, the minimum required
+		 * low memory will be reserved later.
+		 */
+		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
+			search_end = CRASH_ADDR_HIGH_MAX;
+			search_base = CRASH_ADDR_LOW_MAX;
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+			goto retry;
+		}
+
+		/*
+		 * For crashkernel=size[KMG],high, if the first attempt was
+		 * for high memory, fall back to low memory.
+		 */
+		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
+			search_end = CRASH_ADDR_LOW_MAX;
+			search_base = 0;
+			goto retry;
+		}
+		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
+			crash_size);
+		return;
+	}
+
+	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
+	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
+		memblock_phys_free(crash_base, crash_size);
+		return;
+	}
+
+	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		crash_base, crash_base + crash_size, crash_size >> 20);
+
+	/*
+	 * The crashkernel memory will be removed from the kernel linear
+	 * map. Inform kmemleak so that it won't try to access it.
+	 */
+	kmemleak_ignore_phys(crash_base);
+	if (crashk_low_res.end)
+		kmemleak_ignore_phys(crashk_low_res.start);
+
+	crashk_res.start = crash_base;
+	crashk_res.end = crash_base + crash_size - 1;
+	insert_resource(&iomem_resource, &crashk_res);
+}
+#endif
+
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
 {
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
