From: Eric DeVolder <eric.devolder@oracle.com>
Date: Tue, 1 Mar 2022 14:04:42 -0600
Subject: [PATCH v4 03/10] crash hp: definitions and prototype changes
In-Reply-To: <YhWtSWbKbr6aLezO@MiWiFi-R3L-srv>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-4-eric.devolder@oracle.com>
 <YhWtSWbKbr6aLezO@MiWiFi-R3L-srv>
Message-ID: <4645ff8f-d4ab-a6a5-b4dd-df2b652daaee@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 2/22/22 21:43, Baoquan He wrote:
> On 02/09/22 at 02:56pm, Eric DeVolder wrote:
>> This change adds members to struct kimage to facilitate crash
>> hotplug support.
>>
>> This change also defines crash hotplug events and associated
>> prototypes.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/kexec.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 0c994ae37729..13c238c2da48 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -299,6 +299,13 @@ struct kimage {
>>   
>>   	/* Information for loading purgatory */
>>   	struct purgatory_info purgatory_info;
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	bool hotplug_event;
>> +	int offlinecpu;
>> +	bool elf_index_valid;
>> +	int elf_index;
>> +#endif
>>   #endif
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> @@ -315,6 +322,15 @@ struct kimage {
>>   	unsigned long elf_load_addr;
>>   };
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned long a, unsigned long b);
> 
> Seems this patch can be merged with patch 6/10. I don't see prototype
> change in this patch.

Ok, done.
eric

> 
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

