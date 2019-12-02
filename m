Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibvYX-0004Jw-Pl
 for kexec@lists.infradead.org; Mon, 02 Dec 2019 23:56:44 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2NsX3l158292
 for <kexec@lists.infradead.org>; Mon, 2 Dec 2019 23:56:38 GMT
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2wkfuu3nwc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 02 Dec 2019 23:56:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2NsS49076258
 for <kexec@lists.infradead.org>; Mon, 2 Dec 2019 23:56:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2wnb7udbfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 02 Dec 2019 23:56:37 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB2NuaTi019485
 for <kexec@lists.infradead.org>; Mon, 2 Dec 2019 23:56:36 GMT
Subject: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ in
 vmcoreinfo
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-3-git-send-email-bhsharma@redhat.com>
From: John Donnelly <John.P.Donnelly@Oracle.com>
Message-ID: <77006549-7cf8-29e2-3986-be0986b37dad@Oracle.com>
Date: Mon, 2 Dec 2019 17:56:35 -0600
MIME-Version: 1.0
In-Reply-To: <1575057559-25496-3-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org

On 11/29/19 1:59 PM, Bhupesh Sharma wrote:
> vabits_actual variable on arm64 indicates the actual VA space size,
> and allows a single binary to support both 48-bit and 52-bit VA
> spaces.
> 
> If the ARMv8.2-LVA optional feature is present, and we are running
> with a 64KB page size; then it is possible to use 52-bits of address
> space for both userspace and kernel addresses. However, any kernel
> binary that supports 52-bit must also be able to fall back to 48-bit
> at early boot time if the hardware feature is not present.
> 
> Since TCR_EL1.T1SZ indicates the size offset of the memory region
> addressed by TTBR1_EL1 (and hence can be used for determining the
> vabits_actual value) it makes more sense to export the same in
> vmcoreinfo rather than vabits_actual variable, as the name of the
> variable can change in future kernel versions, but the architectural
> constructs like TCR_EL1.T1SZ can be used better to indicate intended
> specific fields to user-space.
> 
> User-space utilities like makedumpfile and crash-utility, need to
> read/write this value from/to vmcoreinfo for determining if a virtual
> address lies in the linear map range.
> 
> The user-space computation for determining whether an address lies in
> the linear map range is the same as we have in kernel-space:
> 
>    #define __is_lm_address(addr)	(!(((u64)addr) & BIT(vabits_actual - 1)))
> 
> I have sent out user-space patches for makedumpfile and crash-utility
> to add features for obtaining vabits_actual value from TCR_EL1.T1SZ (see
> [0] and [1]).
> 
> Akashi reported that he was able to use this patchset and the user-space
> changes to get user-space working fine with the 52-bit kernel VA
> changes (see [2]).
> 
> [0]. https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_kexec_2019-2DNovember_023966.html&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=hl1GOXoV3jxYFfIKiiUHZCo3tERnHZ8sNFncKCLsu0g&s=AuQKgcRrjZzeOv_rg3saDrjUlJJraGBptzAlDaUNirc&e=
> [1]. https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_kexec_2019-2DNovember_024006.html&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=hl1GOXoV3jxYFfIKiiUHZCo3tERnHZ8sNFncKCLsu0g&s=48CAvsBJrAJIyXWl_7dQd_a4HPt2dYKZ134lP3jDLA8&e=
> [2]. https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_kexec_2019-2DNovember_023992.html&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=hl1GOXoV3jxYFfIKiiUHZCo3tERnHZ8sNFncKCLsu0g&s=c-62ZXf5jXn9NYHIS_Qu6-xlbRjPPyG5D07RoEzVzC4&e=
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Tested-by:  John Donnelly <john.p.donnelly@oracle.com>

> ---
>   arch/arm64/include/asm/pgtable-hwdef.h | 1 +
>   arch/arm64/kernel/crash_core.c         | 9 +++++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index d9fbd433cc17..d2e7aff5821e 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -215,6 +215,7 @@
>   #define TCR_TxSZ(x)		(TCR_T0SZ(x) | TCR_T1SZ(x))
>   #define TCR_TxSZ_WIDTH		6
>   #define TCR_T0SZ_MASK		(((UL(1) << TCR_TxSZ_WIDTH) - 1) << TCR_T0SZ_OFFSET)
> +#define TCR_T1SZ_MASK		(((UL(1) << TCR_TxSZ_WIDTH) - 1) << TCR_T1SZ_OFFSET)
>   
>   #define TCR_EPD0_SHIFT		7
>   #define TCR_EPD0_MASK		(UL(1) << TCR_EPD0_SHIFT)
> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index ca4c3e12d8c5..f78310ba65ea 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -7,6 +7,13 @@
>   #include <linux/crash_core.h>
>   #include <asm/memory.h>
>   
> +static inline u64 get_tcr_el1_t1sz(void);
> +
> +static inline u64 get_tcr_el1_t1sz(void)
> +{
> +	return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET;
> +}
> +
>   void arch_crash_save_vmcoreinfo(void)
>   {
>   	VMCOREINFO_NUMBER(VA_BITS);
> @@ -15,5 +22,7 @@ void arch_crash_save_vmcoreinfo(void)
>   						kimage_voffset);
>   	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>   						PHYS_OFFSET);
> +	vmcoreinfo_append_str("NUMBER(tcr_el1_t1sz)=0x%llx\n",
> +						get_tcr_el1_t1sz());
>   	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>   }
> 


-- 
Thank You,
John

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
