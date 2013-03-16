Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmJl-0005Dk-U5
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:30:26 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 9A4033EE0C7
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:22 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id DB91545DE63
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:21 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 703D845DE60
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:21 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 57213E08008
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:21 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E9AF61DB804E
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:20 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 04/21] vmcore,
 sysfs: export ELF note segment size instead of vmcoreinfo data size
Date: Sat, 16 Mar 2013 13:01:10 +0900
Message-ID: <20130316040109.15064.41863.stgit@localhost6.localdomain6>
In-Reply-To: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
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
Cc: zhangyanfei@cn.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Currently, vmcoreinfo exports data part only, but kexec-tool sets it
in p_memsz member as a whole ELF note segment size. Due to this, it
would be no problem on the current ELF note segment size, but if it
grows in the future, then read possibly doesn't reach ELF note header
in larger p_memsz position, failing to read a whole ELF segment.

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
