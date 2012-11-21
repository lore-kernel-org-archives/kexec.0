Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbGFH-0008H2-3J
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 19:46:03 +0000
Subject: [PATCH] makedumpfile: fix to exclude_unnecessary_pages_cyclic
Message-Id: <E1TbGF5-00087E-Sy@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 21 Nov 2012 13:45:51 -0600
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org


The || in exclude_unnecessary_pages_cyclic() makes makedumpfile
scan all the memmap sections, not just the ones containing the current
cyclic range.

Diffed against makedumpfile-1.5.1
---
 makedumpfile.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: makedumpfile-1.5.1/makedumpfile.c
===================================================================
--- makedumpfile-1.5.1.orig/makedumpfile.c
+++ makedumpfile-1.5.1/makedumpfile.c
@@ -4187,7 +4187,7 @@ exclude_unnecessary_pages_cyclic(void)
 			if (mmd->mem_map == NOT_MEMMAP_ADDR)
 				continue;
 
-			if (mmd->pfn_end >= info->cyclic_start_pfn || mmd->pfn_start <= info->cyclic_end_pfn) {
+			if (mmd->pfn_end >= info->cyclic_start_pfn && mmd->pfn_start <= info->cyclic_end_pfn) {
 				if (!__exclude_unnecessary_pages(mmd->mem_map,
 								 mmd->pfn_start, mmd->pfn_end))
 					return FALSE;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
