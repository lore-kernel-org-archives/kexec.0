Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YLAIO-0003wn-GP
 for kexec@lists.infradead.org; Tue, 10 Feb 2015 12:52:04 +0000
Received: by pdjz10 with SMTP id z10so242634pdj.0
 for <kexec@lists.infradead.org>; Tue, 10 Feb 2015 04:51:43 -0800 (PST)
From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH 3/4] mips: remove unused variable.
Date: Tue, 10 Feb 2015 20:46:13 +0800
Message-Id: <1423572374-20841-3-git-send-email-yszhou4tech@gmail.com>
In-Reply-To: <1423572374-20841-1-git-send-email-yszhou4tech@gmail.com>
References: <1423572374-20841-1-git-send-email-yszhou4tech@gmail.com>
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
Cc: Yousong Zhou <yszhou4tech@gmail.com>, horms@verge.net.au

Fixes the following compilation warning.

	kexec/arch/mips/crashdump-mips.c:151:6: warning: unused variable 'i' [-Wunused-variable]

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 kexec/arch/mips/crashdump-mips.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 98c9f7c..dc68cb4 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -148,7 +148,7 @@ static int exclude_crash_reserve_region(int *nr_ranges)
 static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
 	const char iomem[] = "/proc/iomem";
-	int i, memory_ranges = 0;
+	int memory_ranges = 0;
 	char line[MAX_LINE];
 	FILE *fp;
 	unsigned long long start, end;
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
