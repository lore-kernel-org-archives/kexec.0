Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail2.fujitsu.co.jp ([164.71.1.135])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsPy3-0004sg-0z
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 05:11:59 +0000
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [10.0.237.143])
 by fgwmail2.fujitsu.co.jp (Postfix) with ESMTP id 4C29D3EE0BC
 for <kexec@lists.infradead.org>; Thu,  5 Jun 2014 14:11:14 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 60AB2AC1092
 for <kexec@lists.infradead.org>; Thu,  5 Jun 2014 14:11:13 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 14B861DB803C
 for <kexec@lists.infradead.org>; Thu,  5 Jun 2014 14:11:13 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [PATCH 2/2] Fix mistaken check of stat(2) return value
Date: Thu,  5 Jun 2014 14:10:55 +0900
Message-Id: <1401945055-2820-3-git-send-email-indou.takao@jp.fujitsu.com>
In-Reply-To: <1401945055-2820-1-git-send-email-indou.takao@jp.fujitsu.com>
References: <1401945055-2820-1-git-send-email-indou.takao@jp.fujitsu.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org

get_crash_notes_per_cpu() should return -1 if return value of stat(2) is
zero (on success).

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 kexec/crashdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index 131e624..15c1105 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -84,7 +84,7 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
 		if (fopen_errno != ENOENT)
 			die("Could not open \"%s\": %s\n", crash_notes,
 			    strerror(fopen_errno));
-		if (!stat("/sys/devices", &cpu_stat)) {
+		if (stat("/sys/devices", &cpu_stat)) {
 			stat_errno = errno;
 			if (stat_errno == ENOENT)
 				die("\"/sys/devices\" does not exist. "
-- 
1.9.3



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
