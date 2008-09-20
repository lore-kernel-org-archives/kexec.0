Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kgs2h-00085B-8m
	for kexec@lists.infradead.org; Sat, 20 Sep 2008 02:17:51 +0000
Message-ID: <48D45D21.7080702@sgi.com>
Date: Fri, 19 Sep 2008 19:17:05 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: [PATCH] IA64: better calculate PT_LOAD segment size
Content-Type: multipart/mixed; boundary="------------070605020501000209070409"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>, Simon Horman <horms@verge.net.au>, "Luck,
	Tony" <tony.luck@intel.com>

This is a multi-part message in MIME format.
--------------070605020501000209070409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch combines consecutive PL_LOAD segments into one.
The end address of the last PL_LOAD segment, calculated by
adding p_memsz to p_paddr & rounded up to ELF_PAGE_SIZE,
will be the end address of this loaded_segments[] entry.

This patch fixes the kdump kernel MCA problem caused by under-
allocation of memory and a "kdump broken on ALtix 350" problem
reported by Bernhard Walle.

Simon, this patch replaces my previous patch I submitted on the
underallocation issue.

Signed-off-by: Jay Lan <jlan@sgi.com>


--------------070605020501000209070409
Content-Type: text/plain;
 name="bootmem-fix.v2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootmem-fix.v2"

---
 kexec/arch/ia64/crashdump-ia64.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: kexec-tools/kexec/arch/ia64/crashdump-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2008-09-19 14:33:07.593344017 -0700
+++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2008-09-19 17:39:03.732928237 -0700
@@ -86,19 +86,20 @@ static void add_loaded_segments_info(str
                 loaded_segments[loaded_segments_num].end =
 			loaded_segments[loaded_segments_num].start;
 
+		/* Consolidate consecutive PL_LOAD segments into one.
+		 * The end addr of the last PL_LOAD segment, calculated by
+		 * adding p_memsz to p_paddr & rounded up to ELF_PAGE_SIZE,
+		 * will be the end address of this loaded_segments entry.
+		 */
 		while (i < ehdr->e_phnum) {
 			phdr = &ehdr->e_phdr[i];
 	                if (phdr->p_type != PT_LOAD)
 	                        break;
-			if (loaded_segments[loaded_segments_num].end !=
-				phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
-				break;
-			loaded_segments[loaded_segments_num].end +=
-				(phdr->p_memsz + ELF_PAGE_SIZE - 1) &
-				~(ELF_PAGE_SIZE - 1);
+			loaded_segments[loaded_segments_num].end =
+				(phdr->p_paddr + phdr->p_memsz +
+				ELF_PAGE_SIZE - 1) & ~(ELF_PAGE_SIZE - 1);
 			i++;
 		}
-
 		loaded_segments_num++;
 	}
 }

--------------070605020501000209070409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------070605020501000209070409--

