Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hu-out-0506.google.com ([72.14.214.237])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KGtlh-00034O-AV
	for kexec@lists.infradead.org; Thu, 10 Jul 2008 10:52:57 +0000
Received: by hu-out-0506.google.com with SMTP id 16so11471719hue.22
	for <kexec@lists.infradead.org>; Thu, 10 Jul 2008 03:52:55 -0700 (PDT)
Date: Thu, 10 Jul 2008 11:48:23 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: [Patch] kexec/crashdump.c: remove useless code
Message-ID: <20080710104823.GA10478@hack.voiplan.pt>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>


I think we don't need to print fopen errors when stat fails.

Signed-off-by: WANG Cong <wangcong@zeuux.org>
Cc: Simon Horman <horms@verge.net.au>

---
diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index 92de524..257b3f5 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -84,14 +84,12 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
 			    strerror(fopen_errno));
 		if (!stat("/sys/devices", &cpu_stat)) {
 			stat_errno = errno;
-			fprintf(stderr, "Could not open \"%s\": %s\n",
-				crash_notes, strerror(fopen_errno));
 			if (stat_errno == ENOENT)
 				die("\"/sys/devices\" does not exist. "
 				    "Sysfs does not seem to be mounted. "
 				    "Try mounting sysfs.\n");
 			die("Could not open \"/sys/devices\": %s\n",
-			    crash_notes, strerror(stat_errno));
+			    strerror(stat_errno));
 		}
 		/* CPU is not physically present.*/
 		return -1;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
