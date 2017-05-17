Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dArpV-0000k3-Ez
 for kexec@lists.infradead.org; Wed, 17 May 2017 05:49:02 +0000
Received: by mail-pf0-x233.google.com with SMTP id e193so1850637pfh.0
 for <kexec@lists.infradead.org>; Tue, 16 May 2017 22:48:41 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v7 08/10] arm64: kdump: set up other segments
Date: Wed, 17 May 2017 14:51:48 +0900
Message-Id: <20170517055150.12601-9-takahiro.akashi@linaro.org>
In-Reply-To: <20170517055150.12601-1-takahiro.akashi@linaro.org>
References: <20170517055150.12601-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

We make sure that all the other segments, initrd and device-tree blob,
also be loaded into the reserved memory of crash dump kernel.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/kexec-arm64.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 6c21756..dfe16a6 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -376,7 +376,10 @@ int arm64_load_other_segments(struct kexec_info *info,
 	/* Put the other segments after the image. */
 
 	hole_min = image_base + arm64_mem.image_size;
-	hole_max = ULONG_MAX;
+	if (info->kexec_flags & KEXEC_ON_CRASH)
+		hole_max = crash_reserved_mem.end;
+	else
+		hole_max = ULONG_MAX;
 
 	if (arm64_opts.initrd) {
 		initrd_buf = slurp_file(arm64_opts.initrd, &initrd_size);
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
