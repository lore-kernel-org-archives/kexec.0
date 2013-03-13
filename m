Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpWe-0006P6-U0
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:31:42 +0000
Received: by mail-pb0-f41.google.com with SMTP id um15so1259352pbc.0
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:31:39 -0700 (PDT)
Message-ID: <5140B7F3.3050001@gmail.com>
Date: Thu, 14 Mar 2013 01:31:31 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 08/13] kexec: mips: use _ALIGN* to make the logic clear
References: <5140B511.7020109@gmail.com>
In-Reply-To: <5140B511.7020109@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

By replacing all the explicit align opertion with marco _ALIGN*,
the code logic could be more clear.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/mips/crashdump-mips.c |    2 +-
 kexec/arch/mips/kexec-elf-mips.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 6f9f6c6..8e7b1c3 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -373,7 +373,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	info->backup_src_start = BACKUP_SRC_START;
 	info->backup_src_size = BACKUP_SRC_SIZE;
 	/* Create a backup region segment to store backup data*/
-	sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
+	sz = _ALIGN(BACKUP_SRC_SIZE, align);
 	tmp = xmalloc(sz);
 	memset(tmp, 0, sz);
 	info->backup_start = add_buffer(info, tmp, sz, sz, align,
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index 3e19ca2..6951247 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -34,7 +34,7 @@ static const int probe_debug = 0;
 
 #define BOOTLOADER         "kexec"
 #define MAX_COMMAND_LINE   256
-#define UPSZ(X) ((sizeof(X) + 3) & ~3)
+#define UPSZ(X) _ALIGN_UP(sizeof(X), 4)
 static char cmdline_buf[256] = "kexec ";
 
 int elf_mips_probe(const char *buf, off_t len)
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
