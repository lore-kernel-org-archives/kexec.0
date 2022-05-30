From: liaochang (A) <liaochang1@huawei.com>
Date: Mon, 30 May 2022 09:43:26 +0800
Subject: [PATCH v2] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
In-Reply-To: <20220529140655.bnd4fgggccrorj4t@pengutronix.de>
References: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
 <20220529065637.xgapqjp2342flbuj@pengutronix.de>
 <264786d9-7756-19e0-2742-8b8d17f5ace5@csgroup.eu>
 <20220529140655.bnd4fgggccrorj4t@pengutronix.de>
Message-ID: <59e8faec-05fd-805d-7de0-4b0508f8467f@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



? 2022/5/29 22:06, Uwe Kleine-K?nig ??:
> Hello,
> 
> On Sun, May 29, 2022 at 09:46:47AM +0000, Christophe Leroy wrote:
>> Le 29/05/2022 ? 08:56, Uwe Kleine-K?nig a ?crit?:
>>> Hello,
>>>
>>> on current linux-next ARCH=riscv allmodconfig breaks with:
>>>
>>>    CC      arch/riscv/kernel/elf_kexec.o
>>> arch/riscv/kernel/elf_kexec.c:345:5: error: redefinition of ?arch_kexec_apply_relocations_add?
>>>    345 | int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> In file included from arch/riscv/kernel/elf_kexec.c:16:
>>> include/linux/kexec.h:236:1: note: previous definition of ?arch_kexec_apply_relocations_add? with type ?int(struct purgatory_info *, Elf64_Shdr *, const Elf64_Shdr *, const Elf64_Shdr *)? {aka ?int(struct purgatory_info *, struct elf64_shdr *, const struct elf64_shdr *, const struct elf64_shdr *)?}
>>>    236 | arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
>>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> (I think) because there is a conflict between the two commits:
>>>
>>> 233c1e6c319c kexec_file: drop weak attribute from arch_kexec_apply_relocations[_add]
>>> 838b3e28488f RISC-V: Load purgatory in kexec_file
>>>
>>> And so next is broken starting from
>>> 164a9037b1d33f28ba27671c16ec1c23d4a11acf which merges the riscv tree.
>>>
>>
>> In arch/riscv/include/asm/kexec.h, do the same as s390 did in commit 
>> 233c1e6c319c:
>>
>> diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
>> index 7f3c9ac34bd8..540dd469b088 100644
>> --- a/arch/s390/include/asm/kexec.h
>> +++ b/arch/s390/include/asm/kexec.h
>> @@ -83,4 +83,12 @@ struct kimage_arch {
>>   extern const struct kexec_file_ops s390_kexec_image_ops;
>>   extern const struct kexec_file_ops s390_kexec_elf_ops;
>>
>> +#ifdef CONFIG_KEXEC_FILE
>> +struct purgatory_info;
>> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>> +				     Elf_Shdr *section,
>> +				     const Elf_Shdr *relsec,
>> +				     const Elf_Shdr *symtab);
>> +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>> +#endif
>>   #endif /*_S390_KEXEC_H */
> 
> I can confirm that doing
> 
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
> index 206217b23301..eee260e8ab30 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>  
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops elf_kexec_ops;
> +
> +struct purgatory_info;
> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> +				     Elf_Shdr *section,
> +				     const Elf_Shdr *relsec,
> +				     const Elf_Shdr *symtab);
> +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>  #endif
>  
>  #endif

LGTM, you could send a fixup patch to riscv, thanks.

> 
> on top of 838b3e28488f results in a compilable tree. And when merging
> 233c1e6c319c into this, it is still building.
> 
> I'm not enough into kexec (and riscv) to judge if this is sensible, or
> create a useful commit log but the obvious way forward is to apply the
> above patch to the riscv tree before it hits Linus' tree.
> 
> Best regards
> Uwe
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
BR,
Liao, Chang

