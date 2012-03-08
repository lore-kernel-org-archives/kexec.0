Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S5X1J-0001RU-8z
 for kexec@lists.infradead.org; Thu, 08 Mar 2012 06:40:13 +0000
Received: by mail-iy0-f177.google.com with SMTP id y10so310005iak.36
 for <kexec@lists.infradead.org>; Wed, 07 Mar 2012 22:40:13 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 5/5] sh: move DEBUG code to --debug
Date: Thu,  8 Mar 2012 14:39:42 +0800
Message-Id: <1331188782-10912-5-git-send-email-xiyou.wangcong@gmail.com>
In-Reply-To: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
References: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
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
To: kexec@lists.infradead.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Simon Horman <horms@verge.net.au>

Like patch 1/5, this one moves code under #if DEBUG to --debug
on sh arch.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 kexec/arch/sh/crashdump-sh.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/sh/crashdump-sh.c b/kexec/arch/sh/crashdump-sh.c
index f3c8c74..68ca756 100644
--- a/kexec/arch/sh/crashdump-sh.c
+++ b/kexec/arch/sh/crashdump-sh.c
@@ -142,9 +142,9 @@ static int add_cmdline_param(char *cmdline, uint64_t addr, char *cmdstr,
 	if (cmdlen > (COMMAND_LINE_SIZE - 1))
 		die("Command line overflow\n");
 	strcat(cmdline, str);
-#if DEBUG
-	fprintf(stderr, "Command line after adding elfcorehdr: %s\n", cmdline);
-#endif
+
+	dbgprintf("Command line after adding elfcorehdr: %s\n", cmdline);
+
 	return 0;
 }
 
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
