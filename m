Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UClw7-0006eC-Iv
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 07:05:20 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EF6A53EE0C2
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:11 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id CE54E45DE53
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:11 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9FFBB45DE50
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:11 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F0231DB8046
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:11 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 467E11DB803B
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:11 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 03/20] vmcore,
 sysfs: export ELF note segment size instead of vmcoreinfo data size
Date: Sat, 02 Mar 2013 17:36:05 +0900
Message-ID: <20130302083605.31252.26646.stgit@localhost6.localdomain6>
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

p_memsz member of program header entry with PT_NOTE type needs to have
size of the corresponding ELF note segment. Currently, vmcoreinfo
exports data part only. If vmcoreinfo reachs vmcoreinfo_max_size, then
in merge_note_headers_elf{32,64}, empty ELF note header cannot be
found or buffer overrun can happen.

Note: kexec-tools assigns PAGE_SIZE to p_memsz for other ELF note
types. Due to the above reason, the same issue occurs if actual ELF
note data exceeds (PAGE_SIZE - 2 * KEXEC_NOTE_HEAD_BYTES).

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 kernel/ksysfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 6ada93c..97d2763 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -126,7 +126,7 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 {
 	return sprintf(buf, "%lx %x\n",
 		       paddr_vmcoreinfo_note(),
-		       (unsigned int)vmcoreinfo_max_size);
+		       (unsigned int)sizeof(vmcoreinfo_note));
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
