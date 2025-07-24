Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEB5C83F1A
	for <kexec@archiver.kernel.org>; Thu, 24 Jul 2025 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=six3Sv1/lb0L0m3zgi9cAfAD7+Gtbp9Soz+DPeVeLLo=; b=bzsuFOjtjuEnII
	uIs2Tr5Zc40/JtwLJy3nRELrtpbbaojps7n04d4Z+4/vjV3SxzSIyB6CJlzsxDFAARVoHI5Tu4FIE
	aEByLkiq08JN+RI1kXG/Oy3CK80o6Cx8wHFTHc+xJzcu/7ehiYz6EJtv9yb1BPDNZhrdDCeoRJ76y
	yWmN09ZTeK3NiOi7ZQucYkaYK4ZHLyXjOps9TGjgF7V3/esSRlWL+lFSnOM5zJg3bOcVwx8oWROuJ
	Hnz9xvKPp7Yd9CKcPp59AJKNn42NyQ70zjl1o9rDT/7CYue6B3ImhEz8j+fgBiSZYg7bPymfI2Oyg
	hh+rIrJBIETOerWsr8Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uerqi-00000006yZd-01Wl;
	Thu, 24 Jul 2025 09:02:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueoqe-00000006Xz4-0fpA;
	Thu, 24 Jul 2025 05:50:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 13AE746583;
	Thu, 24 Jul 2025 05:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AC7C4CEFB;
	Thu, 24 Jul 2025 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753336230;
	bh=wNKQONSDACRjYYu6I5glKcwwkty7zb+PKkmvdUUj3Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+HZl1rt2NsEtntfRh6EdRo59KNXptZi6pZx+Yrf7cIlLmr71/JLlWZuAyOeTQM6a
	 QagXP6QrI2p+FXqYRHHZ7XjXXGHD/aN7iPid8MJkn88iIkLQrCZ64w8w1N439rr4P0
	 JhwyXJQ0+BUkLdpctVPFwt6PfFYGcCP8BENbupOoSW7tkzRHikSmr9JAyjqmRLqE/0
	 fZVdqAHK8D+IHfTg7BC8eQL1k/rMnDpxqehelDjmBvAweYmiznUlNL9L7cwYxYk4tt
	 oWsaKfu9b7+CnEDYoSulWT+E5BiI7D+szglDWQD/0JTgL7hwR0tSQPkky0lFwA4wy+
	 bUamH4SrdTQuA==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 2/4] x86: Handle KCOV __init vs inline mismatches
Date: Wed, 23 Jul 2025 22:50:26 -0700
Message-Id: <20250724055029.3623499-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724054419.it.405-kees@kernel.org>
References: <20250724054419.it.405-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8992; i=kees@kernel.org; h=from:subject; bh=wNKQONSDACRjYYu6I5glKcwwkty7zb+PKkmvdUUj3Ig=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNJxdHq87byTrV+eeFmu+pxk9mrDErymjTSZ7z2arJo lvq7NmajlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIls1mZkeCNgEnr95wlTvr3M Ac17RX8sua+lf+fIw+nTLUNe7tJm2sTwV0gkcCqD+LfdNnp6PK+kC7LTjySv5f6gflLm/1bLzsz HjAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250723_225032_238136_1D6E9D5E 
X-CRM114-Status: GOOD (  20.40  )
X-Mailman-Approved-At: Thu, 24 Jul 2025 01:12:22 -0700
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
Cc: "Kirill A. Shutemov" <kas@kernel.org>, linux-efi@vger.kernel.org, Gavin Shan <gshan@redhat.com>, Jan Beulich <jbeulich@suse.com>, kvm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Kees Cook <kees@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev, Marco Elver <elver@google.com>, Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Usama Arif <usama.arif@bytedance.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bill Wendling <morbo@google.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-security-module@vger.kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>, Baoquan He <bhe@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Oza Pawandeep <quic_poza@quicinc.com>, Sami Tolvanen <samitolvanen@google.com>, Changyuan Lyu <changyuanl@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Len Brown <lenb@kernel.org>, Thomas Huth <thuth@redhat.com>, Alexander Graf <graf@amazon.com>, "Paul E. McKenney" <paulmck@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, linux-kbuild@vger.kernel.org, Brian Gerst <brgerst@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, James Morris <jmorris@namei.org>, Bibo Mao <maobibo@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, Hans de Goede <hdegoede@redhat.com>, "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>, Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Andrey Konovalov <andreyknvl@gmail.com>, Juergen Gross <jgross@suse.com>, "Serge E. Hallyn" <serge@hallyn.com>, Nicolas Schier <nicolas.schier@linux.dev>, Paul Moore <paul@paul-moore.com>, ibm-acpi-devel@lists.sourceforge.net, kexec@lists.infradead.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, "Peter Zijlstra \(Intel\)" <peterz@infradead.org>, James Morse <james.morse@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Justin Stitt <justinstitt@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, linux-trace-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roger Pau Monne <roger.pau@citrix.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

GCC appears to have kind of fragile inlining heuristics, in the
sense that it can change whether or not it inlines something based on
optimizations. It looks like the kcov instrumentation being added (or in
this case, removed) from a function changes the optimization results,
and some functions marked "inline" are _not_ inlined. In that case,
we end up with __init code calling a function not marked __init, and we
get the build warnings I'm trying to eliminate in the coming patch that
adds __no_sanitize_coverage to __init functions:

WARNING: modpost: vmlinux: section mismatch in reference: xbc_exit+0x8 (section: .text.unlikely) -> _xbc_exit (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: real_mode_size_needed+0x15 (section: .text.unlikely) -> real_mode_blob_end (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: __set_percpu_decrypted+0x16 (section: .text.unlikely) -> early_set_memory_decrypted (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: memblock_alloc_from+0x26 (section: .text.unlikely) -> memblock_alloc_try_nid (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: acpi_arch_set_root_pointer+0xc (section: .text.unlikely) -> x86_init (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: acpi_arch_get_root_pointer+0x8 (section: .text.unlikely) -> x86_init (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: efi_config_table_is_usable+0x16 (section: .text.unlikely) -> xen_efi_config_table_is_usable (section: .init.text)

This problem is somewhat fragile (though using either __always_inline
or __init will deterministically solve it), but we've tripped over
this before with GCC and the solution has usually been to just use
__always_inline and move on.

For x86 this means forcing several functions to be inline with
__always_inline.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Roger Pau Monne <roger.pau@citrix.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Usama Arif <usama.arif@bytedance.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: <kvm@vger.kernel.org>
Cc: <ibm-acpi-devel@lists.sourceforge.net>
Cc: <platform-driver-x86@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>
Cc: <linux-trace-kernel@vger.kernel.org>
Cc: <linux-efi@vger.kernel.org>
Cc: <linux-mm@kvack.org>
---
 arch/x86/include/asm/acpi.h     | 4 ++--
 arch/x86/include/asm/realmode.h | 2 +-
 include/linux/acpi.h            | 4 ++--
 include/linux/bootconfig.h      | 2 +-
 include/linux/efi.h             | 2 +-
 include/linux/memblock.h        | 2 +-
 include/linux/smp.h             | 2 +-
 arch/x86/kernel/kvm.c           | 2 +-
 arch/x86/mm/init_64.c           | 2 +-
 kernel/kexec_handover.c         | 4 ++--
 10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 5ab1a4598d00..a03aa6f999d1 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -158,13 +158,13 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 #define ACPI_HAVE_ARCH_SET_ROOT_POINTER
-static inline void acpi_arch_set_root_pointer(u64 addr)
+static __always_inline void acpi_arch_set_root_pointer(u64 addr)
 {
 	x86_init.acpi.set_root_pointer(addr);
 }
 
 #define ACPI_HAVE_ARCH_GET_ROOT_POINTER
-static inline u64 acpi_arch_get_root_pointer(void)
+static __always_inline u64 acpi_arch_get_root_pointer(void)
 {
 	return x86_init.acpi.get_root_pointer();
 }
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index f607081a022a..e406a1e92c63 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -78,7 +78,7 @@ extern unsigned char secondary_startup_64[];
 extern unsigned char secondary_startup_64_no_verify[];
 #endif
 
-static inline size_t real_mode_size_needed(void)
+static __always_inline size_t real_mode_size_needed(void)
 {
 	if (real_mode_header)
 		return 0;	/* already allocated. */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 71e692f95290..1c5bb1e887cd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -759,13 +759,13 @@ int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count)
 #endif
 
 #ifndef ACPI_HAVE_ARCH_SET_ROOT_POINTER
-static inline void acpi_arch_set_root_pointer(u64 addr)
+static __always_inline void acpi_arch_set_root_pointer(u64 addr)
 {
 }
 #endif
 
 #ifndef ACPI_HAVE_ARCH_GET_ROOT_POINTER
-static inline u64 acpi_arch_get_root_pointer(void)
+static __always_inline u64 acpi_arch_get_root_pointer(void)
 {
 	return 0;
 }
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 3f4b4ac527ca..25df9260d206 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -290,7 +290,7 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
 /* XBC cleanup data structures */
 void __init _xbc_exit(bool early);
 
-static inline void xbc_exit(void)
+static __always_inline void xbc_exit(void)
 {
 	_xbc_exit(false);
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 50db7df0efab..a98cc39e7aaa 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1336,7 +1336,7 @@ struct linux_efi_initrd {
 
 bool xen_efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table);
 
-static inline
+static __always_inline
 bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 {
 	if (!IS_ENABLED(CONFIG_XEN_EFI))
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index bb19a2534224..b96746376e17 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -463,7 +463,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
 					  NUMA_NO_NODE);
 }
 
-static inline void *memblock_alloc_from(phys_addr_t size,
+static __always_inline void *memblock_alloc_from(phys_addr_t size,
 						phys_addr_t align,
 						phys_addr_t min_addr)
 {
diff --git a/include/linux/smp.h b/include/linux/smp.h
index bea8d2826e09..18e9c918325e 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -221,7 +221,7 @@ static inline void wake_up_all_idle_cpus(void) {  }
 
 #ifdef CONFIG_UP_LATE_INIT
 extern void __init up_late_init(void);
-static inline void smp_init(void) { up_late_init(); }
+static __always_inline void smp_init(void) { up_late_init(); }
 #else
 static inline void smp_init(void) { }
 #endif
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 921c1c783bc1..8ae750cde0c6 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -420,7 +420,7 @@ static u64 kvm_steal_clock(int cpu)
 	return steal;
 }
 
-static inline void __set_percpu_decrypted(void *ptr, unsigned long size)
+static inline __init void __set_percpu_decrypted(void *ptr, unsigned long size)
 {
 	early_set_memory_decrypted((unsigned long) ptr, size);
 }
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index fdb6cab524f0..76e33bd7c556 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -805,7 +805,7 @@ kernel_physical_mapping_change(unsigned long paddr_start,
 }
 
 #ifndef CONFIG_NUMA
-static inline void x86_numa_init(void)
+static __always_inline void x86_numa_init(void)
 {
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 49634cc3fb43..e49743ae52c5 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -310,8 +310,8 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 	return -ENOMEM;
 }
 
-static void deserialize_bitmap(unsigned int order,
-			       struct khoser_mem_bitmap_ptr *elm)
+static void __init deserialize_bitmap(unsigned int order,
+				      struct khoser_mem_bitmap_ptr *elm)
 {
 	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
 	unsigned long bit;
-- 
2.34.1


