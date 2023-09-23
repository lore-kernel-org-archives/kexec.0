Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3B2CE7A88
	for <kexec@archiver.kernel.org>; Sat, 23 Sep 2023 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=aaUfHxm2QgPWMnlkdl8a2VLP8WGRLM91ICKP/XbMtKo=; b=0n0yZBCM/agKhi
	5P4JDsIQ2YVpSuWAS67JTFg2urLoVf+h24fwri5XN8PmS3wjFRHkIsmJotnrL40AwRb+ViSjk7YD6
	IizSGqcHIgKkMvvw4X5PtXml7FX6NrC9tNkKzuixy0qoCw0EnEHvzhcSJsWjt5Nd6ItrjrcNjSVIf
	uoCsWwuLgjV+fkhITOHyE2pLGhzBVYGB6QNdho9MCV0JS1xvXqCTVzT5wm7gGgBzE9SmlUIY58Vsn
	hsFLjHNz/80SBtMuZBU+OQtoPw0UoeYzbgv8PZh2rQ2asJ8C811iWueie5dOVi8DfZijIVamMQwON
	/VS/miVwFGbwAWp9d3/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qk5mD-00BDrE-0T;
	Sat, 23 Sep 2023 16:46:41 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qk5m9-00BDqp-1f
	for kexec@lists.infradead.org;
	Sat, 23 Sep 2023 16:46:39 +0000
Received: from home.juju.sh (unknown [IPv6:2a01:e0a:485:b220:64fe:9015:874f:9d44])
	(Authenticated sender: ju.o@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 5570613F89C;
	Sat, 23 Sep 2023 18:46:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1695487594;
	bh=HNEl33IcTdmopKPOCQHMFWo4FIZaAZWn4yTrl797pJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=Qz6Y16es4qM4HVluNEVd7z1pRHPHX+7ilFGtO8LkXSpSiD10FVTm1cQ+Adw66xXEU
	 e+N/Vc22F5IZp1LUBYVcqdqlSH5XoRg18KcO9/RupMQdHP/MSphihFMf9UpSYBI7nB
	 mb0pI4Yu/YXXfQT7PfYq0lOy/KG1JpBU3w0yPZqYzQjS+eMgi06qCYm0ZNIvvHJ38m
	 XaMXcw8rqlDLE44Bt4J7eiA/UW3hsQ9yRtSITLHOg49zKOA+UIHyOCd0wmzeiBhW7m
	 i19PDYxUMwh8Pjb7GqCLQxSgtmnRTr10yU8nVB0/nV47yVvfl7wpAlBnsOA+t15pFN
	 RN5rlIa2lTx0g==
From: Julien Olivain <ju.o@free.fr>
To: kexec@lists.infradead.org
Cc: Julien Olivain <ju.o@free.fr>
Subject: [PATCH 1/1] kexec: provide a memfd_create() wrapper if not present in libc
Date: Sat, 23 Sep 2023 18:46:06 +0200
Message-ID: <20230923164606.58424-1-ju.o@free.fr>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230923_094637_721307_6C222610 
X-CRM114-Status: GOOD (  16.66  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Commit 714fa115 "kexec/arm64: Simplify the code for zImage" introduced
a use of the memfd_create() system call, included in version
kexec-tools v2.0.27.

This system call was introduced in kernel commit [1], first included
in kernel v3.17 (released on 2014-10-05).

The memfd_create() glibc wrapper function was added much later in
commit [2], first included in glibc version 2.27 (released on
2018-02-01).

This direct use memfd_create() introduced a requirement on
Kernel >= 3.17 and glibc >= 2.27.

There is old toolchains like [3] for example (which ships gcc 7.3.1,
glibc 2.25 and includes kernel v4.10 headers), that can still be used
to build newer kernels. Even if such toolchains can be seen as
outdated, they are is still claimed as supported by recent kernel.
For example, Kernel v6.5.5 has a requirement on gcc version 5.1 and
greater. See [4].

Moreover, kexec-tools <= 2.0.26 could be compiled using recent
toolchains with alternative libc (e.g. uclibc-ng, musl) which are not
providing the memfd_create() wrapper.

When compiling kexec-tools v2.0.27 with a toolchain not providing the
memfd_create() syscall wrapper, the compilation fail with message:

    kexec/kexec.c: In function 'copybuf_memfd':
    kexec/kexec.c:645:7: warning: implicit declaration of function 'memfd_create'; did you mean 'SYS_memfd_create'? [-Wimplicit-function-declaration]
      fd = memfd_create("kernel", MFD_ALLOW_SEALING);
           ^~~~~~~~~~~~
           SYS_memfd_create
    kexec/kexec.c:645:30: error: 'MFD_ALLOW_SEALING' undeclared (first use in this function); did you mean '_PC_ALLOC_SIZE_MIN'?
      fd = memfd_create("kernel", MFD_ALLOW_SEALING);
                                  ^~~~~~~~~~~~~~~~~
                                  _PC_ALLOC_SIZE_MIN

In order to let kexec-tools compile in a wider range of configurations,
this commit adds a memfd_create() function check in autoconf configure
script, and adds a system call wrapper which will be used if the
function is not available. With this commit, the environment
requirement is relaxed to only kernel >= v3.17.

Note: this issue was found in kexec-tools integration in Buildroot [5]
using the command "utils/test-pkg -a -p kexec", which tests many
toolchain/arch combinations.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=9183df25fe7b194563db3fec6dc3202a5855839c
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=59d2cbb1fe4b8601d5cbd359c3806973eab6c62d
[3] https://releases.linaro.org/components/toolchain/binaries/7.3-2018.05/aarch64-linux-gnu/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz
[4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/process/changes.rst?h=v6.5.5#n32
[5] https://buildroot.org/

Signed-off-by: Julien Olivain <ju.o@free.fr>
---
 configure.ac  |  3 +++
 kexec/kexec.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/configure.ac b/configure.ac
index 352eefe..602de79 100644
--- a/configure.ac
+++ b/configure.ac
@@ -208,6 +208,9 @@ if test "$ac_cv_lib_xenctrl_xc_kexec_load" = yes ; then
 		AC_MSG_NOTICE([The kexec_status call is not available]))
 fi
 
+dnl Check if libc has the memfd_create() syscall wrapper
+AC_CHECK_FUNCS([memfd_create])
+
 dnl ---Sanity checks
 if test "$CC"      = "no"; then AC_MSG_ERROR([cc not found]); fi
 if test "$CPP"     = "no"; then AC_MSG_ERROR([cpp not found]); fi
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 1edbd34..946f831 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -31,6 +31,10 @@
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#ifndef HAVE_MEMFD_CREATE
+#include <linux/memfd.h>
+#include <sys/syscall.h>
+#endif
 #include <sys/reboot.h>
 #include <sys/mman.h>
 #include <unistd.h>
@@ -638,6 +642,13 @@ char *slurp_decompress_file(const char *filename, off_t *r_size)
 	return kernel_buf;
 }
 
+#ifndef HAVE_MEMFD_CREATE
+static int memfd_create(const char *name, unsigned int flags)
+{
+	return syscall(SYS_memfd_create, name, flags);
+}
+#endif
+
 static int copybuf_memfd(const char *kernel_buf, size_t size)
 {
 	int fd, count;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
