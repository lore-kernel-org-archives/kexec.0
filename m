Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RT9nS-0001Ay-Ud
 for kexec@lists.infradead.org; Wed, 23 Nov 2011 10:11:19 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
 (d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
 by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id pANABAuR021455
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 10:11:10 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pANAB9F42539662
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 10:11:10 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain
 [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pANAB8VX027634
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 03:11:09 -0700
Message-ID: <1322043068.10119.7.camel@br98xy6r>
Subject: [PATCH] kdump: crashk_res init check for /sys/kernel/kexec_crash_size
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 23 Nov 2011 11:11:08 +0100
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: akpm@linux-foundation.org
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Currently it is possible to set the crash_size via the sysfs
/sys/kernel/kexec_crash_size even if no crash kernel memory has
been defined with the "crashkernel" parameter. In this case
"crashk_res" is not initialized and crashk_res.start = crashk_res.end = 0.
Unfortunately resource_size(&crashk_res) returns 1 in this case.
This breaks the s390 implementation of crash_(un)map_reserved_pages().

To fix the problem the correct "old_size" is now calculated in
crash_shrink_memory(). "old_size is set to "0" if crashk_res is
not initialized. With this change crash_shrink_memory() will do nothing,
when "crashk_res" is not initialized. It will return "0" for
"echo 0 > /sys/kernel/kexec_crash_size" and -EINVAL for
"echo [not zero] > /sys/kernel/kexec_crash_size".

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/kexec.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1131,7 +1131,7 @@ void __weak crash_free_reserved_phys_ran
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
-	unsigned long start, end;
+	unsigned long start, end, old_size;
 
 	mutex_lock(&kexec_mutex);
 
@@ -1141,10 +1141,10 @@ int crash_shrink_memory(unsigned long ne
 	}
 	start = crashk_res.start;
 	end = crashk_res.end;
-
-	if (new_size >= end - start + 1) {
+	old_size = (end == 0) ? 0 : end - start + 1;
+	if (new_size >= old_size) {
 		ret = -EINVAL;
-		if (new_size == end - start + 1)
+		if (new_size == old_size)
 			ret = 0;
 		goto unlock;
 	}



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
