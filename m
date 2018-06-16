Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fU6YY-0005Pm-8u
 for kexec@lists.infradead.org; Sat, 16 Jun 2018 08:27:35 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 2/4 V3] Allocate pages for kdump without encryption when SME
 is enabled
Date: Sat, 16 Jun 2018 16:27:12 +0800
Message-Id: <20180616082714.32035-3-lijiang@redhat.com>
In-Reply-To: <20180616082714.32035-1-lijiang@redhat.com>
References: <20180616082714.32035-1-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com, kexec@lists.infradead.org

When SME is enabled in the first kernel, we will allocate pages
for kdump without encryption in order to be able to boot the
second kernel in the same manner as kexec, which helps to keep
the same code style.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 kernel/kexec_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 20fef1a..3c22a9b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -471,6 +471,16 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 		}
 	}
 
+	if (pages) {
+		unsigned int count, i;
+
+		pages->mapping = NULL;
+		set_page_private(pages, order);
+		count = 1 << order;
+		for (i = 0; i < count; i++)
+			SetPageReserved(pages + i);
+		arch_kexec_post_alloc_pages(page_address(pages), 1 << order, 0);
+	}
 	return pages;
 }
 
@@ -865,6 +875,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result  = -ENOMEM;
 			goto out;
 		}
+		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
 		ptr = kmap(page);
 		ptr += maddr & ~PAGE_MASK;
 		mchunk = min_t(size_t, mbytes,
@@ -882,6 +893,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result = copy_from_user(ptr, buf, uchunk);
 		kexec_flush_icache_page(page);
 		kunmap(page);
+		arch_kexec_pre_free_pages(page_address(page), 1);
 		if (result) {
 			result = -EFAULT;
 			goto out;
-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
