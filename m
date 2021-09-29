Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 29 Sep 2021 13:13:37 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v17 05/15] arm64: kexec: skip relocation code for inplace
 kexec
Message-ID: <20210929121336.GB21631@willie-the-truck>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-6-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916231325.125533-6-pasha.tatashin@soleen.com>
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
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com, kernelfans@gmail.com, akpm@linux-foundation.org, madvenka@linux.microsoft.com

On Thu, Sep 16, 2021 at 07:13:15PM -0400, Pasha Tatashin wrote:
> In case of kdump or when segments are already in place the relocation
> is not needed, therefore the setup of relocation function and call to
> it can be skipped.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Suggested-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/kernel/machine_kexec.c   | 34 ++++++++++++++++++-----------
>  arch/arm64/kernel/relocate_kernel.S |  3 ---
>  2 files changed, 21 insertions(+), 16 deletions(-)

[...]

> @@ -188,19 +190,25 @@ void machine_kexec(struct kimage *kimage)
>  	local_daif_mask();
>  
>  	/*
> -	 * cpu_soft_restart will shutdown the MMU, disable data caches, then
> -	 * transfer control to the kern_reloc which contains a copy of
> -	 * the arm64_relocate_new_kernel routine.  arm64_relocate_new_kernel
> -	 * uses physical addressing to relocate the new image to its final
> -	 * position and transfers control to the image entry point when the
> -	 * relocation is complete.
> +	 * Both restart and cpu_soft_restart will shutdown the MMU, disable data
> +	 * caches. However, restart will start new kernel or purgatory directly,
> +	 * cpu_soft_restart will transfer control to arm64_relocate_new_kernel
>  	 * In kexec case, kimage->start points to purgatory assuming that
>  	 * kernel entry and dtb address are embedded in purgatory by
>  	 * userspace (kexec-tools).
>  	 * In kexec_file case, the kernel starts directly without purgatory.
>  	 */
> -	cpu_soft_restart(kimage->arch.kern_reloc, kimage->head, kimage->start,
> -			 kimage->arch.dtb_mem);
> +	if (kimage->head & IND_DONE) {
> +		typeof(__cpu_soft_restart) *restart;
> +
> +		cpu_install_idmap();
> +		restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
> +		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
> +			0, 0);

Why can't you call:

	cpu_soft_restart(kimage->start, kimage->arch.dtb_mem, 0, 0);

here instead of open-coding it?

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
