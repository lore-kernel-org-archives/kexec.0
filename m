Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5FEC61DBE
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UhikRt0HmqGxXvzztoXS5tGgSGD7w/+eDypjfVVuNCU=; b=lpbVR7YkIEWihYA8C8plgcV0WD
	KMk2I5YpbPZbKGKoivwGqx8U75yWBQs6Sp+OwOx7PkTX4Cu4zw66xQPPxJkU60Q76/5eJHw1KHvDS
	6/M9179c+jBgOJ6ufvX9oxDAiQL0LFQvGesN865K5oAizI4PQky74U6bn+vFJBkJl4m3A+lJLFKDZ
	6blvrl/Buaikk0Jp6IbxeEnmKVVmUujjI1hJs9u8JkQFIxMDRp0ZAG9IX1CdxiISXPg1mrhbmCmYx
	YqDaC7u1GpiUH9W3VwOUo8RiHUu1om2GOJLzhsKkJUCKwNSynnRy7K7ituxXDsxBd5+dBcEifV8RD
	ybuyx3BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzCNH-00000002ONb-1u5U;
	Wed, 26 Aug 2026 12:04:59 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzCND-00000002OLy-2ump
	for kexec@lists.infradead.org;
	Wed, 26 Aug 2026 12:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=UhikRt0HmqGxXvzztoXS5tGgSGD7w/+eDypjfVVuNCU=; b=PyAz2+CVX/MmA487mIUvti4/+X
	zDA4hLm7x0EkEu+dr1+T5Wmam3SKWWaSJ6cTvAT+FxzIu4ZOkaD43tFqMrOluM35SU2O2LtAY2H+P
	eQDeMxTeRUy8ho8AOqlrIqBGd7nqC2Ilt7ycp0cnQ1mwW1f2h/eWZW9jq1Z8r78nqpKIRaLe0a55i
	M1LZoG23NsekZL0h7bjuMdqOQkR75FohUp3dMvV4TQqqEtD71+E+Y3LGSn9XJtLMvB//VeNe1aCzR
	jpdggdqeZRaM5zi9RAYDm2AtgeOfg+NbiFSMWfmD7w3gxspgQGpdH4czTejkcb+4JnJuI7dvWhcYw
	L9AmG01w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzCMw-00FCWi-2F;
	Wed, 26 Aug 2026 12:04:39 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 26 Aug 2026 05:03:52 -0700
Subject: [PATCH v3 1/5] mm/memory-failure: efi: add the
 LINUX_EFI_POISONED_MEMORY configuration table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-hwpoison-kho-v3-1-6f79c4b605bc@debian.org>
References: <20260826-hwpoison-kho-v3-0-6f79c4b605bc@debian.org>
In-Reply-To: <20260826-hwpoison-kho-v3-0-6f79c4b605bc@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, kas@kernel.org, 
 kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4813; i=leitao@debian.org;
 h=from:subject:message-id; bh=XZUS/f25dq0I8Z+98iNLJoB6vzCCwIuyygNx7FuPAYw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqjtZKIy44p0OfgXtXkaiRAIy9xVaHpssqtdzOS
 lq7xv41s1CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCao7WSgAKCRA1o5Of/Hh3
 bdVZD/47lVPd3xCInezUT9l7ojDgBYE3rG7/KqPxMTr7D26pl7QUZ5iRnmOa/oYXIODPtbMJNxP
 0AOlMnnBfrspZC6BaebOZMKGhL1fi9VwJ2VpShahrPm29UJG8CZ55YheG5Fq+tE+Uw5zrJHTYrM
 V0tpxo0LtP7Za7l/hFvgHJUmhoiHvKsEEKF61iaHuEFetuOAC/RiZjGLsl5r0Vuv6h9gq44dUZd
 NtIAbECTx05b6eMDlBbtTIVK1FStG0H4bL/M034ORA4zxC5SfGRXNFQA4EF2+MwyMHRa365bXkj
 +uOlUVIuo8nPwuQTiGryGPHzOvTQ9htIgEQQFM2DOFmg/K7tRU1YEiWoqjsz4nfoyU6stgzdUHm
 SnNP9vOsHfFaqQIhwKMRFIxEt3d2JvofMLuVvc84GN1hsb/tQF07t+LbNWphFk5sbdaxj1MOSlI
 hbYy7v6qRb6Ejz7wtOD7svHS1s4vzL0jyILVtLVnT9aKK3rosg5OEtQ0joYBsrU04gFa34UvMfh
 6VVD6JPtjMXH27vAEkmUlr83z31KG6+R5t+i99B4a4l7iyM+eVE9/C8MhKpiHUaYO8oxb+ZEGi1
 HWK2fRFU+2rQYnKQk8NmEvH1olCgdyY6LQeE8sG4DR1FWgTA18lMnr/0nROVTN1/EsddqeXn5Uh
 V2JggMOfw5h3XlA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_050456_024796_96C4FCE6 
X-CRM114-Status: GOOD (  17.35  )
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

Hardware-poisoned page frames are tracked only in the running kernel's
data structures, so a kexec loses them and the next kernel doesn't have
this information, thus, tripping into them again.

Add an EFI configuration table to carry that information across kexec.

It is a bitmap with one bit per EFI_POISON_UNIT_SIZE (2MiB) of physical
memory, modeled on the LINUX_EFI_UNACCEPTED_MEMORY table, and it rides
the EFI system table to every kernel in the chain.

The Kconfig symbol has no prompt. There is nothing for a user to decide,
so it is on wherever it can be, and it only costs 64K per TiB of RAM on
a kernel that already has the EFI stub and MEMORY_FAILURE. It is
restricted to 64BIT because the unit arithmetic would need div_u64() on
32-bit, and there is no 32-bit EFI configuration with MEMORY_FAILURE to
test that on.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/Kconfig |  8 ++++++++
 drivers/firmware/efi/efi.c   |  6 ++++++
 include/linux/efi.h          | 13 +++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 29e0729299f5b..aafcd41bc0063 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -263,6 +263,14 @@ config EFI_COCO_SECRET
 	  virt/coco/efi_secret module to access the secrets, which in turn
 	  allows userspace programs to access the injected secrets.
 
+config EFI_POISONED_MEMORY
+	def_bool y
+	depends on EFI_STUB && MEMORY_FAILURE && 64BIT
+	help
+	  Record page frames that are hardware-poisoned while this kernel runs
+	  into an EFI configuration table, and honor that table early on the
+	  next kernel so a kexec does not hand known-bad RAM back out.
+
 config OVMF_DEBUG_LOG
 	bool "Expose OVMF firmware debug log via sysfs"
 	depends on EFI
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 0327a39d31fa5..111e60479211a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -55,6 +55,9 @@ struct efi __read_mostly efi = {
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	.unaccepted		= EFI_INVALID_TABLE_ADDR,
 #endif
+#ifdef CONFIG_EFI_POISONED_MEMORY
+	.poisoned_memory	= EFI_INVALID_TABLE_ADDR,
+#endif
 };
 EXPORT_SYMBOL(efi);
 
@@ -646,6 +649,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	{LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID,	&efi.unaccepted,	"Unaccepted"	},
 #endif
+#ifdef CONFIG_EFI_POISONED_MEMORY
+	{LINUX_EFI_POISONED_MEMORY_TABLE_GUID,	&efi.poisoned_memory,	"POISON"	},
+#endif
 #ifdef CONFIG_EFI_GENERIC_STUB
 	{LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID,	&primary_display_table			},
 #endif
diff --git a/include/linux/efi.h b/include/linux/efi.h
index b3c83516593d1..c7b4a37f760ec 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -23,6 +23,7 @@
 #include <linux/pstore.h>
 #include <linux/range.h>
 #include <linux/reboot.h>
+#include <linux/sizes.h>
 #include <linux/uuid.h>
 
 #include <asm/page.h>
@@ -422,6 +423,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
 #define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
 #define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
+#define LINUX_EFI_POISONED_MEMORY_TABLE_GUID	EFI_GUID(0xaf828a15, 0x0ef4, 0x439a,  0xb8, 0x6a, 0xd6, 0xd6, 0x9e, 0xaf, 0xba, 0xfa)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 
@@ -650,6 +652,7 @@ extern struct efi {
 	unsigned long			mokvar_table;		/* MOK variable config table */
 	unsigned long			coco_secret;		/* Confidential computing secret table */
 	unsigned long			unaccepted;		/* Unaccepted memory table */
+	unsigned long			poisoned_memory;	/* Hardware-poisoned memory table */
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
@@ -1271,6 +1274,16 @@ struct linux_efi_memreserve {
 #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
 	/ sizeof_field(struct linux_efi_memreserve, entry[0]))
 
+/* Bit N covers unit N of physical address space, counting from address 0. */
+struct linux_efi_poisoned_memory {
+	u32		version;
+	u32		unit_size;	/* bytes of phys space per bitmap bit */
+	u64		size;		/* bitmap size in bytes */
+	unsigned long	bitmap[];
+};
+
+#define EFI_POISON_UNIT_SIZE	SZ_2M
+
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
 /*

-- 
2.53.0-Meta


