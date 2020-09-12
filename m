Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGuV3-0004CP-Jc
 for kexec@lists.infradead.org; Sat, 12 Sep 2020 01:38:46 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH] kexec-tools: Fix a prompt message when crashkernel is not
 reserved
Date: Sat, 12 Sep 2020 09:38:41 +0800
Message-Id: <1599874721-6903-1-git-send-email-tangyouling@loongson.cn>
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
To: Simon Horman <horms@verge.net.au>, Khalid Aziz <khalid@gonehiking.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

Where Y specifies how much memory to reserve for the dump-capture kernel
and X specifies the beginning of this reserved memory. So Y should be
placed before X.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index bb88caa..fd7c8d2 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1530,7 +1530,7 @@ int main(int argc, char *argv[])
 	    !is_crashkernel_mem_reserved()) {
 		die("Memory for crashkernel is not reserved\n"
 		    "Please reserve memory by passing"
-		    "\"crashkernel=X@Y\" parameter to kernel\n"
+		    "\"crashkernel=Y@X\" parameter to kernel\n"
 		    "Then try to loading kdump kernel\n");
 	}
 
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
