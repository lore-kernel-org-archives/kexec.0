Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87C8EEB57D
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BhXTphQnIYm72SL0aalkq6mm2E685jBXNnUPN07T48A=; b=nQuYbmtOIEe39r
	km0DboF2DWvfoaOVipL86nomQ5jOhWUhne2j86fcWfops6cZLSYsT5hbfgnODb8LMA7bOeKSEEJTE
	zRq0s0KgycP2SMsVTXZiTC3gZFlzM8gMU0i2pbxMg/7Q3eQpghAfARQ7+ZPpJ/oXkPGXI9KiadSxC
	dyB1jcKURtDST6By7OA4YuMTvzI5JZDzas559XdydlGuKMEWYvXy5K7xmFCWjWGZWC4m1bEnr5mGb
	2kawbpTecrmlMs/9PwcEu8mCVILH4+qM7N0ncAkxCvo5KvR0qPO9nXZgPPe7mYAK3IF4jnTLsweJt
	NidMAGsVTlFmaJc+VlwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfez5-000N9s-2s;
	Mon, 11 Sep 2023 11:21:39 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfez3-000N93-0h
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 11:21:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694431297; x=1725967297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zw3TazwdjRU8wNvK9+zXRRn6LyFt0jKcjaf9En8Up90=;
  b=AJWH2tglzJdSddm09quCgpkVRavZr6ITm1VtkgdMgQSPqkzJKrIDHHN5
   R17+ydgic9zXWM2zQXrVtOM4bEPF5vRIkxYj/gEXGHcRQTBz/O69FHVHQ
   mr2evH/lkUmoLTqxmKin67GQvDPW82J/qK8svrTtWaUrvEqwv6zxJzvTI
   akQNs/uSlCNOHuxemjAbUBFpvzRoSR53M3nd/DKJAwKCd+M/0h0Gj62sy
   TbiUUdAX+6tUweiA8tKDq+W1uUyIgCPy3AI0YQpE1H6FQFHVelLVuoadF
   L4AQ2WtlXS+pIN+Toh3bPSA1C4dlLkEGN+oegqp21p940CrOZidl9LzUx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358358413"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358358413"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778356397"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778356397"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.216.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:30 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH V2 1/2] efi/unaccepted: Do not let /proc/vmcore try to access unaccepted memory
Date: Mon, 11 Sep 2023 14:21:13 +0300
Message-Id: <20230911112114.91323-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911112114.91323-1-adrian.hunter@intel.com>
References: <20230911112114.91323-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_042137_263435_264DD7CA 
X-CRM114-Status: GOOD (  12.85  )
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

Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
("mm: Add support for unaccepted memory"), whereby a virtual machine may
need to accept memory before it can be used.

Do not let /proc/vmcore try to access unaccepted memory because it can
cause the guest to fail.

For /proc/vmcore, which is read-only, this means a read or mmap of
unaccepted memory will return zeros.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/firmware/efi/unaccepted_memory.c | 20 ++++++++++++++++++++
 include/linux/mm.h                       |  7 +++++++
 2 files changed, 27 insertions(+)


Changes in V2:

          Change patch subject and commit message
          Use vmcore_cb->.pfn_is_ram() instead of changing vmcore.c


diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 853f7dc3c21d..79ba576b22e3 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -3,6 +3,7 @@
 #include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/spinlock.h>
+#include <linux/crash_dump.h>
 #include <asm/unaccepted_memory.h>
 
 /* Protects unaccepted memory bitmap */
@@ -145,3 +146,22 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 
 	return ret;
 }
+
+#ifdef CONFIG_PROC_VMCORE
+static bool unaccepted_memory_vmcore_pfn_is_ram(struct vmcore_cb *cb,
+						unsigned long pfn)
+{
+	return !pfn_is_unaccepted_memory(pfn);
+}
+
+static struct vmcore_cb vmcore_cb = {
+	.pfn_is_ram = unaccepted_memory_vmcore_pfn_is_ram,
+};
+
+static int __init unaccepted_memory_init_kdump(void)
+{
+	register_vmcore_cb(&vmcore_cb);
+	return 0;
+}
+core_initcall(unaccepted_memory_init_kdump);
+#endif /* CONFIG_PROC_VMCORE */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..86511150f1d4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4062,4 +4062,11 @@ static inline void accept_memory(phys_addr_t start, phys_addr_t end)
 
 #endif
 
+static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
+{
+	phys_addr_t paddr = pfn << PAGE_SHIFT;
+
+	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
+}
+
 #endif /* _LINUX_MM_H */
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
