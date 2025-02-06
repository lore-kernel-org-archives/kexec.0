Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5DAC02194
	for <kexec@archiver.kernel.org>; Thu,  6 Feb 2025 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OqhPo9ta4iBL6YwMdbyL5HGD55Dm8ujj4PSl7i6Hsgs=; b=A7aavwqKHnfg510IzQbti0x/I8
	LIn5HlAAWHINEQjQ21TKscCJl2SWsFnRCkfc6i/urA54Zhk3vRzqvtPMTb99x5CC+rubXuvjaJ12K
	oRKdCoNESz+YZpjWUzAvadokYXNcvPgo9PU/eXnUeF0dzLiebLfuQKcvvtQrNcMX53KYHAtP8S2UO
	Z5GJ++b1sfdyeRMhKSZTGTFuWVJKkhu9GrsjSn8Pi7GSJDch8ym59eikwTxVoVhH4QXfKIMCDRame
	VvLkRRLzjyWnXdcRLMAHlyhtC2roB/U9hOUdGy1OdguBK1UHz9nNMnY9amBwB+WllMRkRUB86QewV
	wS1mumTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tg2ES-00000006TqV-41Y1;
	Thu, 06 Feb 2025 13:47:52 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tg1wt-00000006R0g-2mLb;
	Thu, 06 Feb 2025 13:29:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 90828A43521;
	Thu,  6 Feb 2025 13:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6746C4CEE5;
	Thu,  6 Feb 2025 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738848582;
	bh=YhQ3gt0FcvyhHrH/fq8eDTzHj2J/JGVva+XZhcAjRME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFHeaz2Wf6zAlFKNEJGYupJoP4tb+oKUBXfVqahTutVYbwIRBynlBQHaXayGwkEu2
	 DuphCe8xk2pe+8oH7+XZQSe9pjgWZGsmkIospzcHjxO3RytUcsVovJmfiYKBBORcsL
	 4luOZoe358T6aqKuQn/upUfy7Z5PmlquzBJHTrWLVRYP7hc0VriUcgl4lPKOe4bajV
	 ZVwAy9jBA2xpMFC/I3n9y07yrA5AKtZFTK9AcidCwRDnRl6rYTvWRjSGn6dW1qiFfP
	 OHYDZqXXjaHUsYQmI1svg4fNC3oyX5TyerVpmcK3gD0lOT5H5hMpCAfnQUVx3w8RiF
	 MCVMFhIn9tgsQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v4 10/14] arm64: Add KHO support
Date: Thu,  6 Feb 2025 15:27:50 +0200
Message-ID: <20250206132754.2596694-11-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206132754.2596694-1-rppt@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_052943_824207_3AA5F6A3 
X-CRM114-Status: GOOD (  20.96  )
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

From: Alexander Graf <graf@amazon.com>

We now have all bits in place to support KHO kexecs. This patch adds
awareness of KHO in the kexec file as well as boot path for arm64 and
adds the respective kconfig option to the architecture so that it can
use KHO successfully.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/Kconfig |  3 +++
 drivers/of/fdt.c   | 36 ++++++++++++++++++++++++++++++++++++
 drivers/of/kexec.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed3eca8..5d9f07cea258 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1590,6 +1590,9 @@ config ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
 config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
 	def_bool y
 
+config ARCH_SUPPORTS_KEXEC_HANDOVER
+	def_bool y
+
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index aedd0e2dcd89..3178bf9c6bd2 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -875,6 +875,39 @@ void __init early_init_dt_check_for_usable_mem_range(void)
 		memblock_add(rgn[i].base, rgn[i].size);
 }
 
+/**
+ * early_init_dt_check_kho - Decode info required for kexec handover from DT
+ */
+static void __init early_init_dt_check_kho(void)
+{
+	unsigned long node = chosen_node_offset;
+	u64 kho_start, scratch_start, scratch_size;
+	const __be32 *p;
+	int l;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER) || (long)node < 0)
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
+	kho_populate(kho_start, scratch_start, scratch_size);
+}
+
 #ifdef CONFIG_SERIAL_EARLYCON
 
 int __init early_init_dt_scan_chosen_stdout(void)
@@ -1169,6 +1202,9 @@ void __init early_init_dt_scan_nodes(void)
 
 	/* Handle linux,usable-memory-range property */
 	early_init_dt_check_for_usable_mem_range();
+
+	/* Handle kexec handover */
+	early_init_dt_check_kho();
 }
 
 bool __init early_init_dt_scan(void *dt_virt, phys_addr_t dt_phys)
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 5b924597a4de..f6cf0bc13246 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -264,6 +264,43 @@ static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
 }
 #endif /* CONFIG_IMA_KEXEC */
 
+static int kho_add_chosen(const struct kimage *image, void *fdt, int chosen_node)
+{
+	void *dt = NULL;
+	phys_addr_t dt_mem = 0;
+	phys_addr_t dt_len = 0;
+	phys_addr_t scratch_mem = 0;
+	phys_addr_t scratch_len = 0;
+	int ret = 0;
+
+#ifdef CONFIG_KEXEC_HANDOVER
+	dt = image->kho.dt.buffer;
+	dt_mem = image->kho.dt.mem;
+	dt_len = image->kho.dt.bufsz;
+
+	scratch_mem = image->kho.scratch.mem;
+	scratch_len = image->kho.scratch.bufsz;
+#endif
+
+	if (!dt)
+		goto out;
+
+	pr_debug("Adding kho metadata to DT");
+
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-dt",
+				       dt_mem, dt_len);
+	if (ret)
+		goto out;
+
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node, "linux,kho-scratch",
+				       scratch_mem, scratch_len);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
 /*
  * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
  *
@@ -414,6 +451,11 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 #endif
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
2.47.2


