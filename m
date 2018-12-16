Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYbuf-00082O-NM
 for kexec@lists.infradead.org; Sun, 16 Dec 2018 19:17:19 +0000
Received: by mail-pf1-f194.google.com with SMTP id z9so5258183pfi.2
 for <kexec@lists.infradead.org>; Sun, 16 Dec 2018 11:17:15 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v3 2/4] kexec/kexec-arm64.c: Add error handling check against
 return value of 'set_bootargs()'
Date: Mon, 17 Dec 2018 00:46:53 +0530
Message-Id: <1544987815-19527-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1544987815-19527-1-git-send-email-bhsharma@redhat.com>
References: <1544987815-19527-1-git-send-email-bhsharma@redhat.com>
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
Cc: takahiro.akashi@linaro.org, bhsharma@redhat.com, bhupesh.linux@gmail.com, vicencb@gmail.com, horms@verge.net.au

This patch adds missing error handling check against the return value of
'set_bootargs()' in 'kexec-arm64.c'

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index b143e861f7d9..f4913b2e9480 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -413,6 +413,11 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 	}
 
 	result = set_bootargs(dtb, command_line);
+	if (result) {
+		fprintf(stderr, "kexec: cannot set bootargs.\n");
+		result = -EINVAL;
+		goto on_error;
+	}
 
 	/* determine #address-cells and #size-cells */
 	result = get_cells_size(dtb->buf, &address_cells, &size_cells);
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
