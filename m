Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.17.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGLKu-00025p-3K
 for kexec@lists.infradead.org; Fri, 04 Oct 2019 11:01:25 +0000
Date: Fri, 4 Oct 2019 13:01:09 +0200
From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] kexec-tools: Fix conversion overflow when compiling on
 32-bit platforms
Message-ID: <20191004110109.GA15439@ls3530.fritz.box>
References: <20191001151416.GA25667@ls3530.fritz.box>
 <20191003081406.5qmzlmlpwobydfok@verge.net.au>
 <2ac17dd1-99ef-3528-a05e-d51f8af01c95@gmx.de>
 <20191004093737.wftu7iat2gk3abq6@verge.net.au>
 <8157edc8-69cb-33b8-ae1c-7a0d80845c9d@gmx.de>
 <20191004101423.jqpakrotimjjyp3w@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191004101423.jqpakrotimjjyp3w@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org
Cc: Sven Schnelle <svens@stackframe.org>

When compiling kexec-tools on a 32-bit platform, assigning an
(unsigned long long) value to an (unsigned long) variable creates
this warning:

elf_info.c: In function 'read_phys_offset_elf_kcore':
elf_info.c:805:14: warning: conversion from 'long long unsigned int' to
     'long unsigned int' changes value from '18446744073709551615' to '4294967295'
  805 |  *phys_off = UINT64_MAX;

Fix it by using ULONG_MAX instead of UINT64_MAX.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 2bce5cb..7803a94 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -802,7 +802,7 @@ int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off)
 {
 	int ret;

-	*phys_off = UINT64_MAX;
+	*phys_off = ULONG_MAX;

 	ret = read_elf(fd);
 	if (!ret) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
