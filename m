Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KTCPM-0005mU-Ao
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 09:12:45 +0000
Subject: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock, 0)
	in kernel_kexec()
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 13 Aug 2008 17:12:40 +0800
Message-Id: <1218618760.24951.137.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, nigel@nigel.suspend2.net, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, mingo@elte.hu, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org

Fix compiling warning on xchg(&kexec_lock, 0) in kernel_kexec().

Signed-off-by: Huang Ying <ying.huang@intel.com>

---
 kernel/kexec.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1433,6 +1433,7 @@ module_init(crash_save_vmcoreinfo_init)
 int kernel_kexec(void)
 {
 	int error = 0;
+	int locked;
 
 	if (xchg(&kexec_lock, 1))
 		return -EBUSY;
@@ -1498,7 +1499,8 @@ int kernel_kexec(void)
 #endif
 
  Unlock:
-	xchg(&kexec_lock, 0);
+	locked = xchg(&kexec_lock, 0);
+	BUG_ON(!locked);
 
 	return error;
 }



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
