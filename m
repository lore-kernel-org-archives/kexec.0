Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g2bz1-00005R-8h
 for kexec@lists.infradead.org; Wed, 19 Sep 2018 12:54:34 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 1/3 v2] resource: fix an error which walks through iomem
 resources
Date: Wed, 19 Sep 2018 20:52:49 +0800
Message-Id: <20180919125251.8181-2-lijiang@redhat.com>
In-Reply-To: <20180919125251.8181-1-lijiang@redhat.com>
References: <20180919125251.8181-1-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

When we walk through iomem resources by calling walk_iomem_res_desc(),
the values of the function parameter may be modified in the while loop
of __walk_iomem_res_desc(), which will cause us to not get the desired
result in some cases.

At present, it only restores the original value of res->end, but it
doesn't restore the original value of res->flags in the while loop of
__walk_iomem _res_desc(). Whenever the find_next_iomem_res() finds a
resource and returns the result, the original values of this resource
will be modified, which might lead to an error in the next loop. For
example:

The original value of resource flags is:
 res->flags=0x80000200(initial value)

p->flags   _ 0x81000200 _                _ 0x80000200 _
          /              \              /              \
|________|_______A________|____|_....._|______B_________|..........___|
0                                                            0xffffffff
                (memory address ranges)

Note: if ((p->flags & res->flags) != res->flags) continue;

When the resource A is found, the original value of this resource flags
will be changed to 0x81000200(res->flags=0x81000200), and continue to
look for the next resource, when the loop reaches resource B, it can not
get the resource B any more(you can refer to the for loop of find_next
_iomem_res()), because the value of conditional expression will become
true and will also jump the resource B.

In fact, we should get the resource A and B when we walk through the
whole tree, but it only gets the resource A, the resource B is missed.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 kernel/resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index 30e1bc68503b..f5d9fc70a04c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -375,6 +375,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
 				 int (*func)(struct resource *, void *))
 {
 	u64 orig_end = res->end;
+	u64 orig_flags = res->flags;
 	int ret = -1;
 
 	while ((res->start < res->end) &&
@@ -385,6 +386,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
 
 		res->start = res->end + 1;
 		res->end = orig_end;
+		res->flags = orig_flags;
 	}
 
 	return ret;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
