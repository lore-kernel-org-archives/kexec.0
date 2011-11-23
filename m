Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RTCiM-0007Tl-3q
 for kexec@lists.infradead.org; Wed, 23 Nov 2011 13:18:15 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
 (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
 by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id pANDI47b004629
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 13:18:04 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pANDI4s12801876
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 13:18:04 GMT
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pANDI3Mj017156
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 06:18:04 -0700
Message-ID: <1322054283.10119.11.camel@br98xy6r>
Subject: [PATCH v2] kdump: crashk_res init check for
 /sys/kernel/kexec_crash_size
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 23 Nov 2011 14:18:03 +0100
In-Reply-To: <20111123102214.GA4914@verge.net.au>
References: <1322043068.10119.7.camel@br98xy6r>
 <20111123102214.GA4914@verge.net.au>
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
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, "Eric W.
 Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

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

In addition to that this patch also simplifies the "ret = -EINVAL"
vs. "ret = 0" logic as suggested by Simon Horman.

Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/kexec.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1131,7 +1131,7 @@ void __weak crash_free_reserved_phys_ran
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
-	unsigned long start, end;
+	unsigned long start, end, old_size;
 
 	mutex_lock(&kexec_mutex);
 
@@ -1141,11 +1141,9 @@ int crash_shrink_memory(unsigned long ne
 	}
 	start = crashk_res.start;
 	end = crashk_res.end;
-
-	if (new_size >= end - start + 1) {
-		ret = -EINVAL;
-		if (new_size == end - start + 1)
-			ret = 0;
+	old_size = (end == 0) ? 0 : end - start + 1;
+	if (new_size >= old_size) {
+		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
 	}
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
