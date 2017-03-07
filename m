Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1clHwF-0005OR-L9
 for kexec@lists.infradead.org; Tue, 07 Mar 2017 16:26:17 +0000
Received: by mail-io0-x235.google.com with SMTP id f84so7615558ioj.0
 for <kexec@lists.infradead.org>; Tue, 07 Mar 2017 08:25:54 -0800 (PST)
Received: from macbuntu.in.azkaban.com
 (modemcable057.191-130-66.mc.videotron.ca. [66.130.191.57])
 by smtp.gmail.com with ESMTPSA id b129sm6467142itc.3.2017.03.07.08.25.50
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 07 Mar 2017 08:25:51 -0800 (PST)
From: Eric Desrochers <eric.desrochers@canonical.com>
Subject: [PATCH] [PATCH] Fix typo in the ERRMSG of function show_mem_usage.
 "kernel" instead of "kenrel".
Date: Tue,  7 Mar 2017 11:25:48 -0500
Message-Id: <1488903948-13185-1-git-send-email-eric.desrochers@canonical.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

---
 makedumpfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index e3be1ab..18cf30f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -10938,7 +10938,7 @@ int show_mem_usage(void)
 	struct cycle cycle = {0};
 
 	if (!is_crashkernel_mem_reserved()) {
-		ERRMSG("No memory is reserved for crashkenrel!\n");
+		ERRMSG("No memory is reserved for crashkernel!\n");
 		return FALSE;
 	}
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
