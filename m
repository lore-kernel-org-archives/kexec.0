From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 27 Apr 2022 19:49:17 -0300
Subject: [PATCH 23/30] printk: kmsg_dump: Introduce helper to inform number of
 dumpers
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
Message-ID: <20220427224924.592546-24-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Currently we don't have a way to check if there are dumpers set,
except counting the list members maybe. This patch introduces a very
simple helper to provide this information, by just keeping track of
registered/unregistered kmsg dumpers. It's going to be used on the
panic path in the subsequent patch.

Notice that the spinlock guarding kmsg_dumpers list also guards
increment/decrement of the dumper's counter, but there's no need
for that when reading the counter in the panic path, since that is
an atomic path and there's no other (planned) user.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 include/linux/kmsg_dump.h |  7 +++++++
 kernel/printk/printk.c    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 906521c2329c..abea1974bff8 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -65,6 +65,8 @@ bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog,
 
 void kmsg_dump_rewind(struct kmsg_dump_iter *iter);
 
+bool kmsg_has_dumpers(void);
+
 int kmsg_dump_register(struct kmsg_dumper *dumper);
 
 int kmsg_dump_unregister(struct kmsg_dumper *dumper);
@@ -91,6 +93,11 @@ static inline void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 {
 }
 
+static inline bool kmsg_has_dumpers(void)
+{
+	return false;
+}
+
 static inline int kmsg_dump_register(struct kmsg_dumper *dumper)
 {
 	return -EINVAL;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index da03c15ecc89..e3a1c429fbbc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3399,6 +3399,18 @@ EXPORT_SYMBOL(printk_timed_ratelimit);
 
 static DEFINE_SPINLOCK(dump_list_lock);
 static LIST_HEAD(dump_list);
+static int num_dumpers;
+
+/**
+ * kmsg_has_dumpers - inform if there is any kmsg dumper registered.
+ *
+ * Returns true if there's at least one registered dumper, or false
+ * if otherwise.
+ */
+bool kmsg_has_dumpers(void)
+{
+	return num_dumpers ? true : false;
+}
 
 /**
  * kmsg_dump_register - register a kernel log dumper.
@@ -3423,6 +3435,7 @@ int kmsg_dump_register(struct kmsg_dumper *dumper)
 		dumper->registered = 1;
 		list_add_tail_rcu(&dumper->list, &dump_list);
 		err = 0;
+		num_dumpers++;
 	}
 	spin_unlock_irqrestore(&dump_list_lock, flags);
 
@@ -3447,6 +3460,7 @@ int kmsg_dump_unregister(struct kmsg_dumper *dumper)
 		dumper->registered = 0;
 		list_del_rcu(&dumper->list);
 		err = 0;
+		num_dumpers--;
 	}
 	spin_unlock_irqrestore(&dump_list_lock, flags);
 	synchronize_rcu();
-- 
2.36.0


