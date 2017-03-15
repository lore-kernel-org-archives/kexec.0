Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1co5Ml-00007C-GJ
 for kexec@lists.infradead.org; Wed, 15 Mar 2017 09:37:13 +0000
Received: by mail-pg0-x22c.google.com with SMTP id g2so6748772pge.3
 for <kexec@lists.infradead.org>; Wed, 15 Mar 2017 02:36:51 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v6 7/9] arm64: kdump: set up other segments
Date: Wed, 15 Mar 2017 18:38:22 +0900
Message-Id: <20170315093824.24566-8-takahiro.akashi@linaro.org>
In-Reply-To: <20170315093824.24566-1-takahiro.akashi@linaro.org>
References: <20170315093824.24566-1-takahiro.akashi@linaro.org>
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
index 5a1da2e..5e30107 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -375,7 +375,10 @@ int arm64_load_other_segments(struct kexec_info *info,
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
