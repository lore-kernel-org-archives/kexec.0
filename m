Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dDnIg-00016p-LI
 for kexec@lists.infradead.org; Thu, 25 May 2017 07:35:15 +0000
Received: by mail-pf0-f170.google.com with SMTP id n23so159473831pfb.2
 for <kexec@lists.infradead.org>; Thu, 25 May 2017 00:34:53 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch] Fix get_kcore_dump_loads() error case
Date: Thu, 25 May 2017 13:04:43 +0530
Message-Id: <15e94cae34dbec7ebd029f0048cf9e471915c880.1495697583.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org, piliu@redhat.com

commit f10d1e2e94c50 introduced another bug while fixing memory leak.
Use the braces with if condition.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 elf_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/elf_info.c b/elf_info.c
index 601d66e3f176..69b1719b020f 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -893,9 +893,10 @@ int get_kcore_dump_loads(void)
 		if (p->phys_start == NOT_PADDR
 				|| !is_phys_addr(p->virt_start))
 			continue;
-		if (j >= loads)
+		if (j >= loads) {
 			free(pls);
 			return FALSE;
+		}
 
 		if (j == 0) {
 			offset_pt_load_memory = p->file_offset;
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
