Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1frjBq-0007MZ-8i
 for kexec@lists.infradead.org; Mon, 20 Aug 2018 12:21:52 +0000
Date: Mon, 20 Aug 2018 20:21:31 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32" error
Message-ID: <20180820122131.GB4113@MiWiFi-R3L-srv>
References: <e590dc81-7df7-746d-98f2-710f85e03467@googlemail.com>
 <20180820083718.GZ4113@MiWiFi-R3L-srv>
 <cbf043a7-8e95-9486-3441-07ef8f2f86f5@googlemail.com>
 <20180820121721.GA4113@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180820121721.GA4113@MiWiFi-R3L-srv>
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
To: Chris Clayton <chris2553@googlemail.com>, Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Hi Chris,

On 08/20/18 at 08:17pm, Baoquan He wrote:
> In response to a change in binutils, commit b21ebf2fb4c
> (x86: Treat R_X86_64_PLT32 as R_X86_64_PC32) was applied to
> the linux kernel during the 4.16 development cycle and has
> since been backported to earlier stable kernel series. The
> change results in the failure message in $SUBJECT when
> rebooting via kexec.
> 
> Fix this by replicating the change in kexec.
> 
> Signed-off-by: Chris Clayton <chris2553@googlemail.com>

I adjusted the patch log a little bit, you have tested it on upstream
kernel, right?

Thanks
Baoquan

> ---
>  kexec/arch/x86_64/kexec-elf-rel-x86_64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> index 7fdde73..db85b44 100644
> --- a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> +++ b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> @@ -79,6 +79,7 @@ void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
>  			goto overflow;
>  		break;
>  	case R_X86_64_PC32: 
> +	case R_X86_64_PLT32:
>  		*(uint32_t *)location = value - address;
>  		break;
>  	default:
> -- 
> 2.13.6
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
