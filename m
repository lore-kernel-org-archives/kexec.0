From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Sun, 27 Feb 2022 11:07:13 +0800
Subject: [PATCH v21 1/5] kdump: return -ENOENT if required cmdline option does
 not exist
In-Reply-To: <20220227030717.1464-1-thunder.leizhen@huawei.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
Message-ID: <20220227030717.1464-2-thunder.leizhen@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The crashkernel=Y,low is an optional command-line option. When it doesn't
exist, kernel will try to allocate minimum required memory below 4G
automatically. Give it a unique error code to distinguish it from other
error scenarios.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/crash_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573cd09..4d57c03714f4e13 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -243,9 +243,8 @@ static int __init __parse_crashkernel(char *cmdline,
 	*crash_base = 0;
 
 	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
-
 	if (!ck_cmdline)
-		return -EINVAL;
+		return -ENOENT;
 
 	ck_cmdline += strlen(name);
 
-- 
2.25.1


