Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fCttp-0005Ep-9o
 for kexec@lists.infradead.org; Sun, 29 Apr 2018 21:30:27 +0000
Received: by mail-pf0-f194.google.com with SMTP id a14so5243269pfi.1
 for <kexec@lists.infradead.org>; Sun, 29 Apr 2018 14:30:15 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v3 2/2] kexec-arm64: Add functionality to dump 2nd dtb
Date: Mon, 30 Apr 2018 02:52:36 +0530
Message-Id: <1525036956-7440-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1525036956-7440-1-git-send-email-bhsharma@redhat.com>
References: <1525036956-7440-1-git-send-email-bhsharma@redhat.com>
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
Cc: Bhupesh Sharma <bhsharma@redhat.com>, takahiro.akashi@linaro.org, horms@verge.net.au, james.morse@arm.com, bhupesh.linux@gmail.com, dyoung@redhat.com

Since during the arm64 kexec_load()/kdump invocation,
the dtb is passed to the second kernel, it is sometimes useful
to dump the dtb contents (to verify the correctness
of the same).

This patch adds this feature which is enabled when '-d' flag is
used with kexec command line invocation.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 62f37585b788..1b54718465b9 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -477,9 +477,10 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 		dtb->size = fdt_totalsize(new_buf);
 	}
 
+	dbgprintf("%s: found %s\n", __func__, dtb->path);
+	dump_fdt(dtb->buf);
 	dump_reservemap(dtb);
 
-
 	return result;
 
 on_error:
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
