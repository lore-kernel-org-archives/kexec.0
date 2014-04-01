Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUus7-0002E8-2u
 for kexec@lists.infradead.org; Tue, 01 Apr 2014 09:20:44 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 1 Apr 2014 10:20:18 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9958C219005E
 for <kexec@lists.infradead.org>; Tue,  1 Apr 2014 10:20:09 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s319K3ZP1114398
 for <kexec@lists.infradead.org>; Tue, 1 Apr 2014 09:20:03 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s319KEJF018685
 for <kexec@lists.infradead.org>; Tue, 1 Apr 2014 03:20:14 -0600
Date: Tue, 1 Apr 2014 11:20:11 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Message-ID: <20140401112011.63924d6a@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971FBB75@BPXM01GP.gisp.nec.co.jp>
References: <20140325171420.6b558576@holzheu>
 <20140326.105507.429853525.d.hatayama@jp.fujitsu.com>
 <20140326185426.5e2e5fc4@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971FA0EC@BPXM01GP.gisp.nec.co.jp>
 <20140327145441.4c956989@holzheu>
 <20140328120047.24a056ea@hananiah.suse.cz>
 <20140328174622.2896296e@holzheu> <20140328175303.2ed0232a@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971FB6BA@BPXM01GP.gisp.nec.co.jp>
 <20140331123742.21beb21a@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE971FBB75@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "ptesarik@suse.cz" <ptesarik@suse.cz>

On Tue, 1 Apr 2014 05:06:33 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

[...]

> >OTOH, Michal's patch is still neded to fix non-Xen non-cyclic dumps.
> 
> Yes, the fix for create_1st_bitmap() is still necessary.
> 
> Michael, could you fix your patch ? We need to add the conditional
> check for Xen like below:
> 
> +	if (!is_xen_memory()) {
> +	       for (i = 0; i < info->num_mem_map; i++) {
> +   	            if (info->mem_map_data[i].mem_map == NOT_MEMMAP_ADDR)
> +       	                continue;
> +           	    max_pfn = MAX(max_pfn, info->mem_map_data[i].pfn_end);
> +       	}
> +       	info->max_mapnr = MIN(info->max_mapnr, max_pfn);
> +	}

Hello Atsushi and Petr,

Based on the discussion I removed the checks in exclude_xen3_user_domain()
and exclude_xen4_user_domain() and added the is_xen_memory() check
int get_mem_map().

Here the updated patch:
---
[PATCH] makedumpfile: Fix bitmap create for adjusted info->max_mapnr

If info->max_mapnr has been adjusted, for example because the dumped
system has specified the "mem=" kernel parameter, makedumpfile writes
the following error messages for Xen dumps or when the "--non-cyclic"
option has been specified:

set_bitmap: Can't read the bitmap(/tmp/kdump_bitmapBsKAUe). Invalid argument

Fix this and consider "info->max_mapnr" in the create_1st_bitmap() function.

In addition to this, do not adjust max_mapnr for Xen dumps.
For Xen info->max_mapnr gives the maximum machine PFN and the data
in mem_section describes the Dom0 kernel memory map that gets
initialized from info->dom0_mapnr. It may be substantially smaller
than info->max_mapnr.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 makedumpfile.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2868,12 +2868,14 @@ get_mem_map(void)
 	 * than is dumped. For example when "mem=" has been used for the
 	 * dumped system.
 	 */
-	for (i = 0; i < info->num_mem_map; i++) {
-		if (info->mem_map_data[i].mem_map == NOT_MEMMAP_ADDR)
-			continue;
-		max_pfn = MAX(max_pfn, info->mem_map_data[i].pfn_end);
+	if (!is_xen_memory()) {
+		for (i = 0; i < info->num_mem_map; i++) {
+			if (info->mem_map_data[i].mem_map == NOT_MEMMAP_ADDR)
+				continue;
+			max_pfn = MAX(max_pfn, info->mem_map_data[i].pfn_end);
+		}
+		info->max_mapnr = MIN(info->max_mapnr, max_pfn);
 	}
-	info->max_mapnr = MIN(info->max_mapnr, max_pfn);
 	return ret;
 }
 
@@ -4402,6 +4404,9 @@ create_1st_bitmap(void)
 
 		pfn_start = paddr_to_pfn(phys_start);
 		pfn_end   = paddr_to_pfn(phys_end);
+		if (pfn_start > info->max_mapnr)
+			continue;
+		pfn_end = MIN(pfn_end, info->max_mapnr);
 
 		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
 			set_bit_on_1st_bitmap(pfn);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
