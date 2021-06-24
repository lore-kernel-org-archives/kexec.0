Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwHmo-00CmYo-7H
 for kexec@lists.infradead.org; Thu, 24 Jun 2021 05:20:24 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] docs: kernel-parameters: Update to reflect the current
 default size of atomic pool
Date: Thu, 24 Jun 2021 13:20:09 +0800
Message-Id: <20210624052010.5676-2-bhe@redhat.com>
In-Reply-To: <20210624052010.5676-1-bhe@redhat.com>
References: <20210624052010.5676-1-bhe@redhat.com>
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
Cc: linux-mm@kvack.org, x86@kernel.org, rientjes@google.com, rppt@linux.ibm.com, thomas.lendacky@amd.com, brijesh.singh@amd.com, kexec@lists.infradead.org, bhe@redhat.com

Since commit 1d659236fb43("dma-pool: scale the default DMA coherent pool
size with memory capacity"), the default size of atomic pool has been
changed to take by scaling with system memory capacity. So update the
document in kerenl-parameter.txt accordingly.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..2c5017db2621 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -623,7 +623,9 @@
 
 	coherent_pool=nn[KMG]	[ARM,KNL]
 			Sets the size of memory pool for coherent, atomic dma
-			allocations, by default set to 256K.
+			allocations. Otherwise the default size will be scaled
+			with memory capacity, while clamped between 128K and
+			1 << (PAGE_SHIFT + MAX_ORDER-1).
 
 	com20020=	[HW,NET] ARCnet - COM20020 chipset
 			Format:
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
