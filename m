Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from dakia2.marvell.com ([65.219.4.35])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R0F9h-0004DK-VG
	for kexec@lists.infradead.org; Sun, 04 Sep 2011 16:02:46 +0000
Received: from maili.marvell.com (maili.marvell.com [10.68.76.51]) by
	dakia2.marvell.com with ESMTP id m9Ds3lAlBrYiaOy9 for
	<kexec@lists.infradead.org>; Sun, 04 Sep 2011 09:02:40 -0700 (PDT)
Received: from localhost (sh4-dt.marvell.com [10.38.16.140])
	by maili.marvell.com (Postfix) with ESMTP id 467328A002
	for <kexec@lists.infradead.org>; Sun,  4 Sep 2011 09:02:40 -0700 (PDT)
From: Lei Wen <leiwen@marvell.com>
Subject: [PATCH] makedumpfile: omit those section has 0 size
Date: Sun,  4 Sep 2011 09:02:39 -0700
Message-Id: <1315152159-15362-1-git-send-email-leiwen@marvell.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

If the area reserved for the kdump is at the end of system memory, then
it would occur such case that the second sector is turly 0 size. And as
the beginnig of the second sector is already out of system memory range.
Try to access this range, would cause makedumpfile failed.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 makedumpfile.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 7d0c663..3f8d9af 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1336,6 +1336,8 @@ get_elf_info(void)
 		}
 		if (phdr.p_type != PT_LOAD)
 			continue;
+		if (phdr.p_filesz == 0)
+			continue;
 
 		if (j == 0) {
 			info->offset_load_memory = phdr.p_offset;
@@ -5756,6 +5758,8 @@ write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 
 		if (load.p_type != PT_LOAD)
 			continue;
+		if (load.p_filesz == 0)
+			continue;
 
 		off_memory= load.p_offset;
 		paddr     = load.p_paddr;
-- 
1.7.0.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
