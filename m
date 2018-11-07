Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKGKQ-0002HV-Jc
 for kexec@lists.infradead.org; Wed, 07 Nov 2018 05:24:35 +0000
Date: Wed, 7 Nov 2018 13:23:45 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/2 v5] x86/kexec_file: add reserved e820 ranges to kdump
 kernel e820 table
Message-ID: <20181107052345.GQ27491@MiWiFi-R3L-srv>
References: <20181107050019.6663-1-lijiang@redhat.com>
 <20181107050019.6663-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181107050019.6663-3-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On 11/07/18 at 01:00pm, Lianbo Jiang wrote:
> E820 reserved ranges is useful in kdump kernel, it has been added in
> kexec-tools code.
> 
> One reason is PCI mmconf (extended mode) requires reserved region otherwise
> it falls back to legacy mode, and also outputs the following kernel log.

OK, it falls back to legacy mode, and also output kernel log, except of
these, does it crash kernel? kdump kernel hang? Can we leave it if it
only ouptut kernel log?

> 
> Example:
> ......
> [   19.798354] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [   19.800653] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> [   19.800995] PCI: not using MMCONFIG
> ......
> 
> The correct kernel log is like this:
> ......
> [    0.082649] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [    0.083610] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
> ......
> 
> Furthermore, when AMD SME kdump support, it needs to map dmi table area
> as decrypted. For normal boot, these ranges sit in e820 reserved ranges,
> thus the early ioremap code naturally map them as decrypted. If it also
> has same e820 reserve setup in kdump kernel then it will just work like
> normal kernel.

Why do we care? If don't fix, what's happening?

Lianbo, for a bug fix, please describe the problems. Then give out the
analysis about root cause. 


> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/crash.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index ae724a6e0a5f..d3167125800e 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -384,6 +384,10 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
>  			memmap_entry_callback);
>  
> +	cmd.type = E820_TYPE_RESERVED;
> +	walk_iomem_res_desc(IORES_DESC_NONE, 0, 0, -1, &cmd,
> +			   memmap_entry_callback);
> +
>  	/* Add crashk_low_res region */
>  	if (crashk_low_res.end) {
>  		ei.addr = crashk_low_res.start;
> -- 
> 2.17.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
