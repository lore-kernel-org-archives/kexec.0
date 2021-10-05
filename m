Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXjML-00AK4M-SN
 for kexec@lists.infradead.org; Tue, 05 Oct 2021 12:15:51 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/9] x86/xen: update xen_oldmem_pfn_is_ram() documentation
Date: Tue,  5 Oct 2021 14:14:22 +0200
Message-Id: <20211005121430.30136-2-david@redhat.com>
In-Reply-To: <20211005121430.30136-1-david@redhat.com>
References: <20211005121430.30136-1-david@redhat.com>
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
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Boris Ostrovsky <boris.ostrvsky@oracle.com>

The callback is only used for the vmcore nowadays.

Reviewed-by: Boris Ostrovsky <boris.ostrvsky@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/xen/mmu_hvm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index 57409373750f..b242d1f4b426 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -9,12 +9,9 @@
 
 #ifdef CONFIG_PROC_VMCORE
 /*
- * This function is used in two contexts:
- * - the kdump kernel has to check whether a pfn of the crashed kernel
- *   was a ballooned page. vmcore is using this function to decide
- *   whether to access a pfn of the crashed kernel.
- * - the kexec kernel has to check whether a pfn was ballooned by the
- *   previous kernel. If the pfn is ballooned, handle it properly.
+ * The kdump kernel has to check whether a pfn of the crashed kernel
+ * was a ballooned page. vmcore is using this function to decide
+ * whether to access a pfn of the crashed kernel.
  * Returns 0 if the pfn is not backed by a RAM page, the caller may
  * handle the pfn special in this case.
  */
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
