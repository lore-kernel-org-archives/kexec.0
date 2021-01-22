Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2r5N-00021X-EK
 for kexec@lists.infradead.org; Fri, 22 Jan 2021 07:42:26 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] kernel/kexec: remove the lock operation of
 system_transition_mutex
Date: Fri, 22 Jan 2021 15:42:14 +0800
Message-Id: <20210122074214.26583-1-bhe@redhat.com>
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
To: linux-pm@vger.kernel.org
Cc: bhe@redhat.com, kexec@lists.infradead.org, kernelfans@gmail.com, dan.carpenter@oracle.com, rafael@kernel.org

Function kernel_kexec() is called with lock system_transition_mutex held
in reboot system call. While inside kernel_kexec(), it will acquire
system_transition_mutex agin. This will lead to dead lock.

The dead lock should be easily triggered, it hasn't caused any failure
report just because the feature 'kexec jump' is almost not used by anyone
as far as I know. An inquiry can be made about who is using 'kexec jump'
and where it's used. Before that, let's simply remove the lock operation
inside CONFIG_KEXEC_JUMP ifdeffery scope.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Pingfan Liu <kernelfans@gmail.com>
---
 kernel/kexec_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 80905e5aa8ae..a0b6780740c8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1134,7 +1134,6 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
-		lock_system_sleep();
 		pm_prepare_console();
 		error = freeze_processes();
 		if (error) {
@@ -1197,7 +1196,6 @@ int kernel_kexec(void)
 		thaw_processes();
  Restore_console:
 		pm_restore_console();
-		unlock_system_sleep();
 	}
 #endif
 
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
