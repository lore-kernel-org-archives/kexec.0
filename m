Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVHla-008Obf-J9
 for kexec@lists.infradead.org; Tue, 28 Sep 2021 18:23:48 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
Date: Tue, 28 Sep 2021 20:22:52 +0200
Message-Id: <20210928182258.12451-3-david@redhat.com>
In-Reply-To: <20210928182258.12451-1-david@redhat.com>
References: <20210928182258.12451-1-david@redhat.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org

Let's simplify return handling.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/xen/mmu_hvm.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index b242d1f4b426..eb61622df75b 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -21,23 +21,16 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
 		.domid = DOMID_SELF,
 		.pfn = pfn,
 	};
-	int ram;
 
 	if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
 		return -ENXIO;
 
 	switch (a.mem_type) {
 	case HVMMEM_mmio_dm:
-		ram = 0;
-		break;
-	case HVMMEM_ram_rw:
-	case HVMMEM_ram_ro:
+		return 0;
 	default:
-		ram = 1;
-		break;
+		return 1;
 	}
-
-	return ram;
 }
 #endif
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
