Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4C606A32E
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uFjCQzTL;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=alqufkqY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a6J8HagnpENiQ+UCGH9udJuoBmm3aNobu1K7fxrXdFI=; b=uFjCQzTLjjMYulcZB48WBZMpjO
	Q2OOHbMQFmXujgvBzzZiG9w3S9TpnkCujCsAxMJ0nX77So+UtVO0oKosyZhiM06elTEddoMZvhBCJ
	0x1nBLoxqaLg4Avr0tBJj64woopDXvBiWqG8D2TJEv2d61vwobu+I2/cdtSGQ/Oy+dIkPo1TvuwyD
	iJu2eN5lw5ac39i6BRGpaTYTBUVxtPSt6MQx1DiBW8MupJzwjbxAs3caFYjR5YS5VfBuV90Zb2m5j
	hC532CTETjVUPDVXDMjDGwModVleNkEsnhoXBYtBHCj2Dc0+p94QUvekQxDrXIKg/uk7CYhZ++z0h
	l7qS0TSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK1cV-0000000F5vs-0IuP;
	Thu, 22 Oct 2026 22:50:47 +0000
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK1cR-0000000F5sA-1NHL
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 22:50:44 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e601800e58so3328585ad.2
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792709442; x=1793314242; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a6J8HagnpENiQ+UCGH9udJuoBmm3aNobu1K7fxrXdFI=;
        b=alqufkqYY7vzVJfThIhE2/pb/Qha3IG8uMHh5kcKjFxST/RXDGes/BK2c/jDTlTYP3
         Mzs8CIjtgEbp6xZ/IURfghlsVUqkSUCQ1CWEoKJByZsBGcnu3iZuMzelK8qdQX3TAeCd
         6eZVq7/gHIT0wpNb1vrE9e2NU3YOcIkmM7F2HoLTZ74YP/X2vzxQ7TVz5Cv4M2+2EE2N
         6sPydhfgJXyY2R79GPwOeD4KBDyKgHg59WOPXMw1KQuAaK8XyN43qa2AztQCae80Dj7L
         565Wlkr123xR0X5nXOpTeL0UylPyn3SIj1pBbDHh3UQCxIL8JnEUZd3md25u7AnaI4lb
         KtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709442; x=1793314242;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a6J8HagnpENiQ+UCGH9udJuoBmm3aNobu1K7fxrXdFI=;
        b=XlrItoTQWeqDwat3VcLzovqZ7qULRjPoNRPD2F0CZhBb9J2uqO21bU+1PNnoUPOlGa
         BmQUXPQDgcDnO06KQ2RWOKjuGtn+7LMVQpZ4jjvAeDgbE15lN/SmU/g9jLRIVRxrhxRT
         l9MSqfp3vCoa2j0cIcF/SYsOYPBcMma6Zg+j9bJBJoM3IPZZmmIP1hm62FTBL2Qx6jay
         P/ggbTsOuqPXxPbpnTp24nqAFrhMJCmFcbVGt8PEC8pMENDlGYtPsT/Eaj7HPIEKzlij
         2p/7V4KxHB4/Vn7wFbfQv+/c3p+E/wOyyEsM1aoibEbDAXLPM9mqwmEMD0qOT2LJUrju
         S5fg==
X-Gm-Message-State: AFq9FYKDJ4Rg2wqziz0F4L+0Elae4uPrADrus8pnmqj4jNt8JzZVcXkO
	18pBhmVqdCEQ818K7Cs7hcG9MCose+pkTG4lOIf8DsEcLxrguObMDwctDobNJcIHCRASk6zImWI
	4CjwyFrtJ+J0tL58Jdzn1eeRLcKZIPxyEVmOuNAYC0E3lzGut7wFDgx2x11AAVr3dRedwNJknap
	vfd1OTIvr//gSS1Z9kcvxGj2+yS6sf5Jrgb7AxAHSsVmOkRbL7dz0=
X-Received: from plbl14.prod.google.com ([2002:a17:902:eb0e:b0:2e8:af72:767])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3850:b0:2e9:4d9f:a65b with SMTP id d9443c01a7336-2ea7d132eaamr5553695ad.53.1792709441528;
 Thu, 22 Oct 2026 15:50:41 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:50:29 +0000
In-Reply-To: <20261022225035.377445-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022225035.377445-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022225035.377445-5-dmatlack@google.com>
Subject: [PATCH v2 04/10] mm: Rename memfd_luo to shmem_luo
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_155043_435508_BE72CE5F 
X-CRM114-Status: GOOD (  31.37  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-31.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rename the memfd Live Update file handler from memfd_luo to shmem_luo,
including the source file, its KHO ABI header, its documentation and its
Kconfig option (CONFIG_LIVEUPDATE_MEMFD to CONFIG_LIVEUPDATE_SHMEM).

The handler preserves shmem files. Today those are memfds, but following
commits extend it to other files on tmpfs mounts, for which the memfd
name is confusing. Preserving memfds created with MFD_HUGETLB, which are
hugetlbfs files, will need a separate handler, so naming the handler
after the filesystem that backs the files also avoids having to rename
it again then.

Don't change the compatible string of the handler, "memfd-v2". It is
matched against the preserved state from the previous kernel, so
changing it would break live updates from kernels that use the old
name. The serialized format doesn't change either.

Also clarify in the documentation that memfd means a memfd created
without MFD_HUGETLB, and name the ABI documentation after the handler.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/core-api/liveupdate.rst         |   2 +-
 Documentation/mm/index.rst                    |   2 +-
 ...reservation.rst => shmem_preservation.rst} |   8 +-
 MAINTAINERS                                   |   4 +-
 include/linux/kho/abi/{memfd.h => shmem.h}    |  41 ++++---
 kernel/liveupdate/Kconfig                     |   2 +-
 mm/Makefile                                   |   2 +-
 mm/{memfd_luo.c => shmem_luo.c}               | 115 +++++++++---------
 8 files changed, 89 insertions(+), 87 deletions(-)
 rename Documentation/mm/{memfd_preservation.rst => shmem_preservation.rst} (66%)
 rename include/linux/kho/abi/{memfd.h => shmem.h} (65%)
 rename mm/{memfd_luo.c => shmem_luo.c} (81%)

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 2bce2644eba2..669722002440 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -37,7 +37,7 @@ The following types of file descriptors can be preserved
 .. toctree::
    :maxdepth: 1
 
-   ../mm/memfd_preservation
+   ../mm/shmem_preservation
 
 Public API
 ==========
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 13a79f5d092c..b8ab2f89002d 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -61,7 +61,7 @@ documentation, or deleted if it has served its purpose.
    hugetlbfs_reserv
    ksm
    memory-model
-   memfd_preservation
+   shmem_preservation
    mmu_notifier
    multigen_lru
    numa
diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/shmem_preservation.rst
similarity index 66%
rename from Documentation/mm/memfd_preservation.rst
rename to Documentation/mm/shmem_preservation.rst
index c908a12dffa7..e79bf8afaa9e 100644
--- a/Documentation/mm/memfd_preservation.rst
+++ b/Documentation/mm/shmem_preservation.rst
@@ -4,16 +4,16 @@
 Memfd Preservation via LUO
 ==========================
 
-.. kernel-doc:: mm/memfd_luo.c
+.. kernel-doc:: mm/shmem_luo.c
    :doc: Memfd Preservation via LUO
 
 Memfd Preservation ABI
 ======================
 
-.. kernel-doc:: include/linux/kho/abi/memfd.h
-   :doc: memfd Live Update ABI
+.. kernel-doc:: include/linux/kho/abi/shmem.h
+   :doc: shmem Live Update ABI
 
-.. kernel-doc:: include/linux/kho/abi/memfd.h
+.. kernel-doc:: include/linux/kho/abi/shmem.h
    :internal:
 
 See Also
diff --git a/MAINTAINERS b/MAINTAINERS
index 5d1b58271989..742cdce14cf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15184,14 +15184,14 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	Documentation/core-api/liveupdate.rst
-F:	Documentation/mm/memfd_preservation.rst
+F:	Documentation/mm/shmem_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
 F:	include/linux/kho/abi/
 F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
 F:	kernel/liveupdate/
 F:	lib/tests/liveupdate.c
-F:	mm/memfd_luo.c
+F:	mm/shmem_luo.c
 F:	tools/testing/selftests/liveupdate/
 
 LLC (802.2)
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/shmem.h
similarity index 65%
rename from include/linux/kho/abi/memfd.h
rename to include/linux/kho/abi/shmem.h
index 08b10fea2afc..b61687e358a2 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/shmem.h
@@ -8,49 +8,50 @@
  * Pratyush Yadav <ptyadav@amazon.de>
  */
 
-#ifndef _LINUX_KHO_ABI_MEMFD_H
-#define _LINUX_KHO_ABI_MEMFD_H
+#ifndef _LINUX_KHO_ABI_SHMEM_H
+#define _LINUX_KHO_ABI_SHMEM_H
 
 #include <linux/types.h>
 #include <linux/kho/abi/kexec_handover.h>
 
 /**
- * DOC: memfd Live Update ABI
+ * DOC: shmem Live Update ABI
  *
- * memfd uses the ABI defined below for preserving its state across a kexec
- * reboot using the LUO.
+ * The shmem file handler, which preserves memfds created without
+ * ``MFD_HUGETLB``, uses the ABI defined below for preserving their state across
+ * a kexec reboot using the LUO.
  *
- * The state is serialized into a packed structure `struct memfd_luo_ser`
+ * The state is serialized into a packed structure `struct shmem_luo_ser`
  * which is handed over to the next kernel via the KHO mechanism.
  *
  * This interface is a contract. Any modification to the structure layout
  * constitutes a breaking change. Such changes require incrementing the
- * version number in the MEMFD_LUO_FH_COMPATIBLE string.
+ * version number in the SHMEM_LUO_FH_COMPATIBLE string.
  */
 
 /**
- * MEMFD_LUO_FOLIO_DIRTY - The folio is dirty.
+ * SHMEM_LUO_FOLIO_DIRTY - The folio is dirty.
  *
  * This flag indicates the folio contains data from user. A non-dirty folio is
  * one that was allocated (say using fallocate(2)) but not written to.
  */
-#define MEMFD_LUO_FOLIO_DIRTY		BIT(0)
+#define SHMEM_LUO_FOLIO_DIRTY		BIT(0)
 
 /**
- * MEMFD_LUO_FOLIO_UPTODATE - The folio is up-to-date.
+ * SHMEM_LUO_FOLIO_UPTODATE - The folio is up-to-date.
  *
  * An up-to-date folio has been zeroed out. shmem zeroes out folios on first
  * use. This flag tracks which folios need zeroing.
  */
-#define MEMFD_LUO_FOLIO_UPTODATE	BIT(1)
+#define SHMEM_LUO_FOLIO_UPTODATE	BIT(1)
 
 /**
- * struct memfd_luo_folio_ser - Serialized state of a single folio.
+ * struct shmem_luo_folio_ser - Serialized state of a single folio.
  * @pfn:       The page frame number of the folio.
  * @flags:     Flags to describe the state of the folio.
  * @index:     The page offset (pgoff_t) of the folio within the original file.
  */
-struct memfd_luo_folio_ser {
+struct shmem_luo_folio_ser {
 	u64 pfn:52;
 	u64 flags:12;
 	u64 index;
@@ -60,7 +61,7 @@ struct memfd_luo_folio_ser {
  * The set of seals this version supports preserving. If support for any new
  * seals is needed, add it here and bump version.
  */
-#define MEMFD_LUO_ALL_SEALS (F_SEAL_SEAL | \
+#define SHMEM_LUO_ALL_SEALS (F_SEAL_SEAL | \
 			     F_SEAL_SHRINK | \
 			     F_SEAL_GROW | \
 			     F_SEAL_WRITE | \
@@ -68,7 +69,7 @@ struct memfd_luo_folio_ser {
 			     F_SEAL_EXEC)
 
 /**
- * struct memfd_luo_ser - Main serialization structure for a memfd.
+ * struct shmem_luo_ser - Main serialization structure for a memfd.
  * @pos:       The file's current position (f_pos).
  * @size:      The total size of the file in bytes (i_size).
  * @seals:     The seals present on the memfd. The seals are uABI so it is safe
@@ -76,9 +77,9 @@ struct memfd_luo_folio_ser {
  * @flags:     Flags for the file. Unused flag bits must be set to 0.
  * @nr_folios: Number of folios in the folios array.
  * @folios:    KHO vmalloc descriptor pointing to the array of
- *             struct memfd_luo_folio_ser.
+ *             struct shmem_luo_folio_ser.
  */
-struct memfd_luo_ser {
+struct shmem_luo_ser {
 	u64 pos;
 	u64 size;
 	u32 seals;
@@ -87,7 +88,7 @@ struct memfd_luo_ser {
 	struct kho_vmalloc folios;
 } __packed;
 
-/* The compatibility string for memfd file handler */
-#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
+/* The compatibility string for the shmem file handler */
+#define SHMEM_LUO_FH_COMPATIBLE	"memfd-v2"
 
-#endif /* _LINUX_KHO_ABI_MEMFD_H */
+#endif /* _LINUX_KHO_ABI_SHMEM_H */
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index f50daee8eff0..9a1c49e2e0c4 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -69,7 +69,7 @@ config LIVEUPDATE
 
 	  If unsure, say N.
 
-config LIVEUPDATE_MEMFD
+config LIVEUPDATE_SHMEM
 	bool "Live update support for memfd"
 	depends on LIVEUPDATE
 	depends on MEMFD_CREATE
diff --git a/mm/Makefile b/mm/Makefile
index e7245cb88c66..cbdcc2c6b296 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -100,7 +100,7 @@ obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
-obj-$(CONFIG_LIVEUPDATE_MEMFD) += memfd_luo.o
+obj-$(CONFIG_LIVEUPDATE_SHMEM) += shmem_luo.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 ifdef CONFIG_BPF_SYSCALL
diff --git a/mm/memfd_luo.c b/mm/shmem_luo.c
similarity index 81%
rename from mm/memfd_luo.c
rename to mm/shmem_luo.c
index 6b68220275eb..b8d86055912d 100644
--- a/mm/memfd_luo.c
+++ b/mm/shmem_luo.c
@@ -18,6 +18,11 @@
  * Update Orchestrator (LUO) file preservation. This allows userspace to
  * transfer its memory contents to the next kernel after a kexec.
  *
+ * Here, a memfd is a memfd created without ``MFD_HUGETLB``, which is a shmem
+ * file on the kernel's internal shmem mount. Memfds created with
+ * ``MFD_HUGETLB`` are hugetlbfs files, which this file handler doesn't
+ * preserve. Preserving them fails with ``-ENOENT``.
+ *
  * The preservation is not intended to be transparent. Only select properties of
  * the file are preserved. All others are reset to default. The preserved
  * properties are described below.
@@ -26,10 +31,6 @@
  *    The LUO API is not stabilized yet, so the preserved properties of a memfd
  *    are also not stable and are subject to backwards incompatible changes.
  *
- * .. note::
- *    Currently a memfd backed by Hugetlb is not supported. Memfds created
- *    with ``MFD_HUGETLB`` will be rejected.
- *
  * Preserved Properties
  * ====================
  *
@@ -52,7 +53,7 @@
  *
  * Seals
  *   File seals set on the memfd are preserved and re-applied on restore.
- *   Only seals known to this LUO version (see ``MEMFD_LUO_ALL_SEALS``) may
+ *   Only seals known to this LUO version (see ``SHMEM_LUO_ALL_SEALS``) may
  *   be present; preservation fails with ``-EOPNOTSUPP`` otherwise.
  *
  * Non-Preserved Properties
@@ -75,7 +76,7 @@
 #include <linux/file.h>
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
-#include <linux/kho/abi/memfd.h>
+#include <linux/kho/abi/shmem.h>
 #include <linux/liveupdate.h>
 #include <linux/shmem_fs.h>
 #include <linux/vmalloc.h>
@@ -84,13 +85,13 @@
 
 #include "internal.h"
 
-static int memfd_luo_preserve_folios(struct file *file,
+static int shmem_luo_preserve_folios(struct file *file,
 				     struct kho_vmalloc *kho_vmalloc,
-				     struct memfd_luo_folio_ser **out_folios_ser,
+				     struct shmem_luo_folio_ser **out_folios_ser,
 				     u64 *nr_foliosp)
 {
 	struct inode *inode = file_inode(file);
-	struct memfd_luo_folio_ser *folios_ser;
+	struct shmem_luo_folio_ser *folios_ser;
 	unsigned int max_folios;
 	long i, size, nr_pinned;
 	struct folio **folios;
@@ -145,7 +146,7 @@ static int memfd_luo_preserve_folios(struct file *file,
 	}
 
 	for (i = 0; i < nr_folios; i++) {
-		struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		struct shmem_luo_folio_ser *pfolio = &folios_ser[i];
 		struct folio *folio = folios[i];
 
 		err = kho_preserve_folio(folio);
@@ -196,7 +197,7 @@ static int memfd_luo_preserve_folios(struct file *file,
 		folio_unlock(folio);
 
 		pfolio->pfn = folio_pfn(folio);
-		pfolio->flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
+		pfolio->flags = SHMEM_LUO_FOLIO_DIRTY | SHMEM_LUO_FOLIO_UPTODATE;
 		pfolio->index = folio->index;
 	}
 
@@ -227,8 +228,8 @@ static int memfd_luo_preserve_folios(struct file *file,
 	return err;
 }
 
-static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
-					struct memfd_luo_folio_ser *folios_ser,
+static void shmem_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
+					struct shmem_luo_folio_ser *folios_ser,
 					u64 nr_folios)
 {
 	long i;
@@ -239,7 +240,7 @@ static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 	kho_unpreserve_vmalloc(kho_vmalloc);
 
 	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		const struct shmem_luo_folio_ser *pfolio = &folios_ser[i];
 		struct folio *folio;
 
 		if (!pfolio->pfn)
@@ -254,11 +255,11 @@ static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 	vfree(folios_ser);
 }
 
-static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
+static int shmem_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
-	struct memfd_luo_folio_ser *folios_ser;
-	struct memfd_luo_ser *ser;
+	struct shmem_luo_folio_ser *folios_ser;
+	struct shmem_luo_ser *ser;
 	u64 nr_folios, inode_size;
 	int err = 0, seals;
 
@@ -279,7 +280,7 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	}
 
 	/* Make sure the file only has the seals supported by this version. */
-	if (seals & ~MEMFD_LUO_ALL_SEALS) {
+	if (seals & ~SHMEM_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
 		goto err_free_ser;
 	}
@@ -299,7 +300,7 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	ser->size = inode_size;
 	ser->seals = seals;
 
-	err = memfd_luo_preserve_folios(args->file, &ser->folios,
+	err = shmem_luo_preserve_folios(args->file, &ser->folios,
 					&folios_ser, &nr_folios);
 	if (err)
 		goto err_free_ser;
@@ -320,9 +321,9 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	return err;
 }
 
-static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
+static int shmem_luo_freeze(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_ser *ser;
+	struct shmem_luo_ser *ser;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
 		return -EINVAL;
@@ -338,10 +339,10 @@ static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 	return 0;
 }
 
-static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
+static void shmem_luo_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
-	struct memfd_luo_ser *ser;
+	struct shmem_luo_ser *ser;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
 		return;
@@ -351,20 +352,20 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 
 	ser = phys_to_virt(args->serialized_data);
 
-	memfd_luo_unpreserve_folios(&ser->folios, args->private_data,
+	shmem_luo_unpreserve_folios(&ser->folios, args->private_data,
 				    ser->nr_folios);
 
 	kho_unpreserve_free(ser);
 	inode_unlock(inode);
 }
 
-static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_ser,
+static void shmem_luo_discard_folios(const struct shmem_luo_folio_ser *folios_ser,
 				     u64 nr_folios)
 {
 	u64 i;
 
 	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		const struct shmem_luo_folio_ser *pfolio = &folios_ser[i];
 		struct folio *folio;
 		phys_addr_t phys;
 
@@ -383,10 +384,10 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 	}
 }
 
-static void memfd_luo_finish(struct liveupdate_file_op_args *args)
+static void shmem_luo_finish(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser;
-	struct memfd_luo_ser *ser;
+	struct shmem_luo_folio_ser *folios_ser;
+	struct shmem_luo_ser *ser;
 
 	/*
 	 * If retrieve was successful, nothing to do. If it failed, retrieve()
@@ -405,7 +406,7 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 		if (!folios_ser)
 			goto out;
 
-		memfd_luo_discard_folios(folios_ser, ser->nr_folios);
+		shmem_luo_discard_folios(folios_ser, ser->nr_folios);
 		vfree(folios_ser);
 	}
 
@@ -413,8 +414,8 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	kho_restore_free(ser);
 }
 
-static int memfd_luo_retrieve_folios(struct file *file,
-				     struct memfd_luo_folio_ser *folios_ser,
+static int shmem_luo_retrieve_folios(struct file *file,
+				     struct shmem_luo_folio_ser *folios_ser,
 				     u64 nr_folios)
 {
 	struct inode *inode = file_inode(file);
@@ -425,7 +426,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 	long i;
 
 	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		const struct shmem_luo_folio_ser *pfolio = &folios_ser[i];
 		phys_addr_t phys;
 		u64 index;
 		int flags;
@@ -463,9 +464,9 @@ static int memfd_luo_retrieve_folios(struct file *file,
 			goto unlock_folio;
 		}
 
-		if (flags & MEMFD_LUO_FOLIO_UPTODATE)
+		if (flags & SHMEM_LUO_FOLIO_UPTODATE)
 			folio_mark_uptodate(folio);
-		if (flags & MEMFD_LUO_FOLIO_DIRTY)
+		if (flags & SHMEM_LUO_FOLIO_DIRTY)
 			folio_mark_dirty(folio);
 
 		npages = folio_nr_pages(folio);
@@ -497,7 +498,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 	 * freed when the file is freed. Free the ones not added yet here.
 	 */
 	for (long j = i + 1; j < nr_folios; j++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[j];
+		const struct shmem_luo_folio_ser *pfolio = &folios_ser[j];
 		phys_addr_t phys;
 
 		if (!pfolio->pfn)
@@ -514,10 +515,10 @@ static int memfd_luo_retrieve_folios(struct file *file,
 	return err;
 }
 
-static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
+static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser;
-	struct memfd_luo_ser *ser;
+	struct shmem_luo_folio_ser *folios_ser;
+	struct shmem_luo_ser *ser;
 	struct file *file;
 	int err;
 
@@ -526,7 +527,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 		return -EINVAL;
 
 	/* Make sure the file only has seals supported by this version. */
-	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
+	if (ser->seals & ~SHMEM_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
 		goto free_ser;
 	}
@@ -558,7 +559,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 			goto put_file;
 		}
 
-		err = memfd_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
+		err = shmem_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
 		vfree(folios_ser);
 		if (err)
 			goto put_file;
@@ -576,7 +577,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	return err;
 }
 
-static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
+static bool shmem_luo_can_preserve(struct liveupdate_file_handler *handler,
 				   struct file *file)
 {
 	struct inode *inode = file_inode(file);
@@ -584,30 +585,30 @@ static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
 	return shmem_file(file) && !inode->i_nlink;
 }
 
-static unsigned long memfd_luo_get_id(struct file *file)
+static unsigned long shmem_luo_get_id(struct file *file)
 {
 	return (unsigned long)file_inode(file);
 }
 
-static const struct liveupdate_file_ops memfd_luo_file_ops = {
-	.freeze = memfd_luo_freeze,
-	.finish = memfd_luo_finish,
-	.retrieve = memfd_luo_retrieve,
-	.preserve = memfd_luo_preserve,
-	.unpreserve = memfd_luo_unpreserve,
-	.can_preserve = memfd_luo_can_preserve,
-	.get_id = memfd_luo_get_id,
+static const struct liveupdate_file_ops shmem_luo_file_ops = {
+	.freeze = shmem_luo_freeze,
+	.finish = shmem_luo_finish,
+	.retrieve = shmem_luo_retrieve,
+	.preserve = shmem_luo_preserve,
+	.unpreserve = shmem_luo_unpreserve,
+	.can_preserve = shmem_luo_can_preserve,
+	.get_id = shmem_luo_get_id,
 	.owner = THIS_MODULE,
 };
 
-static struct liveupdate_file_handler memfd_luo_handler = {
-	.ops = &memfd_luo_file_ops,
-	.compatible = MEMFD_LUO_FH_COMPATIBLE,
+static struct liveupdate_file_handler shmem_luo_handler = {
+	.ops = &shmem_luo_file_ops,
+	.compatible = SHMEM_LUO_FH_COMPATIBLE,
 };
 
-static int __init memfd_luo_init(void)
+static int __init shmem_luo_init(void)
 {
-	int err = liveupdate_register_file_handler(&memfd_luo_handler);
+	int err = liveupdate_register_file_handler(&shmem_luo_handler);
 
 	if (err && err != -EOPNOTSUPP) {
 		pr_err("Could not register luo filesystem handler: %pe\n",
@@ -618,4 +619,4 @@ static int __init memfd_luo_init(void)
 
 	return 0;
 }
-late_initcall(memfd_luo_init);
+late_initcall(shmem_luo_init);
-- 
2.56.0.257.gf7497c7d27-goog


