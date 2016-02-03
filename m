Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aR5CC-0000vr-Db
 for kexec@lists.infradead.org; Wed, 03 Feb 2016 21:42:41 +0000
Date: Thu, 4 Feb 2016 05:42:00 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/efi: skip bgrt init for kexec reboot
Message-ID: <20160203214200.GA15110@dhcp-128-65.nay.redhat.com>
References: <20160127112044.GA2961@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160127112044.GA2961@dhcp-128-65.nay.redhat.com>
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
To: linux-efi@vger.kernel.org, matt@codeblueprint.co.uk
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org


On 01/27/16 at 07:20pm, Dave Young wrote:
> For kexec reboot the bgrt image address could contains random data because
> we have freed boot service areas in 1st kernel boot phase. One possible
> result is kmalloc fail in efi_bgrt_init due to large random image size.
> 
> So change efi_late_init to avoid efi_bgrt_init in case kexec boot.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/platform/efi/efi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-x86.orig/arch/x86/platform/efi/efi.c
> +++ linux-x86/arch/x86/platform/efi/efi.c
> @@ -531,7 +531,8 @@ void __init efi_init(void)
>  
>  void __init efi_late_init(void)
>  {
> -	efi_bgrt_init();
> +	if (!efi_setup)
> +		efi_bgrt_init();
>  }
>  
>  void __init efi_set_executable(efi_memory_desc_t *md, bool executable)

Matt, opinions about this patch?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
