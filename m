Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KdvdC-0006py-OU
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 23:31:23 +0000
Date: Fri, 12 Sep 2008 09:31:21 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [kexec patch 2/2] Fix ppc64 build warnings
Message-ID: <20080911233119.GH10635@verge.net.au>
References: <48C8771E.40502@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48C8771E.40502@am.sony.com>
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

On Wed, Sep 10, 2008 at 06:40:46PM -0700, Geoff Levand wrote:
> Fix these ppc64 32 bit build warnings:
> 
>  kexec/arch/ppc64/kexec-zImage-ppc64.c: In function 'zImage_ppc64_load':
>  kexec/arch/ppc64/kexec-zImage-ppc64.c:164: warning: cast to pointer from integer of different size
>  kexec/arch/ppc64/kexec-elf-ppc64.c: In function 'elf_ppc64_load':
>  kexec/arch/ppc64/kexec-elf-ppc64.c:121: warning: integer constant is too large for 'unsigned long' type
>  kexec/arch/ppc64/kexec-elf-ppc64.c:237: warning: cast from pointer to integer of different size
>  kexec/arch/ppc64/kexec-elf-ppc64.c:276: warning: cast from pointer to integer of different size
>  kexec/arch/ppc64/kexec-elf-ppc64.c:283: warning: cast from pointer to integer of different size
>  kexec/arch/ppc64/kexec-elf-ppc64.c:287: warning: cast from pointer to integer of different size
>  kexec/arch/ppc64/kexec-elf-ppc64.c:341: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'uint64_t'
>  kexec/arch/ppc64/kexec-elf-ppc64.c:352: warning: format '%ld' expects type 'long int', but argument 5 has type 'size_t'
>  kexec/arch/ppc64/crashdump-ppc64.c:45: warning: integer constant is too large for 'long' type
>  kexec/arch/ppc64/crashdump-ppc64.c:46: warning: integer constant is too large for 'long' type
>  kexec/arch/ppc64/crashdump-ppc64.c:56: warning: integer constant is too large for 'long' type
>  kexec/arch/ppc64/crashdump-ppc64.c:57: warning: integer constant is too large for 'long' type
> 
> Tested on PS3 (ppc64) with 32 and 64 bit builds. 

Thanks, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
