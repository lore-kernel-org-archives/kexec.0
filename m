Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-Id: <58247026f0a2a041eb43a29bc9d9d0a367a694c8.1380746425.git.geoff@infradead.org>
In-Reply-To: <cover.1380746425.git.geoff@infradead.org>
References: <cover.1380746425.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 3/6] purgatory: Fix out-of-source build error
Date: Wed, 02 Oct 2013 20:49:46 +0000
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

The source file config.h is a generated file, so its preprocessor include path must be
relative to the build directory.  Add that path to the purgatory CPPFLAGS.

Fixes build errors like these:

  purgatory/arch/ppc/misc.S: fatal error: config.h: No such file or directory

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index e39adec..1945702 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -54,6 +54,7 @@ $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 			-I$(srcdir)/purgatory/arch/$(ARCH)/include \
 			-I$(srcdir)/util_lib/include \
 			-I$(srcdir)/include \
+			-Iinclude \
 			-I$(shell $(CC) -print-file-name=include)
 $(PURGATORY): LDFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
 			-Wl,--no-undefined -nostartfiles -nostdlib \
-- 
1.8.1.2



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
