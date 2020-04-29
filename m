Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 08/18] arm64: kexec: move relocation function setup
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-9-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <ea2b39d7-d496-d9ac-23c9-c279ec29f5d5@arm.com>
Date: Wed, 29 Apr 2020 18:01:26 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-9-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, catalin.marinas@arm.com, bhsharma@redhat.com, steve.capper@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, rfontana@redhat.com, ebiederm@xmission.com, maz@kernel.org, matthias.bgg@gmail.com, tglx@linutronix.de, will@kernel.org, selindag@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Currently, kernel relocation function is configured in machine_kexec()
> at the time of kexec reboot by using control_code_page.
> 
> This operation, however, is more logical to be done during kexec_load,
> and thus remove from reboot time. Move, setup of this function to
> newly added machine_kexec_post_load().

This would avoid the need to special-case the cache maintenance, so its a good cleanup...


> Because once MMU is enabled, kexec control page will contain more than
> relocation kernel, but also vector table, add pointer to the actual
> function within this page arch.kern_reloc. Currently, it equals to the
> beginning of page, we will add offsets later, when vector table is
> added.

If the vector table always comes second, wouldn't this be extra work to hold the value 0?
You can control the layout of this relocation code, as it has to be written in assembly.
I don't get why this would be necessary.


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index ae1bad0156cd..ec71a153cc2d 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -58,6 +59,17 @@ void machine_kexec_cleanup(struct kimage *kimage)
>  	/* Empty routine needed to avoid build errors. */
>  }
>  
> +int machine_kexec_post_load(struct kimage *kimage)
> +{
> +	void *reloc_code = page_to_virt(kimage->control_code_page);
> +
> +	memcpy(reloc_code, arm64_relocate_new_kernel,
> +	       arm64_relocate_new_kernel_size);
> +	kimage->arch.kern_reloc = __pa(reloc_code);

Could we move the two cache maintenance calls for this area in here too. Keeping it next
to the modification makes it clearer why it is required.

In this case we can use flush_icache_range() instead of its __variant because this now
happens much earlier.


> +	return 0;
> +}

Regardless,
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
