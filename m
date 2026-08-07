Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7866FC5AC7A
	for <kexec@archiver.kernel.org>; Fri,  7 Aug 2026 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MnGA2XpLaKtX7cmmtolKrMtU3s+BumW1DYNOt54uYU=; b=4d1nYYO8rhpCzd5H6px1J2i+zT
	zMzvZgibFahjem8moJJ4Ol/F/fnxMjbYChhlOrgyxWC7qqIBnn9PzbguzWPGVKMKsvJl7ZuoEGkHJ
	pnM00GHO9i7Dw81yFxl6dQEhebHzV41QwhR5eprBo7+659DaCWdwKwokyvDrymaMU3vcXopSrbbIS
	gg4qQ1mGaY5ChktaOHzvSf4q26ELw7+XPtZmFE50aYmpH7HJNUI7WgdF45GdHm5wvsXhd1bvIeHXL
	frov+Cu1NIa16P6zmjEkSh90Ukxs7fXyhlNbV5Dwu0y0+HwxT2589vazBpP5CwsV6aH21/LbR+I2v
	UewCaznA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsHxw-00000007gty-2PzQ;
	Fri, 07 Aug 2026 10:38:16 +0000
Received: from out-179.mta1.migadu.com ([95.215.58.179])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsHxs-00000007gsI-2AIJ
	for kexec@lists.infradead.org;
	Fri, 07 Aug 2026 10:38:14 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786099088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MnGA2XpLaKtX7cmmtolKrMtU3s+BumW1DYNOt54uYU=;
	b=nUqGglQEFSiDP4w9XvLdasgzgUzCQg3EnaBt8s3qJmMZ9muZcSGKjRgCCxC6fluOTVKSvm
	ouR+zIBF+Rfk3GovmnF0OOku9DgEgMRJniWkjd5Hmv1wpvfO38bX97LZBO5HGVKAJB1uoZ
	i51ax670tcY7f0PpRSNY+JBndvEY7kY=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	shuah@kernel.org,
	ardb@kernel.org
Cc: guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v4 1/4] efi: add a KHO configuration table GUID
Date: Fri,  7 Aug 2026 18:37:11 +0800
Message-ID: <20260807103714.33074-2-dongtai.guo@linux.dev>
In-Reply-To: <20260807103714.33074-1-dongtai.guo@linux.dev>
References: <20260807103714.33074-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_033812_722249_B0A0D303 
X-CRM114-Status: GOOD (  16.62  )
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

Kexec Handover (KHO) passes the address of its state FDT and of its
scratch area from the current kernel to the next one.  On architectures
that boot with a device tree, the current kernel writes the
linux,kho-fdt and linux,kho-scratch properties into /chosen, and the next
kernel reads them back in early_init_dt_check_kho().

Architectures that boot through EFI without a device tree have no such
channel.  LoongArch is one of them: its efistub passes the EFI system
table and the command line to the core kernel directly and never creates
an FDT.  x86 has the same problem and carries the state out of band
instead, in a struct kho_data in the setup_data chain of its boot
protocol.

Add an out-of-band channel for EFI: a LINUX_EFI_KHO_TABLE_GUID
configuration table entry, under a randomly generated GUID, pointing at a
struct linux_efi_kho_data.  The
current kernel loads the structure and an extended configuration table as
kexec segments, then switches the EFI system table to the new table
before jumping.  The next kernel finds the entry by GUID and calls
kho_populate().

The structure carries no version field.  An incompatible change to the
layout must use a new GUID, which is the usual rule for EFI configuration
tables.  The handover payload itself is versioned separately, by the
compatible string of the KHO state FDT that kho_populate() checks.

This patch adds the definitions only.  LoongArch is the first user; any
other EFI architecture without a boot FDT can use the same channel.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/linux/efi.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccbc35479684..789ab9e4312a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -422,6 +422,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
 #define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
 #define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
+#define LINUX_EFI_KHO_TABLE_GUID		EFI_GUID(0xc941b6c7, 0x7b3f, 0x4af6,  0x9e, 0x50, 0xfc, 0xb3, 0xa8, 0x86, 0x8a, 0x17)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 
@@ -1271,6 +1272,29 @@ struct linux_efi_memreserve {
 
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
+/*
+ * The LINUX_EFI_KHO_TABLE_GUID config table points to this structure.  It
+ * carries the kexec handover (KHO) state from the current kernel to the next
+ * one: the addresses of the KHO state FDT and of the scratch area.
+ *
+ * This is the handover channel for architectures that boot through EFI without
+ * a device tree, where the /chosen linux,kho-fdt and linux,kho-scratch
+ * properties read by early_init_dt_check_kho() are not available.  The current
+ * kernel loads the structure and an extended configuration table as kexec
+ * segments; the next kernel finds it by GUID and calls kho_populate().
+ *
+ * The layout is an ABI between the two kernels and is fixed.  It carries no
+ * version field: an incompatible change must use a new GUID, and the handover
+ * payload itself is versioned separately by the compatible string of the KHO
+ * state FDT, which kho_populate() checks.
+ */
+struct linux_efi_kho_data {
+	u64 fdt_addr;
+	u64 fdt_size;
+	u64 scratch_addr;
+	u64 scratch_size;
+} __packed;
+
 /*
  * The LINUX_EFI_MOK_VARIABLE_TABLE_GUID config table can be provided
  * to the kernel by an EFI boot loader. The table contains a packed
-- 
2.53.0


