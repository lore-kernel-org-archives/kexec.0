From: Eric DeVolder <eric.devolder@oracle.com>
Date: Fri, 1 Apr 2022 13:35:28 -0500
Subject: [PATCH v5 8/8] x86/crash: Add x86 crash hotplug support for
 kexec_load
In-Reply-To: <YkWMFzxJpkiTjKvL@MiWiFi-R3L-srv>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-9-eric.devolder@oracle.com>
 <YkWMFzxJpkiTjKvL@MiWiFi-R3L-srv>
Message-ID: <bc5ec4a0-a33c-1ca1-c66d-635f4e0b9731@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 3/31/22 06:10, Baoquan He wrote:
> On 03/03/22 at 11:27am, Eric DeVolder wrote:
>> For kexec_file_load support, the loading of the crash kernel occurs
>> entirely within the kernel, and as such the elfcorehdr is readily
>> identified (so that it can be modified upon hotplug events).
>>
>> This change enables support for kexec_load by identifying the
>> elfcorehdr segment in the arch_crash_hotplug_handler(), if it has
>> not already been identified.
>>
>> In general, support for kexec_load requires corresponding changes
>> to the userspace kexec-tools utility. It is the responsibility of
>> the userspace kexec utility to ensure that:
>>   - the elfcorehdr segment is sufficiently large enough to accommodate
>>     hotplug changes, ala CRASH_HOTPLUG_ELFCOREHDR_SZ.
>>   - provides a purgatory that excludes the elfcorehdr from its list of
>>     run-time segments to check.
>> These changes to the userspace kexec utility are available, but not
>> yet accepted upstream.
> 
> These backgroud information should be put in cover letter, or in patch
> where they won't be grabbed into the final commit log.
Removed.

> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
> Here, if you want to put some status or backgroud information and expect
> they are not got into log, this is a appropriate place.
> 
> 
>>   arch/x86/kernel/crash.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 5da30e2bc780..45cc6e3af63e 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -486,6 +486,32 @@ void arch_crash_hotplug_handler(struct kimage *image,
>>   	void *elfbuf = NULL;
>>   	unsigned long mem, memsz;
>>   
>> +	/*
>> +	 * When the struct kimage is alloced, it is wiped to zero, so
>> +	 * the elf_index_valid defaults to false. It is set on the
>> +	 * kexec_file_load path, or here for kexec_load.
> 
>           I would make the last line as:
> 	 kexec_file_load path, or here for kexec_load if not already
>           identified..
done

> 
>> +	 */
>> +	if (!image->elf_index_valid) {
>> +		unsigned int n;
>> +
>> +		for (n = 0; n < image->nr_segments; n++) {
>> +			mem = image->segment[n].mem;
>> +			memsz = image->segment[n].memsz;
>> +			ptr = map_crash_pages(mem, memsz);
>> +			if (ptr) {
>> +				/* The segment containing elfcorehdr */
>> +				if ((ptr[0] == 0x7F) &&
>> +					(ptr[1] == 'E') &&
>> +					(ptr[2] == 'L') &&
>> +					(ptr[3] == 'F')) {
> 
> Can it be like memcmp(ptr, ELFMAG, SELFMAG) as we have done in
> parse_crash_elf_headers()? With that, one line is taken.
done

> 
>> +					image->elf_index = (int)n;
>> +					image->elf_index_valid = true;
>> +				}
>> +			}
>> +			unmap_crash_pages((void **)&ptr);
>> +		}
>> +	}
>> +
>>   	/* Must have valid elfcorehdr index */
>>   	if (!image->elf_index_valid) {
>>   		pr_err("crash hp: unable to locate elfcorehdr segment");
>> -- 
>> 2.27.0
>>
> 

