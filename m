Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1exzyQ-0006Ks-M7
 for kexec@lists.infradead.org; Mon, 19 Mar 2018 18:57:36 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2JIsL02029302
 for <kexec@lists.infradead.org>; Mon, 19 Mar 2018 14:57:22 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gtfew9u3r-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 19 Mar 2018 14:57:21 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 19 Mar 2018 12:57:20 -0600
References: <152010365000.15494.15072043690885225651.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/ppc64: leverage kexec_file_load support
In-reply-to: <152010365000.15494.15072043690885225651.stgit@hbathini.in.ibm.com>
Date: Mon, 19 Mar 2018 15:57:11 -0300
MIME-Version: 1.0
Message-Id: <87y3inhp14.fsf@morokweng.localdomain>
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Simon Horman <horms@verge.net.au>, Kexec-ml <kexec@lists.infradead.org>


Hello Hari,

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> PPC64 kernel now supports kexec_file_load system call. Leverage it by
> enabling that support here. Note that loading crash kernel with this
> system call is not yet supported in the kernel and trying to load one
> will fail with '-ENOTSUPP' error.
>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  kexec/arch/ppc64/kexec-elf-ppc64.c |   84 ++++++++++++++++++++++++++++++++++++
>  kexec/kexec-syscall.h              |    3 +
>  2 files changed, 87 insertions(+)

Thanks for implementing this! Looks good to me, just one nit below.
Regardless of that:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

> diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
> index ddd3de8..2742cd6 100644
> --- a/kexec/arch/ppc64/kexec-elf-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-elf-ppc64.c

<snip>

> @@ -117,6 +196,9 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
>  	uint32_t my_run_at_load;
>  	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
>
> +	if (info->file_mode)
> +		return elf_ppc64_load_file(argc, argv, info);
> +
>  	/* See options.h -- add any more there, too. */
>  	static const struct option options[] = {
>  		KEXEC_ARCH_OPTIONS

This is placing executable code between variable declarations. It may be
fine for gcc but it's more idiomatic C to put it after all variable
declarations. But perhaps the kexec-tools style is fine with it?

--
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
