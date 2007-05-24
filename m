Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HrCGc-0007fa-Bn
	for kexec@lists.infradead.org; Thu, 24 May 2007 08:18:08 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4OBFpwR019670
	for <kexec@lists.infradead.org>; Thu, 24 May 2007 07:15:51 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4OCHwrq497738
	for <kexec@lists.infradead.org>; Thu, 24 May 2007 08:17:58 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4OCHvGO009452
	for <kexec@lists.infradead.org>; Thu, 24 May 2007 08:17:58 -0400
Date: Thu, 24 May 2007 17:47:51 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [Patch 2/2] Kexec/Kdump support - POWER6
Message-ID: <20070524121751.GB4547@in.ibm.com>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18004.7556.311264.415721@cargo.ozlabs.ibm.com>
Reply-To: mohan@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Paul Mackerras <paulus@samba.org>
Cc: Milton Miller II <miltonm@us.ibm.com>, kexec@lists.infradead.org, linuxppc-dev@ozlabs.org, sachinp@in.ibm.com, Olof Johansson <olof@lixom.net>, ellerman@au1.ibm.com

On Wed, May 23, 2007 at 08:55:00PM +1000, Paul Mackerras wrote:
> Sachin P. Sant writes:
> 
> > On Power machines supporting VRMA, Kexec/Kdump does not work.
> > Hypervisor stores VRMA mapping used by the OS, in the hpte hash
> > tables. Make sure these hpte entries are left untouched.
> 
> Surely all we need to do is to avoid clearing the VRMA entries.  We
> can do this by not clearing any HPTE where the top 40 bits of the
> first dword are 0x4001ffffff (B=1 for a 1TB segment and the
> 0x0001ffffff special VSID).  In fact we can avoid having to read each
> entry by doing the H_REMOVEs with H_ANDCOND and the bolted bit when we
> clear the hash table, and only reading the HPTEs for which the
> H_REMOVE returns an error.
>

Paul,

Thanks for your suggestion.

But we can not use 0x4001fffff for H_ANDCOND flag since AND'ing
0x4001ffff value with most of the HPTEs results in non-zero and most of
the HPTE entries are not removed.

From POWER ISA 2.04 document page 425,
"Programming Note:
Software should specify PTE(B) = 0b01 for all Page
Table Entries that map the VRMA in order to be
consistent with the values in Figure 14."

So I tried 0x4000000000000000 as AVPN parameter and using that it
removes all hpte entries other than VRMA(ie non 1TB segment size PTE
entries).

Tested on POWER6/POWER5 machines.

========================
Starting from POWER5+, hypervisor stores VRMA entries in the HPTE tables
and these entries are need by OS and they should not be cleared. These
VRMA entries will be of segment size 1TB. Using H_ANDCOND flag for
H_REMOVE hypervisor call it is made sure that we will not remove any PTE
whose size is 1TB(ie VRMA entries)

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.21.1/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-2.6.21.1.orig/arch/powerpc/platforms/pseries/lpar.c
+++ linux-2.6.21.1/arch/powerpc/platforms/pseries/lpar.c
@@ -369,6 +369,8 @@ static long pSeries_lpar_hpte_remove(uns
 	return -1;
 }
 
+#define VRMA_HPTE_B_1TB ASM_CONST(0x4000000000000000)
+
 static void pSeries_lpar_hptab_clear(void)
 {
 	unsigned long size_bytes = 1UL << ppc64_pft_size;
@@ -378,7 +380,9 @@ static void pSeries_lpar_hptab_clear(voi
 
 	/* TODO: Use bulk call */
 	for (i = 0; i < hpte_count; i++)
-		plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
+		/* dont remove HPTEs of segments size 1TB (VRMA entries) */
+		plpar_pte_remove_raw(H_ANDCOND, i, VRMA_HPTE_B_1TB,
+						&dummy1, &dummy2);
 }
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
