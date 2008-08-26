Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.245])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KXwSZ-00071v-9L
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 11:11:39 +0000
Received: by rv-out-0708.google.com with SMTP id b17so1911060rvf.42
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 04:11:37 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Aug 2008 20:11:50 +0900
Message-Id: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
Subject: [PATCH 00/06] sh: Improved kexec support for SuperH
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

Here comes a few SuperH related patches. Trivial stuff - fixing up plain
kexec support. Kdump is not ready yet. I also have have a few kdump changes
in my local tree but they need more work.

[PATCH 01/06] sh: Add support for sh4al-dsp processors
[PATCH 02/06] sh: Get system memory ranges from /proc/iomem
[PATCH 03/06] sh: Add virtual addresses support
[PATCH 04/06] sh: Autodetect zImage zero page address
[PATCH 05/06] sh: Use dynamic zImage load address
[PATCH 06/06] sh: Add vmlinux support

Tested with 2.6.27-rc on SuperH Mobile processor models sh7722/sh7723.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/arch/sh/Makefile          |    5 +
 kexec/arch/sh/kexec-elf-sh.c    |  114 +++++++++++++++++++++++++++++++++++++++
 kexec/arch/sh/kexec-sh.c        |   97 ++++++++++++++++++++++-----------
 kexec/arch/sh/kexec-sh.h        |    8 ++
 kexec/arch/sh/kexec-zImage-sh.c |   96 +++++++++++++++++++++++---------
 5 files changed, 260 insertions(+), 60 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
