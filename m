Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-blu.bigfish.com ([65.55.251.10]
	helo=mail25-blu-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HlDbD-0005ls-3V
	for kexec@lists.infradead.org; Mon, 07 May 2007 20:30:41 -0400
Received: from mail25-blu (localhost.localdomain [127.0.0.1])
	by mail25-blu-R.bigfish.com (Postfix) with ESMTP id 9D862F10047
	for <kexec@lists.infradead.org>; Tue,  8 May 2007 00:02:54 +0000 (UTC)
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail25-blu.bigfish.com (Postfix) with ESMTP id 5940F1A005F
	for <kexec@lists.infradead.org>; Tue,  8 May 2007 00:02:54 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com
	[43.130.1.111])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id l4802rJu017707
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:02:53 GMT
Received: from USSDIXIM01.am.sony.com (ussdixim01.am.sony.com [43.130.140.33])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id
	l4802rhx019330
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:02:53 GMT
Message-ID: <463FBE2C.6070804@am.sony.com>
Date: Mon, 07 May 2007 17:02:52 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch 2/5] kexec improve build for ppc64
References: <20070507235727.631477448@am.sony.com>>
In-Reply-To: <20070507235727.631477448@am.sony.com>>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Geoff Levand <geoffrey.levand@am.sony.com>

Powerpc 64 bit platforms support both 64 bit and 32 bit runtimes.  Allow
ARCH= to be specified on the command line to separate the processor arch
from the compiler machine.  This also helps cross-builds with non-standard
compiler names.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 configure.ac |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- kexec-tools-hacked.orig/configure.ac
+++ kexec-tools-hacked/configure.ac
@@ -45,7 +45,12 @@ case $host_cpu in
 		AC_MSG_ERROR([ unsupported architecture $host_cpu])
 		;;
 esac
-ARCH=$host_cpu
+
+dnl Try to guess the kernel ARCH based on the autoconf host_cpu variable.
+
+if ! test "${ARCH}" ; then
+	ARCH=$host_cpu
+fi
 
 dnl ---Options
 
@@ -59,10 +64,14 @@ BUILD_CFLAGS='-O2 -Wall $(CPPFLAGS)'
 
 # Check whether ppc64. Add -m64 for building 64-bit binary
 # Add -mcall-aixdesc to generate dot-symbols as in gcc 3.3.3
-if test "$ARCH" = ppc64; then
+if test "$host_cpu" = ppc64; then
   EXTRA_CFLAGS="$EXTRA_CFLAGS -m64 -mcall-aixdesc"
 fi;
 
+if test "$host_cpu" = ppc; then
+  EXTRA_CFLAGS="$EXTRA_CFLAGS -m32"
+fi;
+
 AC_ARG_WITH([objdir], AC_HELP_STRING([--with-objdir=<dir>],[select directory for object files]),
 	[ OBJDIR="$withval" ], [ OBJDIR="$OBJDIR" ])
 

-- 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
