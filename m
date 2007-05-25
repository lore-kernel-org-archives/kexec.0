Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HrVZz-0005aV-Il
	for kexec@lists.infradead.org; Fri, 25 May 2007 04:55:25 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4P8tGeC014963
	for <kexec@lists.infradead.org>; Fri, 25 May 2007 04:55:16 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4P8tFKP558442
	for <kexec@lists.infradead.org>; Fri, 25 May 2007 04:55:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4P8tFtv032355
	for <kexec@lists.infradead.org>; Fri, 25 May 2007 04:55:15 -0400
Message-ID: <4656A488.2020507@in.ibm.com>
Date: Fri, 25 May 2007 14:25:36 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: [Patch ] Kexec/Kdump support - POWER6
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com>
	<20070524142133.GA13191@lixom.net>
In-Reply-To: <20070524142133.GA13191@lixom.net>
Content-Type: multipart/mixed; boundary="------------040701020908050800070706"
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
To: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, maneesh@in.ibm.com, Mohan Kumar M <mohan@in.ibm.com>, kexec@lists.infradead.org, Milton Miller II <miltonm@us.ibm.com>

This is a multi-part message in MIME format.
--------------040701020908050800070706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Olof Johansson wrote:
> As Paul says above, you need to check for failures and compare the VSID
> and possibly unhash it anyway in case of non-match. Otherwise if the
> kernel ever starts using 1TB segments for regular use, those pages will
> never be unhashed. I don't see your code doing that now.
>
>   
How about the following patch ?

Thanks
-Sachin

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
---



--------------040701020908050800070706
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
+++ b/arch/powerpc/platforms/pseries/lpar.c	2007-05-25 14:09:59.000000000 +0530
@@ -369,16 +369,30 @@ static long pSeries_lpar_hpte_remove(uns
 	return -1;
 }
 
+#define VRMA_HPTE_B_1TB ASM_CONST(0x4000000000000000)
+#define VRMA_MASK	ASM_CONST(0x4001ffffff)
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
+		lpar_rc = plpar_pte_remove_raw(H_ANDCOND, i, VRMA_HPTE_B_1TB,
+						&dummy1, &dummy2);
+		if (lpar_rc == H_NOT_FOUND) {
+			lpar_rc = plpar_pte_read_raw(0, i, &dword0, &dummy1);
+			if (!lpar_rc && 
+				(((dword0 >> 24) & VRMA_MASK) != VRMA_MASK))
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

--------------040701020908050800070706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------040701020908050800070706--

