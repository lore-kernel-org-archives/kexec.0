Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOduM-00AuoM-Sy
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:38:30 +0000
Received: by mail-pj1-f72.google.com with SMTP id
 m9-20020a17090ade09b029017903cc8d6cso1096770pjv.4
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:52 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 10/11] makedumpfile: Add zstd manual description
Date: Fri, 10 Sep 2021 18:33:17 +0800
Message-Id: <20210910103318.292017-11-ltao@redhat.com>
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
 makedumpfile.8 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index f782e5f..3022d9c 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -132,10 +132,11 @@ configuration, you need to use --diskset option.
 .SH OPTIONS
 
 .TP
-\fB\-c,\-l,\-p\fR
+\fB\-c,\-l,\-p,\-z\fR
 Compress dump data by each page using zlib for -c option, lzo for -l
-option or snappy for -p option.
-(-l option needs USELZO=on and -p option needs USESNAPPY=on when building)
+option, snappy for -p option or zstd for -z option.
+(-l option needs USELZO=on, -p option needs USESNAPPY=on and -z option needs
+USEZSTD=on when building)
 .br
 A user cannot specify this option with \-E option, because the ELF format does
 not support compressed data.
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
