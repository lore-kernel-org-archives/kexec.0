Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZKeCv-0003Cr-MG
 for kexec@lists.infradead.org; Thu, 30 Jul 2015 03:08:34 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] align crash_notes allocation to make it be inside one
 physical page
Date: Thu, 30 Jul 2015 11:07:59 +0800
Message-Id: <1438225679-13052-1-git-send-email-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, tatsu@ab.jp.nec.com, lisa.mitchell@hp.com, seiji.aguchi.tr@hitachi.com, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

People reported that crash_notes in /proc/vmcore were corrupted and
this cause crash kdump failure. With code debugging and log we got
the root cause. This is because percpu variable crash_notes are
allocated in 2 vmalloc pages. As you know percpu is based on vmalloc
by default. Then vmalloc can't guarantee 2 continuous vmalloc pages
are also on 2 continuous physical pages. Then 1st kernel export the
starting addr and size, kdump kernel use the starting addr and size
to get the content of crash_notes, then 2nd part may not be in the
next neighbouring physical page as we think. That's why nhdr_ptr->n_namesz
or nhdr_ptr->n_descsz could be very huge in update_note_header_size_elf64()
and cause note header merging failure or some warnings.

In this patch change to call __alloc_percpu() to passed in the align
value which is nearest the the 2^log(sizeof(note_buf_t)). This align
value can make sure the crash_notes is allocated inside one physical
page since sizeof(note_buf_t) in all ARCHS is smaller PAGE_SIZE. But
add a WARN_ON in case it grow to be bigger than PAGE_SIZE in the future.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index a785c10..1740c42 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1620,7 +1620,16 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 static int __init crash_notes_memory_init(void)
 {
 	/* Allocate memory for saving cpu registers. */
-	crash_notes = alloc_percpu(note_buf_t);
+	size_t size, align;
+	int order;
+
+	size = sizeof(note_buf_t);
+	order = get_count_order(size);
+	align = 1<< order;
+
+	WARN_ON(size > PAGE_SIZE);
+
+	crash_notes = __alloc_percpu(size, align);
 	if (!crash_notes) {
 		pr_warn("Kexec: Memory allocation for saving cpu register states failed\n");
 		return -ENOMEM;
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
