Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjMF3-00011p-7B
 for kexec@lists.infradead.org; Thu, 02 Mar 2017 08:37:42 +0000
Received: by mail-pf0-f175.google.com with SMTP id w189so19983138pfb.0
 for <kexec@lists.infradead.org>; Thu, 02 Mar 2017 00:37:20 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v3 6/7] makedumpfile: Discard process_dump_load
Date: Thu,  2 Mar 2017 14:06:51 +0530
Message-Id: <7dd6180b3997713c4fe4ce7ab7079838c5d266f4.1488443170.git.panand@redhat.com>
In-Reply-To: <cover.1488443170.git.panand@redhat.com>
References: <cover.1488443170.git.panand@redhat.com>
In-Reply-To: <cover.1488443170.git.panand@redhat.com>
References: <cover.1488443170.git.panand@redhat.com>
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
Cc: dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

From: Baoquan He <bhe@redhat.com>

Kernel commit 464920104bf7 (/proc/kcore: update physical address for
kcore ram and text) provides physical address of direct mapping kcore
program segments. So no need to calculate it specifically now. And the
old code is not correct since it calls vaddr_to_paddr() which has not
been ready at that time.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 elf_info.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index 100272f83c48..8e2437622141 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -857,22 +857,6 @@ static int exclude_segment(struct pt_load_segment **pt_loads,
 	return 0;
 }
 
-static int
-process_dump_load(struct pt_load_segment	*pls)
-{
-	unsigned long long paddr;
-
-	paddr = vaddr_to_paddr(pls->virt_start);
-	pls->phys_start  = paddr;
-	pls->phys_end    = paddr + (pls->virt_end - pls->virt_start);
-	DEBUG_MSG("process_dump_load\n");
-	DEBUG_MSG("  phys_start : %llx\n", pls->phys_start);
-	DEBUG_MSG("  phys_end   : %llx\n", pls->phys_end);
-	DEBUG_MSG("  virt_start : %llx\n", pls->virt_start);
-	DEBUG_MSG("  virt_end   : %llx\n", pls->virt_end);
-
-	return TRUE;
-}
 
 int get_kcore_dump_loads(void)
 {
@@ -917,7 +901,6 @@ int get_kcore_dump_loads(void)
 		}
 
 		pls[j] = *p;
-		process_dump_load(&pls[j]);
 		j++;
 	}
 
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
