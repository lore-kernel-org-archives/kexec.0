Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fzRWv-0004q2-Th
 for kexec@lists.infradead.org; Mon, 10 Sep 2018 19:07:28 +0000
Received: by mail-lf1-f68.google.com with SMTP id v77-v6so18347752lfa.6
 for <kexec@lists.infradead.org>; Mon, 10 Sep 2018 12:07:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0355A8EF@BPXM09GP.gisp.nec.co.jp>
References: <1534794340-1244-1-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355A8EF@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 11 Sep 2018 00:37:13 +0530
Message-ID: <CACi5LpM876F0dH61yawdPgB3r-Wn5zwyF-k08v0Q6pvYpP1XfQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Add a generic method of determining invalid
 phy-addr for calculating 'info->page_offset'
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Kazu,

Sorry for the late reply. I was waiting for the new patches (see [1]
and [2]) to make way upstream/or be discussed upstream, so that we can
simplify the logic of getting the arm64 specific constructs in
user-space utilities  like PHYS_OFFSET and KASLR_OFFSET (which are to
be made available via both '/proc/kcore' and '/proc/vmcore' with the
latest changes).

So, after [1], '/proc/kcore' now contains vmcoreinfo as a PT_NOTE.

I have a working version available now which allows makedumpfile to
determine the contents required for arm64 info->page_offset to be
calculate via the vmcoreinfo inside '/proc/kcore'. I am similarly
working on kexec-tools and crash utility to add the same feature.

I am testing the version on multiple boards now and will soon send out
a version for review:

[1] commit 23c85094fe1895caefdd19ef624ee687ec5f4507
Author: Omar Sandoval <osandov@fb.com>
Date:   Tue Aug 21 21:55:20 2018 -0700

    proc/kcore: add vmcoreinfo note to /proc/kcore

[2] https://www.spinics.net/lists/arm-kernel/msg675582.html

Thanks,
Bhupesh

On Tue, Aug 21, 2018 at 8:57 PM, Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
> Hi Bhupesh,
>
> On 8/20/2018 3:45 PM, Bhupesh Sharma wrote:
>> Commit 94c97db3fe859ca14d7b38b0ae9ee0ffb83689d2 (arm64: Get
>> 'info->page_offset' from PT_LOAD segments to support KASLR boot cases)
>> added a method to determine 'info->page_offset' from PT_LOAD segments
>> for arm64 platforms.
>>
>> In this commit we hardcoded the NOT_PADDR_ARM64 macro as
>> 0x0000000010a80000UL which was a valid value on
>> qualcomm-amberwing boards.
>>
>> However, I was testing this change on several other arm64 boards
>> like apm-mustang, huawei-taishan and hp-moonshot and saw that
>> this value can vary on the basic of the "Kernel code" memory range
>> placement.
>>
>> This patch determines the "Kernel code" memory range from
>> '/proc/iomem' listing and uses the same to determine the
>> NOT_PADDR_ARM64 value, which makes this calculation platform
>> independent and this works well on apm-mustang, huawei-taishan,
>> qualcomm-amberwing and hp-moonshot platforms.
>
> I don't have any arm64 system for now, but I think that a "Kernel code"
> range in /proc/iomem on 2nd kernel will be different from the one on
> 1st kernel.  Does it process /proc/vmcore correctly on 2nd kernel?
> If it doesn't, we have to find another way..
>
> This is the condition for x86_64:
>
>     if (virt_start != NOT_KV_ADDR          ... *1 (0x0)
>         && virt_start < __START_KERNEL_map ... *2 (0xffffffff80000000)
>         && phys_start != NOT_PADDR) {      ... *3 (~0ULL)
>
> These are how we get the appropriate values on x86_64:
>
> # readelf -l vmcore  # I got with cp command
> ...
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   NOTE           0x0000000000001000 0x0000000000000000 0x0000000000000000 // PT_NOTE
>                  0x00000000000009c8 0x00000000000009c8         0
>   LOAD           0x0000000000002000 0xffffffff96c00000 0x000000000f800000 skipped by *2
>                  0x0000000001656000 0x0000000001656000  RWE    0
>   LOAD           0x0000000001658000 0xffff976b00001000 0x0000000000001000 picked
>                  0x000000000009ec00 0x000000000009ec00  RWE    0
>   LOAD           0x00000000016f7000 0xffff976b00100000 0x0000000000100000
>                  0x000000002cf00000 0x000000002cf00000  RWE    0
>   LOAD           0x000000002e5f7000 0xffff976b35000000 0x0000000035000000
>                  0x000000004aff7000 0x000000004aff7000  RWE    0
>
> # readelf -l /proc/kcore
> ...
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   NOTE           0x0000000000000238 0x0000000000000000 0x0000000000000000 // PT_NOTE
>                  0x00000000000011e4 0x0000000000000000         0
>   LOAD           0x00007fffff602000 0xffffffffff600000 0xffffffffffffffff skipped by *3
>                  0x0000000000800000 0x0000000000800000  RWE    1000
>   LOAD           0x00007fff96c02000 0xffffffff96c00000 0x000000000f800000 skipped by *2
>                  0x0000000001656000 0x0000000001656000  RWE    1000
>   LOAD           0x00003228c0002000 0xffffb228c0000000 0xffffffffffffffff skipped by *3
>                  0x00001fffffffffff 0x00001fffffffffff  RWE    1000
>   LOAD           0x00007fffc0002000 0xffffffffc0000000 0xffffffffffffffff skipped by *2
>                  0x000000003f000000 0x000000003f000000  RWE    1000
>   LOAD           0x0000176b00003000 0xffff976b00001000 0x0000000000001000 picked
>                  0x000000000009e000 0x000000000009e000  RWE    1000
>   LOAD           0x00006f1880002000 0xffffef1880000000 0xffffffffffffffff
>                  0x0000000000003000 0x0000000000003000  RWE    1000
>   LOAD           0x0000176b00102000 0xffff976b00100000 0x0000000000100000
>                  0x000000007fef7000 0x000000007fef7000  RWE    1000
>   LOAD           0x00006f1880006000 0xffffef1880004000 0xffffffffffffffff
>                  0x0000000001ffc000 0x0000000001ffc000  RWE    1000
>
> If a value like NOT_PADDR_ARM64 is needed, can we find the condition
> which consists of only static and common values first?
> It would be better that there is something evidence or data as well.
>
> Thanks,
> Kazu
>
>>
>> Here are some logs on my huawei-taishan board with kernel version
>> 4.18.0-rc8:
>>
>> The kernel version is not supported.
>> The makedumpfile operation may be incomplete.
>>
>> TYPE          PAGES                   EXCLUDABLE      DESCRIPTION
>> ----------------------------------------------------------------------
>> ZERO          83081                   yes             Pages filled with zero
>> NON_PRI_CACHE 6330                    yes             Cache pages without private flag
>> PRI_CACHE     927                     yes             Cache pages with private flag
>> USER          2659                    yes             User process pages
>> FREE          4053998                 yes             Free pages
>> KERN_DATA     35331                   no              Dumpable kernel data
>>
>> page size:            65536
>> Total pages on system:        4182326
>> Total size on system: 274092916736     Byte
>>
>> Fixes: 94c97db3fe859ca14d7b38b0ae9ee0ffb83689d2 (arm64: Get
>>       'info->page_offset' from PT_LOAD segments to support KASLR boot
>>       cases)
>>
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>  arch/arm64.c   | 26 ++++++++++++++++++++++++--
>>  makedumpfile.h |  1 -
>>  2 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64.c b/arch/arm64.c
>> index 362609668ea2..e0b30c812124 100644
>> --- a/arch/arm64.c
>> +++ b/arch/arm64.c
>> @@ -303,10 +303,25 @@ get_xen_info_arm64(void)
>>       return ERROR;
>>  }
>>
>> +/* We want to exclude the kernel code mem region while calculating the
>> + * info->page_offset for arm64 arch
>> + */
>> +static struct memory_range kernel_code_mem_range;
>> +
>> +static int kernel_code_resource_callback(void *data, int nr,
>> +                                       char *str,
>> +                                       unsigned long base,
>> +                                       unsigned long length)
>> +{
>> +     kernel_code_mem_range.start = base;
>> +     kernel_code_mem_range.end   = base + length - 1;
>> +     return 0;
>> +}
>> +
>>  int
>>  get_versiondep_info_arm64(void)
>>  {
>> -     int i;
>> +     int i, ret;
>>       unsigned long long phys_start;
>>       unsigned long long virt_start;
>>       ulong _stext;
>> @@ -333,6 +348,13 @@ get_versiondep_info_arm64(void)
>>               return FALSE;
>>       }
>>
>> +     ret = iomem_for_each_line("Kernel code\n",
>> +                                     kernel_code_resource_callback, NULL);
>> +     if (ret != 1) {
>> +             ERRMSG("Cannot find a proper Kernel code memory range in /proc/iomem\n");
>> +             return FALSE;
>> +     }
>> +
>>       if (get_num_pt_loads()) {
>>               for (i = 0;
>>                   get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
>> @@ -340,7 +362,7 @@ get_versiondep_info_arm64(void)
>>                       if (virt_start != NOT_KV_ADDR
>>                           && virt_start < __START_KERNEL_map
>>                           && phys_start != NOT_PADDR
>> -                         && phys_start != NOT_PADDR_ARM64) {
>> +                         && phys_start != kernel_code_mem_range.start) {
>>                               info->page_offset = virt_start - phys_start;
>>                               DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
>>                                               info->page_offset, va_bits);
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index 3244d31ae43a..9fefe150829f 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -544,7 +544,6 @@ unsigned long get_kvbase_arm64(void);
>>  #define KVBASE                       get_kvbase_arm64()
>>
>>  #define __START_KERNEL_map   (0xffffffff80000000UL)
>> -#define NOT_PADDR_ARM64              (0x0000000010a80000UL)
>>
>>  #endif /* aarch64 */
>>
>> --
>> 2.7.4
>>
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
