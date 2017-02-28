Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ciaik-0006Wx-2e
 for kexec@lists.infradead.org; Tue, 28 Feb 2017 05:53:12 +0000
Received: by mail-pg0-f53.google.com with SMTP id s67so1278996pgb.3
 for <kexec@lists.infradead.org>; Mon, 27 Feb 2017 21:52:48 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v2 1/7] show_mem_usage(): calculate page offset
 after elf load
Date: Tue, 28 Feb 2017 11:22:35 +0530
Message-Id: <335a7278001dbf8dd36cce6446be594050354e43.1488260510.git.panand@redhat.com>
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
