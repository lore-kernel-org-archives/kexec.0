Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ernst.netinsight.se ([194.16.221.21])
 by merlin.infradead.org with smtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLqJQ-0000E4-U8
 for kexec@lists.infradead.org; Fri, 07 Mar 2014 08:39:25 +0000
Date: Fri, 7 Mar 2014 09:38:40 +0100
From: Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?= <simon.kagstrom@netinsight.net>
Subject: [PATCH v2 2/4] build: Use INCLUDES for normal CFLAGS in addition to
 CFLAGS_ARCH
Message-ID: <20140307093840.72e71fbe@marrow.netinsight.se>
In-Reply-To: <20140307093626.09701790@marrow.netinsight.se>
References: <20140307093626.09701790@marrow.netinsight.se>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

Useful e.g., when the system headers is in some build directory.

Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---
 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d660951..57e7e44 100644
--- a/Makefile
+++ b/Makefile
@@ -8,7 +8,7 @@ ifeq ($(strip $CC),)
 CC	= gcc
 endif
 
-CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
+CFLAGS = $(INCLUDES) -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
 	  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
 	  -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
 CFLAGS_ARCH	= $(INCLUDES) -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
-- 
1.7.9.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
