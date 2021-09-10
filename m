Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdtW-00AuoN-Ew
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:37:03 +0000
Received: by mail-pf1-f197.google.com with SMTP id
 j21-20020aa78015000000b00412badd61e2so1081955pfi.21
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:54 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 11/11] makedumpfile: Add zstd README description
Date: Fri, 10 Sep 2021 18:33:18 +0800
Message-Id: <20210910103318.292017-12-ltao@redhat.com>
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
 README | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 6629440..0b17cf1 100644
--- a/README
+++ b/README
@@ -49,7 +49,10 @@
   7.Build with snappy support:
     # make USESNAPPY=on ; make install
     The user has to prepare snappy library.
-  8.Build the extension module for --eppic option.
+  8.Build with zstd support:
+    # make USEZSTD=on ; make install
+    The user has to prepare zstd library.
+  9.Build the extension module for --eppic option.
     # make eppic_makedumpfile.so
     The user has to prepare eppic library from the following site:
     http://code.google.com/p/eppic/
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
