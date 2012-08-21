Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T3qNw-0002qI-Mi
 for kexec@lists.infradead.org; Tue, 21 Aug 2012 15:28:53 +0000
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id B46E1A3DDE
 for <kexec@lists.infradead.org>; Tue, 21 Aug 2012 17:28:51 +0200 (CEST)
Resent-To: kexec@lists.infradead.org
Resent-Message-ID: <201208211728.51440.ptesarik@suse.cz>
Message-Id: <20120821084452.704313446@azariah.suse.cz>
Date: Tue, 21 Aug 2012 10:44:57 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [patch 6/9] Fix domain pickled_id computation for xen-3.4+
References: <20120821084451.587187471@azariah.suse.cz>
Content-Disposition: inline; filename=06-xen-pickled-domain.patch
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
Cc: Petr Tesarik <ptesarik@suse.cz>, Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>

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
 arch/x86_64.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -405,12 +405,26 @@ int get_xen_info_x86_64(void)
 {
 	int i;
 
-	/*
-	 * pickled_id == domain addr for x86_64
-	 */
-	for (i = 0; i < info->num_domain; i++) {
-		info->domain_list[i].pickled_id =
-			info->domain_list[i].domain_addr;
+	if (info->xen_crash_info.com &&
+	    (info->xen_crash_info.com->xen_major_version >= 4 ||
+	     (info->xen_crash_info.com->xen_major_version == 3 &&
+	      info->xen_crash_info.com->xen_minor_version >= 4))) {
+		/*
+		 * cf. changeset 0858f961c77a
+		 */
+		for (i = 0; i < info->num_domain; i++) {
+			info->domain_list[i].pickled_id =
+				(info->domain_list[i].domain_addr -
+				 DIRECTMAP_VIRT_START) >> PAGESHIFT();
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
