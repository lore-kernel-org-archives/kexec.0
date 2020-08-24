Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kA9pJ-0001fm-O6
 for kexec@lists.infradead.org; Mon, 24 Aug 2020 10:35:50 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v2 7/7][next] scripts/gdb: support printk finalized records
Date: Mon, 24 Aug 2020 12:41:38 +0206
Message-Id: <20200824103538.31446-8-john.ogness@linutronix.de>
In-Reply-To: <20200824103538.31446-1-john.ogness@linutronix.de>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

With commit ("printk: ringbuffer: add finalization/extension support")
a new state bit for finalized records was added. This not only changed
the bit representation of committed records, but also reduced the size
for record IDs.

Update the gdb scripts to correctly interpret the state variable.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Documentation/admin-guide/kdump/gdbmacros.txt | 10 +++++++---
 scripts/gdb/linux/dmesg.py                    | 10 ++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kdump/gdbmacros.txt b/Documentation/admin-guide/kdump/gdbmacros.txt
index 6025534c6c14..1ccc811c82ad 100644
--- a/Documentation/admin-guide/kdump/gdbmacros.txt
+++ b/Documentation/admin-guide/kdump/gdbmacros.txt
@@ -295,8 +295,11 @@ document dump_record
 end
 
 define dmesg
-	set var $desc_committed = 1UL << ((sizeof(long) * 8) - 1)
-	set var $flags_mask = 3UL << ((sizeof(long) * 8) - 2)
+	# definitions from kernel/printk/printk_ringbuffer.h
+	set var $desc_commit = 1UL << ((sizeof(long) * 8) - 1)
+	set var $desc_final = 1UL << ((sizeof(long) * 8) - 2)
+	set var $desc_reuse = 1UL << ((sizeof(long) * 8) - 3)
+	set var $flags_mask = $desc_commit | $desc_final | $desc_reuse
 	set var $id_mask = ~$flags_mask
 
 	set var $desc_count = 1U << prb->desc_ring.count_bits
@@ -309,7 +312,8 @@ define dmesg
 		set var $desc = &prb->desc_ring.descs[$id % $desc_count]
 
 		# skip non-committed record
-		if (($desc->state_var.counter & $flags_mask) == $desc_committed)
+		# (note that commit+!final records will be displayed)
+		if (($desc->state_var.counter & $desc_commit) == $desc_commit)
 			dump_record $desc $prev_flags
 			set var $prev_flags = $desc->info.flags
 		end
diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
index 6c6022012ea8..367523c5c270 100644
--- a/scripts/gdb/linux/dmesg.py
+++ b/scripts/gdb/linux/dmesg.py
@@ -79,9 +79,10 @@ class LxDmesg(gdb.Command):
 
         # definitions from kernel/printk/printk_ringbuffer.h
         desc_sv_bits = utils.get_long_type().sizeof * 8
-        desc_committed_mask = 1 << (desc_sv_bits - 1)
-        desc_reuse_mask = 1 << (desc_sv_bits - 2)
-        desc_flags_mask = desc_committed_mask | desc_reuse_mask
+        desc_commit_mask = 1 << (desc_sv_bits - 1)
+        desc_final_mask = 1 << (desc_sv_bits - 2)
+        desc_reuse_mask = 1 << (desc_sv_bits - 3)
+        desc_flags_mask = desc_commit_mask | desc_final_mask | desc_reuse_mask
         desc_id_mask = ~desc_flags_mask
 
         # read in tail and head descriptor ids
@@ -96,8 +97,9 @@ class LxDmesg(gdb.Command):
             desc_off = desc_sz * ind
 
             # skip non-committed record
+            # (note that commit+!final records will be displayed)
             state = utils.read_u64(descs, desc_off + sv_off + counter_off) & desc_flags_mask
-            if state != desc_committed_mask:
+            if state & desc_commit_mask != desc_commit_mask:
                 if did == head_id:
                     break
                 did = (did + 1) & desc_id_mask
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
