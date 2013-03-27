Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKpgb-0007gy-UK
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 12:42:40 +0000
Received: by mail-pb0-f47.google.com with SMTP id rp2so5250381pbb.34
 for <kexec@lists.infradead.org>; Wed, 27 Mar 2013 05:42:35 -0700 (PDT)
Message-ID: <5152E934.6000602@gmail.com>
Date: Wed, 27 Mar 2013 20:42:28 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] Revert: "kexec: lengthen the kernel command line image"
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Cliff Wickman <cpw@sgi.com>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

This reverts commit 49320340f705694e387d794f7f19d407ad9baefa. The change
of COMMAND_LINE_SIZE cannot solve Cliff's problem since the kernel side
has the restriction, so it is useless. Let's recover the original value
defined by kernel side.

Cc: Cliff Wickman <cpw@sgi.com>
Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 include/x86/x86-linux.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index 6681f9e..0949dc2 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -197,7 +197,7 @@ struct x86_linux_param_header {
 	uint8_t _pad8[48];			/* 0xcd0 */
 	struct 	edd_info eddbuf[EDDMAXNR];	/* 0xd00 */
 						/* 0xeec */
-#define COMMAND_LINE_SIZE (64*1024)
+#define COMMAND_LINE_SIZE 2048
 };
 
 struct x86_linux_faked_param_header {
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
