Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=outbound7-dub-R.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JPt8T-0000Dn-Pk
	for kexec@lists.infradead.org; Fri, 15 Feb 2008 05:29:29 +0000
Message-ID: <47B522B7.5060308@am.sony.com>
Date: Thu, 14 Feb 2008 21:27:19 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch] kexec: Use target linker for purgatory
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
Cc: kexec@lists.infradead.org, Jeremy Kerr <jk@ozlabs.org>


From: Geoff Levand <geoffrey.levand@am.sony.com>

Pugatory files need to be linked with the target linker,
not the build linker.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

Hi, 

This is a resend from last December. It fixes a cross compile
build error.  Please appy.

-Geoff

diff --git a/purgatory/Makefile b/purgatory/Makefile
index a543cdb..e7d2f15 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -42,7 +42,7 @@ $(PURGATORY): LDFLAGS+=--no-undefined -nostartfiles -nostdlib -nodefaultlibs \
 
 $(PURGATORY): $(PURGATORY_OBJS)
 	$(MKDIR) -p $(@D)
-	$(LD) $(LDFLAGS) -o $@ $^
+	$(CC) $(LDFLAGS) -o $@ $^
 
 #	$(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) --no-undefined -e purgatory_start -r -o $@ $(PURGATORY_OBJS) $(UTIL_LIB)
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
