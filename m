Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QPe7q-0002Eo-QE
	for kexec@lists.infradead.org; Thu, 26 May 2011 17:13:36 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p4QHDBr2017264
	for <kexec@lists.infradead.org>; Thu, 26 May 2011 22:43:11 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4QHDBxj4219034
	for <kexec@lists.infradead.org>; Thu, 26 May 2011 22:43:11 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4QHDBcd006443
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 03:13:11 +1000
Date: Thu, 26 May 2011 22:42:51 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: [Patch 2/6] x86: mce: Convert mce code to xpanic
Message-ID: <20110526171251.GB17988@in.ibm.com>
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


commit aea29c4a9324f24b5c61e7c3919a8137a53be935
Author: Andi Kleen <ak@linux.intel.com>
Date:   Fri Nov 19 18:42:02 2010 +0100

    x86: mce: Convert mce code to xpanic
    
    - Pass in the panic timeout directly instead of
    abusing global variable.
    - Disable backtraces and kexecs on machine check panics
    because they don't do anything useful.
    
    Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
 arch/x86/kernel/cpu/mcheck/mce.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: linux-2.6.slim_kdump/arch/x86/kernel/cpu/mcheck/mce.c
===================================================================
--- linux-2.6.slim_kdump.orig/arch/x86/kernel/cpu/mcheck/mce.c
+++ linux-2.6.slim_kdump/arch/x86/kernel/cpu/mcheck/mce.c
@@ -258,9 +258,8 @@ static void wait_for_panic(void)
 	local_irq_enable();
 	while (timeout-- > 0)
 		udelay(1);
-	if (panic_timeout == 0)
-		panic_timeout = mce_panic_timeout;
-	panic("Panicing machine check CPU died");
+	xpanic(PANIC_NO_KEXEC|PANIC_NO_BACKTRACE, 0,
+		"Panicing machine check CPU died");
 }
 
 static void mce_panic(char *msg, struct mce *final, char *exp)
@@ -316,9 +315,8 @@ static void mce_panic(char *msg, struct
 	if (exp)
 		pr_emerg(HW_ERR "Machine check: %s\n", exp);
 	if (!fake_panic) {
-		if (panic_timeout == 0)
-			panic_timeout = mce_panic_timeout;
-		panic(msg);
+		xpanic(PANIC_NO_KEXEC|PANIC_NO_BACKTRACE, mce_panic_timeout,
+			msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
