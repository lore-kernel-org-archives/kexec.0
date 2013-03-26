Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x233.google.com ([2607:f8b0:400e:c00::233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKUF9-0004Ui-Ch
 for kexec@lists.infradead.org; Tue, 26 Mar 2013 13:48:52 +0000
Received: by mail-da0-f51.google.com with SMTP id g27so3575486dan.38
 for <kexec@lists.infradead.org>; Tue, 26 Mar 2013 06:48:48 -0700 (PDT)
Message-ID: <5151A739.6070502@gmail.com>
Date: Tue, 26 Mar 2013 21:48:41 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: fix a minor mistake in an error message
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

when specified a wrong --entry option, it outputs the error message:
    "Bad option value in --load-jump-back-helper=%s\n"
which is obviously wrong, it should be:
    "Bad option value in --entry=%s\n"

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/kexec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index f3928af..e6395f5 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1121,7 +1121,7 @@ int main(int argc, char *argv[])
 			entry = (void *)strtoul(optarg, &endptr, 0);
 			if (*endptr) {
 				fprintf(stderr,
-					"Bad option value in --load-jump-back-helper=%s\n",
+					"Bad option value in --entry=%s\n",
 					optarg);
 				usage();
 				return 1;
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
