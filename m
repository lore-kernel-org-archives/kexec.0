Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x22f.google.com ([2607:f8b0:400e:c00::22f])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIIs9-0003fq-7O
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 13:16:05 +0000
Received: by mail-da0-f47.google.com with SMTP id s35so984064dak.34
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 06:16:02 -0700 (PDT)
Message-ID: <5149B68C.1080704@gmail.com>
Date: Wed, 20 Mar 2013 21:15:56 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] kexec: Add new interface for printing error messages
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

This patch imports an interface err() for printing error messages.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/kexec.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/kexec/kexec.h b/kexec/kexec.h
index 916a24b..4c43b8c 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -121,6 +121,11 @@ do { \
 		fprintf(stderr, __VA_ARGS__); \
 } while(0)
 
+#define err(...) \
+do { \
+	fprintf(stderr, __VA_ARGS__); \
+} while(0);
+
 struct kexec_segment {
 	const void *buf;
 	size_t bufsz;
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
