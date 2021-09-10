Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdsg-00CTuq-FB
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:35:39 +0000
Received: by mail-pj1-f69.google.com with SMTP id
 m9-20020a17090ade09b029017903cc8d6cso1096442pjv.4
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:34 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 03/11] makedumpfile: Add zstd build support
Date: Fri, 10 Sep 2021 18:33:10 +0800
Message-Id: <20210910103318.292017-4-ltao@redhat.com>
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
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 5d61a69..725c186 100644
--- a/Makefile
+++ b/Makefile
@@ -68,6 +68,11 @@ endif
 CFLAGS += -DUSESNAPPY
 endif
 
+ifeq ($(USEZSTD), on)
+LIBS := -lzstd $(LIBS)
+CFLAGS += -DUSEZSTD
+endif
+
 LIBS := $(LIBS) -lpthread
 
 try-run = $(shell set -e;		\
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
