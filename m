Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zbcat-0002Tz-K4
 for kexec@lists.infradead.org; Mon, 14 Sep 2015 22:51:28 +0000
Received: by padhy16 with SMTP id hy16so155877892pad.1
 for <kexec@lists.infradead.org>; Mon, 14 Sep 2015 15:51:07 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 02/13] Use sys_ni.c instead of #ifdef to disable fork on
 CONFIG_NOMMU
Date: Mon, 14 Sep 2015 15:50:36 -0700
Message-Id: <1442271047-4908-3-git-send-email-palmer@dabbelt.com>
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

I think this change actually doesn't do anything: __NR_fork was still
being defined either way, and on my machine fork() in <unistd.h> comes
from libc.

This just moves to the standard mechanism for defining syscalls that
aren't implemented instead, which has the side-effect of no longer
having an #ifdef CONFIG_* in a user-visible header.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/asm-generic/unistd.h | 4 ----
 kernel/sys_ni.c                   | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 8da542a2874d..21689284360b 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -867,11 +867,7 @@ __SYSCALL(__NR_uselib, sys_uselib)
 __SYSCALL(__NR__sysctl, sys_sysctl)
 
 #define __NR_fork 1079
-#ifdef CONFIG_MMU
 __SYSCALL(__NR_fork, sys_fork)
-#else
-__SYSCALL(__NR_fork, sys_ni_syscall)
-#endif /* CONFIG_MMU */
 
 #undef __NR_syscalls
 #define __NR_syscalls (__NR_fork+1)
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index a02decf15583..c830f7f9e36d 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -174,6 +174,7 @@ cond_syscall(sys_setfsuid);
 cond_syscall(sys_setfsgid);
 cond_syscall(sys_capget);
 cond_syscall(sys_capset);
+cond_syscall(sys_fork);
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
-- 
2.4.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
