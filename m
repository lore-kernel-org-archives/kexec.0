Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ftDX4-0002KH-Mc
 for kexec@lists.infradead.org; Fri, 24 Aug 2018 14:57:51 +0000
Date: Fri, 24 Aug 2018 22:57:28 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32" error
Message-ID: <20180824145728.GQ29313@MiWiFi-R3L-srv>
References: <e590dc81-7df7-746d-98f2-710f85e03467@googlemail.com>
 <20180820083718.GZ4113@MiWiFi-R3L-srv>
 <cbf043a7-8e95-9486-3441-07ef8f2f86f5@googlemail.com>
 <20180820121721.GA4113@MiWiFi-R3L-srv>
 <20180820122131.GB4113@MiWiFi-R3L-srv>
 <aabec0ea-6611-dc95-3f12-391469790d53@googlemail.com>
 <CACi5LpP3mVre_uNAGaHFaSzRKAk2BKoRNC-vpvkkt-Yf8zYujA@mail.gmail.com>
 <20180824075655.szxmhx3qvlg7uohm@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180824075655.szxmhx3qvlg7uohm@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>, Chris Clayton <chris2553@googlemail.com>

On 08/24/18 at 09:56am, Simon Horman wrote:
> On Tue, Aug 21, 2018 at 04:51:49PM +0530, Bhupesh Sharma wrote:
 
> Thanks, and apologies for the delay - I was travelling.
> 
> For some reason the patch did not apply cleanly so I did so by hand.
> The result is as follows:

Thanks a lot for your help, Simon. You can still take the 2 weeks as a
period to merge patch, no hurry.

Thanks
Baoquan

> 
> 
> From b9de21ef51a7ceab7122a707c188602eae22c4ee Mon Sep 17 00:00:00 2001
> From: Chris Clayton <chris2553@googlemail.com>
> Date: Mon, 20 Aug 2018 12:00:31 +0100
> Subject: [PATCH] kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32"
>  error
> 
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
> Acked-by: Baoquan He <bhe@redhat.com>
> Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
> Acked-by: Bhupesh Sharma <bhsharma@redhat.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  kexec/arch/x86_64/kexec-elf-rel-x86_64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> index 7fdde73a5eca..db85b443238d 100644
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
> 2.11.0
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
