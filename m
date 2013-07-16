Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz4R5-0002uY-B0
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 12:32:56 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 2/7] elf: Properly check buf size in get_pt_note_info()
Date: Tue, 16 Jul 2013 14:32:04 +0200
Message-Id: <1373977929-4253-3-git-send-email-daniel.kiper@oracle.com>
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

get_pt_note_info() always ignores VMCOREINFO_XEN note because
buf size must be smaller than note size including \0 char.
Usualy this condition is true but when VMCOREINFO_XEN note
is encountered it does not work due to buf size defined
as sizeof("VMCOREINFO_XEN"). This patch fixes that bug
and VMCOREINFO_XEN note living in /proc/vmcore file
could be properly detected now.

v2 - suggestions/fixes:
   - properly check buf size instead of increasing buf size
     (suggested by Andrew Cooper).

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 elf_info.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/elf_info.c b/elf_info.c
index 0c1e36a..e350b99 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -332,7 +332,7 @@ get_pt_note_info(void)
 		size_desc   = note_descsz(note);
 		offset_desc = offset + offset_note_desc(note);
 
-		if (!size_name || size_name >= sizeof(buf))
+		if (!size_name || size_name > sizeof(buf))
 			goto next_note;
 
 		if (read(fd_memory, &buf, sizeof(buf)) != sizeof(buf)) {
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
