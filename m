Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.40])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nj8nh-0004x0-6v
	for kexec@lists.infradead.org; Sun, 21 Feb 2010 10:12:38 +0000
From: Bernhard Walle <bernhard@bwalle.de>
Subject: [PATCH] Fix buffer overflow when writing dh->signature
Date: Sun, 21 Feb 2010 11:12:58 +0100
Message-Id: <1266747178-3536-1-git-send-email-bernhard@bwalle.de>
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
To: oomichi@mxs.nes.nec.co.jp
Cc: Bernhard Walle <bernhard@bwalle.de>, kexec@lists.infradead.org

Fix following compile warning when building with gcc 4.5 and with the
flags '-O2 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector -funwind-tables
-fasynchronous-unwind-tables -g -O2 -Wall'.

  In function 'strcpy',
      inlined from 'write_kdump_header' at makedumpfile.c:5457:8: \
      /usr/include/bits/string3.h:107:3: warning: call to \
      __builtin___strcpy_chk will always overflow destination buffer

Solution: Don't copy the terminating zero byte.

Signed-off-by: Bernhard Walle <bernhard@bwalle.de>
---
 makedumpfile.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 4fa6f50..855c718 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5454,7 +5454,7 @@ write_kdump_header(void)
 	/*
 	 * Write common header
 	 */
-	strcpy(dh->signature, KDUMP_SIGNATURE);
+	strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
 	dh->header_version = 3;
   	dh->block_size     = info->page_size;
 	dh->sub_hdr_size   = sizeof(kh) + info->size_vmcoreinfo;
-- 
1.6.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
