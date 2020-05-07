Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 15/18] arm64: kexec: kexec EL2 vectors
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-16-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <c9b5897b-a4a3-0ec1-10d1-520c8b7c89cc@arm.com>
Date: Thu, 7 May 2020 17:21:59 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-16-pasha.tatashin@soleen.com>
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

What happened to the subject?
(it really needs a verb to make any sense)

On 26/03/2020 03:24, Pavel Tatashin wrote:
> If we have a EL2 mode without VHE, the EL2 vectors are needed in order
> to switch to EL2 and jump to new world with hyperivsor privileges.

Yes, but the hyp-stub has an API to let you do this... but you need your own version.

Could you explain why in the commit message?

(spelling: hyperivsor)


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index ab571fca9bd1..bd398def7627 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -84,6 +84,11 @@ int machine_kexec_post_load(struct kimage *kimage)
>  	kern_reloc_arg->head = kimage->head;
>  	kern_reloc_arg->entry_addr = kimage->start;
>  	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
> +	/* Setup vector table only when EL2 is available, but no VHE */
> +	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
> +		kern_reloc_arg->el2_vector = __pa(reloc_code)
> +						+ kexec_el2_vectors_offset;
> +	}

Why does the asm relocation code need to know where the vector is? It must access it via HVC.




Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
