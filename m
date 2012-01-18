Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RnST2-0006sa-Lg
 for kexec@lists.infradead.org; Wed, 18 Jan 2012 10:10:09 +0000
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 18 Jan 2012 15:40:00 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0IA9Hvb4202498
 for <kexec@lists.infradead.org>; Wed, 18 Jan 2012 15:39:17 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0IA9G3M008342
 for <kexec@lists.infradead.org>; Wed, 18 Jan 2012 21:09:17 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v1 1/3] [makedumpfile] Support for cross building 
Date: Wed, 18 Jan 2012 15:39:14 +0530
Message-ID: <20120118100755.29422.5803.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
References: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Support cross building of makedumpfile. This would be useful for building
the makedumpfile for embedded PPC boards. Support for PPC32 would be added
in the later patches.

Use TARGET variable to set the arch to build for. Also honour the value of
CC if set.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 Makefile |   12 +++++++++++-
 README   |    5 +++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 9afbe1c..174a0d9 100644
--- a/Makefile
+++ b/Makefile
@@ -3,7 +3,11 @@
 VERSION=1.4.1
 DATE=6 January 2012
 
+# Honour the environment variable CC
+ifeq ($(strip $CC),)
 CC	= gcc
+endif
+
 CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
 	  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
 	  -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
@@ -11,7 +15,13 @@ CFLAGS_ARCH	= -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
 		    -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
 # LDFLAGS = -L/usr/local/lib -I/usr/local/include
 
-ARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
+# Use TARGET as the target architecture if specified.
+# Defaults to uname -m
+ifeq ($(strip($TARGET)),)
+TARGET := $(shell uname -m)
+endif
+
+ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
 			       -e s/arm.*/arm/ -e s/sa110/arm/ \
 			       -e s/s390x/s390/ -e s/parisc64/parisc/ \
 			       -e s/ppc64/powerpc/ )
diff --git a/README b/README
index 8aa4ab3..595b446 100644
--- a/README
+++ b/README
@@ -37,6 +37,11 @@
     # cd makedumpfile-x.y.z
   4.Build, and install:
     # make; make install
+  5.Build for a different architecture than the host :
+    # make TARGET=<arch> ; make install
+    where <arch> is the 'uname -m' of the target architecture. 
+    The user has to set the environment variable CC to appropriate
+    compiler for the target architecture.
 
 * SUPPORTED KERNELS
   This makedumpfile supports the following kernels.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
