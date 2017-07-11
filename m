Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dUptY-0000NH-39
 for kexec@lists.infradead.org; Tue, 11 Jul 2017 07:47:46 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [makedumpfile PATCH] Allow PFN_EXCLUDED to be tunable via
 command line option --exclude-threshold
Date: Tue, 11 Jul 2017 07:43:47 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EEFA89@BPXM01GP.gisp.nec.co.jp>
References: <1499368882-2125-1-git-send-email-eric.devolder@oracle.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EEEC72@BPXM01GP.gisp.nec.co.jp>
 <109a59ca-9ea3-662c-6c27-2a919f991053@oracle.com>
 <cf1f0817-ab19-30b9-fce4-b82b6e678091@oracle.com>
In-Reply-To: <cf1f0817-ab19-30b9-fce4-b82b6e678091@oracle.com>
Content-Language: ja-JP
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
To: Eric DeVolder <eric.devolder@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "daniel.kiper@oracle.com" <daniel.kiper@oracle.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>

Hello Eric,

>> On 07/07/2017 04:09 AM, Atsushi Kumagai wrote:
>>>> The PFN_EXCLUDED value is used to control at which point a run of
>>>> zeros in the bitmap (zeros denote excluded pages) is large enough
>>>> to warrant truncating the current output segment and to create a
>>>> new output segment (containing non-excluded pages), in an ELF dump.
>>>>
>>>> If the run is smaller than PFN_EXCLUDED, then those excluded pages
>>>> are still output in the ELF dump, for the current output segment.
>>>>
>>>> By using smaller values of PFN_EXCLUDED, the resulting dump file
>>>> size can be made smaller by actually removing more excluded pages
>>>> from the resulting dump file.
>>>>
>>>> This patch adds the command line option --exclude-threshold=<value>
>>>> to indicate the threshold. The default is 256, the legacy value
>>>> of PFN_EXCLUDED. The smallest value permitted is 1.
>>>>
>>>> Using an existing vmcore, this was tested by the following:
>>>>
>>>> % makedumpfile -E -d31 --exclude-threshold=256 -x vmlinux vmcore
>>>> newvmcore256
>>>> % makedumpfile -E -d31 --exclude-threshold=4 -x vmlinux vmcore
>>>> newvmcore4
>>>>
>>>> I utilize -d31 in order to exclude as many page types as possible,
>>>> resulting in a [significantly] smaller file sizes than the original
>>>> vmcore.
>>>>
>>>> -rwxrwx--- 1 edevolde edevolde 4034564096 Jun 27 10:24 vmcore
>>>> -rw------- 1 edevolde edevolde 119808156 Jul  6 13:01 newvmcore256
>>>> -rw------- 1 edevolde edevolde 100811276 Jul  6 13:08 newvmcore4
>>>>
>>>> The use of smaller value of PFN_EXCLUDED increases the number of
>>>> output segments (the 'Number of program headers' in the readelf
>>>> output) in the ELF dump file.
>>>
>>> How will you tune the value ? I'm not sure what is the benefit of the
>>> tunable PFN_EXCLUDED. If there is no regression caused by too many
>>> PT_LOAD
>>> entries, I think we can decide a concrete PFN_EXCLUDED.
>>
>> Allow me note two things prior to addressing the question.
>>
>> Note that the value for PFN_EXCLUDED really should be in the range:
>>
>>   1 <= PFN_EXCLUDED <= NUM_PAGES(largest segment)
>>
>> but that values larger than NUM_PAGES(largest segment) behave the same
>> as NUM_PAGES(largest segment) and simply prevent makedumpfile from ever
>> omitting excluded pages from the dump file.
>>
>> Also note that the ELF header allows for a 16-bit e_phnum value for the
>> number of segments in the dump file. As it stands today, I doubt that
>> anybody has come close to reaching 65535 segments, but the combination
>> of larger and larger memories as well as the work we (Oracle) are doing
>> to further enhance the capabilities of makedumpfile, I believe we will
>> start to challenge this 65535 number.

I overlooked the limitation of the number of segments, so I considered
only "The first benefit" you said below. 

>> The ability to tune PFN_EXCLUDED allows one to minimize file size while
>> still staying within ELF boundaries.
>>
>> There are two ways in which have PFN_EXCLUDED as a tunable parameter
>> benefits the user.
>>
>> The first benefit is, when making PFN_EXCLUDED smaller, makedumpfile has
>> more opportunities to NOT write excluded pages to the resulting dump
>> file, thus obtaining a smaller overall dump file size. And since a
>> PT_LOAD header is smaller than a page, this penalty (of more segments)
>> will always result in a smaller file size. (In the example I cite the
>> dump file was 18MB smaller with a PFN_EXCLUDED value of 4 than default
>> 256, in spite of increasing the number of segments from 6 to 244).
>>
>> The second benefit is, when enabling PFN_EXCLUDED to become larger, it
>> allows makedumpfile to continue to generate valid ELF dump files in the
>> presence of larger and larger memory systems. Generally speaking, the
>> goal is to minimize the size of dump files via the exclusion of
>> uninteresting pages (ie zero, free, etc), especially as the size of
>> memory continues to grow and grow. As the memory increases, there are
>> more and more of these uninteresting pages, and more opportunities for
>> makedumpfile to omit them (even at the current PFN_EXCLUDED value of
>> 256). Furthermore, we are working on additional page exclusion
>> strategies that will drive more and more opportunities for makedumpfile
>> to omit these pages from the dump file. And as makedumpfile omits more
>> and more pages from the dump file, that increases the number of segments
>> needed.
>>
>> By enabling a user to tune the value of PFN_EXCLUDED, we provide an
>> additional mechanism to balance the size of the ELF dump file with
>> respect to the size of memory.
>
>It occurred to me that offering the option "--exclude-threshold=auto"
>whereby a binary search on the second bitmap in the function
>get_loads_dumpfile_cyclic() to determine the optimum value of
>PFN_EXCLUDED (optimum here meaning the smallest possible value while
>still staying within 65535 segments, which would yield the smallest
>possible dump file size for the given constraints) would be an excellent
>feature to have?

I think the "auto" is necessary for --exclude-threshold, the optimum
value should be calculated automatically. Otherwise, it imposes trial-and-error
on users every time, it doesn't sound practical. IOW, this patch is
unacceptable if there is no mechanism to support users.
So now, my only concern for this option is the processing time of the
binary search.

[snip]
>>>> And with a larger number of segments, loading both vmcore and newvmcore4
>>>> into 'crash' resulted in identical outputs when run with the dmesg, ps,
>>>> files, mount, and net sub-commands.
>>>
>>> What about the processing speed of crash, is there no slow down ?
>>
>> I did not observe a noticeable change in processing speed of crash.

Good, it would be better to be represented by actual measured results.

Thanks,
Atsushi Kumagai

>>>
>>>
>>> Thanks,
>>> Atsushi Kumagai
>>>
>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>>> ---
>>>> v1: Posted 06jul2017 to kexec-tools mailing list
>>>> - original
>>>> ---
>>>> makedumpfile.c | 20 +++++++++++++++++---
>>>> makedumpfile.h |  4 +++-
>>>> 2 files changed, 20 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/makedumpfile.c b/makedumpfile.c
>>>> index e69b6df..940f64c 100644
>>>> --- a/makedumpfile.c
>>>> +++ b/makedumpfile.c
>>>> @@ -7236,7 +7236,7 @@ get_loads_dumpfile_cyclic(void)
>>>>
>>>>                 /*
>>>>                  * If the number of the contiguous pages to be excluded
>>>> -                 * is 256 or more, those pages are excluded really.
>>>> +                 * is PFN_EXCLUDED or more, those pages are excluded
>>>> really.
>>>>                  * And a new PT_LOAD segment is created.
>>>>                  */
>>>>                 if (num_excluded >= PFN_EXCLUDED) {
>>>> @@ -7352,7 +7352,7 @@ write_elf_pages_cyclic(struct cache_data
>>>> *cd_header, struct cache_data *cd_page)
>>>>                     continue;
>>>>                     /*
>>>>                      * If the number of the contiguous pages to be
>>>> excluded
>>>> -                     * is 255 or less, those pages are not excluded.
>>>> +                     * is less than PFN_EXCLUDED, those pages are
>>>> not excluded.
>>>>                      */
>>>>                 } else if (num_excluded < PFN_EXCLUDED) {
>>>>                     if ((pfn == pfn_end - 1) && frac_tail) {
>>>> @@ -7370,7 +7370,7 @@ write_elf_pages_cyclic(struct cache_data
>>>> *cd_header, struct cache_data *cd_page)
>>>>
>>>>                 /*
>>>>                  * If the number of the contiguous pages to be excluded
>>>> -                 * is 256 or more, those pages are excluded really.
>>>> +                 * is PFN_EXCLUDED or more, those pages are excluded
>>>> really.
>>>>                  * And a new PT_LOAD segment is created.
>>>>                  */
>>>>                 load.p_memsz = memsz;
>>>> @@ -11007,6 +11007,7 @@ static struct option longopts[] = {
>>>>     {"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
>>>>     {"work-dir", required_argument, NULL, OPT_WORKING_DIR},
>>>>     {"num-threads", required_argument, NULL, OPT_NUM_THREADS},
>>>> +    {"exclude-threshold", required_argument, NULL,
>>>> OPT_PFN_EXCLUDE_THRESHOLD},
>>>>     {0, 0, 0, 0}
>>>> };
>>>>
>>>> @@ -11044,6 +11045,14 @@ main(int argc, char *argv[])
>>>>      */
>>>>     info->flag_usemmap = MMAP_TRY;
>>>>
>>>> +    /*
>>>> +     * A run of zeros in the bitmap (excluded pages) of less than
>>>> +     * pfn_excluded_threshold in length will still be dumped. Runs
>>>> greater
>>>> +     * than or equal to pfn_excluded_threshold will result in the
>>>> creation
>>>> +     * of a new output segment, for ELF dumps.
>>>> +     */
>>>> +    info->pfn_exclude_threshold = 256;
>>>> +
>>>>     info->block_order = DEFAULT_ORDER;
>>>>     message_level = DEFAULT_MSG_LEVEL;
>>>>     while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lpRvXx:",
>>>> longopts,
>>>> @@ -11163,6 +11172,11 @@ main(int argc, char *argv[])
>>>>         case OPT_NUM_THREADS:
>>>>             info->num_threads = MAX(atoi(optarg), 0);
>>>>             break;
>>>> +        case OPT_PFN_EXCLUDE_THRESHOLD:
>>>> +            info->pfn_exclude_threshold = strtoul(optarg, NULL, 0);
>>>> +            if (0 == info->pfn_exclude_threshold)
>>>> +                info->pfn_exclude_threshold = 1;
>>>> +            break;
>>>>         case '?':
>>>>             MSG("Commandline parameter is invalid.\n");
>>>>             MSG("Try `makedumpfile --help' for more information.\n");
>>>> diff --git a/makedumpfile.h b/makedumpfile.h
>>>> index e32e567..33d3eb0 100644
>>>> --- a/makedumpfile.h
>>>> +++ b/makedumpfile.h
>>>> @@ -216,7 +216,7 @@ isAnon(unsigned long mapping)
>>>>
>>>> #define BITPERBYTE        (8)
>>>> #define PGMM_CACHED        (512)
>>>> -#define PFN_EXCLUDED        (256)
>>>> +#define PFN_EXCLUDED        (info->pfn_exclude_threshold)
>>>> #define BUFSIZE            (1024)
>>>> #define BUFSIZE_FGETS        (1500)
>>>> #define BUFSIZE_BITMAP        (4096)
>>>> @@ -1139,6 +1139,7 @@ struct DumpInfo {
>>>>     long        page_size;           /* size of page */
>>>>     long        page_shift;
>>>>     mdf_pfn_t    max_mapnr;   /* number of page descriptor */
>>>> +    unsigned long    pfn_exclude_threshold;
>>>>     unsigned long   page_offset;
>>>>     unsigned long   section_size_bits;
>>>>     unsigned long   max_physmem_bits;
>>>> @@ -2143,6 +2144,7 @@ struct elf_prstatus {
>>>> #define OPT_SPLITBLOCK_SIZE    OPT_START+14
>>>> #define OPT_WORKING_DIR         OPT_START+15
>>>> #define OPT_NUM_THREADS    OPT_START+16
>>>> +#define OPT_PFN_EXCLUDE_THRESHOLD    OPT_START+17
>>>>
>>>> /*
>>>>  * Function Prototype.
>>>> --
>>>> 2.7.4
>>>
>>>
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>>>
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
