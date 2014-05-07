Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WhuWh-0007GF-Jd
 for kexec@lists.infradead.org; Wed, 07 May 2014 05:36:20 +0000
From: Liu Hua <sdu.liu@huawei.com>
Subject: [RESEND PATCH] makedumpfile: ARM: fix bug on sparse_decode_mem_map
Date: Wed, 7 May 2014 13:28:59 +0800
Message-ID: <1399440539-31444-1-git-send-email-sdu.liu@huawei.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp, chaowang@redhat.com
Cc: wangnan0@huawei.com, kexec@lists.infradead.org, peifeiyue@huawei.com, Liu Hua <sdu.liu@huawei.com>

In sparse_decode_mem_map, makedumpfile checks whether coded_mem_map
is a vald vaddr. But coded_mem_map is not real vaddr. So this patch
checks decoded_mem_map instead.

Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 makedumpfile.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 16081a5..94515f6 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2794,13 +2794,15 @@ section_mem_map_addr(unsigned long addr)
 unsigned long
 sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long section_nr)
 {
-	if (!is_kvaddr(coded_mem_map))
-		return NOT_KV_ADDR;
+	unsigned long mem_map;
 
-	return coded_mem_map +
+	mem_map =  coded_mem_map +
 	    (SECTION_NR_TO_PFN(section_nr) * SIZE(page));
-}
 
+	if (!is_kvaddr(mem_map))
+		return NOT_KV_ADDR;
+	return mem_map;
+}
 int
 get_mm_sparsemem(void)
 {
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
