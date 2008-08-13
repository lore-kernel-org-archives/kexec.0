Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KT4n1-0003Yh-NB
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 01:04:39 +0000
Subject: [PATCH] kexec jump: fix code size checking
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 13 Aug 2008 09:04:35 +0800
Message-Id: <1218589475.24951.59.camel@caritas-dev.intel.com>
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

Fix building issue when CONFIG_KEXEC=n. Thanks to Vivek Goyal for his
reminding.

Signed-off-by: Huang Ying <ying.huang@intel.com>

---
 include/asm-x86/kexec.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/asm-x86/kexec.h
+++ b/include/asm-x86/kexec.h
@@ -43,6 +43,9 @@
 
 #ifdef CONFIG_X86_32
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
+# ifndef CONFIG_KEXEC
+#  define kexec_control_code_size	0
+# endif
 #endif
 
 #ifndef __ASSEMBLY__



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
