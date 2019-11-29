Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaUmd-00044A-B8
 for kexec@lists.infradead.org; Fri, 29 Nov 2019 01:09:21 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH] makedumpfile/Makefile: remove -lebl from LIBS
Date: Fri, 29 Nov 2019 09:09:05 +0800
Message-Id: <1574989745-5262-1-git-send-email-piliu@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>

since the following commit, -lebl has been removed from elfutils.
commit b833c731359af12af9f16bcb621b3cdc170eafbc
Author: Mark Wielaard <mark@klomp.org>
Date:   Thu Aug 29 23:34:11 2019 +0200

    libebl: Don't install libebl.a, libebl.h and remove backends from spec.

    All archive members from libebl.a are now in libdw.a. We don't generate
    separate backend shared libraries anymore. So remove them from the
    elfutils.spec file.

    Signed-off-by: Mark Wielaard <mark@klomp.org>

So remove it from LIBS for makedumpfile

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1fdb628..df21b93 100644
--- a/Makefile
+++ b/Makefile
@@ -50,7 +50,7 @@ OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
 
-LIBS = -ldw -lbz2 -lebl -ldl -lelf -lz
+LIBS = -ldw -lbz2 -ldl -lelf -lz
 ifneq ($(LINKTYPE), dynamic)
 LIBS := -static $(LIBS)
 endif
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
