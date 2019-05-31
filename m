Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hWdka-0004xJ-2a
 for kexec@lists.infradead.org; Fri, 31 May 2019 09:23:01 +0000
Date: Fri, 31 May 2019 11:22:56 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/3] x86: Support multiboot2 images
Message-ID: <20190531092256.5kvnkfhpa6oweewi@verge.net.au>
References: <1558423948-24583-1-git-send-email-vrd@amazon.de>
 <1558423948-24583-3-git-send-email-vrd@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1558423948-24583-3-git-send-email-vrd@amazon.de>
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
Cc: kexec@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>

On Tue, May 21, 2019 at 09:32:28AM +0200, Varad Gautam wrote:
> Add a new type `multiboot2-x86` that allows loading multiboot2 images
> within the relocation range specified in the image header. The image is
> always placed at the lowest available address, regardless of the
> preference information.
> 
> Also make multiboot2 take priority over multiboot if the -t flag isn't
> specified.
> 
> Signed-off-by: Varad Gautam <vrd@amazon.de>
> ---
>  doc/multiboot2.html              | 2716 ++++++++++++++++++++++++++++++++++++++

multiboot2.html does not appear to be licenced as GPLv2.
Is it possible to provide a link to this document
rather than the text itself?

>  include/x86/multiboot2.h         |  416 ++++++
>  kexec/arch/i386/kexec-mb2-x86.c  |  543 ++++++++
>  kexec/arch/i386/kexec-x86.c      |    2 +
>  kexec/arch/x86_64/Makefile       |    1 +
>  kexec/arch/x86_64/kexec-x86_64.c |    2 +
>  kexec/arch/x86_64/kexec-x86_64.h |    5 +
>  kexec/kexec.8                    |   24 +
>  8 files changed, 3709 insertions(+)
>  create mode 100644 doc/multiboot2.html
>  create mode 100644 include/x86/multiboot2.h
>  create mode 100644 kexec/arch/i386/kexec-mb2-x86.c

...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
