From: Eric DeVolder <eric.devolder@oracle.com>
Date: Fri, 21 Jan 2022 07:48:58 -0600
Subject: [PATCH v3 3/6] crash hp: definitions and prototype changes
In-Reply-To: <20220119082645.GA6349@MiWiFi-R3L-srv>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220110195727.1682-4-eric.devolder@oracle.com>
 <20220119082645.GA6349@MiWiFi-R3L-srv>
Message-ID: <8af14bc9-7aab-433b-f741-494b3857226f@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Baoquan,
Thanks for looking at this. Inline responses below.
eric

On 1/19/22 02:26, Baoquan He wrote:
> On 01/10/22 at 02:57pm, Eric DeVolder wrote:
>> This change adds members to struct kimage to facilitate crash
>> hotplug support.
>>
>> This change also defines crash hotplug events and associated
>> prototypes.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/kexec.h | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 0c994ae37729..068f853f1c65 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -221,8 +221,9 @@ struct crash_mem {
>>   extern int crash_exclude_mem_range(struct crash_mem *mem,
>>   				   unsigned long long mstart,
>>   				   unsigned long long mend);
>> -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
>> -				       void **addr, unsigned long *sz);
>> +extern int crash_prepare_elf64_headers(struct kimage *image,
>> +					struct crash_mem *mem, int kernel_map,
>> +					void **addr, unsigned long *sz);
>>   #endif /* CONFIG_KEXEC_FILE */
>>   
>>   #ifdef CONFIG_KEXEC_ELF
>> @@ -299,6 +300,13 @@ struct kimage {
>>   
>>   	/* Information for loading purgatory */
>>   	struct purgatory_info purgatory_info;
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	bool hotplug_event;
>> +	int offlinecpu;
>> +	bool elf_index_valid;
>> +	int elf_index;
> 
> Do we really need elf_index_valid? Can we initialize elf_index to , e.g '-1',
> then check if the value is valid?

These members become part of struct kimage, and when the kimage is allocated, it is automatically 
zero'd. Wrt/ elf_index, 0 is a valid index, and so it needs to be qualified. I initially had used 
-1, but that required code and was fragile as I had to find the right place to do that. Using the 
boolean elf_index_valid, the problems with -1 vanish, and for free! I also found when examining the 
code that reading 'elf_index_valid' was better than 'elf_index != -1', more clear.

Let me know what you think.
eric

> 
>> +#endif
>>   #endif
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> @@ -315,6 +323,15 @@ struct kimage {
>>   	unsigned long elf_load_addr;
>>   };
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned long a, unsigned long b);
>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> +
>>   /* kexec interface functions */
>>   extern void machine_kexec(struct kimage *image);
>>   extern int machine_kexec_prepare(struct kimage *image);
>> -- 
>> 2.27.0
>>
> 

