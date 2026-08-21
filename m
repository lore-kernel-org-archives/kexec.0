Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A81C5DF87
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 10:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=clgEu5ocwrJ3/2sMRprXhyjnlGpexA9HwN+YHsN7hWE=; b=sGREUfXGRtfE3NrmlE2LG6rYSb
	/+wM/qzrDwF4d+LxtX7oSIkFawSFQQVyCveFK1Iir8ud3MXAnEtNJcgDdb/n4OIIm69tb8EhFfG8h
	qZXRqjrdYfXjYMoxlGuDNX00TMd7WhJE4eBr8xT45r6w+VG84Lijiwxj3s3mvwd3NNm1tYNb41bae
	vc58oInMfw39xcWxBagD/zUraslKim4Kp1IspXip0ejUaMbXFjTIqvCPHN8xlgCE2tQyM9qxSRVmM
	j+lUTckyUEXCKWrKL4GI6GsZ6GHGdw0G0vvhzUg8kB7IS0bG7eNBMObIvjRlVof+Qz7kGn6BRtiLw
	JIfoKWHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxM9I-0000000D1b1-0w8u;
	Fri, 21 Aug 2026 10:06:56 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxM9E-0000000D1WX-0JLs
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 10:06:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=clgEu5ocwrJ3/2sMRprXhyjnlGpexA9HwN+YHsN7hWE=; b=MlayavnHGn93lBnpvs956q0XXD
	CVT+1RGs2pahyXBKzbABxG5K9HCaqueKoaMRMlRJlxoYTruWY+ViP9hC9ggDwSa7p/xp6CVXfiYBF
	Vkb/5h/+iGhZ0SMb/usYLoXRqfu8B/Uv5ZRg4+wIA5XCYg/Moojlgz9XZyHEOHSQzTYImSZLRx0gp
	ndgIoMz1pVbt7Q/NTZCvVtwgLmRdkToCfEc3gneLx1YnsXyu7jJvSRBwaA80QVPm4VIZeECOFIYgV
	6D5EmSzBV7DP1LTe+NSG1FAB2NfipYX1D4LlenITVvl8Y97FvZBFlyDnkEvEVhayB86P05bQZwG0D
	tPbmeQvQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxM9C-00BGCh-0e;
	Fri, 21 Aug 2026 10:06:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Aug 2026 03:06:06 -0700
Subject: [PATCH v2 6/6] efi: respect the poisoned pages coming from
 previous kernel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-hwpoison-kho-v2-6-5743791e48e6@debian.org>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
In-Reply-To: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, rmikey@meta.com, kas@kernel.org, riel@surriel.com, 
 kexec@lists.infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4736; i=leitao@debian.org;
 h=from:subject:message-id; bh=Xsp5t/AjlrO67qweZEiBvofZ/A1yR4ej/H2a8cEi3f8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqiCMaLD0gMUB4x31WYY7Fkyu5rCsTlY48ZbsVw
 Nj6u6XVr3uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaogjGgAKCRA1o5Of/Hh3
 bX8cD/kBHVlSr41tBzDeV+jCDztGEjkDtT4IWUNxuOkogpCQezn/v6qS40A8wDFiNHJFSXDbAKx
 rtgqpRfApNGBuCI3kw6A1v/hmQGPaqdIo7Z4qSwy0ThsszkBZ2I2TBvDwL8C/eEEV9NklYeiF0y
 Jaav/ViHoSnLsaq77+gX3G1vLYYA8BhkRFazDF9imjYp8+vT+WTEIblxYzXG2B/a0ptHQaLn2VB
 ig/KL/jhwH7ncyfMig0bC0z/LbmQa7s0JdTXUSM7amzpllpgNW5yiV/CBIJ2xxcJtJnnRceU9dG
 BeInri9f9Ph27Zhyw2kRB7vVC/7uDGw/s1r6RjAUrCTeamf5sB2vdGl3Zg2xJ8bpYBXHkyBNFb8
 sGmmVIRJw+aZNplMEtGSUMceZoWGFXnrmaOCi3TUNxUfGtuZMF8Zc6ZrJBOpJ6fYW6/WqmRrKBA
 uqIsr0cE4uNUxBWSzO5YsTeuutpBfJYmulEBwIQSZjQAbeoNHjtIZLuMSAzAgPeJMdxOEaVLalc
 IzWFCsG0L/dTguYbx7Jxm9sWwP4krI3vzqYy/yKaLtwTCFg26qY8oJKydmVGZWNgapQsXjyj/cL
 blpYLbmyzaDkOL8RomhW5VZxKMKR079hL+ZT0EklfZwjKhv1vLLVsoLfc8nr05AY6n8KZemvcaD
 G5RQ0RnqrD7GxtQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_030652_134405_7BF2953D 
X-CRM114-Status: GOOD (  19.32  )
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

On kexec next kernel, walk the LINUX_EFI_POISONED_MEMORY bitmap during
EFI init -- before memblock hands memory to the buddy allocator -- and
memblock_reserve() every unit whose bit is set. So a frame poisoned
under a previous kernel is never handed back out across a kexec.

This runs from efi_config_parse_tables(), early enough to keep the
frames out of memblock and the buddy allocator.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/efi.c    |  2 ++
 drivers/firmware/efi/poison.c | 71 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/efi.h           |  2 ++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 111e60479211a..7474eeebb0add 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -812,6 +812,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
+	efi_reserve_poisoned_memory();
+
 	if (rt_prop != EFI_INVALID_TABLE_ADDR) {
 		efi_rt_properties_table_t *tbl;
 
diff --git a/drivers/firmware/efi/poison.c b/drivers/firmware/efi/poison.c
index 2f47293a4e45f..e418c6b3aab81 100644
--- a/drivers/firmware/efi/poison.c
+++ b/drivers/firmware/efi/poison.c
@@ -3,8 +3,9 @@
  * Runtime handling for the LINUX_EFI_POISONED_MEMORY configuration table: a
  * bitmap with one bit per EFI_POISON_UNIT_SIZE of physical memory that records
  * hardware-poisoned frames so the next kexec kernel can keep them out of its
- * allocator. The stub installs the (empty) bitmap; this kernel sets bits at
- * runtime.
+ * allocator. The stub allocates and installs the (empty) bitmap; this kernel
+ * sets bits at runtime; the next kernel reserves the set units before the
+ * allocator comes up.
  *
  * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2026 Breno Leitao <leitao@debian.org>
@@ -16,6 +17,8 @@
 #include <linux/efi.h>
 #include <linux/io.h>
 #include <linux/log2.h>
+#include <linux/memblock.h>
+#include <linux/minmax.h>
 #include <linux/mm.h>
 #include <linux/overflow.h>
 
@@ -128,3 +131,67 @@ void efi_hwpoison_record_pfn(unsigned long pfn)
 
 	set_bit(unit, efi_poison->bitmap);
 }
+
+void __init efi_reserve_poisoned_memory(void)
+{
+	u64 ppm = efi.poisoned_memory, phys_base, unit_size, bitmap_size, off;
+	struct linux_efi_poisoned_memory *pm;
+	unsigned int nr_units = 0;
+
+	if (ppm == EFI_INVALID_TABLE_ADDR)
+		return;
+
+	pm = early_memremap(ppm, sizeof(*pm));
+	if (!pm) {
+		pr_warn("Could not map poisoned-memory table\n");
+		return;
+	}
+
+	if (!efi_poison_table_valid(pm)) {
+		/* Keep the runtime side off a table this pass rejected. */
+		efi.poisoned_memory = EFI_INVALID_TABLE_ADDR;
+		early_memunmap(pm, sizeof(*pm));
+		return;
+	}
+
+	phys_base = pm->phys_base;
+	unit_size = pm->unit_size;
+	bitmap_size = pm->size;
+
+	early_memunmap(pm, sizeof(*pm));
+
+	/* Reserve the table itself so it survives a further kexec. */
+	memblock_reserve(PAGE_ALIGN_DOWN(ppm),
+			 PAGE_ALIGN(ppm + sizeof(*pm) + bitmap_size) -
+			 PAGE_ALIGN_DOWN(ppm));
+
+	/*
+	 * Walk the bitmap a page at a time and reserve each poisoned unit.
+	 * memblock.memory is not populated this early, so memblock_remove()
+	 * and memblock_mark_nomap() would be no-ops; a reservation is what
+	 * keeps the units away from the allocator.
+	 */
+	for (off = 0; off < bitmap_size; off += PAGE_SIZE) {
+		u64 chunk = min_t(u64, PAGE_SIZE, bitmap_size - off);
+		unsigned long bit, nbits = chunk * BITS_PER_BYTE;
+		unsigned long *map;
+
+		map = early_memremap(ppm + offsetof(struct linux_efi_poisoned_memory,
+						    bitmap) + off, chunk);
+		if (!map) {
+			pr_warn("Could not map poisoned-memory bitmap\n");
+			return;
+		}
+		for_each_set_bit(bit, map, nbits) {
+			u64 unit = off * BITS_PER_BYTE + bit;
+
+			memblock_reserve(phys_base + unit * unit_size, unit_size);
+			nr_units++;
+		}
+		early_memunmap(map, chunk);
+	}
+
+	if (nr_units)
+		pr_info("reserved %u poisoned unit(s) (%lluK each) inherited across kexec\n",
+			nr_units, unit_size >> 10);
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index f03b1bb576133..350a3cb0babdd 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1285,8 +1285,10 @@ struct linux_efi_poisoned_memory {
 #define EFI_POISON_UNIT_SIZE	SZ_2M
 
 #ifdef CONFIG_EFI_POISONED_MEMORY
+void efi_reserve_poisoned_memory(void);
 void efi_hwpoison_record_pfn(unsigned long pfn);
 #else
+static inline void efi_reserve_poisoned_memory(void) { }
 static inline void efi_hwpoison_record_pfn(unsigned long pfn) { }
 #endif
 

-- 
2.53.0-Meta


