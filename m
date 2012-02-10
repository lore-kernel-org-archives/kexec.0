Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RvnvQ-0001k1-Dq
 for kexec@lists.infradead.org; Fri, 10 Feb 2012 10:41:58 +0000
Date: Fri, 10 Feb 2012 18:42:35 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v1 1/3] [makedumpfile] Support for cross building
Message-Id: <20120210184235.0f4a5dd2.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120118100755.29422.5803.stgit@suzukikp.in.ibm.com>
References: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
 <20120118100755.29422.5803.stgit@suzukikp.in.ibm.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: suzuki@in.ibm.com
Cc: kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp

Hi, Suzuki

On Wed, 18 Jan 2012 15:39:14 +0530
"Suzuki K. Poulose" <suzuki@in.ibm.com> wrote:

> Support cross building of makedumpfile. This would be useful for building
> the makedumpfile for embedded PPC boards. Support for PPC32 would be added
> in the later patches.
> 
> Use TARGET variable to set the arch to build for. Also honour the value of
> CC if set.
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> ---
> 
>  Makefile |   12 +++++++++++-
>  README   |    5 +++++
>  2 files changed, 16 insertions(+), 1 deletions(-)

This patch looks good.
I will merge it to makedumpfile-1.4.3.

Thanks
Atsushi Kumagai

> Support cross building of makedumpfile. This would be useful for building
> the makedumpfile for embedded PPC boards. Support for PPC32 would be added
> in the later patches.
> 
> Use TARGET variable to set the arch to build for. Also honour the value of
> CC if set.
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> ---
> 
>  Makefile |   12 +++++++++++-
>  README   |    5 +++++
>  2 files changed, 16 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 9afbe1c..174a0d9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3,7 +3,11 @@
>  VERSION=1.4.1
>  DATE=6 January 2012
>  
> +# Honour the environment variable CC
> +ifeq ($(strip $CC),)
>  CC	= gcc
> +endif
> +
>  CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
>  	  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
>  	  -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
> @@ -11,7 +15,13 @@ CFLAGS_ARCH	= -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
>  		    -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
>  # LDFLAGS = -L/usr/local/lib -I/usr/local/include
>  
> -ARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
> +# Use TARGET as the target architecture if specified.
> +# Defaults to uname -m
> +ifeq ($(strip($TARGET)),)
> +TARGET := $(shell uname -m)
> +endif
> +
> +ARCH := $(shell echo ${TARGET}  | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
>  			       -e s/arm.*/arm/ -e s/sa110/arm/ \
>  			       -e s/s390x/s390/ -e s/parisc64/parisc/ \
>  			       -e s/ppc64/powerpc/ )
> diff --git a/README b/README
> index 8aa4ab3..595b446 100644
> --- a/README
> +++ b/README
> @@ -37,6 +37,11 @@
>      # cd makedumpfile-x.y.z
>    4.Build, and install:
>      # make; make install
> +  5.Build for a different architecture than the host :
> +    # make TARGET=<arch> ; make install
> +    where <arch> is the 'uname -m' of the target architecture. 
> +    The user has to set the environment variable CC to appropriate
> +    compiler for the target architecture.
>  
>  * SUPPORTED KERNELS
>    This makedumpfile supports the following kernels.
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
