Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HsdbD-0008Gn-8I
	for kexec@lists.infradead.org; Mon, 28 May 2007 12:41:20 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l4SBb1EK014594
	for <kexec@lists.infradead.org>; Mon, 28 May 2007 07:37:01 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4SBf1PS176368
	for <kexec@lists.infradead.org>; Mon, 28 May 2007 05:41:01 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4SBf199001395
	for <kexec@lists.infradead.org>; Mon, 28 May 2007 05:41:01 -0600
Message-ID: <465ABFC9.9020502@in.ibm.com>
Date: Mon, 28 May 2007 17:10:57 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: [Patch ] Kexec/Kdump support - POWER6
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com>
	<20070524142133.GA13191@lixom.net> <4656A488.2020507@in.ibm.com>
	<1180132987.19517.9.camel@localhost.localdomain>
In-Reply-To: <1180132987.19517.9.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------060003080400090808010504"
Reply-To: sachinp@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Milton Miller II <miltonm@us.ibm.com>, kexec@lists.infradead.org, linuxppc-dev@ozlabs.org

This is a multi-part message in MIME format.
--------------060003080400090808010504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> If you're going to use the B (1T segment) bit instead of the bolted bit,
> at least define a proper constant in line with the existing naming of
> the hash table constants in mmu-hash64.h. I would suggest doing the same
> with the VRMA_MASK/VALUE thing and calling it HPTE_V_VRMA_MASK or
> something similar.
>   
Well i had used them properly in my previous patches. Don't know why
i changed it in this patch :-( 

Here is the updated patch. 

>> +	}
>>  }
>>     
> In addition, I would recommend following Michael's advice and using
> using the bulk remove Hcall whenever possible.
>   
Yes will send out a separate patch to use bulk remove Hcall.

Thanks
-Sachin


Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
---





--------------060003080400090808010504
Content-Type: text/plain;
 name="kexec-kdump-support-on-POWER6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kexec-kdump-support-on-POWER6"

* On Power machines supporting VRMA, Kexec/Kdump does not work.
* Hypervisor stores VRMA mapping used by the OS, in the hpte hash tables.
* Make sure these hpte entries are left untouched.
*
* This patch also adds plpar_pte_read_raw() on the lines of
* plpar_pte_remove_raw().

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
---

diff -Naurp a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
--- a/arch/powerpc/platforms/pseries/lpar.c	2007-05-19 09:36:17.000000000 +0530
+++ b/arch/powerpc/platforms/pseries/lpar.c	2007-05-28 16:49:46.000000000 +0530
@@ -369,16 +369,30 @@ static long pSeries_lpar_hpte_remove(uns
 	return -1;
 }
 
+#define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
+#define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff)
+
 static void pSeries_lpar_hptab_clear(void)
 {
 	unsigned long size_bytes = 1UL << ppc64_pft_size;
 	unsigned long hpte_count = size_bytes >> 4;
-	unsigned long dummy1, dummy2;
+	unsigned long dummy1, dummy2, dword0;
+	long lpar_rc;
 	int i;
 
 	/* TODO: Use bulk call */
-	for (i = 0; i < hpte_count; i++)
-		plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
+	for (i = 0; i < hpte_count; i++) {
+		/* dont remove HPTEs with VRMA mappings */
+		lpar_rc = plpar_pte_remove_raw(H_ANDCOND, i, HPTE_V_1TB_SEG,
+						&dummy1, &dummy2);
+		if (lpar_rc == H_NOT_FOUND) {
+			lpar_rc = plpar_pte_read_raw(0, i, &dword0, &dummy1);
+			if (!lpar_rc && (((dword0 >> 24) & HPTE_V_VRMA_MASK) 
+				!= HPTE_V_VRMA_MASK))
+				/* Can be hpte for 1TB Seg. So remove it */
+				plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
+		}
+	}
 }
 
 /*
diff -Naurp a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h	2007-05-19 09:36:17.000000000 +0530
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h	2007-05-25 12:20:38.000000000 +0530
@@ -108,6 +108,21 @@ static inline long plpar_pte_read(unsign
 	return rc;
 }
 
+/* plpar_pte_read_raw can be called in real mode. It calls plpar_hcall_raw */
+static inline long plpar_pte_read_raw(unsigned long flags, unsigned long ptex,
+		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall_raw(H_READ, retbuf, flags, ptex);
+
+	*old_pteh_ret = retbuf[0];
+	*old_ptel_ret = retbuf[1];
+
+	return rc;
+}
+
 static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
 		unsigned long avpn)
 {

--------------060003080400090808010504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------060003080400090808010504--

