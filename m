Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46])
 by merlin.infradead.org with esmtps (Exim 4.85 #2 (Red Hat Linux))
 id 1Zbcb4-0005x9-4i
 for kexec@lists.infradead.org; Mon, 14 Sep 2015 22:51:39 +0000
Received: by padhy16 with SMTP id hy16so155880831pad.1
 for <kexec@lists.infradead.org>; Mon, 14 Sep 2015 15:51:15 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 09/13] Move bp_type_idx to kernel/event/hw_breakpoint.c
Date: Mon, 14 Sep 2015 15:50:43 -0700
Message-Id: <1442271047-4908-10-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
References: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: arnd@arndb.de, dhowells@redhat.com
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, plagnioj@jcrosoft.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, a.p.zijlstra@chello.nl, jikos@kernel.org, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

This has a "#ifdef CONFIG_*" that used to be exposed to userspace.

The names in here are so generic that I don't think it's a good idea
to expose them to userspace (or even the rest of the kernel).  Since
there's only one kernel user, it's been moved to that file.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/linux/hw_breakpoint.h | 10 ----------
 kernel/events/hw_breakpoint.c      | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/hw_breakpoint.h b/include/uapi/linux/hw_breakpoint.h
index b04000a2296a..7a6a5a7f9511 100644
--- a/include/uapi/linux/hw_breakpoint.h
+++ b/include/uapi/linux/hw_breakpoint.h
@@ -17,14 +17,4 @@ enum {
 	HW_BREAKPOINT_INVALID   = HW_BREAKPOINT_RW | HW_BREAKPOINT_X,
 };
 
-enum bp_type_idx {
-	TYPE_INST 	= 0,
-#ifdef CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
-	TYPE_DATA	= 0,
-#else
-	TYPE_DATA	= 1,
-#endif
-	TYPE_MAX
-};
-
 #endif /* _UAPI_LINUX_HW_BREAKPOINT_H */
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 92ce5f4ccc26..5ad117e0f55b 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -58,6 +58,16 @@ struct bp_cpuinfo {
 	unsigned int	flexible; /* XXX: placeholder, see fetch_this_slot() */
 };
 
+enum bp_type_idx {
+	TYPE_INST	= 0,
+#if defined(CONFIG_HAVE_MIXED_BREAKPOINTS_REGS)
+	TYPE_DATA	= 0,
+#else
+	TYPE_DATA	= 1,
+#endif
+	TYPE_MAX
+};
+
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
 static int nr_slots[TYPE_MAX];
 
-- 
2.4.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
