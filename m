Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 10/18] arm64: kexec: cpu_soft_restart change argument
 types
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-11-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <e6faa23d-27a8-838a-33ef-2a6ad8a5c746@arm.com>
Date: Wed, 29 Apr 2020 18:01:39 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-11-pasha.tatashin@soleen.com>
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
> Change argument types from unsigned long to a more descriptive
> phys_addr_t.

For 'entry', which is a physical addresses, sure...

> diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
> index ed50e9587ad8..38cbd4068019 100644
> --- a/arch/arm64/kernel/cpu-reset.h
> +++ b/arch/arm64/kernel/cpu-reset.h
> @@ -10,17 +10,17 @@
>  
>  #include <asm/virt.h>
>  
> -void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
> -	unsigned long arg0, unsigned long arg1, unsigned long arg2);

> +void __cpu_soft_restart(phys_addr_t el2_switch, phys_addr_t entry,
> +			phys_addr_t arg0, phys_addr_t arg1, phys_addr_t arg2);

This looks weird because its re-using the hyp-stub API, because it might call the hyp-stub
from the idmap. entry is passed in, so this isn't tied to kexec. Without tying it to
kexec, how do you know arg2 is a physical address?
I think it tried to be re-usable because 32bit has more users for this.

arg0-2 are unsigned long because the hyp-stub is just moving general purpose registers around.

This is to avoid casting?
Sure, its only got one caller. This thing evolved because the platform-has-EL2 and
kdump-while-KVM-was-running code was bolted on as they were discovered.


> -static inline void __noreturn cpu_soft_restart(unsigned long entry,
> -					       unsigned long arg0,
> -					       unsigned long arg1,
> -					       unsigned long arg2)
> +static inline void __noreturn cpu_soft_restart(phys_addr_t entry,
> +					       phys_addr_t arg0,
> +					       phys_addr_t arg1,
> +					       phys_addr_t arg2)
>  {
>  	typeof(__cpu_soft_restart) *restart;
>  
> -	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
> +	phys_addr_t el2_switch = !is_kernel_in_hyp_mode() &&
>  		is_hyp_mode_available();

What on earth happened here!?


>  	restart = (void *)__pa_symbol(__cpu_soft_restart);


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
