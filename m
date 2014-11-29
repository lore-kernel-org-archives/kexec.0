Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XuWEV-0005HA-Ap
 for kexec@lists.infradead.org; Sat, 29 Nov 2014 00:49:58 +0000
From: HuKeping <hukeping@huawei.com>
Subject: [PATCH] kexec: remove some re zero-assignment
Date: Sat, 29 Nov 2014 08:45:32 +0800
Message-ID: <1417221932-75098-1-git-send-email-hukeping@huawei.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, peifeiyue@huawei.com, sdu.liu@huawei.com

since we have already cleared kexec_info with memset,
there is no need to do that again to the struct members.

Signed-off-by: Hu Keping <hukeping@huawei.com>
---
 kexec/kexec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index a5e78c6..b088916 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -662,10 +662,6 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	int guess_only = 0;
 
 	memset(&info, 0, sizeof(info));
-	info.segment = NULL;
-	info.nr_segments = 0;
-	info.entry = NULL;
-	info.backup_start = 0;
 	info.kexec_flags = kexec_flags;
 
 	result = 0;
-- 
1.8.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
