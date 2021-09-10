Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdsX-00CTry-5L
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:35:31 +0000
Received: by mail-pj1-f70.google.com with SMTP id
 41-20020a17090a0fac00b00195a5a61ab8so1122558pjz.3
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:31 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 02/11] makedumpfile: Add command-line processing for zstd
Date: Fri, 10 Sep 2021 18:33:09 +0800
Message-Id: <20210910103318.292017-3-ltao@redhat.com>
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
 makedumpfile.c | 5 ++++-
 makedumpfile.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 7777157..100b407 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -11656,7 +11656,7 @@ main(int argc, char *argv[])
 
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
-	while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lL:pRvXx:", longopts,
+	while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lL:pRvXx:z", longopts,
 	    NULL)) != -1) {
 		switch (opt) {
 			unsigned long long val;
@@ -11739,6 +11739,9 @@ main(int argc, char *argv[])
 		case OPT_COMPRESS_SNAPPY:
 			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
 			break;
+		case OPT_COMPRESS_ZSTD:
+			info->flag_compress = DUMP_DH_COMPRESSED_ZSTD;
+			break;
 		case OPT_XEN_PHYS_START:
 			info->xen_phys_start = strtoul(optarg, NULL, 0);
 			break;
diff --git a/makedumpfile.h b/makedumpfile.h
index bd9e2f6..46d77b0 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -2471,6 +2471,7 @@ struct elf_prstatus {
 #define OPT_VERSION             'v'
 #define OPT_EXCLUDE_XEN_DOM     'X'
 #define OPT_VMLINUX             'x'
+#define OPT_COMPRESS_ZSTD       'z'
 #define OPT_START               256
 #define OPT_SPLIT               OPT_START+0
 #define OPT_REASSEMBLE          OPT_START+1
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
