Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from m12-13.163.com ([220.181.12.13])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvWSZ-000jIb-Lh
 for kexec@lists.infradead.org; Fri, 10 Dec 2021 03:20:37 +0000
From: lizhe <sensor1010@163.com>
Subject: [PATCH] kernel/crash_core.c: No judgment required
Date: Thu,  9 Dec 2021 19:20:03 -0800
Message-Id: <20211210032003.16278-1-sensor1010@163.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com, sensor1010@163.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

No judgment required ck_cmdline is NULL
its caller has alreadly judged, see __parse_crashkernel
function

Signed-off-by: lizhe <sensor1010@163.com>
---
 kernel/crash_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index eb53f5ec62c9..9981cf9b9fe4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -221,9 +221,6 @@ static __init char *get_last_crashkernel(char *cmdline,
 		p = strstr(p+1, name);
 	}
 
-	if (!ck_cmdline)
-		return NULL;
-
 	return ck_cmdline;
 }
 
-- 
2.25.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
