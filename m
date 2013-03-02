Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UClwI-0006i3-Au
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 07:05:30 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id ACA2F3EE0B5
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:28 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 872962AEA8A
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:28 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6DD8945DE5A
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:28 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 58167E08004
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:28 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0C0471DB804F
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:28 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 06/20] vmcore,
 procfs: introduce a flag to distinguish objects copied in 2nd kernel
Date: Sat, 02 Mar 2013 17:36:22 +0900
Message-ID: <20130302083622.31252.38843.stgit@localhost6.localdomain6>
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

The part of dump target memory is copied into the 2nd kernel if it
doesn't satisfy mmap()'s page-size boundary requirement. To
distinguish such copied object from usual old memory, a flag
MEM_TYPE_CURRENT_KERNEL is introduced. If this flag is set, the object
is considered being copied into buffer on the 2nd kernel.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 include/linux/proc_fs.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 8307f2f..11dd592 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -97,11 +97,17 @@ struct kcore_list {
 	int type;
 };
 
+#define MEM_TYPE_CURRENT_KERNEL 0x1
+
 struct vmcore {
 	struct list_head list;
-	unsigned long long paddr;
+	union {
+		unsigned long long paddr;
+		char *buf;
+	};
 	unsigned long long size;
 	loff_t offset;
+	unsigned int flag;
 };
 
 #ifdef CONFIG_PROC_FS


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
