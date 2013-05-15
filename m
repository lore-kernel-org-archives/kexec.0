Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcXfD-0002x9-PA
 for kexec@lists.infradead.org; Wed, 15 May 2013 09:06:24 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7F4873EE0C0
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 18:06:04 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6F38F45DE54
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 18:06:04 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 538B945DE4D
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 18:06:04 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4652E1DB8042
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 18:06:04 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EC5AB1DB803A
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 18:06:03 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v6 4/8] vmalloc: make find_vm_area check in range
Date: Wed, 15 May 2013 18:06:03 +0900
Message-ID: <20130515090602.28109.90142.stgit@localhost6.localdomain6>
In-Reply-To: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
References: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, zhangyanfei@cn.fujitsu.com, kosaki.motohiro@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

Currently, __find_vmap_area searches for the kernel VM area starting
at a given address. This patch changes this behavior so that it
searches for the kernel VM area to which the address belongs. This
change is needed by remap_vmalloc_range_partial to be introduced in
later patch that receives any position of kernel VM area as target
address.

This patch changes the condition (addr > va->va_start) to the
equivalent (addr >= va->va_end) by taking advantage of the fact that
each kernel VM area is non-overlapping.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 mm/vmalloc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d365724..3875fa2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -292,7 +292,7 @@ static struct vmap_area *__find_vmap_area(unsigned long addr)
 		va = rb_entry(n, struct vmap_area, rb_node);
 		if (addr < va->va_start)
 			n = n->rb_left;
-		else if (addr > va->va_start)
+		else if (addr >= va->va_end)
 			n = n->rb_right;
 		else
 			return va;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
