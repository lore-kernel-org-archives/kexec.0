Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UClwk-0006ra-Fz
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 07:05:59 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id DE4E53EE0C8
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:56 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7805C45DEC0
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:56 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5D50945DEB5
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:56 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 47AE4E08008
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:56 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id DD037E08003
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:55 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 11/20] vmcore: allocate per-cpu crash_notes objects on
 page-size boundary
Date: Sat, 02 Mar 2013 17:36:50 +0900
Message-ID: <20130302083649.31252.99922.stgit@localhost6.localdomain6>
In-Reply-To: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
References: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
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
To: vgoyal@redhat.com, ebiederm@xmission.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com, heiko.carstens@de.ibm.com, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

To satisfy mmap()'s page-size boundary requirement, allocate per-cpu
crash_notes objects on page-size boundary.

/proc/vmcore on the 2nd kernel checks if each note objects is
allocated on page-size boundary. If there's some object not satisfying
the page-size boundary requirement, /proc/vmcore doesn't provide
mmap() interface.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 kernel/kexec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index bddd3d7..d1f365e 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1234,7 +1234,8 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 static int __init crash_notes_memory_init(void)
 {
 	/* Allocate memory for saving cpu registers. */
-	crash_notes = alloc_percpu(note_buf_t);
+	crash_notes = __alloc_percpu(roundup(sizeof(note_buf_t), PAGE_SIZE),
+				     PAGE_SIZE);
 	if (!crash_notes) {
 		printk("Kexec: Memory allocation for saving cpu register"
 		" states failed\n");


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
