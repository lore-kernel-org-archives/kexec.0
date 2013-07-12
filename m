Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uxdim-00012N-LS
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 13:49:18 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 6/7] Use elf_getshdrstrndx() instead of elf_getshstrndx()
Date: Fri, 12 Jul 2013 15:48:14 +0200
Message-Id: <1373636895-31682-7-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1373636895-31682-1-git-send-email-daniel.kiper@oracle.com>
References: <1373636895-31682-1-git-send-email-daniel.kiper@oracle.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Use elf_getshdrstrndx() instead of elf_getshstrndx()
because later is marked as deprecated.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 dwarf_info.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_info.c b/dwarf_info.c
index 86cae69..3678cbe 100644
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
