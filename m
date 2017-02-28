Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ciaix-0006XI-NV
 for kexec@lists.infradead.org; Tue, 28 Feb 2017 05:53:25 +0000
Received: by mail-pf0-f174.google.com with SMTP id w189so1015450pfb.0
 for <kexec@lists.infradead.org>; Mon, 27 Feb 2017 21:53:02 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v2 6/7] makedumpfile: Discard process_dump_load
Date: Tue, 28 Feb 2017 11:22:40 +0530
Message-Id: <90c87a48af7fc6b3e639b02925060934d5476ea2.1488260510.git.panand@redhat.com>
In-Reply-To: <cover.1488260510.git.panand@redhat.com>
References: <cover.1488260510.git.panand@redhat.com>
In-Reply-To: <cover.1488260510.git.panand@redhat.com>
References: <cover.1488260510.git.panand@redhat.com>
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

Pratyush has made a kernel patch [0] to add the physical address of
direct mapping kcore program segments. So no need to calculate it
specifically now. And the old code is not correct since it calls
vaddr_to_paddr() which has been not ready at that time.

[0] http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?h=next-20170206&id=c9d4e5d7b7fd6c74e134ca44df8a5386efbc561c

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
