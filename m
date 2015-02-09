Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x233.google.com ([2a00:1450:4010:c04::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YKntl-0001mU-3y
 for kexec@lists.infradead.org; Mon, 09 Feb 2015 12:57:10 +0000
Received: by mail-lb0-f179.google.com with SMTP id w7so5350686lbi.10
 for <kexec@lists.infradead.org>; Mon, 09 Feb 2015 04:56:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150209055808.GC29385@verge.net.au>
References: <1422720608-28700-1-git-send-email-yszhou4tech@gmail.com>
 <1422720608-28700-3-git-send-email-yszhou4tech@gmail.com>
 <20150209055808.GC29385@verge.net.au>
From: Yousong Zhou <yszhou4tech@gmail.com>
Date: Mon, 9 Feb 2015 20:56:25 +0800
Message-ID: <CAECwjAhBPPPV-BPjcseFd3op-G_en=mUBrw6oeSGgKt4d0AM3Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] Fix a few compilation warnings.
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On 9 February 2015 at 13:58, Simon Horman <horms@verge.net.au> wrote:
> These changes do not seem to be related to each other.
> Please split this into 4 separate patches each with
> a changelog that briefly describes what the problem is.
>

Will split them each into a separate patch.

> On Sun, Feb 01, 2015 at 12:10:08AM +0800, Yousong Zhou wrote:
>>
>> Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
>> ---
>>  kexec/arch/mips/crashdump-mips.c |    3 ++-
>>  kexec/arch/mips/kexec-elf-mips.c |    2 +-
>>  kexec/kexec-elf-rel.c            |    3 +++
>>  kexec/kexec.h                    |    2 +-
>>  4 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
>> index e7840e0..98c9f7c 100644
>> --- a/kexec/arch/mips/crashdump-mips.c
>> +++ b/kexec/arch/mips/crashdump-mips.c
>> @@ -22,6 +22,7 @@
>>  #include <stdlib.h>
>>  #include <errno.h>
>>  #include <limits.h>
>> +#include <inttypes.h>
>>  #include <elf.h>
>>  #include <sys/types.h>
>>  #include <sys/stat.h>
>> @@ -52,7 +53,7 @@ static int get_kernel_paddr(struct crash_elf_info *elf_info)
>>
>>       if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
>>               elf_info->kern_paddr_start = start;
>> -             dbgprintf("kernel load physical addr start = 0x%lx\n", start);
>> +             dbgprintf("kernel load physical addr start = 0x%" PRIu64 "\n", start);
>>               return 0;
>>       }
>>
>> diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
>> index a27d986..8a6419a 100644
>> --- a/kexec/arch/mips/kexec-elf-mips.c
>> +++ b/kexec/arch/mips/kexec-elf-mips.c
>> @@ -158,7 +158,7 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
>>       if (info->kexec_flags & KEXEC_ON_CRASH)
>>               /* In case of crashdump segment[0] is kernel.
>>                * Put cmdline just after it. */
>> -             cmdline_addr = info->segment[0].mem +
>> +             cmdline_addr = (unsigned long)info->segment[0].mem +
>>                               info->segment[0].memsz;
>
> I wonder if we can resolve this without resorting to a cast.

It's a "pointer to integer without cast" warning.  I think keeping
(unsigned long) for a pointer is fine, isnt it?

>
>>       else
>>               cmdline_addr = 0;
>> diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
>> index c625f30..5a5fcd1 100644
>> --- a/kexec/kexec-elf-rel.c
>> +++ b/kexec/kexec-elf-rel.c
>> @@ -347,6 +347,9 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
>>                       else if (shdr->sh_type == SHT_RELA) {
>>                               rel = elf_rela(ehdr, ptr);
>>                       }
>> +                     else {
>> +                             die("Unexpected sh_type: %d\n", shdr->sh_type);
>> +                     }
>>                       /* the location to change */
>>                       location = section->sh_data + rel.r_offset;
>>

This one has already been fixed by explicitly initialising the local
variable.  So I will drop it in the next version.

Thank you for your time on this.

                yousong

>> diff --git a/kexec/kexec.h b/kexec/kexec.h
>> index 4be2b2f..2c85052 100644
>> --- a/kexec/kexec.h
>> +++ b/kexec/kexec.h
>> @@ -245,7 +245,7 @@ extern int file_types;
>>
>>  extern void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr);
>>  extern void die(const char *fmt, ...)
>> -     __attribute__ ((format (printf, 1, 2)));
>> +     __attribute__ ((format (printf, 1, 2), noreturn));
>>  extern void *xmalloc(size_t size);
>>  extern void *xrealloc(void *ptr, size_t size);
>>  extern char *slurp_file(const char *filename, off_t *r_size);
>> --
>> 1.7.10.4
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
