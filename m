Return-path: <kexec-bounces@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IiUQK-0004Rq-FA
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 13:24:28 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9ICKmVU007229
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 08:20:48 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9ICKlnM075374
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 08:20:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9ICKl7U005859
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 08:20:47 -0400
Date: Thu, 18 Oct 2007 17:51:03 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH] kmap leak fix for x86_32 kdump
Message-ID: <20071018122103.GD8779@in.ibm.com>
References: <1192705816.23637.12.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1192705816.23637.12.camel@sebastian.kern.oss.ntt.co.jp>
Reply-To: vgoyal@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org

On Thu, Oct 18, 2007 at 08:10:16PM +0900, Fernando Luis V=E1zquez Cao wrote:
> copy_oldmem_page should not return leaving a page frame from the
> previous kernel mapped.
> =

> Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
> ---
> =

> diff -urNp linux-2.6.23-git13-orig/arch/x86/kernel/crash_dump_32.c linux-=
2.6.23-git13/arch/x86/kernel/crash_dump_32.c
> --- linux-2.6.23-git13-orig/arch/x86/kernel/crash_dump_32.c	2007-10-18 19=
:42:54.000000000 +0900
> +++ linux-2.6.23-git13/arch/x86/kernel/crash_dump_32.c	2007-10-18 19:49:2=
5.000000000 +0900
> @@ -47,6 +47,7 @@ ssize_t copy_oldmem_page(unsigned long p
>  		if (!kdump_buf_page) {
>  			printk(KERN_WARNING "Kdump: Kdump buffer page not"
>  				" allocated\n");
> +			kunmap_atomic(vaddr, KM_PTE0);
>  			return -EFAULT;
>  		}
>  		copy_page(kdump_buf_page, vaddr);
>

Thanks Fernando. This makes sense.

Vivek
 =


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
