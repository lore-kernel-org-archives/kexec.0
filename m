Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qrs6t-0001vG-MQ
	for kexec@lists.infradead.org; Fri, 12 Aug 2011 13:49:19 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7CDn9PQ021954
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 13:49:09 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7CDn93B2490440
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 14:49:09 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7CDn8n6027853
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 07:49:08 -0600
Message-Id: <20110812134908.120804811@linux.vnet.ibm.com>
Date: Fri, 12 Aug 2011 15:48:57 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v3 8/8] kexec-tools: Allow to call verify_sha256_digest() from
	kernel
References: <20110812134849.748973593@linux.vnet.ibm.com>
Content-Disposition: inline; filename=kexec-tools-s390-kdump-entry.patch
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

For s390 we first want to check if kdump checksums are valid before we start
the kdump kernel. With this patch on s390 the purgatory entry point is
called with a parameter. If the parameter is "0", only the checksum test
is done and the result (0 = ok, 1 = invalid) is passed as return code back
to the caller (kernel). If the parameter is "1", the complete purgatory code
is executed and kdump is started.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 purgatory/arch/s390/setup-s390.S |   14 ++++++++++++++
 purgatory/purgatory.c            |   13 ++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

--- a/purgatory/arch/s390/setup-s390.S
+++ b/purgatory/arch/s390/setup-s390.S
@@ -11,12 +11,23 @@
 	.balign 16
 purgatory_start:
 #ifdef __s390x__
+	larl	%r5,gprs_save_area
+	stmg	%r6,%r15,0(%r5)
 	larl	%r15,lstack_end
 	aghi	%r15,-160
+
+	clgfi	%r2,0
+	je	verify_checksums
+
 	brasl	%r14,purgatory
 	larl	%r14,kdump_psw
 	lpswe	0(%r14)
 
+verify_checksums:
+	brasl	%r14,verify_sha256_digest
+	larl	%r5,gprs_save_area
+	lmg	%r6,%r15,0(%r5)
+	br	%r14
 	.section ".data"
 	.balign 16
 kdump_psw:
@@ -24,6 +35,9 @@ kdump_psw:
 	.quad 0x0000000000010010
 
 	.bss
+gprs_save_area:
+	.fill 80
+
 	.balign 4096
 lstack:
 	.skip 4096
--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -9,7 +9,7 @@
 struct sha256_region sha256_regions[SHA256_REGIONS] = {};
 sha256_digest_t sha256_digest = { };
 
-void verify_sha256_digest(void)
+int verify_sha256_digest(void)
 {
 	struct sha256_region *ptr, *end;
 	sha256_digest_t digest;
@@ -34,16 +34,19 @@ void verify_sha256_digest(void)
 			printf("%hhx ", sha256_digest[i]);
 		}
 		printf("\n");
-		for(;;) {
-			/* loop forever */
-		}
+		return 1;
 	}
+	return 0;
 }
 
 void purgatory(void)
 {
 	printf("I'm in purgatory\n");
 	setup_arch();
-	verify_sha256_digest();
+	if (verify_sha256_digest()) {
+		for(;;) {
+			/* loop forever */
+		}
+	}
 	post_verification_setup_arch();
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
