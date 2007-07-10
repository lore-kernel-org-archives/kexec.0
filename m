Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I88es-0000Ha-Sy
	for kexec@lists.infradead.org; Tue, 10 Jul 2007 01:53:12 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6A5qrYJ023325
	for <kexec@lists.infradead.org>; Tue, 10 Jul 2007 01:52:53 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6A5qr9f267072
	for <kexec@lists.infradead.org>; Mon, 9 Jul 2007 23:52:53 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6A5qrP5017401
	for <kexec@lists.infradead.org>; Mon, 9 Jul 2007 23:52:53 -0600
Received: from vivek.in.ibm.com (vivek.in.ibm.com [9.124.31.49] (may be
	forged))
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6A5qqfN017380
	for <kexec@lists.infradead.org>; Mon, 9 Jul 2007 23:52:52 -0600
Date: Tue, 10 Jul 2007 11:22:59 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH] Determine ELF32/ELF64 automatically on i386
Message-ID: <20070710055259.GA5471@in.ibm.com>
References: <20070702131541.GA6084@suse.de> <20070703161207.GA5070@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070703161207.GA5070@suse.de>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Tue, Jul 03, 2007 at 06:12:07PM +0200, Bernhard Walle wrote:
> On i386, kexec generates ELF64 core headers by default if the user doesn't
> override this via a command line option. Because GDB cannot analyse
> ELF64 core dumps on 32 bit platforms, it's a bad idea to use ELF64 if it's not
> needed.
> 
> This patch selects ELF32 if the biggest memory address fits in 32 bit address
> space, which should be the case on non PAE systems. If the user specifies
> a command line option, that option overrides the detection.
> 

Makes sense to me. No need to generate 64bit ELF headers on systems
having less than 4G of memory. gdb runs into issues with 64bit ELF headers
on 32bit machines.

> +++ b/kexec/arch/i386/kexec-x86.h
> @@ -2,8 +2,12 @@
>  #define KEXEC_X86_H
> 
>  #define MAX_MEMORY_RANGES 64
> -#define CORE_TYPE_ELF32 1
> -#define CORE_TYPE_ELF64 2
> +
> +enum CoreType {
> +	CORE_TYPE_UNDEF = 0,
> +	CORE_TYPE_ELF32 = 1,
> +	CORE_TYPE_ELF64 = 2
> +};
> 

I think we can avoid mixed case in "CoreType" and use something like
"coretype".

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
