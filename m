Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvwuO-0004sY-V0
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 05:58:17 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466088775.24747.1248185448154277951.stgit@hbathini.in.ibm.com>
 <87365t8pse.fsf@morokweng.localdomain>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 04/12] ppc64/kexec_file: avoid stomping memory used by
 special regions
In-reply-to: <87365t8pse.fsf@morokweng.localdomain>
Date: Thu, 16 Jul 2020 02:58:04 -0300
Message-ID: <87pn8w80ib.fsf@morokweng.localdomain>
MIME-Version: 1.0
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> Hari Bathini <hbathini@linux.ibm.com> writes:
>
>> diff --git a/arch/powerpc/include/asm/crashdump-ppc64.h b/arch/powerpc/include/asm/crashdump-ppc64.h
>> new file mode 100644
>> index 0000000..90deb46
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/crashdump-ppc64.h
>> @@ -0,0 +1,10 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef _ASM_POWERPC_CRASHDUMP_PPC64_H
>> +#define _ASM_POWERPC_CRASHDUMP_PPC64_H
>> +
>> +/* min & max addresses for kdump load segments */
>> +#define KDUMP_BUF_MIN		(crashk_res.start)
>> +#define KDUMP_BUF_MAX		((crashk_res.end < ppc64_rma_size) ? \
>> +				 crashk_res.end : (ppc64_rma_size - 1))
>> +
>> +#endif /* __ASM_POWERPC_CRASHDUMP_PPC64_H */
>> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
>> index 7008ea1..bf47a01 100644
>> --- a/arch/powerpc/include/asm/kexec.h
>> +++ b/arch/powerpc/include/asm/kexec.h
>> @@ -100,14 +100,16 @@ void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_co
>>  #ifdef CONFIG_KEXEC_FILE
>>  extern const struct kexec_file_ops kexec_elf64_ops;
>>
>> -#ifdef CONFIG_IMA_KEXEC
>>  #define ARCH_HAS_KIMAGE_ARCH
>>
>>  struct kimage_arch {
>> +	struct crash_mem *exclude_ranges;
>> +
>> +#ifdef CONFIG_IMA_KEXEC
>>  	phys_addr_t ima_buffer_addr;
>>  	size_t ima_buffer_size;
>> -};
>>  #endif
>> +};
>>
>>  int setup_purgatory(struct kimage *image, const void *slave_code,
>>  		    const void *fdt, unsigned long kernel_load_addr,
>> @@ -125,6 +127,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>>  			unsigned long initrd_load_addr,
>>  			unsigned long initrd_len, const char *cmdline);
>>  #endif /* CONFIG_PPC64 */
>> +
>>  #endif /* CONFIG_KEXEC_FILE */
>>
>>  #else /* !CONFIG_KEXEC_CORE */
>> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>> index 23ad04c..c695f94 100644
>> --- a/arch/powerpc/kexec/elf_64.c
>> +++ b/arch/powerpc/kexec/elf_64.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/of_fdt.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>> +#include <asm/crashdump-ppc64.h>
>>
>>  static void *elf64_load(struct kimage *image, char *kernel_buf,
>>  			unsigned long kernel_len, char *initrd,
>> @@ -46,6 +47,12 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>  	if (ret)
>>  		goto out;
>>
>> +	if (image->type == KEXEC_TYPE_CRASH) {
>> +		/* min & max buffer values for kdump case */
>> +		kbuf.buf_min = pbuf.buf_min = KDUMP_BUF_MIN;
>> +		kbuf.buf_max = pbuf.buf_max = KDUMP_BUF_MAX;
>
> This is only my personal opinion and an actual maintainer may disagree,
> but just looking at the lines above, I would assume that KDUMP_BUF_MIN
> and KDUMP_BUF_MAX were constants, when in fact they aren't.
>
> I suggest using static inline macros in <asm/crashdump-ppc64.h>, for
> example:
>
> static inline resource_size_t get_kdump_buf_min(void)
> {
> 	return crashk_res.start;
> }
>
> static inline resource_size_t get_kdump_buf_max(void)
> {
> 	return (crashk_res.end < ppc64_rma_size) ? \
> 		 crashk_res.end : (ppc64_rma_size - 1)
> }

I later noticed that KDUMP_BUF_MIN and KDUMP_BUF_MAX are only used here.
In this case, I think the best option is to avoid the macros and inline
functions and just use the actual expressions in the code.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
