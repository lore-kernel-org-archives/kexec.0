Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QPe96-0002IS-Lj
	for kexec@lists.infradead.org; Thu, 26 May 2011 17:14:53 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p4QHETNU017749
	for <kexec@lists.infradead.org>; Thu, 26 May 2011 22:44:29 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4QHETIS4296824
	for <kexec@lists.infradead.org>; Thu, 26 May 2011 22:44:29 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4QHESu3031526
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 03:14:29 +1000
Date: Thu, 26 May 2011 22:44:22 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: [Bugfix][Patch 3/3] Invoke vpanic inside xpanic function
Message-ID: <20110526171422.GC17988@in.ibm.com>
References: <20110526170722.GB23266@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110526170722.GB23266@in.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>


Invoke vpanic inside xpanic function

xpanic must invoke the worker routine vpanic to perform the erstwhile panic
related function. Instead it erroneously invokes xpanic (recursively) which
needs to be fixed.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 kernel/panic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.slim_kdump/kernel/panic.c
===================================================================
--- linux-2.6.slim_kdump.orig/kernel/panic.c
+++ linux-2.6.slim_kdump/kernel/panic.c
@@ -70,7 +70,7 @@ NORET_TYPE void xpanic(enum panic_flags
 {
 	va_list ap;
 	va_start(ap, fmt);
-	xpanic(flags, timeout, fmt, ap);
+	vpanic(flags, timeout, fmt, ap);
 }
 EXPORT_SYMBOL(xpanic);
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
