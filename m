Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIu3U-0001RD-Tx
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:02:50 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 01:02:25 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 1B70F6E803A
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 01:02:18 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R62NNu63635592
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 06:02:23 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R62MOb024146
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 01:02:22 -0500
Subject: [PATCH] makedumpfile/eppic: Properly resolve structure members
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 11:32:20 +0530
Message-ID: <20140227060220.25635.83843.stgit@aravindap>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org
Cc: tachibana@mxm.nes.nec.co.jp

makedumpfile/eppic was not able to resolve member of the
structure in cases such as:

struct abc
{
	...
	...
	struct xyz
	...
}

and eppic script:

sample()
{
	struct abc *a;
	struct xyz *x;

	x->member;
}

would fail to resolve "member" of structure xyz. However
it works if "struct abc *a;" line is removed from eppic
script. This patch fixes this issue.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 dwarf_info.c      |    2 +-
 extension_eppic.c |   17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/dwarf_info.c b/dwarf_info.c
index c5752c9..b7012b2 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -1468,7 +1468,7 @@ get_die_attr_type(unsigned long long die_off, int *type_flag,
 {
 	Dwarf_Die result;
 
-	if (!die_attr_off)
+	if (!die_attr_off || !die_off)
 		return FALSE;
 
 	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
diff --git a/extension_eppic.c b/extension_eppic.c
index 7e045c9..20d996d 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -24,6 +24,8 @@
 #include "makedumpfile.h"
 #include "extension_eppic.h"
 
+static int apigetctype(int, char *, type_t *);
+
 /*
  * Most of the functions included in this file performs similar
  * functionality as in the applications/crash/eppic.c file part of
@@ -183,7 +185,15 @@ drilldown(ull offset, type_t *t)
 			goto label;
 		case DW_TAG_structure_type:
 			eppic_type_mkstruct(t);
-			goto label;
+label:
+			eppic_type_setsize(t, GET_DIE_LENGTH(t_die_off, TRUE));
+			eppic_type_setidx(t, (ull)t_die_off);
+			tstr = GET_DIE_NAME(t_die_off);
+			/* Drill down further */
+			if (tstr)
+				apigetctype(V_STRUCT, tstr, t);
+			die_off = 0;
+			break;
 		/* Unknown TAG ? */
 		default:
 			die_off = t_die_off;
@@ -191,11 +201,6 @@ drilldown(ull offset, type_t *t)
 		}
 	}
 
-label:
-	eppic_type_setsize(t, GET_DIE_LENGTH(t_die_off, TRUE));
-	eppic_type_setidx(t, (ull)t_die_off);
-	tstr = GET_DIE_NAME(t_die_off);
-
 out:
 	eppic_setupidx(t, ref, nidx, idxlst);
 	if (fctflg)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
