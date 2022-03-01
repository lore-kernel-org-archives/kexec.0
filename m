From: Eric DeVolder <eric.devolder@oracle.com>
Date: Tue, 1 Mar 2022 14:07:50 -0600
Subject: [PATCH v4 07/10] crash hp: exclude elfcorehdr from the segment
 digest
In-Reply-To: <YhWxeSG3GfJwOGOV@MiWiFi-R3L-srv>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-8-eric.devolder@oracle.com>
 <YhWxeSG3GfJwOGOV@MiWiFi-R3L-srv>
Message-ID: <dbe84151-e3dc-7a1a-6cb2-2021d8dfb461@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 2/22/22 22:00, Baoquan He wrote:
> On 02/09/22 at 02:57pm, Eric DeVolder wrote:
>> When a crash kernel is loaded via the kexec_file_load syscall, the
>> kernel places the various segments (ie crash kernel, crash initrd,
>> boot_params, elfcorehdr, purgatory, etc) in memory. For those
>> architectures that utilize purgatory, a hash digest of the segments
>> is calculated for integrity checking. This digest is embedded into
>> the purgatory image prior to placing purgatory in memory.
>>
>> Since hotplug events cause changes to the elfcorehdr, purgatory
>> integrity checking fails (at crash time, and no kdump created).
>> As a result, this change explicitly excludes the elfcorehdr segment
>> from the list of segments used to create the digest. By doing so,
>> this permits changes to the elfcorehdr in response to hotplug events,
>> without having to also reload purgatory due to the change to the
>> digest.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
Thank you!
eric

> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   kernel/kexec_file.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 801d0d0a5012..93bb0c0ce66c 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
>>   	for (j = i = 0; i < image->nr_segments; i++) {
>>   		struct kexec_segment *ksegment;
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +		/* This segment excluded to allow future changes via hotplug */
>> +		if (image->elf_index_valid && (j == image->elf_index))
>> +			continue;
>> +#endif
>> +
>>   		ksegment = &image->segment[i];
>>   		/*
>>   		 * Skip purgatory as it will be modified once we put digest
>> -- 
>> 2.27.0
>>
> 

