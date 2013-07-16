Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz4R9-0002uc-00
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 12:33:00 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 5/7] Do not break progress messages
Date: Tue, 16 Jul 2013 14:32:07 +0200
Message-Id: <1373977929-4253-6-git-send-email-daniel.kiper@oracle.com>
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

DEBUG_MSG() displaying erase info size breaks progress messages.
Fix this by moving relevant DEBUG_MSG() to write_elf_eraseinfo().

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 makedumpfile.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b4abbe5..a3bfc80 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5045,7 +5045,6 @@ write_elf_header(struct cache_data *cd_header)
 	 * function.
 	 */
 	info->size_elf_eraseinfo = size_eraseinfo;
-	DEBUG_MSG("erase info size: %lu\n", info->size_elf_eraseinfo);
 
 	/*
 	 * Write a PT_NOTE header.
@@ -6326,6 +6325,8 @@ write_elf_eraseinfo(struct cache_data *cd_header)
 	off_t offset_eraseinfo;
 	unsigned long note_header_size, size_written, size_note;
 
+	DEBUG_MSG("erase info size: %lu\n", info->size_elf_eraseinfo);
+
 	if (!info->size_elf_eraseinfo)
 		return TRUE;
 
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
