Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTS1N-0004hz-Im
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 08:20:15 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH 1/2] Earlier initialization of dom0_mapnr
Date: Fri, 28 Mar 2014 08:18:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FAC57@BPXM01GP.gisp.nec.co.jp>
References: <20140327175508.5F86560141@nathan.suse.cz>
 <1395943576-25362-1-git-send-email-ptesarik@suse.cz>
 <1395943576-25362-2-git-send-email-ptesarik@suse.cz>
In-Reply-To: <1395943576-25362-2-git-send-email-ptesarik@suse.cz>
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
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Petr,

>Xen dumps fail, because the p2m mapping is initialized too late.
>The dependency goes like this:
>
>- Xen uses FLATMEM
>- get_mm_flatmem() uses info->dom0_mapnr to initialize mm structures
>- get_dom0_mapnr() needs p2m mappings to read from a VADDR
>- the p2m list is initialized in get_machdep_info()
>
>Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
>---
> makedumpfile.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index e91583d..d3f5237 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -3128,6 +3128,12 @@ out:
> 	if (!get_max_mapnr())
> 		return FALSE;
>
>+	if (debug_info && !get_machdep_info())
>+		return FALSE;

You have to move get_machdep_info() after cache_init()
since get_machdep_info() calls readmem() on some architectures.
Otherwise, readmem() calls cache_alloc() without the cache
initialization.


Thanks
Atsushi Kumagai

>+
>+	if (is_xen_memory() && !get_dom0_mapnr())
>+		return FALSE;
>+
> 	if (info->flag_cyclic) {
> 		if (info->bufsize_cyclic == 0) {
> 			if (!calculate_cyclic_buffer_size())
>@@ -3185,9 +3191,6 @@ out:
> 		if (info->flag_sadump)
> 			(void) sadump_virt_phys_base();
>
>-		if (!get_machdep_info())
>-			return FALSE;
>-
> 		if (info->flag_sadump) {
> 			int online_cpus;
>
>@@ -3233,9 +3236,6 @@ out:
> 			return FALSE;
> 	}
>
>-	if (is_xen_memory() && !get_dom0_mapnr())
>-		return FALSE;
>-
> 	if (!get_value_for_old_linux())
> 		return FALSE;
>
>--
>1.8.4.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
