Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XPCVB-0001Jc-8d
 for kexec@lists.infradead.org; Wed, 03 Sep 2014 15:29:41 +0000
Date: Wed, 3 Sep 2014 11:29:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] Return error code in case of invalid command line option
Message-ID: <20140903152917.GA23097@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Kexec Mailing List <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>

Currently kexec returns success even if an invalid command line option
is encountered. Kexec currently prints usage message and then returns
0. That's not right. It is an error and error code 1 should be returned.

Due to this wrapper script thinks that kdump succeeded but that's not
the case.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 kexec/kexec.c |    2 ++
 1 file changed, 2 insertions(+)

Index: kexec-tools/kexec/kexec.c
===================================================================
--- kexec-tools.orig/kexec/kexec.c	2014-08-28 15:36:17.563115135 -0400
+++ kexec-tools/kexec/kexec.c	2014-09-03 11:19:46.505871590 -0400
@@ -1209,6 +1209,8 @@ int main(int argc, char *argv[])
 				  options, 0)) != -1) {
 		switch(opt) {
 		case '?':
+			usage();
+			return 1;
 		case OPT_HELP:
 			usage();
 			return 0;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
