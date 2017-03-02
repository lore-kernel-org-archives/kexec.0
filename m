Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjMEq-00011W-4v
 for kexec@lists.infradead.org; Thu, 02 Mar 2017 08:37:29 +0000
Received: by mail-pf0-f172.google.com with SMTP id e66so1597475pfe.1
 for <kexec@lists.infradead.org>; Thu, 02 Mar 2017 00:37:06 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v3 1/7] show_mem_usage(): calculate page offset
 after elf load
Date: Thu,  2 Mar 2017 14:06:46 +0530
Message-Id: <0650e237037a65018e553444e9913aa96c61a901.1488443170.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

x86_64 calculated page offset from PT_LOAD headers. Therefore call
get_page_offset() after get_elf_loads()

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 makedumpfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index e69b6df9a9ee..6942047199de 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -10944,15 +10944,15 @@ int show_mem_usage(void)
 
 	info->dump_level = MAX_DUMP_LEVEL;
 
-	if (!get_page_offset())
-		return FALSE;
-
 	if (!open_files_for_creating_dumpfile())
 		return FALSE;
 
 	if (!get_elf_loads(info->fd_memory, info->name_memory))
 		return FALSE;
 
+	if (!get_page_offset())
+		return FALSE;
+
 	if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
 		return FALSE;
 
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
