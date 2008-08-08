Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KRLqI-0000aj-Eb
	for kexec@lists.infradead.org; Fri, 08 Aug 2008 06:52:54 +0000
Subject: [PATCH -v2 7/8] kexec jump: ftrace_enabled_save/restore
From: Huang Ying <ying.huang@intel.com>
Date: Fri, 08 Aug 2008 14:52:48 +0800
Message-Id: <1218178368.22039.80.camel@caritas-dev.intel.com>
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

Add ftrace_enabled_save/restore, used to disable ftrace for a
while. This is used by kexec jump.

Signed-off-by: Huang Ying <ying.huang@intel.com>

---
 include/linux/ftrace.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -98,6 +98,24 @@ static inline void tracer_disable(void)
 #endif
 }
 
+static inline int ftrace_enabled_save(void)
+{
+#ifdef CONFIG_FTRACE
+	int saved_ftrace_enabled = ftrace_enabled;
+	ftrace_enabled = 0;
+	return saved_ftrace_enabled;
+#else
+	return 0;
+#endif
+}
+
+static inline void ftrace_enabled_restore(int enabled)
+{
+#ifdef CONFIG_FTRACE
+	ftrace_enabled = enabled;
+#endif
+}
+
 #ifdef CONFIG_FRAME_POINTER
 /* TODO: need to fix this for ARM */
 # define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
