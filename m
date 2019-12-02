Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibvXH-0004DA-D1
 for kexec@lists.infradead.org; Mon, 02 Dec 2019 23:55:25 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2NsSva156270
 for <kexec@lists.infradead.org>; Mon, 2 Dec 2019 23:55:16 GMT
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2wkgcq3jdx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 02 Dec 2019 23:55:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2NsT46005991
 for <kexec@lists.infradead.org>; Mon, 2 Dec 2019 23:55:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2wn8k1bbkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 02 Dec 2019 23:55:15 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB2NtE0x024925
 for <kexec@lists.infradead.org>; Mon, 2 Dec 2019 23:55:14 GMT
Subject: Re: [RESEND PATCH v5 1/5] crash_core, vmcoreinfo: Append
 'MAX_PHYSMEM_BITS' to vmcoreinfo
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-2-git-send-email-bhsharma@redhat.com>
From: John Donnelly <John.P.Donnelly@Oracle.com>
Message-ID: <07946b28-3855-f8e9-52bb-b5452758a18c@Oracle.com>
Date: Mon, 2 Dec 2019 17:55:12 -0600
MIME-Version: 1.0
In-Reply-To: <1575057559-25496-2-git-send-email-bhsharma@redhat.com>
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
> Right now user-space tools like 'makedumpfile' and 'crash' need to rely
> on a best-guess method of determining value of 'MAX_PHYSMEM_BITS'
> supported by underlying kernel.
> 
> This value is used in user-space code to calculate the bit-space
> required to store a section for SPARESMEM (similar to the existing
> calculation method used in the kernel implementation):
> 
>    #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> 
> Now, regressions have been reported in user-space utilities
> like 'makedumpfile' and 'crash' on arm64, with the recently added
> kernel support for 52-bit physical address space, as there is
> no clear method of determining this value in user-space
> (other than reading kernel CONFIG flags).
> 
> As per suggestion from makedumpfile maintainer (Kazu), it makes more
> sense to append 'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself
> rather than in arch-specific code, so that the user-space code for other
> archs can also benefit from this addition to the vmcoreinfo and use it
> as a standard way of determining 'SECTIONS_SHIFT' value in user-land.
> 
> A reference 'makedumpfile' implementation which reads the
> 'MAX_PHYSMEM_BITS' value from vmcoreinfo in a arch-independent fashion
> is available here:
> 
> [0]. https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_bhupesh-2Dsharma_makedumpfile_blob_remove-2Dmax-2Dphys-2Dmem-2Dbit-2Dv1_arch_ppc64.c-23L471&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=WdAKu3i_AeChZ2ZngChACvP5LtULN6mgHopxlQbu16Q&s=AYn-OBh6EqC80XVBg3oLc8ivaCwCNs-cm0PMkJ_2fjo&e=
> 
> Cc: Boris Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Tested-by:  John Donnelly <john.p.donnelly@oracle.com>

> ---
>   kernel/crash_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 9f1557b98468..18175687133a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -413,6 +413,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>   	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>   	VMCOREINFO_STRUCT_SIZE(mem_section);
>   	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>   #endif
>   	VMCOREINFO_STRUCT_SIZE(page);
>   	VMCOREINFO_STRUCT_SIZE(pglist_data);
> 


-- 
Thank You,
John

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
