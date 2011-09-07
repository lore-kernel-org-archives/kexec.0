Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R1Fli-0005dS-BZ
	for kexec@lists.infradead.org; Wed, 07 Sep 2011 10:54:11 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p878gtox009964
	for <kexec@lists.infradead.org>; Wed, 7 Sep 2011 08:42:55 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p878gto52371612
	for <kexec@lists.infradead.org>; Wed, 7 Sep 2011 09:42:55 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p878gpIm011658
	for <kexec@lists.infradead.org>; Wed, 7 Sep 2011 02:42:51 -0600
Subject: [PATCH] kexec-tools: Add --append option for s390
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 07 Sep 2011 10:42:50 +0200
Message-ID: <1315384970.7763.5.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Hello Simon,

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

All architectures define the "--append" option together with the
"--command-line" option to specify kernel parameters. This option
is also used by kdump init scripts. In order to be compatible this
patch introduces the "--append" option also for s390. In addition
to that the help text is adjusted so that it is now the same as on
all other architectures.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kexec/arch/s390/include/arch/options.h |    1 +
 kexec/arch/s390/kexec-image.c          |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/kexec/arch/s390/include/arch/options.h
+++ b/kexec/arch/s390/include/arch/options.h
@@ -30,6 +30,7 @@
 #define KEXEC_ALL_OPTIONS				\
 	KEXEC_ARCH_OPTIONS				\
 	{"command-line",     1, 0, OPT_APPEND},		\
+	{"append",           1, 0, OPT_APPEND},		\
 	{"initrd",	     1, 0, OPT_RAMDISK},
 
 #define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -61,6 +61,7 @@ image_s390_load(int argc, char **argv, c
 		{
 			KEXEC_OPTIONS
 			{"command-line",     1, 0, OPT_APPEND},
+			{"append",           1, 0, OPT_APPEND},
 			{"initrd",           1, 0, OPT_RAMDISK},
 			{0,                  0, 0, 0},
 		};
@@ -160,7 +161,8 @@ image_s390_probe(const char *UNUSED(kern
 void
 image_s390_usage(void)
 {
-	printf("--command-line=STRING Pass a custom command line STRING to the kernel.\n"
+	printf("--command-line=STRING Set the kernel command line to STRING.\n"
+	       "--append=STRING       Set the kernel command line to STRING.\n"
 	       "--initrd=FILENAME     Use the file FILENAME as a ramdisk.\n"
 		);
 }



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
