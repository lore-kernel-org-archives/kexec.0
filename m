From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Thu, 24 Mar 2022 11:37:27 +0530
Subject: [RFC v3 PATCH 3/5] powrepc/crash hp: update kimage struct
In-Reply-To: <8fc2d63d-97db-59ab-3043-d453fed1e7e3@oracle.com>
References: <20220321080422.56255-1-sourabhjain@linux.ibm.com>
 <20220321080422.56255-4-sourabhjain@linux.ibm.com>
 <8fc2d63d-97db-59ab-3043-d453fed1e7e3@oracle.com>
Message-ID: <1d9a3eaf-191c-da35-3628-38e8c0ad54bc@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hello Eric,

On 24/03/22 00:02, Eric DeVolder wrote:
>
>
> On 3/21/22 03:04, Sourabh Jain wrote:
>> Two new members fdt_index and fdt_index_valid are added in kimage_arch
>> struct to track the FDT kexec segment. These new members of kimage_arch
>> struct will help the crash hotplug handler to easily access the FDT
>> segment from the kexec segment array. Otherwise, we have to loop through
>> all kexec segments to find the FDT segments.
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>
>> ---
>> ? arch/powerpc/include/asm/kexec.h | 2 ++
>> ? 1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/kexec.h 
>> b/arch/powerpc/include/asm/kexec.h
>> index e1288826e22e..19c2cab6a880 100644
>> --- a/arch/powerpc/include/asm/kexec.h
>> +++ b/arch/powerpc/include/asm/kexec.h
>> @@ -104,6 +104,8 @@ extern const struct kexec_file_ops kexec_elf64_ops;
>> ? struct kimage_arch {
>> ????? struct crash_mem *exclude_ranges;
>> ? +??? int fdt_index;
>> +??? bool fdt_index_valid;
>> ????? unsigned long backup_start;
>> ????? void *backup_buf;
>> ????? void *fdt;
>>
>
> Question, for the kexec_file_load scenario, is there a need to have 
> the fdt_index segment excluded by kexec_calculate_store_digests() ?

On PowerPC, SHA verification is not done for kexec_file_load system 
call, so we might not need to exclude the FDT segment.

Thanks for the review.

- Sourabh Jain


