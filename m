From: lizhe <sensor1010@163.com>
Date: Wed,  4 May 2022 05:36:23 -0700
Subject: [PATCH] kernel/crash_core.c : Remove redundant checks for ck_cmdline
 is NULL
Message-ID: <20220504123623.36852-1-sensor1010@163.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

When ck_cmdline is NULL. The last three lines of
this function(get_last_crashkernel()) are equivalent to :
	if (!NULL)
		return NULL;

	return NULL;
This is obviously a redundant check

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


