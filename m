Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f73.google.com ([209.85.213.73])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S2nDd-0006lm-V7
 for kexec@lists.infradead.org; Wed, 29 Feb 2012 17:21:39 +0000
Received: by yhpp61 with SMTP id p61so579593yhp.0
 for <kexec@lists.infradead.org>; Wed, 29 Feb 2012 09:21:35 -0800 (PST)
MIME-Version: 1.0
From: Eugene Surovegin <surovegin@google.com>
Subject: [PATCH] kdump: force page alignment for per-CPU crash notes.
Date: Wed, 29 Feb 2012 09:21:23 -0800
Message-Id: <1330536083-13098-1-git-send-email-surovegin@google.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Eugene Surovegin <surovegin@google.com>, kexec-list <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Per-CPU allocations are not guaranteed to be physically contiguous.
However, kdump kernel and user-space code assumes that per-CPU
memory, used for saving CPU registers on crash, is.
This can cause corrupted /proc/vmcore in some cases - the main
symptom being huge ELF note section.

Force page alignment for note_buf_t to ensure that this assumption holds.

Signed-off-by: Eugene Surovegin <surovegin@google.com>
CC: Eric Biederman <ebiederm@xmission.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: kexec-list <kexec@lists.infradead.org>
---
 kernel/kexec.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 7b08867..e641b5c 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1232,8 +1232,13 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 
 static int __init crash_notes_memory_init(void)
 {
-	/* Allocate memory for saving cpu registers. */
-	crash_notes = alloc_percpu(note_buf_t);
+	/* Allocate memory for saving cpu registers.
+	 * Force page alignment to avoid crossing physical page boundary -
+	 * kexec-tools and kernel /proc/vmcore handler assume these per-CPU
+	 * chunks are physically contiguous.
+	 */
+	crash_notes = (note_buf_t __percpu *)__alloc_percpu(sizeof(note_buf_t),
+							    PAGE_SIZE);
 	if (!crash_notes) {
 		printk("Kexec: Memory allocation for saving cpu register"
 		" states failed\n");
-- 
1.7.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
