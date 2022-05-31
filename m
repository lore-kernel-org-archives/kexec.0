From: Eric DeVolder <eric.devolder@oracle.com>
Date: Tue, 31 May 2022 17:18:34 -0500
Subject: [PATCH v8 7/7] x86/crash: Add x86 crash hotplug support for
 kexec_load
In-Reply-To: <e9ddbcfe-f8d4-e542-deab-a0fadf86c6eb@linux.ibm.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-8-eric.devolder@oracle.com>
 <e9ddbcfe-f8d4-e542-deab-a0fadf86c6eb@linux.ibm.com>
Message-ID: <fed45ff2-0f1d-6c55-244f-357e103fd775@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 5/25/22 09:26, Sourabh Jain wrote:
> Hello Eric,
> 
> On 06/05/22 00:16, Eric DeVolder wrote:
>> For kexec_file_load support, the loading of the crash kernel occurs
>> entirely within the kernel, and as such the elfcorehdr is readily
>> identified (so that it can be modified upon hotplug events).
>>
>> This change enables support for kexec_load by identifying the
>> elfcorehdr segment in the arch_crash_handle_hotplug_event(),
>> if it has not already been identified.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>> ? arch/x86/kernel/crash.c | 24 ++++++++++++++++++++++++
>> ? 1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 951ef365f0a7..845d7c77854d 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -485,6 +485,30 @@ void arch_crash_handle_hotplug_event(struct kimage *image,
>> ????? void *elfbuf = NULL;
>> ????? unsigned long mem, memsz;
>> +??? /*
>> +???? * When the struct kimage is alloced, it is wiped to zero, so
>> +???? * the elfcorehdr_index_valid defaults to false. It is set on the
>> +???? * kexec_file_load path, or here for kexec_load, if not already
>> +???? * identified.
>> +???? */
>> +??? if (!image->elfcorehdr_index_valid) {
>> +??????? unsigned int n;
>> +
>> +??????? for (n = 0; n < image->nr_segments; n++) {
>> +??????????? mem = image->segment[n].mem;
>> +??????????? memsz = image->segment[n].memsz;
>> +??????????? ptr = map_crash_pages(mem, memsz);
>> +??????????? if (ptr) {
>> +??????????????? /* The segment containing elfcorehdr */
>> +??????????????? if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>> +??????????????????? image->elfcorehdr_index = (int)n;
>> +??????????????????? image->elfcorehdr_index_valid = true;
> 
> How about finding elfcorehdr index on kexec_load path post kimage_load_segment call in
> do_kexec_load (kernel/kexec.c) or other suitable place? This way we can avoid checking for
> elfcorehdr index for every hotplug. Also we might not need image->elfcorehdr_index_valid.

That would be a viable place to put it. However, a couple of notes.

This code actually works for both kexec_load and kexec_file_load paths (how I originally used this 
code); so if we were to move this to a more common location, I'd be in favor of a location that 
serves both paths (ie handle_hotplug_event() makes sense to me). That would eliminate the need for 
setting the index in the kexec_file_load paths.

Also, I don't see a scenario where elfcorehdr_index_valid can be eliminated; the index isn't always 
valid. What are you thinking?

And the check is rather low cost being the check of a boolean.

eric
> 
> Thanks,
> Sourabh Jain
> 
> 

