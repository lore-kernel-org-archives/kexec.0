Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-f68.google.com ([209.85.214.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1exrzX-0000XR-3M
 for kexec@lists.infradead.org; Mon, 19 Mar 2018 10:26:12 +0000
Received: by mail-it0-f68.google.com with SMTP id w3-v6so9755011itc.4
 for <kexec@lists.infradead.org>; Mon, 19 Mar 2018 03:26:00 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 2/2] kexec-arm64: Add functionality to dump 2nd dtb
Date: Mon, 19 Mar 2018 15:55:45 +0530
Message-Id: <1521455145-6813-2-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1521455145-6813-1-git-send-email-bhsharma@redhat.com>
References: <1521455145-6813-1-git-send-email-bhsharma@redhat.com>
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
Cc: dyoung@redhat.com, takahiro.akashi@linaro.org, bhsharma@redhat.com, bhupesh.linux@gmail.com, james.morse@arm.com

Since during the arm64 kexec_load()/kdump invocation,
the dtb is passed to the second kernel, it is sometimes useful
to dump the dtb contents (to verify the correctness
of the same).

This patch adds this feature which is enabled when '-d' flag is
used with kexec command line invocation.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Merge with 2nd patch

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 62f37585b788..c304c3775ada 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -471,12 +471,14 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 			result = -EINVAL;
 			goto on_error;
 		}
-
+		
 		fdt_pack(new_buf);
 		dtb->buf = new_buf;
 		dtb->size = fdt_totalsize(new_buf);
 	}
 
+	dbgprintf("%s: found %s\n", __func__, dtb->path);
+	dump_fdt(dtb->buf);
 	dump_reservemap(dtb);
 
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
