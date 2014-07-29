Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XC0zK-000734-9U
 for kexec@lists.infradead.org; Tue, 29 Jul 2014 06:34:19 +0000
Date: Tue, 29 Jul 2014 08:33:50 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] ppc64/kdump: Fix ELF header endianess
Message-ID: <20140729083350.76dd3813@hananiah.suse.cz>
In-Reply-To: <20140725150749.17944.26746.stgit@nimbus>
References: <20140725150749.17944.26746.stgit@nimbus>
Mime-Version: 1.0
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
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Fri, 25 Jul 2014 17:07:49 +0200
Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> The ELF header created among the loading of the kdump kernel should be
> flagged using the current endianess and not always as big endian.
> 
> Without this patch the data exposed in /proc/vmcore are not readable when
> running in LE mode.

FWIW I can confirm that this patch has fixed kdump on my ppc64le system.

Thank you, Laurent!

Petr Tesarik

> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  kexec/arch/ppc64/crashdump-ppc64.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
> index 00a0e632f48e..6214b831fdf2 100644
> --- a/kexec/arch/ppc64/crashdump-ppc64.c
> +++ b/kexec/arch/ppc64/crashdump-ppc64.c
> @@ -38,7 +38,11 @@
>  static struct crash_elf_info elf_info64 =
>  {
>  	class: ELFCLASS64,
> +#if BYTE_ORDER == LITTLE_ENDIAN
> +	data: ELFDATA2LSB,
> +#else
>  	data: ELFDATA2MSB,
> +#endif
>  	machine: EM_PPC64,
>  	page_offset: PAGE_OFFSET,
>  	lowmem_limit: MAXMEM,
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
