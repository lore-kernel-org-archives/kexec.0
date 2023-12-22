Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE8CC47072
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o9+uOgigr0LF2JIP6DAfAbNvWOX8wR/Hck0npBAVjI8=; b=WRWhvWJg1Xk2Nh
	k8C3yNtQN0M5ixAbY5GMlu52YoHo7gQvxmtk62v9OeH8/8EN8a/BBAI6vUv+oo8s7UZPqbEnDuS3t
	l3nhg4DFygooLFfGaTroru3eW0+4iVXZlJF9ttum2SLwa5MBQ1UPrTk8rEL+ddKMOXcMmJJlwiBI8
	5cppuzX6w4FKqinvepXkWvAJLz5xLfQt6tmpWPKhDC8aIM9NiMDbit1CoV5YAUwdlmrEc//K8FDDp
	1cllV0ttWT7hiQxG6UJF9ZcFN6dXk3cJ0y2u/pz6sGK4YCRDmZ2Ask9ZpCa6Ev9xULONAeTry58EO
	CHGINT9DT2XmTGNkLywQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpJy-0073A9-0C;
	Fri, 22 Dec 2023 23:52:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpJu-007363-2e
	for kexec@bombadil.infradead.org;
	Fri, 22 Dec 2023 23:52:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3KH5f6CWcQidM10Z+WVYilOIAJxlUOn95N5EqJfJdQg=; b=ImaVV0fIo8cRi4+n2/3ajWNeHA
	ayuD5fIJ2KOZxvOEj/RbBmiNgfuqOwTIq9Bp2eMCbweJGL8iRinj2Vx/swIn81StoKxzfj0ReWxQq
	+anC2sUAtlVyBbGa5Ep+n64FYgl+LytkYSKQUJoK72gAS1BbocgWxfXs35hxpremtjUavER7v8VKf
	02YRr8K7pQeK4WwxnHgGUEVAKGOkzk6KmSkoX1R/eNQTO0Zpk2R9iQzUlAfsxwCnWSqF/upu+FTOA
	oMe+F8B4sS3B3A0G8ydlSayT/NMshDeOhckInr9WEkWeVehAfqYTOs6mh6EZ3LIxWHsQrSJs+QL5z
	ra0ifOqw==;
Received: from mgamail.intel.com ([192.198.163.10])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpJq-00FQML-0l
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 23:52:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703289162; x=1734825162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JV7Vomm3hL/vDYDiUsjcPKFfbqW2xkr31p+WaTWWLWA=;
  b=ILTTDU0kkE7IMO/He9Y7MHraFQs7AsqrnjLSVW0WqRicHIjHxuKEo2qX
   4pJ+IB7iXk/45HtQeZc4OI6yVTj+TnlzWZeFvtoGDTUuRF82SEYSu9i+S
   BBu7WiaEiGkV6QB2xLj8vvd2wJo8wx3XJPr2VXVqk8rPNhWiZ+he+ZloT
   SgArwun8OTa3prv3yN2Znh9zD7B8CX3+S3f716iuu3i5jq+SU08J+88id
   2lymtj2OK30imTqBm7SZv+Eg6r+vpQIvfvsG/7zdjhTcM/efJjv61fxUN
   KaOMyisMt6uLf4rVpjE2lhsNirYUpQcmt6FEfdRfskwilfFsmTWT8hCvf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="3414349"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="3414349"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="726961491"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="726961491"
Received: from jeroenke-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.35.180])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:52:21 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 387D010A4D9; Sat, 23 Dec 2023 02:52:12 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 09/16] x86/tdx: Account shared memory
Date: Sat, 23 Dec 2023 02:52:01 +0300
Message-ID: <20231222235209.32143-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_235242_785602_9BF85F3D 
X-CRM114-Status: GOOD (  15.94  )
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

The kernel will convert all shared memory back to private during kexec.
The direct mapping page tables will provide information on which memory
is shared.

It is extremely important to convert all shared memory. If a page is
missed, it will cause the second kernel to crash when it accesses it.

Keep track of the number of shared pages. This will allow for
cross-checking against the shared information in the direct mapping and
reporting if the shared bit is lost.

Include a debugfs interface that allows for the check to be performed at
any point.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 69 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 4397a6b2b04c..8a49484a2917 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/debugfs.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <asm/coco.h>
@@ -38,6 +39,13 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+static atomic_long_t nr_shared;
+
+static inline bool pte_decrypted(pte_t pte)
+{
+	return cc_mkdec(pte_val(pte)) == pte_val(pte);
+}
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __noreturn __tdx_hypercall_failed(void)
 {
@@ -821,6 +829,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
 		return -EIO;
 
+	if (enc)
+		atomic_long_sub(numpages, &nr_shared);
+	else
+		atomic_long_add(numpages, &nr_shared);
+
 	return 0;
 }
 
@@ -896,3 +909,59 @@ void __init tdx_early_init(void)
 
 	pr_info("Guest detected\n");
 }
+
+#ifdef CONFIG_DEBUG_FS
+static int tdx_shared_memory_show(struct seq_file *m, void *p)
+{
+	unsigned long addr, end;
+	unsigned long found = 0;
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		if (pte && pte_decrypted(*pte))
+			found += size / PAGE_SIZE;
+
+		addr += size;
+
+		cond_resched();
+	}
+
+	seq_printf(m, "Number of shared pages in kernel page tables:  %16lu\n",
+		   found);
+	seq_printf(m, "Number of pages accounted as shared:           %16ld\n",
+		   atomic_long_read(&nr_shared));
+	return 0;
+}
+
+static int tdx_shared_memory_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, tdx_shared_memory_show, NULL);
+}
+
+static const struct file_operations tdx_shared_memory_fops = {
+	.open           = tdx_shared_memory_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+static __init int debug_tdx_shared_memory(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return 0;
+
+	debugfs_create_file("tdx_shared_memory", 0400, arch_debugfs_dir,
+			    NULL, &tdx_shared_memory_fops);
+	return 0;
+}
+fs_initcall(debug_tdx_shared_memory);
+#endif
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
