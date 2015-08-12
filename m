Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZPLVa-0000Kz-UY
 for kexec@lists.infradead.org; Wed, 12 Aug 2015 02:11:15 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [Patch v3] align crash_notes allocation to make it be inside one
 physical page
Date: Wed, 12 Aug 2015 10:10:40 +0800
Message-Id: <1439345440-6752-1-git-send-email-bhe@redhat.com>
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
To: akpm@linux-foundation.org, ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com, mhuang@redhat.com, lisa.mitchell@hp.com, tatsu@ab.jp.nec.com, seiji.aguchi.tr@hitachi.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

People reported that crash_notes in /proc/vmcore were corrupted and
this cause crash kdump failure. With code debugging and log we got
the root cause. This is because percpu variable crash_notes are
allocated in 2 vmalloc pages. Currently percpu is based on vmalloc
by default. Vmalloc can't guarantee 2 continuous vmalloc pages
are also on 2 continuous physical pages. So when 1st kernel exports
the starting address and size of crash_notes through sysfs like below:

/sys/devices/system/cpu/cpux/crash_notes
/sys/devices/system/cpu/cpux/crash_notes_size

kdump kernel use them to get the content of crash_notes. However the
2nd part may not be in the next neighbouring physical page as we
expected if crash_notes are allocated accross 2 vmalloc pages. That's
why nhdr_ptr->n_namesz or nhdr_ptr->n_descsz could be very huge in
update_note_header_size_elf64() and cause note header merging failure
or some warnings.

In this patch change to call __alloc_percpu() to passed in the align
value by rounding crash_notes_size up to the nearest power of two.
This makes sure the crash_notes is allocated inside one physical page
since sizeof(note_buf_t) in all ARCHS is smaller than PAGE_SIZE.
Meanwhile add a BUILD_BUG_ON to break compile if size is bigger than
PAGE_SIZE since crash_notes definitely will be in 2 pages. That need
be avoided, and need be reported if it's unavoidable.

v1->v2:
    Minfei mentioned percpu can't take align value bigger then PAGE_SIZE.
    So limit align to be PAGE_SIZE at most.

v2->v3:
    Change code and add code comments as Andrew suggested.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 35d9e0a..293fe64 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1620,7 +1620,24 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 static int __init crash_notes_memory_init(void)
 {
 	/* Allocate memory for saving cpu registers. */
-	crash_notes = alloc_percpu(note_buf_t);
+	size_t size, align;
+
+	/* crash_notes could be allocated across 2 vmalloc pages when percpu
+	 * is vmalloc based . vmalloc doesn't guarantee 2 continuous vmalloc
+	 * pages are also on 2 continuous physical pages. In this case the
+	 * 2nd part of crash_notes in 2nd page could be lost since only the
+	 * starting address and size of crash_notes are exported through sysfs.
+	 * Here round up the size of crash_notes to the nearest power of two
+	 * and pass it to __alloc_percpu as align value. This can make sure
+	 * crash_notes is allocated inside one physical page. */
+	size = sizeof(note_buf_t);
+	align = min(roundup_pow_of_two(sizeof(note_buf_t)), PAGE_SIZE);
+
+	/* Break compile if size is bigger than PAGE_SIZE since crash_notes
+	 * definitely will be in 2 pages with that. */
+	BUILD_BUG_ON(size > PAGE_SIZE);
+
+	crash_notes = __alloc_percpu(size, align);
 	if (!crash_notes) {
 		pr_warn("Kexec: Memory allocation for saving cpu register states failed\n");
 		return -ENOMEM;
-- 
1.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
