Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cqATx-0004co-Gd
 for kexec@lists.infradead.org; Tue, 21 Mar 2017 03:29:15 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 767A781129
 for <kexec@lists.infradead.org>; Tue, 21 Mar 2017 03:28:21 +0000 (UTC)
Received: from mylaptop.nay.redhat.com (unknown [10.66.131.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 759F117CF7
 for <kexec@lists.infradead.org>; Tue, 21 Mar 2017 03:28:20 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH] elf_info.c: fix memory leak in get_kcore_dump_loads()
Date: Tue, 21 Mar 2017 11:28:19 +0800
Message-Id: <1490066899-29298-1-git-send-email-piliu@redhat.com>
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
To: kexec@lists.infradead.org

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 elf_info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/elf_info.c b/elf_info.c
index d84553a..35e754b 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -893,12 +893,14 @@ int get_kcore_dump_loads(void)
 				|| !is_phys_addr(p->virt_start))
 			continue;
 		if (j >= loads)
+			free(pls)
 			return FALSE;
 
 		if (j == 0) {
 			offset_pt_load_memory = p->file_offset;
 			if (offset_pt_load_memory == 0) {
 				ERRMSG("Can't get the offset of page data.\n");
+				free(pls)
 				return FALSE;
 			}
 		}
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
