Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAjfT-0006Hp-7t
 for kexec@lists.infradead.org; Wed, 26 Aug 2020 00:52:00 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH v2] kexec/kexec.c: Add missing close() call
Date: Wed, 26 Aug 2020 08:51:54 +0800
Message-Id: <1598403114-19103-1-git-send-email-tangyouling@loongson.cn>
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
To: Simon Horman <horms@verge.net.au>, Khalid Aziz and Shuah Khan <azizkhan@gonehiking.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

Add missing close() call.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index a62b362..bb88caa 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -585,6 +585,7 @@ static char *slurp_file_generic(const char *filename, off_t *r_size,
 		die("Read on %s ended before stat said it should\n", filename);
 
 	*r_size = size;
+	close(fd);
 	return buf;
 }
 
@@ -1257,12 +1258,14 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	if (i == file_types) {
 		fprintf(stderr, "Cannot determine the file type " "of %s\n",
 				kernel);
+		close(kernel_fd);
 		return EFAILED;
 	}
 
 	ret = file_type[i].load(argc, argv, kernel_buf, kernel_size, &info);
 	if (ret < 0) {
 		fprintf(stderr, "Cannot load %s\n", kernel);
+		close(kernel_fd);
 		return ret;
 	}
 
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
