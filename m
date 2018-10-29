Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH4AB-0001u2-Vs
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 09:50:48 +0000
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so5472992lfh.9
 for <kexec@lists.infradead.org>; Mon, 29 Oct 2018 02:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <1538916769-3499-1-git-send-email-bhsharma@redhat.com>
 <20181012064839.GA1731@192.168.1.5>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355DFC9@BPXM09GP.gisp.nec.co.jp>
 <20181025063446.GD2120@MiWiFi-R3L-srv>
In-Reply-To: <20181025063446.GD2120@MiWiFi-R3L-srv>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 29 Oct 2018 15:18:22 +0530
Message-ID: <CACi5LpPib4XuzSQdq=u5J5rD_Y_bRYvZtENU518=Y-=exdWzyQ@mail.gmail.com>
Subject: Re: [PATCH] Use VMCOREINTO inside '/proc/kcore' if available
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
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Petr Tesarik <ptesarik@suse.cz>, kexec mailing list <kexec@lists.infradead.org>

Hi Baoquen, Kazu,

Thanks a lot for your comments and sorry for the late reply, but I
could get access to the required test setups just last week and hence
was not able to complete the checks, before sending reply.

On Thu, Oct 25, 2018 at 12:04 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 10/18/18 at 08:26pm, Kazuhito Hagio wrote:
> > > > To fix the same, this patchset uses a new approach. Since kernel
> > > > version 4.19-rc5 (Commit
> > > > 23c85094fe1895caefdd19ef624ee687ec5f4507 ["proc/kcore: add vmcoreinfo
> > > > note to /proc/kcore"]), '/proc/kcore' contains a new
> > > > PT_NOTE which carries the VMCOREINFO information.
> > > >
> > > > If the same is available, we can use it for makedumpfile
> > > > 'show_mem_usage()' and other functionality. This is especially useful
> > > > for architectures like arm64 as we can get kernel symbols like
> > > > 'VA_BITS' and 'kimage_voffset' from the '/proc/kcore' itself and use it
> > > > to calculate 'info->page_offset' when we make a call to
> > > > 'get_page_offset()'.
> >
> > Your approach looks good but it makes makedumpfile's process flow
> > more complex, so I would like to think about other methods too,
> > and I have an idea.
>
> Yes, agree.

Actually, makedumpfile '--mem-usage' features already opens the '/proc/kcore'
file via 'open_files_for_creating_dumpfile ' function and tries to read the file
for kdump or sadump header.

My simple point was that since we already have the 'fd' available for
'/proc/kcore'
if can check the same for 'vmcoreinfo' note presence. In-fact as the
timing analysis for two quick runs
on 4.19.0-rc8+ indicate the timings for this scenario and the approach
proposed by Kazu (which
does work on a few arm64 boards at my end) aren't much different:

Timings when we read 'vmcoreinfo' form '/proc/kcore'
-------------------------------------------------------------------
[root@qualcomm-amberwing-rep-14 code]# time makedumpfile -f
--mem-usage /proc/kcore
The kernel version is not supported.
The makedumpfile operation may be incomplete.
<..snip..>
real    0m4.184s
user    0m0.621s
sys    0m3.522s

Timings when we use Kazu's approach
--------------------------------------------------
[root@qualcomm-amberwing-rep-14 code]# time makedumpfile -f
--mem-usage /proc/kcore
The kernel version is not supported.
The makedumpfile operation may be incomplete.
<..snip..>
real    0m4.163s
user    0m0.701s
sys    0m3.461s

So timings are almost the same. In terms of the code addition we add
calls to only a couple of functions (for elf reading)
and set a flag, which also is probably not too much.

> > I've investigated the source code of /proc/kcore and /proc/vmcore,
> > and it seems that they have the PT_LOADs of linear maps which we want
> > at the last of program headers.  So I'm thinking that we can derive
> > info->page_offset from the last PT_LOAD that satisfies the conditions.
> > This approach is simpler and does not need 4.19 kernel.
>
> Hi Bhupesh,
>
> And I saw you have posted another patchset and insist on the old
> idea.
> [PATCH 0/2] kexec-tools/arm64: Add support to read PHYS_OFFSET from vmcoreinfo inside '/proc/kcore'
>
> And in log you mentioned you want to change x86 to use the same method
> to get information from vmcoreinfo. Here I just want to notice that
> earlier for supporting KASLR, I planned to get information, e.g
> PAGE_OFFSET/VMALLOC_START from vmcoreinfo, but that was vetoed by Eric.
> Since he think we can't always expoet these information each time we
> change them. So we have to try to parse from /proc/kcore program header.
>
> So if you want to get PHYS_OFFSET from vmcoreinfo for arm64, I am fine
> since that might be not easy to get from kcore. And if you insist to get
> other PAGE_OFFSET/VMALLOC_START/VMEMMAP from vmcoreinfo for arm64, only
> if kernel maintainer accept them to be added to arch/arm64 and Kazu
> would like to pick them into makedumpfile, that is also fine. While for
> x86 64, I think we should still use the current way, and I personally
> suggest arm64 can be similar to keep the process flow consistent for
> better maintaining as Kazu said.
>
> Personal opinion.

Thanks Baoquen for your useful advice. Actually, the original issue
which triggered this discussion
with the arm64 maintainers was the reading of PHYS_OFFSET via
kexec-tools, which was buggy.

From there the arm maintainers suggested that we use a unified way to
read kernel exported
machine specific details in user-space utilities rather than using
different mechanism for the
same in different user-space utilities. Later on the kernel patch
which adds vmcoreinfo to
'/proc/kcore' was added as an arch agnostic approach to unify the
differences existing
in exporting kernel space information to the user-space code and I was
asked by the maintainers
to use the same for user-space purposes.

I have since sent a x86_64 specific patch to append 'page_offset_base'
in vmcoreinfo as well
(please see <https://lkml.org/lkml/2018/10/27/86> for details), which
tries to make
the 'info->page_offset' calculation in makedumpfile code for x86_64
easier as well
for newer kernels.

I understand that there might be some reservations about exporting
such machine-specific details in the vmcoreinfo, but to unify
the implementations across user-land and archs, perhaps this would be
good starting point to start a discussion.

> Thanks
> Baoquan
>
> >
> > Here is an example patch for x86_64:
> >
> > diff --git a/arch/x86_64.c b/arch/x86_64.c
> > index 2b3c0bb..6a1adca 100644
> > --- a/arch/x86_64.c
> > +++ b/arch/x86_64.c
> > @@ -106,9 +106,10 @@ get_page_offset_x86_64(void)
> >                                       && virt_start < __START_KERNEL_map
> >                                       && phys_start != NOT_PADDR) {
> >                               info->page_offset = virt_start - phys_start;
> > -                             return TRUE;
> >                       }
> >               }
> > +             if (info->page_offset)
> > +                     return TRUE;
> >       }
> >
> >       if (info->kernel_version < KERNEL_VERSION(2, 6, 27)) {
> >
> > Actually, it looks like this patch fixes the issue you mentioned
> > below:
> >
> > >>       (NOTE that x86_64 makedumpfile --mem-usage use-case is currently
> > >>       broken with upstream kernel, but I have debugged the root-cause
> > >>       and will separately send a patch to fix the same).
> >
> > I think that the root-cause is KCORE_REMAP, which was added to kcore
> > and it is also at the front of other PT_LOADs like the "Kernel code",
> > so we can overwite it with the correct value with the above patch.
> > I'm testing it on some x86_64 systems.
> >
> > What do you think about this approach?  Does it work on arm64?

Yes, it works on a few types of arm64 boards, but fails on others.
Please see my replies to your formal patch here:
<http://lists.infradead.org/pipermail/kexec/2018-October/021750.html>

Also, I have just sent out a v2 patchset which can be viewed here:
http://lists.infradead.org/pipermail/kexec/2018-October/021767.html

which, tries to introduce an architecture independent
method to calculate the 'info->page_offset' value for x86_64
and arm64 architectures, by reading the VMCOREINFO note in
'/proc/kcore'.

Kindly review the same (and also help with your comments on the kernel patch
which I have sent for x86_64 on which I have Cc'ed you both.

I understand that this is an invasive approach and we will hit some
roadblocks initially, but
I see this as a good way to standardize the code to determine machine
specific details in user-space utilities (for kexec-tools and makedumpfile
I have already sent out the relevant patches and for crash utility I
plan to send
out a patch later this week).

Thanks,
Bhupesh

> >
> > Thanks,
> > Kazu
> >
> > > >
> > > > This VMCOREINFO note provides us a standard interface which can be
> > > > leveraged while debugging live (or primary) kernel with makedumpfile
> > > > (and other user-space tools), especially to derive the machine specific
> > > > details (for e.g. VA_BITS, PHYS_OFFSET and kimage_voffset for arm64
> > > > arch).
> > > >
> > > > I also verified the makedumpfile functionality in crash kernel with this
> > > > patchset. Here are some details of the tests I ran:
> > > >
> > > > Testing:
> > > > --------
> > > > 1. Architectures tested:
> > > >    a) arm64 :- huawei-taishan, apm-mustang and qualcomm-amberwing boards.
> > > >    b) x86_64 :- Dell optiplex workstation.
> > > >       (NOTE that x86_64 makedumpfile --mem-usage use-case is currently
> > > >       broken with upstream kernel, but I have debugged the root-cause
> > > >       and will separately send a patch to fix the same).
> > > >
> > > > 2. Use-cases tested:
> > > >    a) Primary kernel ->
> > > >       [] --mem-usage:
> > > >          # makedumpfile -f --mem-usage /proc/kcore
> > > >
> > > >       [] filtering use-case:
> > > >          # makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
> > > >
> > > >       [] dumpfile creation:
> > > >          # makedumpfile -d 31 -x vmlinux vmcore dumpfile
> > > >
> > > >    b) Crash kernel ->
> > > >       [] dumpfile creation:
> > > >          # makedumpfile -l --message-level 31 -d 31 /proc/vmcore dump
> > > >
> > > > 3. Kernel versions tested:
> > > >    a) Kernel version 4.19-rc5 and above on both arm64 and x86_64.
> > > >    b) Fedora 28 on x86_64.
> > > >    c) Kernel version 4.14 on arm64.
> > > >
> > > > Fixes: 94c97db3fe859ca14d7b38b0ae9ee0ffb83689d2 "arm64: Get 'info->page_offset' from PT_LOAD segments
> > > to support KASLR boot cases"
> > > > Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> > > > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > > > ---
> > > >  arch/arm64.c   | 114 +++++++++++++++++++++++++++++++++++++++++++--------------
> > > >  makedumpfile.c |  67 ++++++++++++++++++++++++++++++---
> > > >  makedumpfile.h |   2 +-
> > > >  3 files changed, 149 insertions(+), 34 deletions(-)
> > > >
> > > > diff --git a/arch/arm64.c b/arch/arm64.c
> > > > index 362609668ea2..d695eff628f0 100644
> > > > --- a/arch/arm64.c
> > > > +++ b/arch/arm64.c
> > > > @@ -53,6 +53,7 @@ static unsigned long kimage_voffset;
> > > >  #define PAGE_OFFSET_42 ((0xffffffffffffffffUL) << 42)
> > > >  #define PAGE_OFFSET_47 ((0xffffffffffffffffUL) << 47)
> > > >  #define PAGE_OFFSET_48 ((0xffffffffffffffffUL) << 48)
> > > > +#define __PAGE_OFFSET(x) ((0xffffffffffffffffUL) << (x - 1))
> > > >
> > > >  #define pgd_val(x)               ((x).pgd)
> > > >  #define pud_val(x)               (pgd_val((x).pgd))
> > > > @@ -311,45 +312,104 @@ get_versiondep_info_arm64(void)
> > > >   unsigned long long virt_start;
> > > >   ulong _stext;
> > > >
> > > > - _stext = get_stext_symbol();
> > > > - if (!_stext) {
> > > > -         ERRMSG("Can't get the symbol of _stext.\n");
> > > > -         return FALSE;
> > > > - }
> > > > + /* Calculate 'VA_BITS'. */
> > > >
> > > > - /* Derive va_bits as per arch/arm64/Kconfig */
> > > > - if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
> > > > -         va_bits = 36;
> > > > - } else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
> > > > -         va_bits = 39;
> > > > - } else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
> > > > -         va_bits = 42;
> > > > - } else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
> > > > -         va_bits = 47;
> > > > - } else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
> > > > -         va_bits = 48;
> > > > + /* Since kernel version 4.19, '/proc/kcore' contains a new
> > > > +  * PT_NOTE which carries the VMCOREINFO information.
> > > > +  *
> > > > +  * If the same is available, use it as it already contains the
> > > > +  * value of 'VA_BITS' on the machine.
> > > > +  *
> > > > +  * Otherwise, we can read the '_stext' symbol and determine the
> > > > +  * 'VA_BITS' value from the same as well.
> > > > +  */
> > > > + if (info->flag_kcore_contains_vmcoreinfo &&
> > > > +     (NUMBER(VA_BITS) != NOT_FOUND_NUMBER)) {
> > > > +         va_bits = NUMBER(VA_BITS);
> > > >   } else {
> > > > -         ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
> > > > -         return FALSE;
> > > > +         _stext = get_stext_symbol();
> > > > +         if (!_stext) {
> > > > +                 ERRMSG("Can't get the symbol of _stext.\n");
> > > > +                 return FALSE;
> > > > +         }
> > > > +
> > > > +         /* Derive va_bits as per arch/arm64/Kconfig */
> > > > +         if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
> > > > +                 va_bits = 36;
> > > > +         } else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
> > > > +                 va_bits = 39;
> > > > +         } else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
> > > > +                 va_bits = 42;
> > > > +         } else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
> > > > +                 va_bits = 47;
> > > > +         } else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
> > > > +                 va_bits = 48;
> > > > +         } else {
> > > > +                 ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
> > > > +                 return FALSE;
> > > > +         }
> > > > + }
> > > > +
> > > > + /* Calculate 'info->page_offset'. */
> > > > +
> > > > + /* Since kernel version 4.19, '/proc/kcore' contains a new
> > > > +  * PT_NOTE which carries the VMCOREINFO information.
> > > > +  *
> > > > +  * If the same is available, use it as it already contains the
> > > > +  * value of 'kimage_voffset' on the machine.
> > > > +  */
> > > > + if (info->flag_kcore_contains_vmcoreinfo &&
> > > > +     (NUMBER(kimage_voffset) != NOT_FOUND_NUMBER)) {
> > > > +         kimage_voffset = NUMBER(kimage_voffset);
> > > >   }
> > > >
> > > > + /* First, lets try and calculate the 'info->page_offset' value
> > > > +  * from PT_LOAD segments, if they are available.
> > > > +  */
> > > >   if (get_num_pt_loads()) {
> > > >           for (i = 0;
> > > >               get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
> > > >               i++) {
> > > > -                 if (virt_start != NOT_KV_ADDR
> > > > -                     && virt_start < __START_KERNEL_map
> > > > -                     && phys_start != NOT_PADDR
> > > > -                     && phys_start != NOT_PADDR_ARM64) {
> > > > -                         info->page_offset = virt_start - phys_start;
> > > > -                         DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
> > > > -                                         info->page_offset, va_bits);
> > > > -                         return TRUE;
> > > > +                 /* On systems where we have a valid 'kimage_voffset'
> > > > +                  * available by now, we should give preference to the same
> > > > +                  * while calculating 'info->page_offset'.
> > > > +                  *
> > > > +                  * Otherwise, we can ensure that we consider
> > > > +                  * only those PT_LOAD segments whose 'virt_start'
> > > > +                  * is greater than the PAGE_OFFSET value (as defined
> > > > +                  * in 'arch/arm64/include/asm/memory.h').
> > > > +                  */
> > > > +                 if (!kimage_voffset) {
> > > > +                         if (virt_start != NOT_KV_ADDR &&
> > > > +                            virt_start > __PAGE_OFFSET(va_bits) &&
> > > > +                            phys_start != NOT_PADDR) {
> > > > +                                 info->page_offset = virt_start - phys_start;
> > > > +                                 DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
> > > > +                                                 info->page_offset, va_bits);
> > > > +                                 return TRUE;
> > > > +                         }
> > > > +                 } else {
> > > > +                         if (virt_start != NOT_KV_ADDR &&
> > > > +                            phys_start != NOT_PADDR &&
> > > > +                            (virt_start - phys_start) != kimage_voffset) {
> > > > +                                 info->page_offset = virt_start - phys_start;
> > > > +                                 DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
> > > > +                                                 info->page_offset, va_bits);
> > > > +                                 return TRUE;
> > > > +                         }
> > > >                   }
> > > >           }
> > > >   }
> > > >
> > > > - info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> > > > + /* Fallback to hard-coded value (equal to PAGE_OFFSET macro
> > > > +  * defined in 'arch/arm64/include/asm/memory.h'), as the last
> > > > +  * resort.
> > > > +  *
> > > > +  * Note that this will not be a valid value on KASLR enabled
> > > > +  * kernels as the start address of linear range is also
> > > > +  * randomized for KASLR boot cases.
> > > > +  */
> > > > + info->page_offset = __PAGE_OFFSET(va_bits);
> > > >   DEBUG_MSG("page_offset=%lx, va_bits=%d\n", info->page_offset,
> > > >                   va_bits);
> > > >
> > > > diff --git a/makedumpfile.c b/makedumpfile.c
> > > > index 3ccdaaeda0c5..59967f95e0d3 100644
> > > > --- a/makedumpfile.c
> > > > +++ b/makedumpfile.c
> > > > @@ -1302,6 +1302,20 @@ error:
> > > >   return FALSE;
> > > >  }
> > > >
> > > > +static int
> > > > +check_kcore_contains_vmcoreinfo(int fd, char *name)
> > > > +{
> > > > + if (!get_elf_info(fd, name))
> > > > +         return FALSE;
> > > > +
> > > > + if (!has_vmcoreinfo())
> > > > +         return FALSE;
> > > > +
> > > > + DEBUG_MSG("VMCOREINFO PT_NOTE found in %s\n", name);
> > > > +
> > > > + return TRUE;
> > > > +}
> > > > +
> > > >  int
> > > >  open_dump_memory(void)
> > > >  {
> > > > @@ -1314,6 +1328,23 @@ open_dump_memory(void)
> > > >   }
> > > >   info->fd_memory = fd;
> > > >
> > > > + /* Since kernel version 4.19, '/proc/kcore' contains a new
> > > > +  * PT_NOTE which carries the VMCOREINFO information.
> > > > +  *
> > > > +  * If the same is available, use it for makedumpfile
> > > > +  * show_mem_usage() cases.
> > > > +  */
> > > > + if (info->flag_mem_usage &&
> > > > +     !(strcmp(info->name_memory, "/proc/kcore")) &&
> > > > +     (info->kernel_version >= KERNEL_VERSION(4, 19, 0))){
> > > > +         status = check_kcore_contains_vmcoreinfo(fd,
> > > > +                                         info->name_memory);
> > > > +         if (status == TRUE) {
> > > > +                 info->flag_kcore_contains_vmcoreinfo = TRUE;
> > > > +                 return TRUE;
> > > > +         }
> > > > + }
> > > > +
> > > >   status = check_kdump_compressed(info->name_memory);
> > > >   if (status == TRUE) {
> > > >           info->flag_refiltering = TRUE;
> > > > @@ -11195,6 +11226,8 @@ static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
> > > >
> > > >  int show_mem_usage(void)
> > > >  {
> > > > + off_t offset;
> > > > + unsigned long size;
> > > >   uint64_t vmcoreinfo_addr, vmcoreinfo_len;
> > > >   struct cycle cycle = {0};
> > > >
> > > > @@ -11208,17 +11241,39 @@ int show_mem_usage(void)
> > > >   if (!open_files_for_creating_dumpfile())
> > > >           return FALSE;
> > > >
> > > > - if (!get_elf_loads(info->fd_memory, info->name_memory))
> > > > -         return FALSE;
> > > > + /* Since kernel version 4.19, '/proc/kcore' contains a new
> > > > +  * PT_NOTE which carries the VMCOREINFO information.
> > > > +  *
> > > > +  * If the same is available, use it for makedumpfile
> > > > +  * show_mem_usage(). This is especially useful for architectures
> > > > +  * like arm64 as we can get symbols like 'VA_BITS' and
> > > > +  * 'kimage_voffset' before we call get_page_offset().
> > > > +  */
> > > > +
> > > > + if (!info->flag_kcore_contains_vmcoreinfo) {
> > > > +         if (!get_elf_loads(info->fd_memory, info->name_memory))
> > > > +                 return FALSE;
> > > > + } else {
> > > > +         if (has_vmcoreinfo()) {
> > > > +                 get_vmcoreinfo(&offset, &size);
> > > > +                 if (!read_vmcoreinfo_from_vmcore(offset, size, FALSE))
> > > > +                         return FALSE;
> > > > +         }
> > > > + }
> > > >
> > > >   if (!get_page_offset())
> > > >           return FALSE;
> > > >
> > > > - if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
> > > > -         return FALSE;
> > > > + /* If flag_kcore_contains_vmcoreinfo is TRUE when we are here,
> > > > +  * we don't need to read the vmcoreinfo again.
> > > > +  */
> > > > + if (!info->flag_kcore_contains_vmcoreinfo)
> > > > +         if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
> > > > +                 return FALSE;
> > > >
> > > > - if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
> > > > -         return FALSE;
> > > > + if (!info->flag_kcore_contains_vmcoreinfo)
> > > > +         if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
> > > > +                 return FALSE;
> > > >
> > > >   if (!initial())
> > > >           return FALSE;
> > > > diff --git a/makedumpfile.h b/makedumpfile.h
> > > > index d1fcd87e85f5..3ae683774fe5 100644
> > > > --- a/makedumpfile.h
> > > > +++ b/makedumpfile.h
> > > > @@ -544,7 +544,6 @@ unsigned long get_kvbase_arm64(void);
> > > >  #define KVBASE                   get_kvbase_arm64()
> > > >
> > > >  #define __START_KERNEL_map       (0xffffffff80000000UL)
> > > > -#define NOT_PADDR_ARM64          (0x0000000010a80000UL)
> > > >
> > > >  #endif /* aarch64 */
> > > >
> > > > @@ -1307,6 +1306,7 @@ struct DumpInfo {
> > > >   int             flag_vmemmap;        /* kernel supports vmemmap address space */
> > > >   int             flag_excludevm;      /* -e - excluding unused vmemmap pages */
> > > >   int             flag_use_count;      /* _refcount is named _count in struct page */
> > > > + int             flag_kcore_contains_vmcoreinfo;    /* '/proc/kcore' contains a VMCOREINFO PT_NOTE */
> > > >   unsigned long   vaddr_for_vtop;      /* virtual address for debugging */
> > > >   long            page_size;           /* size of page */
> > > >   long            page_shift;
> > > > --
> > > > 2.7.4
> > > >
> > > >
> > > > _______________________________________________
> > > > kexec mailing list
> > > > kexec@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/kexec
> >
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
