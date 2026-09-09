Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B462C79FAD
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fLp0/6osqzYu1K79RxqaODeJezxTORDI/HZWm8RTcnE=; b=urG0DHpGO86pi0XAjbNgu+fm8O
	1jYXYZJbJTB81ii4KybCrKYUwVZxst8CK4n+jlgnVRNHEBV44IX8TxfdfnxHhidJnxdJCRtUAoLEl
	o0zC488K6SGIUain1TiVEda8ImZIMKns/DdFQaSChJ5IbZKu1wRz1TbEtfB5K/K9NTwCTXDv7zuC/
	LzbXKSMoArRKkHR4+yRGm4iJcmNm4o9RgjMP8JIvQhUw0aOWm9gTBulL9rlkYorIeY0yP0ZkOC6to
	xRUjmMOQIw3X1g3bdxVc8w9W49U4CNNeWrds9RovDhK49og0Bcm7unFPoAv0dkZ1GXcpbkywcpSFN
	NeOX5MwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4I0S-0000000BkjB-0eY4;
	Wed, 09 Sep 2026 13:06:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4I0P-0000000BkiG-3xhy
	for kexec@bombadil.infradead.org;
	Wed, 09 Sep 2026 13:06:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=fLp0/6osqzYu1K79RxqaODeJezxTORDI/HZWm8RTcnE=; b=bVx70QppPaVTxcw4UGYdqXHc9/
	9dHsLta/v1XjIa4fI/EmXNI/fcl42MFtI5zk2L02dTrCe8HjXMqim+qpfK9lWYczrgOIKu7FPBBbn
	Ey3pr6daa8AwgVaLeb7WZkb7i8ZAVOMRfGhodR7ezqONA6rSCd6J+vcuueukErRCRi0U2sTd7I8aE
	fmzt6tWolyENU8ga4vc/DiVkWizK/MjvfJbG2X/FvI08ffM9rIHkSMiWyjUVxo7sk15hYNjNXsZmv
	a2HuV8PJmx5wA//HPeD2KpCeb0f4tz88Tdzm7YZlmdEmNHtFvoYEyr8DTCEN+Zm2otAX5sIK7+2OO
	61oddsYA==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4I0N-00000001CoA-0sFz
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 13:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=fLp0/6osqzYu1K79RxqaODeJezxTORDI/HZWm8RTcnE=; b=DYC+Xp5c43ihxjxqgyBzUWuGvH
	OvrZVuEMqQGQgQaImD+gdQeUa310L9Q5m3jEu6y3giBi+QYcNJerc3cSPP/EXUXH2aL3FHh1g1vu7
	nXF0SVYaltmLCxKobKfzZPIXB2MkY+opTT/GjLak9UQodGHA06dmqWww7s9HBInF/2iLj9IRiRk5i
	rPk1CFQ2JItFsGKL6o1cc+iZhw0n2hXEc2j6IBjMzdc/3pJhdN/DDqH6RHEGlHVFCp01gIChxSla3
	pgDo4yFsvC5V8KnQsJ+KGz29tvzDm7/UszGGAJSPzGy9TyKnU2D3hb1nkfTdRH/IddFY8+T0r752W
	LYudlCfg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4Hzh-0034dQ-32;
	Wed, 09 Sep 2026 13:05:42 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 09 Sep 2026 06:05:20 -0700
Subject: [PATCH v4 1/5] mm/memory-failure: efi: add the
 LINUX_EFI_POISONED_MEMORY configuration table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-hwpoison-kho-v4-1-359313564495@debian.org>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
In-Reply-To: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, kas@kernel.org, 
 kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, 
 Breno Leitao <leitao@debian.org>, harry@kernel.org, kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=5629; i=leitao@debian.org;
 h=from:subject:message-id; bh=ctiHNkWke05Q0iaiTEl4WUQNecfiVhJWf2TuHJC4Tno=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqoVmYv6/F2rp5R0pqzLMUowHz37sQM9qWNR5x2
 UuJzfxpaNuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqFZmAAKCRA1o5Of/Hh3
 bfNHD/0apJ2TYY/PkRtgB2eQI58aaL6LZZSdIvSHzd5ZQG3H/NgtttpYjBPyQ5g3FNs0bGo7NEM
 9+zRqvaatJOs8qOLNakhUerv/PJNYpZKHji0Nm/qok+8Qk8eSVwyC1iCg6oNwYN09a4TbMb8wc7
 3kZgwEQYBtEylUQ42+a4P0TXQgCzIFk55ZH1vVM/5vcLrTENg5qa8n6OnbbCyDVwZumfiLd2/3F
 Rd7olMYEJKE92ZCWRP1cGXohvSGxUfJA1DplypSNwcusEsFSwV7YVc+rlBKpOvby/KYt7b5Jcw5
 JvF2ewSM2f576xh6R4pTenjcZVcBfBji8d086jQ7EFqkLCIDQsU6QAo15LQZYCJvHuTD4CbYFuo
 9ykGUChQq9HfUxGzVyuZEcZZK1DcVjWv8uJHTK8W5I63pLBt2RdSdrRhT8rYg8wMjdJ2NPyu7rN
 8qSHc5s1e/adnS6JBLkK0We5xHNaFlber0z3gULBMD5D2W1b7xn81PwynMwtrrNIRsdcKPcCOmi
 IL9oFYTZRoU7WOIkNLwRPrphx3cpsL9L7zReLWaVzt2uXigRk+SajgHza5wMMt9akA3ljDpFcvR
 llSWuV9hAWlbz0k7nbB1c0MGCa6qo31FFQLEKKmrkbFnZBp1N7E2XzF5grQOcVnEIBud5sNjtjk
 ZhRCZ8I8nSt2Wpw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_140623_347871_F485F420 
X-CRM114-Status: GOOD (  20.02  )
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
memory starting at phys_base, modeled on the LINUX_EFI_UNACCEPTED_MEMORY
table, and it rides the EFI system table to every kernel in the chain.
Basing the bitmap keeps a machine whose RAM starts high from paying for
the hole below it.

List the table in the x86 efi_tables[] too, so an SME host maps it
unencrypted like every other EFI table.

The Kconfig symbol has no prompt. There is nothing for a user to decide,
so it is on wherever it can be, and it only costs 64K per TiB of RAM on
a kernel that already has the EFI stub and MEMORY_FAILURE. It is
restricted to 64BIT because the unit arithmetic would need div_u64() on
32-bit, and there is no 32-bit EFI configuration with MEMORY_FAILURE to
test that on.

This is a similar approach as used as unaccepted memory.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/platform/efi/efi.c  |  3 +++
 drivers/firmware/efi/Kconfig |  8 ++++++++
 drivers/firmware/efi/efi.c   |  6 ++++++
 include/linux/efi.h          | 14 ++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 0c39adb96b912..2b37b96a36e09 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -93,6 +93,9 @@ static const unsigned long * const efi_tables[] = {
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	&efi.unaccepted,
 #endif
+#ifdef CONFIG_EFI_POISONED_MEMORY
+	&efi.poisoned_memory,
+#endif
 };
 
 u64 efi_setup;		/* efi setup_data physical address */
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
index 6d987d7f97781..af1fa443839c4 100644
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
 
@@ -677,6 +680,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
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
index c35446a0b66fa..efaf63f9a54ed 100644
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
@@ -1272,6 +1275,17 @@ struct linux_efi_memreserve {
 #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
 	/ sizeof_field(struct linux_efi_memreserve, entry[0]))
 
+/* Bit N covers the unit at @phys_base + N * @unit_size. */
+struct linux_efi_poisoned_memory {
+	u32		version;
+	u32		unit_size;	/* bytes of phys space per bitmap bit */
+	u64		phys_base;	/* address the first bit covers */
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


