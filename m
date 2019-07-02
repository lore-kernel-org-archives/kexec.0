Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1hiGfW-0000q9-LI
 for kexec@lists.infradead.org; Tue, 02 Jul 2019 11:09:52 +0000
Date: Tue, 2 Jul 2019 13:09:44 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] x86: Support multiboot2 images
Message-ID: <20190702110944.mcugf6krueakfpam@verge.net.au>
References: <1561630363-6342-1-git-send-email-vrd@amazon.de>
 <1561630363-6342-2-git-send-email-vrd@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1561630363-6342-2-git-send-email-vrd@amazon.de>
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
To: Varad Gautam <vrd@amazon.de>
Cc: Amit Shah <aams@amazon.de>, kexec@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>

On Thu, Jun 27, 2019 at 12:12:43PM +0200, Varad Gautam wrote:
> Add a new type `multiboot2-x86` that allows loading multiboot2 [1] images
> within the relocation range specified in the image header. The image is
> always placed at the lowest available address, regardless of the
> preference information.
> 
> [1] https://www.gnu.org/software/grub/manual/multiboot2/multiboot.html
> 
> Signed-off-by: Varad Gautam <vrd@amazon.de>
> ---
>  include/x86/multiboot2.h         | 416 ++++++++++++++++++++++++++++++
>  kexec/arch/i386/kexec-mb2-x86.c  | 543 +++++++++++++++++++++++++++++++++++++++
>  kexec/arch/i386/kexec-x86.c      |   2 +
>  kexec/arch/x86_64/Makefile       |   1 +
>  kexec/arch/x86_64/kexec-x86_64.c |   2 +
>  kexec/arch/x86_64/kexec-x86_64.h |   5 +
>  kexec/kexec.8                    |  24 ++
>  7 files changed, 993 insertions(+)
>  create mode 100644 include/x86/multiboot2.h
>  create mode 100644 kexec/arch/i386/kexec-mb2-x86.c
> 
> diff --git a/include/x86/multiboot2.h b/include/x86/multiboot2.h
> new file mode 100644
> index 0000000..5693923
> --- /dev/null
> +++ b/include/x86/multiboot2.h
> @@ -0,0 +1,416 @@
> +/*  multiboot2.h - Multiboot 2 header file.  */
> +/*  Copyright (C) 1999,2003,2007,2008,2009,2010  Free Software Foundation, Inc.
> + *
> + *  Permission is hereby granted, free of charge, to any person obtaining a copy
> + *  of this software and associated documentation files (the "Software"), to
> + *  deal in the Software without restriction, including without limitation the
> + *  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
> + *  sell copies of the Software, and to permit persons to whom the Software is
> + *  furnished to do so, subject to the following conditions:
> + *
> + *  The above copyright notice and this permission notice shall be included in
> + *  all copies or substantial portions of the Software.
> + *
> + *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL ANY
> + *  DEVELOPER OR DISTRIBUTOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
> + *  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
> + */

As per my comment on your previous posting of this patch:

multiboot2.h does not appear to be licenced as GPLv2.
This seems incompatible with inclusion in kexec-tools.
Can we discuss this?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
