Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat.scz.novell.com ([213.151.88.252] helo=nathan.suse.cz)
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StHdZ-0003Z4-Uo
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 12:21:24 +0000
Message-Id: <20120723113254.848020940@suse.cz>
Date: Mon, 23 Jul 2012 13:32:48 +0200
From: ptesarik@suse.cz
Subject: [PATCH 4/8] Fix domain pickled_id computation for xen-3.4+
References: <20120723113244.751777873@suse.cz>
Content-Disposition: inline; filename=makedumpfile-xen4-pickled-domain.patch
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Petr Tesarik <ptesarik@suse.cz>

Originally, Xen stored the 32-bit address of the domain structure in struct
page_info. On x86-64, the physical address was stored, but since all heap
objects were allocated in the 1:1 mapping which started at 0xffff830000000000,
the end result was the same as if we simply chopped off the high bits (actual
implementation in makedumpfile).

Then, during the development of Xen-3.4, this logic was changed several times
for x86-64:

changeset 39517e863cc8 widened the _domain field to 64 bits and stored the
        virtual address of struct domain instead of physical address
changeset beba88f6f90d removed the pickle/unpickle macros
changeset 0858f961c77a changed _domain back from unsigned long to u32,
        *and* stores the MFN of struct domain instead

All the above changes went into Xen-3.4, and the relation between a domain
address and the contents of the _domain field hasn't changed since then.
That means, when the MADDR space was compressed in Xen-4.0, the type of the
_domain field was changed to _pdx_t, which was specifically invented to
preserve its calculation from the struct domain address.

To sum it up:

1. For all Xen versions before Xen-3.4, the _domain field contains the address
   of struct domain (with high bits chopped for x86-64).
2. For all Xen versions starting with Xen-3.4, the _domain field can be
   computed from struct domain address as:
        (addr - DIRECTMAP_VIRT_START) >> PAGE_SHIFT

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/x86_64.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -402,14 +402,30 @@ int get_xen_basic_info_x86_64(void)
 
 int get_xen_info_x86_64(void)
 {
+	crash_xen_info_common_t *xen_crash_info;
 	int i;
 
-	/*
-	 * pickled_id == domain addr for x86_64
-	 */
-	for (i = 0; i < info->num_domain; i++) {
-		info->domain_list[i].pickled_id =
-			info->domain_list[i].domain_addr;
+	xen_crash_info = get_xen_crash_info(NULL);
+	if (xen_crash_info &&
+	    (xen_crash_info->xen_major_version >= 4 ||
+	     (xen_crash_info->xen_major_version == 3 &&
+	      xen_crash_info->xen_minor_version >= 4))) {
+		/*
+		 * cf. changeset 0858f961c77a
+		 */
+		for (i = 0; i < info->num_domain; i++) {
+			info->domain_list[i].pickled_id =
+				(info->domain_list[i].domain_addr
+				 - DIRECTMAP_VIRT_START) >> info->page_shift;
+		}
+	} else {
+		/*
+		 * pickled_id == domain addr for x86_64
+		 */
+		for (i = 0; i < info->num_domain; i++) {
+			info->domain_list[i].pickled_id =
+				info->domain_list[i].domain_addr;
+		}
 	}
 
 	return TRUE;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
