Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdt5-00CU2a-Ig
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:36:04 +0000
Received: by mail-pl1-f200.google.com with SMTP id
 k9-20020a170902c40900b0013a41f4fee5so814391plk.9
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:36 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 04/11] makedumpfile: Notify zstd unsupporting when disabled
Date: Fri, 10 Sep 2021 18:33:11 +0800
Message-Id: <20210910103318.292017-5-ltao@redhat.com>
In-Reply-To: <20210910103318.292017-1-ltao@redhat.com>
References: <20210910103318.292017-1-ltao@redhat.com>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: k-hagio-ab@nec.com, Tao Liu <ltao@redhat.com>, Coiby Xu <coxu@redhat.com>

Signed-off-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 makedumpfile.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 100b407..f3bf297 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4171,6 +4171,15 @@ initial(void)
 	}
 #endif
 
+#ifndef USEZSTD
+	if (info->flag_compress == DUMP_DH_COMPRESSED_ZSTD) {
+		MSG("'-z' option is disabled, ");
+		MSG("because this binary doesn't support zstd "
+		    "compression.\n");
+		MSG("Try `make USEZSTD=on` when building.\n");
+	}
+#endif
+
 	if (info->flag_exclude_xen_dom && !is_xen_memory()) {
 		MSG("'-X' option is disable,");
 		MSG("because %s is not Xen's memory core image.\n", info->name_memory);
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
