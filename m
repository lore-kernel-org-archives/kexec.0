From: lizhe <sensor1010@163.com>
Date: Mon, 25 Apr 2022 08:38:57 -0700
Subject: [PATCH] kernel/crash_core.c : Remove redundant checks for ck_cmdline
 is NULL
Message-ID: <20220425153857.21922-1-sensor1010@163.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

 When ck_cmdline is NULL, the only caller of get_last_crashkernel()
 has already done non-NULL check(see __parse_crashkernel()),
 so it doesn't make any sense to make a check here

Signed-off-by: lizhe <sensor1010@163.com>
---
 kernel/crash_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..c232f01a2c54 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -222,9 +222,6 @@ static __init char *get_last_crashkernel(char *cmdline,
 		p = strstr(p+1, name);
 	}
 
-	if (!ck_cmdline)
-		return NULL;
-
 	return ck_cmdline;
 }
 
-- 
2.25.1


