Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kx8iB-0007T8-2X
	for kexec@lists.infradead.org; Mon, 03 Nov 2008 23:19:55 +0000
Date: Tue, 4 Nov 2008 10:19:53 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] powerpc32: pull in libfdt
Message-ID: <20081103231952.GB24084@verge.net.au>
References: <1225749543-32683-1-git-send-email-sebastian@breakpoint.cc>
	<1225749543-32683-4-git-send-email-sebastian@breakpoint.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1225749543-32683-4-git-send-email-sebastian@breakpoint.cc>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org

On Mon, Nov 03, 2008 at 10:59:02PM +0100, Sebastian Andrzej Siewior wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This is v1.2.0 of libfdt from the dtc project which is available at
>  git://www.jdl.com/software/dtc.git
> 
> The other files
> - include/page.h
> - include/types.h
> - libfdt-wrapper.c
> - ops.h
> 
> are part of the glue code which is used the powerpc boot wrapper code
> is comming from the Linux kernel v2.6.27-rc6 and has been modified a
> little to fit.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The diff seems to be missing :-)

> ---
>  kexec/arch/ppc/Makefile                 |   11 +-
>  kexec/arch/ppc/include/page.h           |   34 +
>  kexec/arch/ppc/include/types.h          |   27 +
>  kexec/arch/ppc/libfdt-wrapper.c         |  189 ++++++
>  kexec/arch/ppc/libfdt/Makefile.libfdt   |    8 +
>  kexec/arch/ppc/libfdt/TODO              |    3 +
>  kexec/arch/ppc/libfdt/fdt.c             |  201 ++++++
>  kexec/arch/ppc/libfdt/fdt.h             |   60 ++
>  kexec/arch/ppc/libfdt/fdt_ro.c          |  466 +++++++++++++
>  kexec/arch/ppc/libfdt/fdt_rw.c          |  463 +++++++++++++
>  kexec/arch/ppc/libfdt/fdt_strerror.c    |   96 +++
>  kexec/arch/ppc/libfdt/fdt_sw.c          |  257 ++++++++
>  kexec/arch/ppc/libfdt/fdt_wip.c         |  145 +++++
>  kexec/arch/ppc/libfdt/libfdt.h          | 1076 +++++++++++++++++++++++++++++++
>  kexec/arch/ppc/libfdt/libfdt_env.h      |   23 +
>  kexec/arch/ppc/libfdt/libfdt_internal.h |   95 +++
>  kexec/arch/ppc/ops.h                    |  151 +++++
>  17 files changed, 3304 insertions(+), 1 deletions(-)
>  create mode 100644 kexec/arch/ppc/include/page.h
>  create mode 100644 kexec/arch/ppc/include/types.h
>  create mode 100644 kexec/arch/ppc/libfdt-wrapper.c
>  create mode 100644 kexec/arch/ppc/libfdt/Makefile.libfdt
>  create mode 100644 kexec/arch/ppc/libfdt/TODO
>  create mode 100644 kexec/arch/ppc/libfdt/fdt.c
>  create mode 100644 kexec/arch/ppc/libfdt/fdt.h
>  create mode 100644 kexec/arch/ppc/libfdt/fdt_ro.c
>  create mode 100644 kexec/arch/ppc/libfdt/fdt_rw.c
>  create mode 100644 kexec/arch/ppc/libfdt/fdt_strerror.c
>  create mode 100644 kexec/arch/ppc/libfdt/fdt_sw.c
>  create mode 100644 kexec/arch/ppc/libfdt/fdt_wip.c
>  create mode 100644 kexec/arch/ppc/libfdt/libfdt.h
>  create mode 100644 kexec/arch/ppc/libfdt/libfdt_env.h
>  create mode 100644 kexec/arch/ppc/libfdt/libfdt_internal.h
>  create mode 100644 kexec/arch/ppc/ops.h
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
