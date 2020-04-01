Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJcp1-0000xC-E1
 for kexec@lists.infradead.org; Wed, 01 Apr 2020 12:50:20 +0000
Date: Wed, 1 Apr 2020 14:50:15 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Remove duplicated variable declarations
Message-ID: <20200401125015.GF29376@vergenet.net>
References: <20200129053819.622511-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200129053819.622511-1-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, Jan 29, 2020 at 01:38:19PM +0800, Kairui Song wrote:
> When building kexec-tools for Fedora 32, following error is observed:
> 
> /usr/bin/ld: kexec/arch/x86_64/kexec-bzImage64.o:(.bss+0x0): multiple definition of `bzImage_support_efi_boot';
> kexec/arch/i386/kexec-bzImage.o:(.bss+0x0): first defined here
> 
> /builddir/build/BUILD/kexec-tools-2.0.20/kexec/arch/arm/../../fs2dt.h:33: multiple definition of `my_debug';
> kexec/fs2dt.o:/builddir/build/BUILD/kexec-tools-2.0.20/kexec/fs2dt.h:33: first defined here
> 
> /builddir/build/BUILD/kexec-tools-2.0.20/kexec/arch/arm64/kexec-arm64.h:68: multiple definition of `arm64_mem';
> kexec/fs2dt.o:/builddir/build/BUILD/kexec-tools-2.0.20/././kexec/arch/arm64/kexec-arm64.h:68: first defined here
> 
> /builddir/build/BUILD/kexec-tools-2.0.20/kexec/arch/arm64/kexec-arm64.h:54: multiple definition of `initrd_size';
> kexec/fs2dt.o:/builddir/build/BUILD/kexec-tools-2.0.20/././kexec/arch/arm64/kexec-arm64.h:54: first defined here
> 
> /builddir/build/BUILD/kexec-tools-2.0.20/kexec/arch/arm64/kexec-arm64.h:53: multiple definition of `initrd_base';
> kexec/fs2dt.o:/builddir/build/BUILD/kexec-tools-2.0.20/././kexec/arch/arm64/kexec-arm64.h:53: first defined here
> 
> And apparently, these variables are wrongly declared multiple times. So
> remove duplicated declaration.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
