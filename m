Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hWdpD-0006da-86
 for kexec@lists.infradead.org; Fri, 31 May 2019 09:27:48 +0000
Date: Fri, 31 May 2019 11:27:44 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 0/4] x86: Always try to fill acpi_rsdp_addr in boot
 params
Message-ID: <20190531092743.qgwku2ob4trduadr@verge.net.au>
References: <20190524062321.24126-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190524062321.24126-1-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>

On Fri, May 24, 2019 at 02:23:17PM +0800, Kairui Song wrote:
> This patch sync the behavior of user space kexec and kexec_file_load,
> they will both fill the boot_params.acpi_rsdp_addr with a valid RSDP
> value, to make sure second kernel can always get the RSDP consistently.
> 
> This will make it effortless to boot newer version of kernel (5.0+)
> without specifying acpi_rsdp= cmdline on EFI system even with EFI
> service disabled. Should not change any behavior with older kernels.
> 
> Update from V2:
>   - Drop unneeded 'packed' attribute for boot parameters structure
>   - Don't trust kernel cmdline as a reliable acpi rsdp source
> 
> Update from V1:
>   - Split into multiple patches for a cleaner structure, content is not
>     changed.

Thanks Kairui,

applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
