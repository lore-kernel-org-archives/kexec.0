Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from avon.wwwdotorg.org ([2001:470:1f0f:bd7::2])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwabA-0004JV-Ff
 for kexec@lists.infradead.org; Tue, 09 Jul 2013 16:17:06 +0000
From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH REPOST] kexec: return error of machine_kexec() fails
Date: Tue,  9 Jul 2013 10:16:37 -0600
Message-Id: <1373386597-3884-1-git-send-email-swarren@wwwdotorg.org>
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: Stephen Warren <swarren@nvidia.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

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
---
 kernel/kexec.c | 2 ++
 1 file changed, 2 insertions(+)

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
1.8.1.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
