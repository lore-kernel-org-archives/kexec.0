Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HrDoK-0007y7-JK
	for kexec@lists.infradead.org; Thu, 24 May 2007 09:57:03 -0400
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] fix kexec-tools options 
In-reply-to: <20070524124936.GA7982@in.ibm.com> 
References: <20070524124936.GA7982@in.ibm.com>
Date: Thu, 24 May 2007 23:56:52 +1000
Message-ID: <26898.1180015012@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: maneesh@in.ibm.com
Cc: horms@verge.net.au, kexec@lists.infradead.org

> o value for OPT_REUSE_INITRD clashes with arch specific options which are
>   defined as (OPT_MAX + 1), like --serial option on x86_64. Changed the
>   values so that OPT_REUSE_INITRD is less than OPT_MAX.
> 
> Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>

Oops.. thanks for fixing.

> ----
> --- kexec.h.orig	2007-05-15 10:06:33.000000000 +0530
> +++ kexec.h	2007-05-24 17:37:34.000000000 +0530

BTW the path has been stripped here, so this patch doesn't apply.  I've
fixed it up and reposted below.

Mikey


o value for OPT_REUSE_INITRD clashes with arch specific options which
  are defined as (OPT_MAX + 1), like --serial option on x86_64. Changed
  the values so that OPT_REUSE_INITRD is less than OPT_MAX.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Acked-by: Michael Neuling <mikey@neuling.org>
---
 kexec/kexec.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: kexec-tools-testing/kexec/kexec.h
===================================================================
--- kexec-tools-testing.orig/kexec/kexec.h
+++ kexec-tools-testing/kexec/kexec.h
@@ -162,8 +162,8 @@ extern int file_types;
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
