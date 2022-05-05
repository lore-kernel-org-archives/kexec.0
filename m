From: Hui Li <lihui@loongson.cn>
Date: Thu, 5 May 2022 16:08:29 +0800
Subject: [PATCH] Add method to pass initrd through cmdline
In-Reply-To: <YnDLraNHThX6PLqS@vergenet.net>
References: <20220418013659.5545-1-lihui@loongson.cn>
 <YmuyegqF7HeSfkah@vergenet.net>
 <966d2720-ee01-2838-4bde-fd3309d9175d@loongson.cn>
 <YnDLraNHThX6PLqS@vergenet.net>
Message-ID: <a5345f06-134f-457c-e950-2faf3e20a1e9@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Simon Horman

  Thanks for your reply.

On 2022/5/3 ??2:29, Simon Horman wrote:
> On Tue, May 03, 2022 at 01:50:19PM +0800, Hui Li wrote:
>> Hi Simon Horman,
>>
>> Thanks for your review.
>>
>> On 2022/4/29 ??5:40, Simon Horman wrote:
>>> Hi Hui Li,
>>>
>>> thanks for your patch.
>>>
>>> On Mon, Apr 18, 2022 at 09:36:59AM +0800, Hui Li wrote:
>>>> Problem description:
>>>> Under loongson platform,use command:
>>>> kexec -l vmlinux... --append="root=UUID=28e1..." --initrd=...
>>>> kexec -e
>>>> quick restart failed.
>>>>
>>>> The reason of this problem:
>>>> The kernel cannot parse the UUID,UUID is parsed in the initrd.
>>>> Loongson platform obtain the initrd through cmdline in kernel.
>>>> In kexec-tools, initrd is not added to cmdline.
>>>
>>> Is this common to other platforms?
>>> If not, is there a reason that Loongson takes this approach?
>>>
>> in kernel code,arch/mips/configs/loongson3_defconfig,
>> CONFIG_BLK_DEV_INITRD=y is defined.
>> In arch/mips/kernel/setup.c file, the following code?
>>
>> #ifdef CONFIG_BLK_DEV_INITRD
>>
>>
>> static int __init rd_start_early(char *p)
>> {
>>      unsigned long start = memparse(p, &p);
>>
>> #ifdef CONFIG_64BIT
>>      /* Guess if the sign extension was forgotten by bootloader */
>>      if (start < XKPHYS)
>>          start = (int)start;
>> #endif
>>      initrd_start = start;
>>      initrd_end += start;
>>      return 0;
>> }
>> early_param("rd_start", rd_start_early);
>>
>> static int __init rd_size_early(char *p)
>> {
>>      initrd_end += memparse(p, &p);
>>      return 0;
>> }
>> early_param("rd_size", rd_size_early);
>> ...
>> ...
>> ...
>> #endif
>>
>>
>>
>> The purpose of parsing initrd parameters through cmdline on the loongson is
>> to compatible with previous platforms
> 
> Thanks. I'm very fine with mechanisms that preserve compatibility.
> But if I understand things correctly then this feature is not specific
> to Loongson (although it has only been tested on Loongson).
> 

Thanks.
This problem was found on the loongson platform,and seeing mips and 
other platforms, the approach in this part is really different.
I want to solve this problem of the loongson cpu without affecting other 
platforms.
Therefore, the following modifications are based on this principle.


>> Maybe other platforms use DTB to parse initrd, but it can be seen that the
>> kernel also supports the use of cmdline to parse initrd.
>>
>>>> The solution:
>>>> Add initrd parameter to cmdline. and add a CONFIG_LOONGSON configuration
>>>> to distinguish PAGE_OFFSET between different platforms under mips.
>>>>
>>>> Signed-off-by: Hui Li <lihui@loongson.cn>
>>>> ---
>>>>    configure.ac                     |  5 ++++
>>>>    kexec/arch/mips/crashdump-mips.h |  6 ++++-
>>>>    kexec/arch/mips/kexec-elf-mips.c | 43 ++++++++++++++++++++++++++++++++
>>>>    3 files changed, 53 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/configure.ac b/configure.ac
>>>> index cf8e8a2..26bfbcd 100644
>>>> --- a/configure.ac
>>>> +++ b/configure.ac
>>>> @@ -111,6 +111,11 @@ AC_ARG_WITH([booke],
>>>>    		AC_DEFINE(CONFIG_BOOKE,1,
>>>>    			[Define to build for BookE]))
>>>> +AC_ARG_WITH([loongson],
>>>> +		AC_HELP_STRING([--with-loongson],[build for loongson]),
>>>> +		AC_DEFINE(CONFIG_LOONGSON,1,
>>>> +			[Define to build for LoongsoN]))
>>>> +
>>>>    dnl ---Programs
>>>>    dnl To specify a different compiler, just 'export CC=/path/to/compiler'
>>>>    if test "${build}" != "${host}" ; then
>>>> diff --git a/kexec/arch/mips/crashdump-mips.h b/kexec/arch/mips/crashdump-mips.h
>>>> index 7edd859..d53c696 100644
>>>> --- a/kexec/arch/mips/crashdump-mips.h
>>>> +++ b/kexec/arch/mips/crashdump-mips.h
>>>> @@ -5,7 +5,11 @@ struct kexec_info;
>>>>    int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
>>>>    				unsigned long max_addr, unsigned long min_base);
>>>>    #ifdef __mips64
>>>> -#define PAGE_OFFSET	0xa800000000000000ULL
>>>> +#ifdef CONFIG_LOONGSON
>>>> +#define PAGE_OFFSET 0xFFFFFFFF80000000ULL
>>>> +#else
>>>> +#define PAGE_OFFSET 0xa800000000000000ULL
>>>> +#endif
>>>
>>> Could this be detected at runtime?
>>>
>>> It seems awkward to set the PAGE_OFFSET at compile time and
>>> thus need separate builds for separate platforms (with no warning
>>> if the wrong one is used).
>>>
>> Thank you very much for this good suggestion.
>> I see that there is a way to get different platform information at runtime
>> via "/proc/cpuinfo", which is used to distinguish PAGE_OFFSET for different
>> platforms.
> 
> Looking at ARM and arm64 implementations of get_kernel_page_offset()
> they seem to rely on /proc/kallsyms for autodetection of page_offset.
> 
> Perhaps something similar could be done for MIPS.
> 
> Also, as an asside, it seems at a glance that ARM and adm64 are the same in
> this regard. So there seems to be some scope for consolidation.
> 

Thanks for the tips.
I analyzed the relevant code of mips and other platforms.
It seems that the page_offset will be modified in crashdump-xxx.c

kexec/arch/mips/crashdump-mips.c  uses the following method to 
distinguish the page_offset of different cpus.

static int patch_elf_info(void) 
 

{
     ...
     const char cpuinfo[] = "/proc/cpuinfo";
     ...
     ...
     fp = fopen(cpuinfo, "r");
     ...
     while (fgets(line, sizeof(line), fp) != 0) {
         if (strncmp(line, "cpu model", 9) == 0) {
             /* OCTEON uses a different page_offset. */
             if (strstr(line, "Octeon"))
                 elf_info64.page_offset = 0x8000000000000000ULL;
             break;
         }
     }

}
I will also add the page_offset modification of the loongson CPU here in 
v3 patch.

But,the modification here is for crash_kernel.

I want to add the following code to kexec/arch/mips/kexec-elf-mips.c.

/* add initrd to cmdline to compatible with previous platforms. */
static int patch_initrd_info(char *cmdline, unsigned long initrd_base, 
unsigned long initrd_size)
{
     const char cpuinfo[] = "/proc/cpuinfo";
     char line[MAX_LINE];
     FILE *fp;
     unsigned long page_offset = PAGE_OFFSET;

     fp = fopen(cpuinfo, "r");
     if (!fp) {
         fprintf(stderr, "Cannot open %s: %s\n",
         cpuinfo, strerror(errno));
         return -1;
     }
     while (fgets(line, sizeof(line), fp) != 0) {
         if (strncmp(line, "cpu model", 9) == 0) {
             /* LOONGSON64  uses a different page_offset. */
         if (strstr(line, "Loongson")) {
                 if (arch_options.core_header_type == CORE_TYPE_ELF64)
                     page_offset = (unsigned long)0xffffffff80000000ULL;
                 cmdline_add_initrd(cmdline, page_offset + initrd_base, 
" rd_start=");
                 cmdline_add_initrd(cmdline, initrd_size, " rd_size=");
             break;
             }
         }
     }
     fclose(fp);
     return 0;
}

for some reasons:
1?kexec -l and kexec -p  are two different branches in 
elf_mips_load().the crash_elf_info structure is used in the crashdump 
function. Add this part to kexec-elf-mips.c. The main purpose is to not 
affect the existing code architecture and functionality.

2?The page_offset is not modified through the symbol table similar to 
arm ?The main purpose is to be able to distinguish more clearly between 
the cpu.In this way, modifications on loongson platform will not affect 
other public code and other mips platform.

3?If other mips platform cpu have the same situation,Just add in this 
function.

>>
>>>>    #define MAXMEM		0
>>>>    #else
>>>>    #define PAGE_OFFSET	0x80000000
>>>> diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
>>>> index a2d11fc..1de418e 100644
>>>> --- a/kexec/arch/mips/kexec-elf-mips.c
>>>> +++ b/kexec/arch/mips/kexec-elf-mips.c
>>>> @@ -40,6 +40,44 @@ static const int probe_debug = 0;
>>>>    #define CMDLINE_PREFIX "kexec "
>>>>    static char cmdline_buf[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
>>>> +/* Converts unsigned long to ascii string. */
>>>> +static void ultoa(unsigned long i, char *str)
>>>> +{
>>>> +	int j = 0, k;
>>>> +	char tmp;
>>>> +
>>>> +	do {
>>>> +		str[j++] = i % 10 + '0';
>>>> +	} while ((i /= 10) > 0);
>>>> +	str[j] = '\0';
>>>
>>> Could the above be achieved using printf?
>>>
>>>> +	/* Reverse the string. */
>>>> +	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
>>>> +		tmp = str[k];
>>>> +		str[k] = str[j];
>>>> +		str[j] = tmp;
>>>> +	}
>>>
>>> I'm confused as to why the string needs to be reversed.
>>> Could it be avoided by byte-swapping 'i' before rendering it to a string?
>>> Thanks a lot for your suggestions on these details.
>> ultoa() function is used in many places.I see many other platforms have the
>> same implementation like:
>> /kexec/arch/i386/crashdump-x86.c
>> /kexec/arch/ppc64/crashdump-ppc64.c
>> /kexec/arch/ppc64/crashdump-sh.c
>>
>> So, Is it possible to keep the existing implementation ?
> 
> Ok, sure.
> 

Thanks.

>>>> +}
>>>> +
>>>> +/* Adds initrd parameters to command line. */
>>>> +static int cmdline_add_initrd(char *cmdline, unsigned long addr, char *new_para)
>>>> +{
>>>> +	int cmdlen, len;
>>>> +	char str[30], *ptr;
>>>> +
>>>> +	ptr = str;
>>>> +	strcpy(str, new_para);
>>>> +	ptr += strlen(str);
>>>> +	ultoa(addr, ptr);
>>>> +	len = strlen(str);
>>>> +	cmdlen = strlen(cmdline) + len;
>>>> +	if (cmdlen > (COMMAND_LINE_SIZE - 1))
>>>> +		die("Command line overflow\n");
>>>> +	strcat(cmdline, str);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +
>>>>    int elf_mips_probe(const char *buf, off_t len)
>>>>    {
>>>>    	struct mem_ehdr ehdr;
>>>> @@ -171,6 +209,11 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
>>>>    		/* Now that the buffer for initrd is prepared, update the dtb
>>>>    		 * with an appropriate location */
>>>>    		dtb_set_initrd(&dtb_buf, &dtb_length, initrd_base, initrd_base + initrd_size);
>>>> +
>>>> +		/* Add the initrd parameters to cmdline */
>>>> +		cmdline_add_initrd(cmdline_buf, PAGE_OFFSET + initrd_base, " rd_start=");
>>>> +		cmdline_add_initrd(cmdline_buf, initrd_size, " rd_size=");
>>>> +
>>>
>>> Will this be safe for existing use-cases?
>>>
>>
>> This modification is safe for other existing use-cases.
>> Now this method is only for the loongson platform to pass the initrd
>> correctly.  At this stage, this change is no problem to use on the loongson
>> platform, and it will not affect other platforms.
>> This part can be further constrained, only for the loongson platform.
>>
>> let me think about the above and try to
>> find a proper way, and then I will send a v3 patch.
> 
> I think it would be best to avoid compile-time constraints.
> But if a runtime constraint can ensure this runs only for tested
> platforms and existing behaviour is preserved for other platforms (if any)
> then I think we would be in good shape.
> 
> Kind regards,
> Simon
> 

I totally agree with your suggestion.
As mentioned above, existing modifications are also based on this principle.

now,Just add patch_initrd_info() function in public code,
and it only works on the loongson platform at runtime. other platforms 
remain as they were before.

Changed in v3 patch,please review.
http://lists.infradead.org/pipermail/kexec/2022-May/024797.html

Thanks!

Hui Li


