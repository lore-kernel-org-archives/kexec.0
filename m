Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSZgg-0004tq-VM
 for kexec@lists.infradead.org; Fri, 30 Nov 2018 03:41:56 +0000
Date: Fri, 30 Nov 2018 11:41:29 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2 v8] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
Message-ID: <20181130034129.GA26791@dhcp-128-65.nay.redhat.com>
References: <20181129080956.20776-1-lijiang@redhat.com>
 <20181129080956.20776-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129080956.20776-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: tony.luck@intel.com, fenghua.yu@intel.com, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, bhe@redhat.com, ard.biesheuvel@linaro.org, peterz@infradead.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org

On 11/29/18 at 04:09pm, Lianbo Jiang wrote:
> When doing kexec_file_load, the first kernel needs to pass the e820
> reserved ranges to the second kernel. But kernel can not exactly
> match the e820 reserved ranges when walking through the iomem resources
> with the descriptor 'IORES_DESC_NONE', because several e820 types(
> e.g. E820_TYPE_RESERVED_KERN/E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820
> _TYPE_RESERVED) are converted to the descriptor 'IORES_DESC_NONE'. It
> may pass these four types to the kdump kernel, that is not desired result.
> 
> So, this patch adds a new I/O resource descriptor 'IORES_DESC_RESERVED'
> for the iomem resources search interfaces. It is helpful to exactly
> match the reserved resource ranges when walking through iomem resources.
> 
> In addition, since the new descriptor 'IORES_DESC_RESERVED' is introduced,
> these code originally related to the descriptor 'IORES_DESC_NONE' need to
> be updated. Otherwise, it will be easily confused and also cause some
> errors. Because the 'E820_TYPE_RESERVED' type is converted to the new
> descriptor 'IORES_DESC_RESERVED' instead of 'IORES_DESC_NONE', it has been
> changed.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>

This was suggested by Boris instead :) 

> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/ia64/kernel/efi.c |  4 ++++
>  arch/x86/kernel/e820.c |  2 +-
>  arch/x86/mm/ioremap.c  | 13 ++++++++++++-
>  include/linux/ioport.h |  1 +
>  kernel/resource.c      |  6 +++---
>  5 files changed, 21 insertions(+), 5 deletions(-)
> 
> 
[snip]

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
