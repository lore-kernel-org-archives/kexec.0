From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:49:22 -0300
Subject: [PATCH 28/30] panic: Unexport crash_kexec_post_notifiers
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-29-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

There is no users anymore of this variable that requires
it to be "exported" in the headers; also, it was deprecated
by the kernel parameter "panic_notifiers_level".

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 include/linux/panic.h          | 2 --
 include/linux/panic_notifier.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 34175d0188d0..d301db07a8af 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -34,8 +34,6 @@ extern int sysctl_panic_on_rcu_stall;
 extern int sysctl_max_rcu_stall_to_panic;
 extern int sysctl_panic_on_stackoverflow;
 
-extern bool crash_kexec_post_notifiers;
-
 /*
  * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
  * holds a CPU number which is executing panic() currently. A value of
diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index b5041132321d..8fda7045e2f7 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -11,7 +11,6 @@ extern struct atomic_notifier_head panic_pre_reboot_list;
 extern struct atomic_notifier_head panic_post_reboot_list;
 
 bool panic_notifiers_before_kdump(void);
-extern bool crash_kexec_post_notifiers;
 
 enum panic_notifier_val {
 	PANIC_UNUSED,
-- 
2.36.0


