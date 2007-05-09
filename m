Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]
	helo=outbound2-blu-R.bigfish.com)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hla7O-0003gZ-EA
	for kexec@lists.infradead.org; Wed, 09 May 2007 01:33:26 +0100
Message-ID: <464116C7.3060304@am.sony.com>
Date: Tue, 08 May 2007 17:33:11 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch 1/2] kexec add strict-prototypes
References: <20070507235727.631477448@am.sony.com>>
	<463FBE30.8080500@am.sony.com> <20070508023811.GA8170@verge.net.au>
In-Reply-To: <20070508023811.GA8170@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Add the complier flag -Wstrict-prototypes to EXTRA_CFLAGS.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 configure.ac                   |    2 -

--- kexec-tools-hacked.orig/configure.ac
+++ kexec-tools-hacked/configure.ac
@@ -59,7 +59,7 @@ if test "${host_alias}" ; then
 	OBJDIR="$OBJDIR-${host_alias}"
 fi 
 
-EXTRA_CFLAGS='-Wall -g -fno-strict-aliasing $(CPPFLAGS) $(EXTRA_CPPFLAGS)'
+EXTRA_CFLAGS='-Wall -g -fno-strict-aliasing -Wstrict-prototypes $(CPPFLAGS) $(EXTRA_CPPFLAGS)'
 BUILD_CFLAGS='-O2 -Wall $(CPPFLAGS)'
 
 # Check whether ppc64. Add -m64 for building 64-bit binary



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
