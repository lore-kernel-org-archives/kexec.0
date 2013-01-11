Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TtaUV-0004kz-RA
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 09:01:32 +0000
Message-ID: <50EFD445.2090002@cn.fujitsu.com>
Date: Fri, 11 Jan 2013 16:58:45 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] kexec: add additional check when getting memory info
References: <50EFD3F0.9030900@cn.fujitsu.com>
In-Reply-To: <50EFD3F0.9030900@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

This check makes sure that we indeed get the memory information.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/kexec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 89ec182..16c6308 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -675,7 +675,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 #endif
 
 	if (get_memory_ranges(&info.memory_range, &info.memory_ranges,
-		info.kexec_flags) < 0) {
+		info.kexec_flags) < 0 || info.memory_ranges == 0) {
 		fprintf(stderr, "Could not get memory layout\n");
 		return -1;
 	}
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
