Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz4R9-0002ue-F3
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 12:33:01 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 7/7] Use elf_getshdrstrndx() instead of elf_getshstrndx()
Date: Tue, 16 Jul 2013 14:32:09 +0200
Message-Id: <1373977929-4253-8-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
References: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: andrew.cooper3@citrix.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Use elf_getshdrstrndx() instead of elf_getshstrndx()
because later is marked as deprecated.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 dwarf_info.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_info.c b/dwarf_info.c
index 85c116e..c5752c9 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -944,7 +944,7 @@ get_debug_info(void)
 	elfd = dwarf_info.elfd;
 	dwarfd = dwarf_info.dwarfd;
 
-	if (elf_getshstrndx(elfd, &shstrndx) < 0) {
+	if (elf_getshdrstrndx(elfd, &shstrndx) < 0) {
 		ERRMSG("Can't get the section index of the string table.\n");
 		goto out;
 	}
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
