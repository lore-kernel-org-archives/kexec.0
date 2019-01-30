Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
Date: Wed, 30 Jan 2019 15:21:09 +0000
MIME-Version: 1.0
In-Reply-To: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Bhupesh,

On 01/30/2019 12:23 PM, Bhupesh Sharma wrote:
> With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
> supports these extensions can support upto 52-bit virtual and 52-bit
> physical addresses respectively.
> 
> Since at the moment we enable the support of these extensions via CONFIG
> flags, e.g.
>   - LPA via CONFIG_ARM64_PA_BITS_52
> 
> there are no clear mechanisms in user-space right now to
> deteremine these CONFIG flag values and also determine the PARange and
> VARange address values.
> User-space tools like 'makedumpfile' and 'crash-utility' can instead
> use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
> the maximum virtual address and physical address (respectively)
> supported by underlying kernel.
> 
> A reference 'makedumpfile' implementation which uses this approach to
> determining the maximum physical address is available in [0].

Why does it need to know?

(Suzuki asked the same question on your earlier version)
https://lore.kernel.org/linux-arm-kernel/cff44754-7fe4-efea-bc8e-4dde2277c821@arm.com/


 From your github link it looks like you use this to re-assemble the two 
bits of the PFN from the pte. Can't you always do this for 64K pages? 
CPUs with the feature always do this too, its not something the kernel 
turns on.


Thanks,

James


> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index ca4c3e12d8c5..ad231be5c0d8 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -10,6 +10,8 @@
>   void arch_crash_save_vmcoreinfo(void)
>   {
>   	VMCOREINFO_NUMBER(VA_BITS);
> +	VMCOREINFO_NUMBER(MAX_USER_VA_BITS);
> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>   	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
>   	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
>   						kimage_voffset);
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
