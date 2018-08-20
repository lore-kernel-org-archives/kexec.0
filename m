Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1frfgs-00033x-GR
 for kexec@lists.infradead.org; Mon, 20 Aug 2018 08:37:36 +0000
Date: Mon, 20 Aug 2018 16:37:18 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: (Possible) fix for "Unhandled rela relocation: R_X86_64_PLT32"
 error
Message-ID: <20180820083718.GZ4113@MiWiFi-R3L-srv>
References: <e590dc81-7df7-746d-98f2-710f85e03467@googlemail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e590dc81-7df7-746d-98f2-710f85e03467@googlemail.com>
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
To: Chris Clayton <chris2553@googlemail.com>
Cc: kexec@lists.infradead.org

On 07/25/18 at 09:46am, Chris Clayton wrote:
> Hi.
> 
> I haven't rebooted my laptop with kexec for quite some time, but when I tried to this morning I got the error you will
> see in $SUBJECT.  The error occurs with both kexec-tools-2.0.17 or -2.0.16 run on either 4.18.0-rc6+ (built from a git
> pull this morning) or 4.14.57 kernels.
> 
> I searched for "R_X86_64_PLT32" and found that there was a change to the kernel that may be related -
> b21ebf2fb4cde1618915a97cc773e287ff49173e x86: Treat R_X86_64_PLT32 as R_X86_64_PC32. So I replicated the change that
> patch made to arch/x86/kernel/machine_kexec_64.c in kexec/arch/x86_64/kexec-elf-rel-x86_64.c and kexec now reboots into
> the new kernel.
> 
> I don't know enough about relocations and the like to know whether my 'fix' is correct and the best way to go about it,
> but I've included it below for your consideration.
> 
> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
> 
> --- kexec-tools-2.0.17/kexec/arch/x86_64/kexec-elf-rel-x86_64.c.orig	2018-07-25 08:48:24.152054030 +0100
> +++ kexec-tools-2.0.17/kexec/arch/x86_64/kexec-elf-rel-x86_64.c	2018-07-25 08:49:16.860055330 +0100
> @@ -79,6 +79,7 @@ void machine_apply_elf_rel(struct mem_eh
>  			goto overflow;
>  		break;
>  	case R_X86_64_PC32:
> +	case R_X86_64_PLT32:

Looks like a good fix, could you make a formal patch, e.g rearrange the
patch log, I woule like to ack it.

>  		*(uint32_t *)location = value - address;
>  		break;
>  	default:
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
