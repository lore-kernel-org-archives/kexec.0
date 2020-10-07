Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQ3Nm-000175-Io
 for kexec@lists.infradead.org; Wed, 07 Oct 2020 06:57:04 +0000
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 3/3] Cleanup: Remove offset_pt_load_memory
Date: Wed,  7 Oct 2020 08:56:52 +0200
Message-Id: <20201007065652.28160-4-ptesarik@suse.com>
In-Reply-To: <20201007065652.28160-1-ptesarik@suse.com>
References: <20201007065652.28160-1-ptesarik@suse.com>
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
To: Kazuhito Hagio <k-hagio-ab@nec.com>, kexec-ml <kexec@lists.infradead.org>
Cc: Petr Tesarik <ptesarik@suse.com>

After the previous commit, this variable has become write-only, so
it is clearly no longer needed.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 elf_info.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index 5ed65fc..a6624b5 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -63,7 +63,6 @@ static int			flags_memory;
  */
 static unsigned int		num_pt_loads;
 static struct pt_load_segment	*pt_loads;
-static off_t			offset_pt_load_memory;
 
 /*
  * PT_NOTE information about /proc/vmcore:
@@ -843,15 +842,6 @@ int get_kcore_dump_loads(void)
 			return FALSE;
 		}
 
-		if (j == 0) {
-			offset_pt_load_memory = p->file_offset;
-			if (offset_pt_load_memory == 0) {
-				ERRMSG("Can't get the offset of page data.\n");
-				free(pls);
-				return FALSE;
-			}
-		}
-
 		pls[j] = *p;
 		j++;
 	}
@@ -929,13 +919,6 @@ get_elf_info(int fd, char *filename)
 		if (phdr.p_type != PT_LOAD)
 			continue;
 
-		if (j == 0) {
-			offset_pt_load_memory = phdr.p_offset;
-			if (offset_pt_load_memory == 0) {
-				ERRMSG("Can't get the offset of page data.\n");
-				return FALSE;
-			}
-		}
 		if (j >= num_pt_loads)
 			return FALSE;
 		if(!dump_Elf_load(&phdr, j))
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
