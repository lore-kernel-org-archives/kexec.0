Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75357C79F9E
	for <kexec@archiver.kernel.org>; Tue,  8 Sep 2026 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tcijen+XrkE1sKKJX8CkIKKooxVBnQd0uzlIx9kSVSA=; b=eFwMTGZQqoDALfiXsb7vFbXC5E
	YNmfGUVu06As3yxaV/MYH/P7hBE72WooNQq8fRfdWA/3xb0PbO4DO+lPg+8lNfKlg6t9LQGO0Hsjo
	CN26k7VrFWECqWFHIOFk8vR2fzhuv0GgyD+L/tD9cbJVqEc7YWoolydWQplS0MNLHuDuU0svA6F5T
	5QmlNe4EStmhU5oBOE3X9uNEEBr0DoFyjrm0UfVD4NdPwlgqSATcc3sZ52eEPmjg/dI9uVP6OZ+GV
	ifCUC/N0EvVsJE3B3aC3YDTu4u7nH4lA/SltQITMqhWv9OSzJZsd7ZpDGLw8ci0/1vkaClF4EELH8
	oU3zZyyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3yBs-00000009ZK5-1snD;
	Tue, 08 Sep 2026 15:56:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3yBr-00000009ZJ9-0MeO
	for kexec@lists.infradead.org;
	Tue, 08 Sep 2026 15:56:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 85FD3601FF;
	Tue,  8 Sep 2026 15:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457E61F00A3E;
	Tue,  8 Sep 2026 15:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883014;
	bh=Tcijen+XrkE1sKKJX8CkIKKooxVBnQd0uzlIx9kSVSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GnNqH/UQFVYnXra3IOHQ/cSX+xcE9Gtflza4237iNzbU/emeQIcdFaFSEbmxT34Ah
	 7Mc7hfUaC0iEvJlhSwl7XOxg60TDmRvikCOiTgwVLAM5VImOq6qIMbukd03QYVSwPJ
	 PmgeFd9GIF66wvENo0/46QR8MbGs6TlXSePQaUiBaf5EWrtEPtoE0/zKps9Qb9G8J8
	 ex8McOjWWn7qQoI5U6se5codMlXNQ6NR7YEHTlNmH6C+qYSrLgXUwdbSFeZXIO8Hu2
	 0YL9+81ECY8oWT45na2qdN4jrVvWW+FObaNB764wG4B/ajp8jvv5E8PgAPd0efZBVB
	 xPDJ103/UfgbA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Baoquan He <baoquan.he@linux.dev>
Cc: x86@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 1/4] memblock: get rid of CONFIG_MEMBLOCK_KHO_SCRATCH
Date: Tue,  8 Sep 2026 17:56:35 +0200
Message-ID: <20260908155639.2496551-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260908155639.2496551-1-pratyush@kernel.org>
References: <20260908155639.2496551-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

This config is only a proxy for CONFIG_KEXEC_HANDOVER. It is only
enabled by KHO. No point in the indirection. Use CONFIG_KEXEC_HANDOVER
directly.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/memblock.h  | 2 +-
 kernel/liveupdate/Kconfig | 1 -
 mm/Kconfig                | 4 ----
 mm/memblock.c             | 4 ++--
 4 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index d62db9e776cf..db3b106c6335 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -614,7 +614,7 @@ static inline void early_memtest(phys_addr_t start, phys_addr_t end) { }
 static inline void memtest_report_meminfo(struct seq_file *m) { }
 #endif
 
-#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+#ifdef CONFIG_KEXEC_HANDOVER
 void memblock_set_kho_scratch_only(void);
 void memblock_clear_kho_scratch_only(void);
 #else
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index c13af38ba23a..f50daee8eff0 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -5,7 +5,6 @@ menu "Live Update and Kexec HandOver"
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
-	select MEMBLOCK_KHO_SCRATCH
 	select KEXEC_FILE
 	select LIBFDT
 	select CMA
diff --git a/mm/Kconfig b/mm/Kconfig
index 604c58199acb..631a410eaee9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -483,10 +483,6 @@ config HAVE_GUP_FAST
 	depends on MMU
 	bool
 
-# Enable memblock support for scratch memory which is needed for kexec handover
-config MEMBLOCK_KHO_SCRATCH
-	bool
-
 # Don't discard allocated memory used to track "memory" and "reserved" memblocks
 # after early boot, so it can still be used to test for validity of memory.
 # Also, memblocks are updated with memory hot(un)plug.
diff --git a/mm/memblock.c b/mm/memblock.c
index 9ce86349a29f..197d854c18d5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -113,7 +113,7 @@ unsigned long min_low_pfn;
 unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
-#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+#ifdef CONFIG_KEXEC_HANDOVER
 /* When set to true, only allocate from MEMBLOCK_KHO_SCRATCH ranges */
 static bool kho_scratch_only;
 #else
@@ -2596,7 +2596,7 @@ int reserve_mem_release_by_name(const char *name)
 	return 1;
 }
 
-#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+#ifdef CONFIG_KEXEC_HANDOVER
 __init void memblock_set_kho_scratch_only(void)
 {
 	kho_scratch_only = true;
-- 
2.55.0.979.g7e5102b832-goog


