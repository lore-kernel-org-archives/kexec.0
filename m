Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKR0c-0001LT-2t
 for kexec@lists.infradead.org; Fri, 13 Sep 2013 10:53:56 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A2A2D3EE0B6
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:28 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 95C4E45DE51
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:28 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7F00145DE50
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:28 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7273D1DB8037
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:28 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 29D701DB8032
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:28 +0900 (JST)
Subject: [PATCH 1/2] sadump: correct buffer size for GUID EFI text
 representation
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Fri, 13 Sep 2013 19:53:27 +0900
Message-ID: <20130913105327.2332.70627.stgit@localhost6.localdomain6>
In-Reply-To: <20130913105216.2332.8060.stgit@localhost6.localdomain6>
References: <20130913105216.2332.8060.stgit@localhost6.localdomain6>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

While GUID EFI text representaion needs 36 bytes, all the buffers for
GUID EFI passed to guid_to_str() are of 33 bytes, due to which last
three characters in GUID are not displayed now.

This patch increases buffer size from 33 bytes to 36 bytes and make
GUID fully visible.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 sadump_info.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sadump_info.c b/sadump_info.c
index be6cf55..e563180 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -23,6 +23,8 @@
 #include "print_info.h"
 #include "sadump_mod.h"
 
+#define SADUMP_EFI_GUID_TEXT_REPR_LEN 36
+
 #ifdef __x86__
 
 #define KEXEC_NOTE_HEAD_BYTES roundup(sizeof(Elf32_Nhdr), 4)
@@ -427,7 +429,7 @@ read_sadump_header(char *filename)
 	unsigned long bitmap_len, dumpable_bitmap_len;
 	enum sadump_format_type flag_sadump;
 	uint32_t smram_cpu_state_size = 0;
-	char guid[33];
+	char guid[SADUMP_EFI_GUID_TEXT_REPR_LEN+1];
 
 	if ((si->sph_memory = malloc(SADUMP_DEFAULT_BLOCK_SIZE)) == NULL) {
 		ERRMSG("Can't allocate memory for partition header buffer: "
@@ -664,7 +666,7 @@ read_sadump_header_diskset(int diskid, struct sadump_diskset_info *sdi)
 {
 	struct sadump_part_header *sph = NULL;
 	unsigned long offset = 0;
-	char guid[33];
+	char guid[SADUMP_EFI_GUID_TEXT_REPR_LEN+1];
 
 	if ((sph = malloc(si->sh_memory->block_size)) == NULL) {
 		ERRMSG("Can't allocate memory for partition header buffer. "


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
