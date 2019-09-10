Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7dHc-0007Fb-M7
 for kexec@lists.infradead.org; Tue, 10 Sep 2019 10:22:02 +0000
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6AF78C05AA58
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 10:22:00 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id w126so11424166pfd.22
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 03:22:00 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 1/2] vmcore-dmesg/vmcore-dmesg.c: Fix shifting error reported
 by cppcheck
Date: Tue, 10 Sep 2019 15:51:49 +0530
Message-Id: <20190910102150.7229-2-bhsharma@redhat.com>
In-Reply-To: <20190910102150.7229-1-bhsharma@redhat.com>
References: <20190910102150.7229-1-bhsharma@redhat.com>
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
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, Lianbo Jiang <lijiang@redhat.com>, horms@verge.net.au

Running 'cppcheck' static code analyzer (see cppcheck(1))
 on 'vmcore-dmesg/vmcore-dmesg.c' shows the following
shifting error:

$ cppcheck  --enable=all  vmcore-dmesg/vmcore-dmesg.c
Checking vmcore-dmesg/vmcore-dmesg.c ...
[vmcore-dmesg/vmcore-dmesg.c:17]: (error) Shifting signed 32-bit value by 31 bits is undefined behaviour

Fix the same via this patch.

Cc: Lianbo Jiang <lijiang@redhat.com>
Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 vmcore-dmesg/vmcore-dmesg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index 81c2a58..122e536 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -6,7 +6,7 @@ typedef Elf32_Nhdr Elf_Nhdr;
 extern const char *fname;
 
 /* stole this macro from kernel printk.c */
-#define LOG_BUF_LEN_MAX (uint32_t)(1 << 31)
+#define LOG_BUF_LEN_MAX (uint32_t)(1U << 31)
 
 static void write_to_stdout(char *buf, unsigned int nr)
 {
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
