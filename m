Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411CEC79F85
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5G+FHeX7T6X2vmqnylMHuTpvmbc7hsVAEhZdK5QIvv0=; b=iyIN9OKBdZ6o5N6kLGtFUGYyDG
	fwbgJKCM+ESnvry/HHtSJ6/x6tI614lMhjj7JSx4YGluFHVefnfdBdokO9SVKD055rNKtn4uQ8xdx
	8+zWQbw7LNodGoPbnenJY1MlRh284UFSiIfQVFuwfxeQQ9FvpVxlks1x6+qfKvhkevCPt+Zr6Gqfp
	gaj0ySQxgep9hv9rhIXvTtZiHLcWLWvMT+HeKxqkJdcyV/UNqXZW5LBiIdhlJwg0tLO9CcN4yN/CU
	h66Y4Y7nfTB/9DtA6D1PmaemvpItDimd0T51DCV0f8I508l+vuVMCg3QvxqbyC0uPd4xZ3mLf80zO
	DdrjNJgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2QsR-00000001ciA-0VuI;
	Fri, 04 Sep 2026 10:10:31 +0000
Received: from out-78.mta0.migadu.com ([2001:41d0:1004:224b::4e] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2QsN-00000001cgT-0bvS
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 10:10:29 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=HvzAFA3PwYD95faWowDYT060CwppIvNZX691N3gouBk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788516625; v=1; x=1789121425;
 b=tTP7V36qCtvcLHfmzhjNqHtSqxqOmJqcixopkpczVmPo8uTKgEslGAb8UiRAXkGaCqPAAQ5G
 7Ydd+0l3x3tLFy0X9Atn6vzhvDObPOHwvJpcpSOxjfKpSw2EEFxr4EgThwoaJ/GJVfvFpncDKQO
 0oF2DCKx7QDnLSwXjeh7r1kk=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 9df508514e3edb12;
	Fri, 04 Sep 2026 10:10:24 +0000
X-Mizu-Trace-ID: 9df508514e3edb12
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	chenhuacai@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org
Cc: ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v5 1/5] efi: add a KHO configuration table channel
Date: Fri,  4 Sep 2026 18:08:48 +0800
Message-ID: <20260904100852.26006-2-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904100852.26006-1-dongtai.guo@linux.dev>
References: <20260904100852.26006-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_031027_326337_CF85F043 
X-CRM114-Status: GOOD (  26.65  )
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

From: George Guo <guodongtai@kylinos.cn>

Add an architecture-agnostic EFI configuration table channel for kexec
handover (KHO): a LINUX_EFI_KEXEC_HANDOVER_GUID table entry pointing at
a struct linux_efi_kho_data that carries the KHO state FDT and scratch
area addresses from one kernel to the next.

This is the channel for architectures that boot through EFI without a
device tree (e.g. LoongArch), where the /chosen linux,kho-fdt and
linux,kho-scratch properties read by early_init_dt_check_kho() are not
available.  Architectures with a boot FDT (arm64, riscv) keep using the
FDT path and do not select this.

The design mirrors the LINUX_EFI_MEMRESERVE_TABLE_GUID channel:

  - The EFI stub allocates and installs the table once at boot
    (install_kho_table(), next to install_memreserve_table()), so the
    config table entry is inherited across kexec for free.

  - The reader is a common_tables[] entry in
    efi_config_parse_tables().  It reserves the stub-allocated table
    with memblock_reserve(), the same way the memreserve entries are
    reserved there, so the table is neither handed out by the buddy
    allocator nor placed on by kexec segments.  It then maps the table
    and calls kho_populate().  No arch-specific setup.c hook is
    needed.

  - efi_kho_update() rewrites the table contents in place before a
    kexec; the config table array is never rebuilt and st->tables is
    never switched, unlike the per-arch approach it replaces.  The
    table stays persistently mapped from an early_initcall, the same
    way the memreserve root is, so the update also works on the crash
    kexec path.

Gated behind CONFIG_EFI_KHO, selected by architectures that use this
channel.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 drivers/firmware/efi/Kconfig            | 12 ++++
 drivers/firmware/efi/efi.c              | 78 +++++++++++++++++++++++++
 drivers/firmware/efi/libstub/efi-stub.c | 25 ++++++++
 include/linux/efi.h                     | 36 ++++++++++++
 4 files changed, 151 insertions(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 29e0729299f5..d6c1372484b4 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -314,6 +314,18 @@ config EFI_SBAT_FILE
 
 	  If unsure, leave blank.
 
+config EFI_KHO
+	bool
+	depends on EFI_STUB && EFI_GENERIC_STUB && KEXEC_HANDOVER
+	help
+	  Carry the KHO state (the KHO state FDT and the scratch area) from
+	  one kernel to the next across kexec via an EFI configuration table
+	  entry under LINUX_EFI_KEXEC_HANDOVER_GUID, for architectures that
+	  boot through EFI without a device tree (e.g. LoongArch).
+
+	  Architectures with a boot FDT (arm64, riscv) use the /chosen FDT
+	  path instead and do not select this.
+
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 0327a39d31fa..6380cfab1493 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -24,6 +24,7 @@
 #include <linux/initrd.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+#include <linux/kexec_handover.h>
 #include <linux/platform_device.h>
 #include <linux/random.h>
 #include <linux/reboot.h>
@@ -62,6 +63,9 @@ unsigned long __ro_after_init efi_rng_seed = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata initrd = EFI_INVALID_TABLE_ADDR;
+#ifdef CONFIG_EFI_KHO
+static unsigned long __ro_after_init efi_kho_table_phys = EFI_INVALID_TABLE_ADDR;
+#endif
 
 extern unsigned long primary_display_table;
 
@@ -629,6 +633,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{EFI_TCG2_FINAL_EVENTS_TABLE_GUID,	&efi.tpm_final_log,	"TPMFinalLog"	},
 	{EFI_CC_FINAL_EVENTS_TABLE_GUID,	&efi.tpm_final_log,	"CCFinalLog"	},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID,	&mem_reserve,		"MEMRESERVE"	},
+#ifdef CONFIG_EFI_KHO
+	{LINUX_EFI_KEXEC_HANDOVER_GUID,		&efi_kho_table_phys,	"KHO"		},
+#endif
 	{LINUX_EFI_INITRD_MEDIA_GUID,		&initrd,		"INITRD"	},
 	{EFI_RT_PROPERTIES_TABLE_GUID,		&rt_prop,		"RTPROP"	},
 #ifdef CONFIG_OVMF_DEBUG_LOG
@@ -806,6 +813,31 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
+#ifdef CONFIG_EFI_KHO
+	if (efi_kho_table_phys != EFI_INVALID_TABLE_ADDR) {
+		struct linux_efi_kho_data *kho;
+
+		/*
+		 * Reserve the stub-allocated table so it is neither handed
+		 * out by the buddy allocator nor placed on by kexec
+		 * segments, mirroring the memreserve handling above.  This
+		 * runs on every boot, so it also protects the table in the
+		 * next kernel until it reads it.
+		 */
+		memblock_reserve(efi_kho_table_phys, sizeof(*kho));
+
+		kho = early_memremap(efi_kho_table_phys, sizeof(*kho));
+		if (kho) {
+			if (kho->fdt_addr)
+				kho_populate((phys_addr_t)kho->fdt_addr,
+					     kho->fdt_size,
+					     (phys_addr_t)kho->scratch_addr,
+					     kho->scratch_size);
+			early_memunmap(kho, sizeof(*kho));
+		}
+	}
+#endif
+
 	if (rt_prop != EFI_INVALID_TABLE_ADDR) {
 		efi_rt_properties_table_t *tbl;
 
@@ -1171,6 +1203,52 @@ static int __init efi_memreserve_root_init(void)
 }
 early_initcall(efi_memreserve_root_init);
 
+#ifdef CONFIG_EFI_KHO
+static struct linux_efi_kho_data *efi_kho_table __ro_after_init;
+
+static int __init efi_kho_table_init(void)
+{
+	if (efi_kho_table_phys == EFI_INVALID_TABLE_ADDR)
+		return 0;
+
+	/*
+	 * Keep a persistent mapping of the table, the same way
+	 * efi_memreserve_root_init() keeps the memreserve root mapped:
+	 * efi_kho_update() is also called on the crash kexec path, where
+	 * memremap() is no longer an option.
+	 */
+	efi_kho_table = memremap(efi_kho_table_phys, sizeof(*efi_kho_table),
+				 MEMREMAP_WB);
+	WARN_ON_ONCE(!efi_kho_table);
+
+	return 0;
+}
+early_initcall(efi_kho_table_init);
+
+/*
+ * Update the KHO config table in place before a kexec, so the next kernel
+ * finds the current handover state.  Mirrors efi_mem_reserve_persistent():
+ * the config table entry was installed once by the EFI stub and is inherited
+ * across kexec, so only the table contents are rewritten here -- the config
+ * table array is never rebuilt and st->tables is never switched.
+ */
+int efi_kho_update(phys_addr_t fdt_addr, u64 fdt_size,
+		   phys_addr_t scratch_addr, u64 scratch_size)
+{
+	struct linux_efi_kho_data *kho = efi_kho_table;
+
+	if (!kho)
+		return -ENODEV;
+
+	kho->fdt_addr		= fdt_addr;
+	kho->fdt_size		= fdt_size;
+	kho->scratch_addr	= scratch_addr;
+	kho->scratch_size	= scratch_size;
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_KEXEC
 static int update_efi_random_seed(struct notifier_block *nb,
 				  unsigned long code, void *unused)
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 42d6073bcd06..751f46280433 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -100,6 +100,29 @@ static void install_memreserve_table(void)
 		efi_err("Failed to install memreserve config table!\n");
 }
 
+static void install_kho_table(void)
+{
+#ifdef CONFIG_EFI_KHO
+	struct linux_efi_kho_data *kho;
+	efi_guid_t kho_table_guid = LINUX_EFI_KEXEC_HANDOVER_GUID;
+	efi_status_t status;
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*kho),
+			     (void **)&kho);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to allocate KHO config table!\n");
+		return;
+	}
+
+	*kho = (struct linux_efi_kho_data){};
+
+	status = efi_bs_call(install_configuration_table, &kho_table_guid,
+			     kho);
+	if (status != EFI_SUCCESS)
+		efi_err("Failed to install KHO config table!\n");
+#endif
+}
+
 static u32 get_supported_rt_services(void)
 {
 	const efi_rt_properties_table_t *rt_prop_table;
@@ -180,6 +203,8 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 
 	install_memreserve_table();
 
+	install_kho_table();
+
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
 	free_primary_display(dpy);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index aa15ff88539b..564b3cbd5ccb 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -422,6 +422,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
 #define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
 #define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
+#define LINUX_EFI_KEXEC_HANDOVER_GUID		EFI_GUID(0xc941b6c7, 0x7b3f, 0x4af6,  0x9e, 0x50, 0xfc, 0xb3, 0xa8, 0x86, 0x8a, 0x17)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 
@@ -1273,6 +1274,41 @@ struct linux_efi_memreserve {
 
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
+#ifdef CONFIG_EFI_KHO
+/*
+ * The LINUX_EFI_KEXEC_HANDOVER_GUID config table points to this structure.
+ * It carries the kexec handover (KHO) state from the current kernel to the
+ * next one: the addresses of the KHO state FDT and of the scratch area.
+ *
+ * This is the handover channel for architectures that boot through EFI
+ * without a device tree (e.g. LoongArch), where the /chosen linux,kho-fdt
+ * and linux,kho-scratch properties read by early_init_dt_check_kho() are not
+ * available.  The EFI stub allocates and installs the table once at boot;
+ * the current kernel updates its contents before a kexec, and the next
+ * kernel reads it back and calls kho_populate().
+ *
+ * The layout is an ABI between the two kernels and carries no version
+ * field: an incompatible change must use a new GUID.  The handover payload
+ * itself is versioned separately by the compatible string of the KHO state
+ * FDT, which kho_populate() checks.
+ */
+struct linux_efi_kho_data {
+	u64 fdt_addr;
+	u64 fdt_size;
+	u64 scratch_addr;
+	u64 scratch_size;
+} __packed;
+
+int efi_kho_update(phys_addr_t fdt_addr, u64 fdt_size,
+		   phys_addr_t scratch_addr, u64 scratch_size);
+#else
+static inline int efi_kho_update(phys_addr_t fdt_addr, u64 fdt_size,
+				 phys_addr_t scratch_addr, u64 scratch_size)
+{
+	return 0;
+}
+#endif
+
 /*
  * The LINUX_EFI_MOK_VARIABLE_TABLE_GUID config table can be provided
  * to the kernel by an EFI boot loader. The table contains a packed
-- 
2.53.0


