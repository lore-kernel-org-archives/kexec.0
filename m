Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlIfn-0006IP-J9
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 19:54:41 +0000
Received: by mail-pf1-f196.google.com with SMTP id p184so1576774pfp.7
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2019 12:54:39 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 1/4] kexec/kexec.c: Add the missing close() for fd used for
 kexec_file_load()
Date: Thu, 11 Jul 2019 01:24:26 +0530
Message-Id: <1562788469-22935-2-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1562788469-22935-1-git-send-email-bhsharma@redhat.com>
References: <1562788469-22935-1-git-send-email-bhsharma@redhat.com>
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
Cc: bhupesh.linux@gmail.com, bhsharma@redhat.com, horms@verge.net.au, takahiro.akashi@linaro.org

In kexec/kexec.c, we open() the kernel Image file and pass this file
descriptor to the kexec_file_load() system call, but never call a
corresponding close().

Fix the same via this patch.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 32ae56c8f1c3..8ca3b457cac8 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1234,6 +1234,8 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	if (ret != 0)
 		fprintf(stderr, "kexec_file_load failed: %s\n",
 					strerror(errno));
+
+	close(kernel_fd);
 	return ret;
 }
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
