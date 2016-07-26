Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRxIh-0000Gm-Ec
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 08:01:22 +0000
Received: by mail-pf0-x232.google.com with SMTP id h186so72849681pfg.3
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 01:00:59 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 4/6] arm64: kdump: set up other segments
Date: Tue, 26 Jul 2016 17:05:23 +0900
Message-Id: <20160726080525.2539-5-takahiro.akashi@linaro.org>
In-Reply-To: <20160726080525.2539-1-takahiro.akashi@linaro.org>
References: <20160726080525.2539-1-takahiro.akashi@linaro.org>
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
 kexec/arch/arm64/kexec-arm64.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index a61f856..22ab098 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -590,9 +590,15 @@ int arm64_load_other_segments(struct kexec_info *info,
 
 	/* Put the other segments after the image. */
 
-	image_base = arm64_mem.phys_offset + arm64_mem.text_offset;
-	hole_min = image_base + arm64_mem.image_size;
-	hole_max = ULONG_MAX;
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		image_base = crash_reserved_mem.start + arm64_mem.text_offset;
+		hole_min = image_base + arm64_mem.image_size;
+		hole_max = crash_reserved_mem.end;
+	} else {
+		image_base = arm64_mem.phys_offset + arm64_mem.text_offset;
+		hole_min = image_base + arm64_mem.image_size;
+		hole_max = ULONG_MAX;
+	}
 
 	if (arm64_opts.initrd) {
 		initrd_buf = slurp_file(arm64_opts.initrd, &initrd_size);
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
