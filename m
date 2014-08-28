Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XMzMZ-0002F7-2t
 for kexec@lists.infradead.org; Thu, 28 Aug 2014 13:03:39 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 28 Aug 2014 14:03:15 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 843CA17D804E
 for <kexec@lists.infradead.org>; Thu, 28 Aug 2014 14:05:09 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7SD3DmV34406480
 for <kexec@lists.infradead.org>; Thu, 28 Aug 2014 13:03:14 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7SD3Cer024436
 for <kexec@lists.infradead.org>; Thu, 28 Aug 2014 07:03:12 -0600
Message-ID: <53FF288F.80009@linux.vnet.ibm.com>
Date: Thu, 28 Aug 2014 15:03:11 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] ppc64/kdump: Fix ELF header endianess
References: <20140725150749.17944.26746.stgit@nimbus>
In-Reply-To: <20140725150749.17944.26746.stgit@nimbus>
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
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 25/07/2014 17:07, Laurent Dufour wrote:
> The ELF header created among the loading of the kdump kernel should be
> flagged using the current endianess and not always as big endian.
> 
> Without this patch the data exposed in /proc/vmcore are not readable when
> running in LE mode.

Hi Simon,

Do you have any concerns with this patch ?
If not, would you please consider it for merge since it fixes a major
issue with dump analysis.

Thanks
Laurent.

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
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
