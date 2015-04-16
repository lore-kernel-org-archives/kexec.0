Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yitc5-0007wZ-Qd
 for kexec@lists.infradead.org; Thu, 16 Apr 2015 23:54:30 +0000
Date: Fri, 17 Apr 2015 08:54:05 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RFC 0/6] Various fixes for purgatory and ARM64
Message-ID: <20150416235405.GA6880@verge.net.au>
References: <cover.1429201849.git.panand@redhat.com>
 <cover.1429201849.git.panand@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1429201849.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org

Hi,

On Thu, Apr 16, 2015 at 10:17:23PM +0530, Pratyush Anand wrote:
> These patches can be applied on top of Geoff's Kexec [1] and Takahiro's
> Kdump [2] patches and are available in my tree [3].
> 
> First two patches are for purgatory. 1st patch is a very important fix
> for sha verification.  2nd patch is good to have.
> 
> Rest all patches are fixes and addon for ARM64.
> 
> These patchset adds three extra command line options for ARM64.
> 
>  --page-offset: Needed for binary image only. Default value is
> 0xfffffe0000000000.
> 
>  --port-lsr: It is UART's Line status register address. Normally for a
> UART based on 8250, 16450 or 16550 should have value as --port's value +
> 0x14.
> 
>  --port-lsr-val: It is the SET value of LSR register for TX buffer to be
> empty. Normally for above UARTs it should be 0x60 
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git
> : master
> [2] git://git.linaro.org/people/takahiro.akashi/kexec-tools.git :
> kdump/v0.10
> [3] https://github.com/pratyushanand/kexec-tools.git : master
> (6c8a63f701e9)

I'm more than happy to consider accepting patches into my
kexec tree if they are in a suitable state.

> Pratyush Anand (6):
>   purgatory: Fix memcmp for src address increment
>   purgatory: No need to sha256 update if ptr->len is zero
>   arm64: allocate memory for other segments after kernel
>   arm64: support reuse-cmdline option
>   arm64: Add support for binary image
>   arm64: wait for transmit completion before next character transmission
> 
>  kexec/arch/arm64/crashdump-arm64.c      |  3 +-
>  kexec/arch/arm64/crashdump-arm64.h      |  1 +
>  kexec/arch/arm64/include/arch/options.h | 21 +++++++++++--
>  kexec/arch/arm64/kexec-arm64.c          | 28 ++++++++++++++++-
>  kexec/arch/arm64/kexec-arm64.h          |  2 ++
>  kexec/arch/arm64/kexec-image-arm64.c    | 54 ++++++++++++++++++++++++++++++---
>  purgatory/arch/arm64/entry.S            | 10 ++++++
>  purgatory/arch/arm64/purgatory-arm64.c  | 22 +++++++++++++-
>  purgatory/purgatory.c                   |  2 ++
>  purgatory/string.c                      |  2 ++
>  10 files changed, 135 insertions(+), 10 deletions(-)
> 
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
