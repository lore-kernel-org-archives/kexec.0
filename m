Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WKMxO-0004pb-SJ
 for kexec@lists.infradead.org; Mon, 03 Mar 2014 07:06:36 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile/eppic: Properly resolve structure members
Date: Mon, 3 Mar 2014 07:03:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971EFC11@BPXM01GP.gisp.nec.co.jp>
References: <20140227060220.25635.83843.stgit@aravindap>
In-Reply-To: <20140227060220.25635.83843.stgit@aravindap>
Content-Language: ja-JP
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
To: "aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>makedumpfile/eppic was not able to resolve member of the
>structure in cases such as:
>
>struct abc
>{
>	...
>	...
>	struct xyz
>	...
>}
>
>and eppic script:
>
>sample()
>{
>	struct abc *a;
>	struct xyz *x;
>
>	x->member;
>}
>
>would fail to resolve "member" of structure xyz. However
>it works if "struct abc *a;" line is removed from eppic
>script. This patch fixes this issue.
>
>Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Thanks, I'll merge this patch into makedumpfile-1.5.6.

Atsushi Kumagai

>---
> dwarf_info.c      |    2 +-
> extension_eppic.c |   17 +++++++++++------
> 2 files changed, 12 insertions(+), 7 deletions(-)
>
>diff --git a/dwarf_info.c b/dwarf_info.c
>index c5752c9..b7012b2 100644
>--- a/dwarf_info.c
>+++ b/dwarf_info.c
>@@ -1468,7 +1468,7 @@ get_die_attr_type(unsigned long long die_off, int *type_flag,
> {
> 	Dwarf_Die result;
>
>-	if (!die_attr_off)
>+	if (!die_attr_off || !die_off)
> 		return FALSE;
>
> 	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
>diff --git a/extension_eppic.c b/extension_eppic.c
>index 7e045c9..20d996d 100644
>--- a/extension_eppic.c
>+++ b/extension_eppic.c
>@@ -24,6 +24,8 @@
> #include "makedumpfile.h"
> #include "extension_eppic.h"
>
>+static int apigetctype(int, char *, type_t *);
>+
> /*
>  * Most of the functions included in this file performs similar
>  * functionality as in the applications/crash/eppic.c file part of
>@@ -183,7 +185,15 @@ drilldown(ull offset, type_t *t)
> 			goto label;
> 		case DW_TAG_structure_type:
> 			eppic_type_mkstruct(t);
>-			goto label;
>+label:
>+			eppic_type_setsize(t, GET_DIE_LENGTH(t_die_off, TRUE));
>+			eppic_type_setidx(t, (ull)t_die_off);
>+			tstr = GET_DIE_NAME(t_die_off);
>+			/* Drill down further */
>+			if (tstr)
>+				apigetctype(V_STRUCT, tstr, t);
>+			die_off = 0;
>+			break;
> 		/* Unknown TAG ? */
> 		default:
> 			die_off = t_die_off;
>@@ -191,11 +201,6 @@ drilldown(ull offset, type_t *t)
> 		}
> 	}
>
>-label:
>-	eppic_type_setsize(t, GET_DIE_LENGTH(t_die_off, TRUE));
>-	eppic_type_setidx(t, (ull)t_die_off);
>-	tstr = GET_DIE_NAME(t_die_off);
>-
> out:
> 	eppic_setupidx(t, ref, nidx, idxlst);
> 	if (fctflg)
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
