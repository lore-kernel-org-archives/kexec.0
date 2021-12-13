Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwkQf-009TmN-Hy
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 12:27:43 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 0/5] Avoid requesting page from DMA zone when no managed
 pages
Date: Mon, 13 Dec 2021 20:27:07 +0800
Message-Id: <20211213122712.23805-1-bhe@redhat.com>
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
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, bhe@redhat.com

Background information can be checked in cover letter of v2 RESEND POST
as below:
https://lore.kernel.org/all/20211207030750.30824-1-bhe@redhat.com/T/#u

Changelog:
v2-Resend -> v3:
 - Re-implement has_managed_dma() according to David's suggestion.
 - Add Fixes tag and cc stable.

v2->v2 RESEND:
 - John pinged to push the repost of this patchset. So fix one typo of
   suject of patch 3/5; Fix a building error caused by mix declaration in
   patch 5/5. Both of them are found by John from his testing.
 - Rewrite cover letter to add more information.

v1->v2:
 Change to check if managed DMA zone exists. If DMA zone has managed
 pages, go further to request page from DMA zone to initialize. Otherwise,
 just skip to initialize stuffs which need pages from DMA zone.
  

V2 RESEND post:
https://lore.kernel.org/all/20211207030750.30824-1-bhe@redhat.com/T/#u

v2 post:
https://lore.kernel.org/all/20210810094835.13402-1-bhe@redhat.com/T/#u

v1 post:
https://lore.kernel.org/all/20210624052010.5676-1-bhe@redhat.com/T/#u


Baoquan He (5):
  docs: kernel-parameters: Update to reflect the current default size of
    atomic pool
  dma-pool: allow user to disable atomic pool
  mm_zone: add function to check if managed dma zone exists
  dma/pool: create dma atomic pool only if dma zone has managed pages
  mm/slub: do not create dma-kmalloc if no managed pages in DMA zone

 Documentation/admin-guide/kernel-parameters.txt |  5 ++++-
 include/linux/mmzone.h                          |  9 +++++++++
 kernel/dma/pool.c                               | 11 +++++++----
 mm/page_alloc.c                                 | 15 +++++++++++++++
 mm/slab_common.c                                |  9 +++++++++
 5 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
