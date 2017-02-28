Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cics3-0001gd-64
 for kexec@lists.infradead.org; Tue, 28 Feb 2017 08:10:55 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6571361B96
 for <kexec@lists.infradead.org>; Tue, 28 Feb 2017 08:10:04 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH] ifdown: if socket can not be opened, then no need to close it
Date: Tue, 28 Feb 2017 16:10:01 +0800
Message-Id: <1488269401-25926-1-git-send-email-piliu@redhat.com>
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
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 kexec/ifdown.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/ifdown.c b/kexec/ifdown.c
index 9679ad7..a5067ae 100644
--- a/kexec/ifdown.c
+++ b/kexec/ifdown.c
@@ -34,7 +34,7 @@ int ifdown(void)
 	if ((fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
 		fprintf(stderr, "ifdown: ");
 		perror("socket");
-		goto error;
+		goto exit;
 	}
 
 	if ((ifa = if_nameindex()) == NULL) {
@@ -74,5 +74,6 @@ int ifdown(void)
 
 error:
 	close(fd);
+exit:
 	return -1;
 }
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
