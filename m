Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwjdB-0007L9-DG
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 01:55:46 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] kexec: return error of machine_kexec() fails
Date: Wed, 10 Jul 2013 10:54:56 +0900
Message-Id: <1373421296-6112-1-git-send-email-horms@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>

From: Stephen Warren <swarren@nvidia.com>

Prior to commit 3ab8352 "kexec jump", if machine_kexec() returned,
sys_reboot() would return -EINVAL. This patch restores this behaviour
for the non-KEXEC_JUMP case, where machine_kexec() is not expected to
return.

This situation can occur on ARM, where kexec requires disabling all but
one CPU using CPU hotplug. However, if hotplug isn't supported by the
particular HW the kernel is running on, then kexec cannot succeed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 kernel/kexec.c | 2 ++
 1 file changed, 2 insertions(+)

Andrew, could you consider picking up this patch?

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 59f7b55..bde1190 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1702,6 +1702,8 @@ int kernel_kexec(void)
 		pm_restore_console();
 		unlock_system_sleep();
 	}
+#else
+	error = -EINVAL;
 #endif
 
  Unlock:
-- 
1.8.2.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
