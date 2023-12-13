Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984E6C4167D
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 00:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Moiy0tqHZsf2SUAT/ZH9bnU591pQ+rR3roDMBCt13+4=; b=tKU+xUt2vZ9w7i
	uJ8Ul/dH+dPFvGRobKTTcR8PcLul+OPuh6iPQDqk7Ko8ahuvs89rJSejJkx56t/R/1ByVu1iZ5MHn
	PKleK4aoFbyqtaq8bpY9upTjYnbpcKaNO9DXuiTKakE5isCWRIeDXHx/RQSKXW4BArBYBcwrP+fLx
	QzqbW34Z1G0u+AEKnWfBpwpKA6Q1mBjimWoPjFdWS3NIEmd+ci6aARIraehnjTEGAx/FxiCyVvMth
	2RudQyfFlCMBayQ0fglM8vj7ZW+XQxoywECkvi10yqyWAd2W5WxNxsCAASM+JZVDEEAahhjHgfSHl
	kX8tf06dtKxK3XJ1EkXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDClb-00D7Xb-2m;
	Wed, 13 Dec 2023 00:06:23 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDClZ-00D7VH-0W;
	Wed, 13 Dec 2023 00:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702425982; x=1733961982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2/g7t8dqwJHCv4j3q+tOmI1oayO/LeEOR2vQQ38tfk8=;
  b=KYMkbudlQsuPO2/UgFg2jdL9MI2x2HwcLSNy3UPgGDzVqjoP6lSULV7V
   s40e5Ywwslb7bSkDLE5JZ8nk2thVH4coBj22kWvINXvbaZICFhjfBmapd
   5+ch+d83y80NMwErI8Vl5oCTSUUKWEpk0Of8jlhEUYFVR2GDfSzXvgWUr
   I=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="373412697"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:06:19 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id CCC6E49815;
	Wed, 13 Dec 2023 00:06:05 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:23290]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 5b333ece-94a3-4a4f-9c0a-106bd493cbae; Wed, 13 Dec 2023 00:06:04 +0000 (UTC)
X-Farcaster-Flow-ID: 5b333ece-94a3-4a4f-9c0a-106bd493cbae
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:04 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:00 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH 06/15] arm64: Add KHO support
Date: Wed, 13 Dec 2023 00:04:43 +0000
Message-ID: <20231213000452.88295-7-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_160621_357462_7D997B97 
X-CRM114-Status: GOOD (  22.94  )
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

We now have all bits in place to support KHO kexecs. This patch adds
awareness of KHO in the kexec file as well as boot path for arm64 and
adds the respective kconfig option to the architecture so that it can
use KHO successfully.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 arch/arm64/Kconfig        | 12 ++++++++++++
 arch/arm64/kernel/setup.c |  2 ++
 arch/arm64/mm/init.c      |  8 ++++++++
 drivers/of/fdt.c          | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/of/kexec.c        | 36 ++++++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..1ba338ce7598 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1501,6 +1501,18 @@ config ARCH_SUPPORTS_CRASH_DUMP
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_CORE
 
+config KEXEC_KHO
+	bool "kexec handover"
+	depends on KEXEC
+	select MEMBLOCK_SCRATCH
+	select LIBFDT
+	select CMA
+	help
+	  Allow kexec to hand over state across kernels by generating and
+	  passing additional metadata to the target kernel. This is useful
+	  to keep data or state alive across the kexec. For this to work,
+	  both source and target kernels need to have this option enabled.
+
 config TRANS_TABLE
 	def_bool y
 	depends on HIBERNATION || KEXEC_CORE
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..8035b673d96d 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -346,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 
 	paging_init();
 
+	kho_reserve_mem();
+
 	acpi_table_upgrade();
 
 	/* Parse the ACPI tables for possible boot-time configuration */
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 74c1db8ce271..254d82f3383a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -358,6 +358,8 @@ void __init bootmem_init(void)
 	 */
 	arch_reserve_crashkernel();
 
+	kho_reserve();
+
 	memblock_dump_all();
 }
 
@@ -386,6 +388,12 @@ void __init mem_init(void)
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();
 
+	/*
+	 * Now that all KHO pages are marked as reserved, let's flip them back
+	 * to normal pages with accurate refcount.
+	 */
+	kho_populate_refcount();
+
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
 	 * detected at build time already.
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..af95139351ed 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1006,6 +1006,44 @@ void __init early_init_dt_check_for_usable_mem_range(void)
 		memblock_add(rgn[i].base, rgn[i].size);
 }
 
+/**
+ * early_init_dt_check_kho - Decode info required for kexec handover from DT
+ */
+void __init early_init_dt_check_kho(void)
+{
+#ifdef CONFIG_KEXEC_KHO
+	unsigned long node = chosen_node_offset;
+	u64 kho_start, scratch_start, scratch_size, mem_start, mem_size;
+	const __be32 *p;
+	int l;
+
+	if ((long)node < 0)
+		return;
+
+	p = of_get_flat_dt_prop(node, "linux,kho-dt", &l);
+	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+		return;
+
+	kho_start = dt_mem_next_cell(dt_root_addr_cells, &p);
+
+	p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
+	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+		return;
+
+	scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
+	scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
+
+	p = of_get_flat_dt_prop(node, "linux,kho-mem", &l);
+	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+		return;
+
+	mem_start = dt_mem_next_cell(dt_root_addr_cells, &p);
+	mem_size = dt_mem_next_cell(dt_root_addr_cells, &p);
+
+	kho_populate(kho_start, scratch_start, scratch_size, mem_start, mem_size);
+#endif
+}
+
 #ifdef CONFIG_SERIAL_EARLYCON
 
 int __init early_init_dt_scan_chosen_stdout(void)
@@ -1304,6 +1342,9 @@ void __init early_init_dt_scan_nodes(void)
 
 	/* Handle linux,usable-memory-range property */
 	early_init_dt_check_for_usable_mem_range();
+
+	/* Handle kexec handover */
+	early_init_dt_check_kho();
 }
 
 bool __init early_init_dt_scan(void *params)
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 68278340cecf..a612e6bb8c75 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -264,6 +264,37 @@ static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
 }
 #endif /* CONFIG_IMA_KEXEC */
 
+static int kho_add_chosen(const struct kimage *image, void *fdt, int chosen_node)
+{
+	int ret = 0;
+
+#ifdef CONFIG_KEXEC_KHO
+	if (!image->kho.dt.buffer || !image->kho.mem_cache.buffer)
+		goto out;
+
+	pr_debug("Adding kho metadata to DT");
+
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-dt",
+				       image->kho.dt.mem, image->kho.dt.memsz);
+	if (ret)
+		goto out;
+
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-scratch",
+				       kho_scratch_phys, kho_scratch_len);
+	if (ret)
+		goto out;
+
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-mem",
+				       image->kho.mem_cache.mem,
+				       image->kho.mem_cache.bufsz);
+	if (ret)
+		goto out;
+
+out:
+#endif
+	return ret;
+}
+
 /*
  * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
  *
@@ -412,6 +443,11 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		}
 	}
 
+	/* Add kho metadata if this is a KHO image */
+	ret = kho_add_chosen(image, fdt, chosen_node);
+	if (ret)
+		goto out;
+
 	/* add bootargs */
 	if (cmdline) {
 		ret = fdt_setprop_string(fdt, chosen_node, "bootargs", cmdline);
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
