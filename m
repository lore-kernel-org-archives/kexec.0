Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmK1-0005OT-Kz
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:30:42 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 681883EE0C3
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:38 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4E58845DE59
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:38 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 33B0D45DE4E
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:38 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 08303E38005
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:38 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A30781DB8038
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:37 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 07/21] vmcore,
 procfs: introduce a flag to distinguish objects copied in 2nd kernel
Date: Sat, 16 Mar 2013 13:01:26 +0900
Message-ID: <20130316040126.15064.67305.stgit@localhost6.localdomain6>
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
