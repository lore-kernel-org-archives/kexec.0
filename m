Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-f52.google.com ([209.85.210.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TkivR-0003GG-4Y
 for kexec@lists.infradead.org; Mon, 17 Dec 2012 22:12:41 +0000
Received: by mail-da0-f52.google.com with SMTP id f10so2921750dak.11
 for <kexec@lists.infradead.org>; Mon, 17 Dec 2012 14:12:39 -0800 (PST)
From: Anders Hedlund <anders.j.hedlund@gmail.com>
Subject: [PATCH] kexec-elf-ppc: Fix crashkernel region overflow check
Date: Mon, 17 Dec 2012 23:11:48 +0100
Message-Id: <1355782308-8867-1-git-send-email-anders.j.hedlund@gmail.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org
Cc: Anders Hedlund <anders.j.hedlund@gmail.com>

Signed-off-by: Anders Hedlund <anders.j.hedlund@gmail.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 314eb1e..8e408cc 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -382,7 +382,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 			(ramdisk_base > crash_base + crash_size) ) {
 			printf("WARNING: ramdisk is above crashkernel region!\n");
 		}
-		else if (ramdisk_base + initrd_size > crash_base + crash_size) {
+		else if (ramdisk_base + ramdisk_size > crash_base + crash_size) {
 			printf("WARNING: ramdisk overflows crashkernel region!\n");
 		}
 	}
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
