Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HrCkt-0008OX-QD
	for kexec@lists.infradead.org; Thu, 24 May 2007 13:49:27 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4OCn2vA002327
	for <kexec@lists.infradead.org>; Thu, 24 May 2007 08:49:02 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4OCn2jF260246
	for <kexec@lists.infradead.org>; Thu, 24 May 2007 06:49:02 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4OCn29O012177
	for <kexec@lists.infradead.org>; Thu, 24 May 2007 06:49:02 -0600
Date: Thu, 24 May 2007 18:19:36 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
Subject: [PATCH] fix kexec-tools options
Message-ID: <20070524124936.GA7982@in.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
Reply-To: maneesh@in.ibm.com
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
Cc: mikey@neuling.org, horms@verge.net.au


o value for OPT_REUSE_INITRD clashes with arch specific options which are
  defined as (OPT_MAX + 1), like --serial option on x86_64. Changed the
  values so that OPT_REUSE_INITRD is less than OPT_MAX.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>

----
--- kexec.h.orig	2007-05-15 10:06:33.000000000 +0530
+++ kexec.h	2007-05-24 17:37:34.000000000 +0530
@@ -162,8 +162,8 @@
 #define OPT_PANIC		'p'
 #define OPT_MEM_MIN             256
 #define OPT_MEM_MAX             257
-#define OPT_MAX			258
-#define OPT_REUSE_INITRD	259
+#define OPT_REUSE_INITRD	258
+#define OPT_MAX			259
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \


Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center,
IBM India Systems and Technology Lab, 
Bangalore, India

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
