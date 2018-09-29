Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g6HQ3-00069x-EN
 for kexec@lists.infradead.org; Sat, 29 Sep 2018 15:44:37 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 2/4 v8] kexec: allocate decrypted control pages for kdump in
 case SME is enabled
Date: Sat, 29 Sep 2018 23:43:31 +0800
Message-Id: <20180929154333.3116-3-lijiang@redhat.com>
In-Reply-To: <20180929154333.3116-1-lijiang@redhat.com>
References: <20180929154333.3116-1-lijiang@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

When SME is enabled in the first kernel, it needs to allocate decrypted
pages for kdump, because when it boots to the kdump kernel, these pages
won't be accessed encrypted at the initial stage, in order to boot the
kdump kernel in the same manner as originally booted.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
Changes since v7:
1. Modify comment in the code.(Suggested by Borislav)
2. Improve patch log.(Suggested by Borislav)

 kernel/kexec_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 23a83a4da38a..6353daaee7f1 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -471,6 +471,18 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 		}
 	}
 
+	if (pages) {
+		/*
+		 * For kdump, it needs to ensure that these pages are
+		 * decrypted if SME is enabled.
+		 * By the way, it is unnecessary to call the arch_
+		 * kexec_pre_free_pages(), because these pages are
+		 * reserved memory and once the crash kernel is done,
+		 * it will always remain in these memory until reboot
+		 * or unloading.
+		 */
+		arch_kexec_post_alloc_pages(page_address(pages), 1 << order, 0);
+	}
 	return pages;
 }
 
@@ -867,6 +879,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result  = -ENOMEM;
 			goto out;
 		}
+		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
 		ptr = kmap(page);
 		ptr += maddr & ~PAGE_MASK;
 		mchunk = min_t(size_t, mbytes,
@@ -884,6 +897,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result = copy_from_user(ptr, buf, uchunk);
 		kexec_flush_icache_page(page);
 		kunmap(page);
+		arch_kexec_pre_free_pages(page_address(page), 1);
 		if (result) {
 			result = -EFAULT;
 			goto out;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
