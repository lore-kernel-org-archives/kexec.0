From: lizhe <sensor1010@163.com>
Date: Fri,  6 May 2022 03:41:16 -0700
Subject: [PATCH v5] kernel/crash_core.c : remove redundant check of ck_cmdline
Message-ID: <20220506104116.259323-1-sensor1010@163.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

At the end of get_last_crashkernel(), the judgement of ck_cmdline is
obviously unnecessary and causes redundance, let's clean it up.

Signed-off-by: lizhe <sensor1010@163.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Philipp Rudo <prudo@redhat.com>
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


