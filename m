Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdsU-00CTrN-IY
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:35:28 +0000
Received: by mail-pj1-f72.google.com with SMTP id
 j14-20020a17090a318e00b001796382f0caso1145474pjb.5
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:29 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 01/11] makedumpfile: Add dump header for zstd.
Date: Fri, 10 Sep 2021 18:33:08 +0800
Message-Id: <20210910103318.292017-2-ltao@redhat.com>
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
 diskdump_mod.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diskdump_mod.h b/diskdump_mod.h
index 3733953..e4bce5c 100644
--- a/diskdump_mod.h
+++ b/diskdump_mod.h
@@ -98,6 +98,7 @@ struct kdump_sub_header {
 #define DUMP_DH_COMPRESSED_INCOMPLETE	0x8
 					/* indicate an incomplete dumpfile */
 #define DUMP_DH_EXCLUDED_VMEMMAP 0x10	/* unused vmemmap pages are excluded */
+#define DUMP_DH_COMPRESSED_ZSTD  0x20	/* page is compressed with zstd */
 
 /* descriptor of each page for vmcore */
 typedef struct page_desc {
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
