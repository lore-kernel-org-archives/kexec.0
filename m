Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from omzsmtpe01.verizonbusiness.com ([199.249.25.210])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ve8E4-0000Xd-Ri
 for kexec@lists.infradead.org; Wed, 06 Nov 2013 18:53:13 +0000
From: Don Slutz <dslutz@verizon.com>
Message-ID: <527A8F38.2050300@terremark.com>
Date: Wed, 6 Nov 2013 13:49:28 -0500
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 1/9] x86: give FIX_EFI_MPF its own fixmap entry
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <1383749386-11891-2-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1383749386-11891-2-git-send-email-david.vrabel@citrix.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, Jan Beulich <jbeulich@suse.com>

Looks good.

Reviewed-by: Don Slutz <dslutz@verizon.com>

    -Don Slutz

On 11/06/13 09:49, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> FIX_EFI_MPF was the same as FIX_KEXEC_BASE_0 which is going away.  So
> add its own entry.
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> Tested-by: Daniel Kiper <daniel.kiper@oracle.com>
> Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
>   xen/arch/x86/mpparse.c       |    2 --
>   xen/include/asm-x86/fixmap.h |    1 +
>   2 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/xen/arch/x86/mpparse.c b/xen/arch/x86/mpparse.c
> index 97d34bc..3753704 100644
> --- a/xen/arch/x86/mpparse.c
> +++ b/xen/arch/x86/mpparse.c
> @@ -538,8 +538,6 @@ static inline void __init construct_default_ISA_mptable(int mpc_default_type)
>   	}
>   }
>   
> -#define FIX_EFI_MPF FIX_KEXEC_BASE_0
> -
>   static __init void efi_unmap_mpf(void)
>   {
>   	if (efi_enabled)
> diff --git a/xen/include/asm-x86/fixmap.h b/xen/include/asm-x86/fixmap.h
> index d850be4..8b4266d 100644
> --- a/xen/include/asm-x86/fixmap.h
> +++ b/xen/include/asm-x86/fixmap.h
> @@ -66,6 +66,7 @@ enum fixed_addresses {
>       FIX_APEI_RANGE_BASE,
>       FIX_APEI_RANGE_END = FIX_APEI_RANGE_BASE + FIX_APEI_RANGE_MAX -1,
>       FIX_IGD_MMIO,
> +    FIX_EFI_MPF,
>       __end_of_fixed_addresses
>   };
>   


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
