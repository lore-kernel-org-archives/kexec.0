Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UClwT-0006mB-Ct
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 07:05:41 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id CADA83EE0AE
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:39 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id AEF0245DE4E
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8D17E45DD78
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7788EE08002
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:39 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2F41D1DB8038
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:39 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 08/20] vmcore: modify vmcore clean-up function to free
 buffer on 2nd kernel
Date: Sat, 02 Mar 2013 17:36:33 +0900
Message-ID: <20130302083633.31252.48024.stgit@localhost6.localdomain6>
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

If flag MEM_TYPE_CURRENT_KERNEL is set, the object is copied in some
buffer on the 2nd kernel, so clean-up funciton needs to free it.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 6b071b4..e4751ce 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -926,6 +926,10 @@ void vmcore_cleanup(void)
 		struct vmcore *m;
 
 		m = list_entry(pos, struct vmcore, list);
+
+		if (m->flag & MEM_TYPE_CURRENT_KERNEL)
+			free_pages((unsigned long)m->buf, get_order(m->size));
+
 		list_del(&m->list);
 		kfree(m);
 	}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
