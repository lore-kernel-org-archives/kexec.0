Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGU1y-0007o8-HL
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 12:46:43 +0000
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 15 Mar 2013 12:43:53 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 09954219005F
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 12:48:12 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2FCkONc54263912
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 12:46:24 GMT
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2FCkXUJ004282
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 06:46:33 -0600
Received: from holzheu (dyn-9-152-212-104.boeblingen.de.ibm.com
 [9.152.212.104])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2FCkXsG004273
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 06:46:33 -0600
Date: Fri, 15 Mar 2013 13:46:32 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH] kexec/s390: Replace clgfi with cghi
Message-ID: <20130315134632.1177a239@holzheu>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

The clgfi instruction needs at least z9 machine level. To allow kexec-tools
compiled also with z900, this patch replaces clgfi with the older cghi
instruction.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 purgatory/arch/s390/setup-s390.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: kexec-tools-2.0.3/purgatory/arch/s390/setup-s390.S
===================================================================
--- kexec-tools-2.0.3.orig/purgatory/arch/s390/setup-s390.S
+++ kexec-tools-2.0.3/purgatory/arch/s390/setup-s390.S
@@ -16,7 +16,7 @@ purgatory_start:
 	larl	%r15,lstack_end
 	aghi	%r15,-160
 
-	clgfi	%r2,0
+	cghi	%r2,0
 	je	verify_checksums
 
 	brasl	%r14,purgatory


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
