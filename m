Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q4iln-0001Yo-AE
	for kexec@lists.infradead.org; Tue, 29 Mar 2011 23:56:20 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/3] build: Pass --no-undefined as a linker option
Date: Wed, 30 Mar 2011 08:56:07 +0900
Message-Id: <1301442969-11811-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1301442969-11811-1-git-send-email-horms@verge.net.au>
References: <1301442969-11811-1-git-send-email-horms@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>

gcc-4.6 does not accept --no-undefined as a compiler option

Reported-by: Civil <civil.over@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 purgatory/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index ea0c19a..ee1679c 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -56,8 +56,8 @@ $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 			-I$(srcdir)/include \
 			-I$(shell $(CC) -print-file-name=include)
 $(PURGATORY): LDFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
-			--no-undefined -nostartfiles -nostdlib -nodefaultlibs \
-			-e purgatory_start -r
+			-Wl,--no-undefined -nostartfiles -nostdlib \
+			-nodefaultlibs -e purgatory_start -r
 
 $(PURGATORY): $(PURGATORY_OBJS)
 	$(MKDIR) -p $(@D)
-- 
1.7.2.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
