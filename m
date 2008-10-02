Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KlSid-0006r2-V8
	for kexec@lists.infradead.org; Thu, 02 Oct 2008 18:16:08 +0000
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: SetVirtualAddressMap() on Tiano EFI firmware
Date: Thu, 2 Oct 2008 12:16:03 -0600
References: <200809111423.58814.bjorn.helgaas@hp.com>
In-Reply-To: <200809111423.58814.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200810021216.03922.bjorn.helgaas@hp.com>
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
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>

On Thursday 11 September 2008 02:23:58 pm Bjorn Helgaas wrote:
> ...
> The following patch makes kexec-tools work on either old or new
> firmware.  Masking out the top nibble of either a physical address
> or a virtual address in region 7 results in a physical address.
> 
> diff --git a/purgatory/arch/ia64/purgatory-ia64.c b/purgatory/arch/ia64/purgatory-ia64.c
> index b2fe6d4..acacb56 100644
> --- a/purgatory/arch/ia64/purgatory-ia64.c
> +++ b/purgatory/arch/ia64/purgatory-ia64.c
> @@ -147,7 +147,7 @@ setup_arch(void)
>  
>  inline unsigned long PA(unsigned long addr)
>  {
> -	return addr - PAGE_OFFSET;
> +	return addr & 0x0fffffffffffffffLL;
>  }
>  
>  void
> 

I haven't seen any activity on this.

Simon, if nobody objects to it, would you consider the patch above
for kexec-tools?

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
