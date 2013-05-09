Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-la0-x230.google.com ([2a00:1450:4010:c03::230])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UaI8V-0006gj-06
 for kexec@lists.infradead.org; Thu, 09 May 2013 04:07:20 +0000
Received: by mail-la0-f48.google.com with SMTP id eg20so2446537lab.35
 for <kexec@lists.infradead.org>; Wed, 08 May 2013 21:06:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <300993645.8498114.1368019791503.JavaMail.root@redhat.com>
References: <CAEyr1FSxmTW2st4BSzWa3K6AJpBLj-PqJh6-zmA_K6f5C8r7ng@mail.gmail.com>
 <CAEyr1FQ6MGMJK1+dyrLF+YaPwDFa1d+WVeRe6fuKojPUJO--xQ@mail.gmail.com>
 <CAEyr1FRhLFjyoqWKyQoMc4cQqqA8fX7bPA=MWpY-z2RK74fekQ@mail.gmail.com>
 <300993645.8498114.1368019791503.JavaMail.root@redhat.com>
Date: Thu, 9 May 2013 09:36:51 +0530
Message-ID: <CAEyr1FTJ=mEfvx-p4VfcHg2JNMO+w_KVO9j+===jwUJE+_QrsQ@mail.gmail.com>
Subject: Re: [Crash-utility] crash read error: kernel virtual address / vmcore
 address mismatch ?
From: Anand Raj Manickam <anandrm@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

On Wed, May 8, 2013 at 6:59 PM, Dave Anderson <anderson@redhat.com> wrote:
>
>
>
> ----- Original Message -----
>> On Wed, May 8, 2013 at 11:23 AM, Anand Raj Manickam <anandrm@gmail.com>
>> wrote:
>> >> Hi ,
>> >> Sorry about re posting this as i did not find solution ...
>> >>
>> >> I m facing a issue where on
>> >>
>> >> #crash /data/linux-2.6.30.8/vmlinux /proc/vmcore
>> >
>> > Do yourself a favor and copy /proc/vmcore to somewhere on disk.  Then
>> > reboot the system into the original kernel, and run crash on the saved
>> > vmcore.  I've never seen crash run on a /proc/vmcore file from the
>> > secondary kernel.
>> >
>> > Also, after rebooting the the original kernel, please confirm that
>> > crash runs OK on the live system.
>> >
>> >
>> >> crash 6.1.6
>> >> Copyright (C) 2002-2013  Red Hat, Inc.
>> >> Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
>> >> Copyright (C) 1999-2006  Hewlett-Packard Co
>> >> Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
>> >> Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
>> >> Copyright (C) 2005, 2011  NEC Corporation
>> >> Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
>> >> Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
>> >> This program is free software, covered by the GNU General Public License,
>> >> and you are welcome to change it and/or distribute copies of it under
>> >> certain conditions.  Enter "help copying" to see the conditions.
>> >> This program has absolutely no warranty.  Enter "help warranty" for
>> >> details.
>> >>
>> >> GNU gdb (GDB) 7.3.1
>> >> Copyright (C) 2011 Free Software Foundation, Inc.
>> >> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
>> >> This is free software: you are free to change and redistribute it.
>> >> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
>> >> and "show warranty" for details.
>> >> This GDB was configured as "i686-pc-linux-gnu"...
>> >>
>> >> crash: read error: kernel virtual address: c127a9c8  type: "cpu_possible_mask"
>> >
>> > Please show the full output of "crash -d8 vmlinux vmcore".
>>
>> After rebooting to the primary / live kernel
>>
>>    I have attached the output for "crash -d8 vmlinux /data/vmcore" in d8.txt
>
> Looking at the ELF header data in the debug output, your configuration
> does require special handling.  X86 kernels are typically not configured
> with CONFIG_PHYSICAL_START larger than CONFIG_PHYSICAL_ALIGN, because
> when that is done, the vmlinux unity-mapped symbol values do not match
> their relocated values when the kernel is loaded.  This entry in the
> crash.changelog describes the situation:
>
> http://people.redhat.com/anderson/crash.changelog.html#4_0_4_5
>
> 4.0-4.5  - Addresses FC7/upstream x86 kernels that have been configured such
>            that the vmlinux symbol values do not match their relocated values
>            when loaded.  If CONFIG_PHYSICAL_START contains a value that is
>            greater then CONFIG_PHYSICAL_ALIGN, then this mismatch occurs.
>            Since the crash utility and its embedded gdb have always expected
>            that the compiled-in kernel symbol addresses are "real", the virtual
>            to physical translation fails, leading to an initialization-time
>            failure with the message: "crash: vmlinux and /dev/crash do not
>            match!" (/dev/mem or the dumpfile name may replace /dev/crash).
>            To deal with this issue, there are several alternatives:
>
>             1) Configure the kernel with CONFIG_PHYSICAL_START less than
>                or equal to CONFIG_PHYSICAL_ALIGN.  Having done that, there
>                is no problem; the resultant vmlinux file will be loaded at
>                the address for which it was compiled, which has always
>                been the case.
>             2) Since /proc/kallsyms uses the same format as a System.map file,
>                and since it reflects the relocated symbol addresses, it
>                can be placed on the crash command line as if it were
>                a System.map file.  (Note that the System.map file created
>                by these relocated kernels contains the same "wrong" symbol
>                values as the vmlinux file from which it was created.)
>             3) On a live system that has /proc/kallsyms (i.e., the kernel was
>                configured with CONFIG_KALLSYMS), this version of the crash
>                utility will replace/patch the vmlinux symbol values with those
>                seen in /proc/kallsyms.  The relocation value will be displayed
>                as a WARNING message during initialization.
>             4) On a dumpfile, the relocation will not be performed automatically
>                as on a live system.  It will require the addition of the
>                /proc/kallsyms on the command line, or if run on a different
>                host, a copy of the crashed system's /proc/kallsyms may be
>                used.
>             5) Alternatively on a dumpfile, a new command line option has been
>                created to specify the relocation amount.  For example, if a
>                kernel was configured with a CONFIG_PHYSICAL_START value of 16MB
>                and a CONFIG_PHYSICAL_ALIGN of 4MB, that results in a relocation
>                of 12MB.  To specify that, enter "crash --reloc=12m ..." on the
>                command line.  (Recall that if crash is run on the live system,
>                a WARNING message will specify the relocation amount.)
>
>            Using /proc/kallsyms or a --reloc=[size] as a command line argument
>            is similar to using a System.map file, in that it results in the loss
>            of the use of line number debug data.  (anderson@redhat.com)
>
>            ...
>
>>> My current config for
>>>
>>> CONFIG_PHYSICAL_START=0x1000000
>>> CONFIG_RELOCATABLE=y
>>> CONFIG_PHYSICAL_ALIGN=0x400000
>>>
>>> The /proc/kallsyms is diffrent between the System Kernel and Debug Kernel.
>>> On the System Kernel it starts from 0x400000 .On the Debug kernel it
>>> starts from 0x1000000.
>
> So your configuration exactly matches paragraph 5) above, you should
> be able to come up OK by entering either:
>

>  $ crash vmlinux vmcore --reloc=12m

This did the trick :-)

Great !! and Thanks Dave.

>
> or
>
>  $ crash vmlinux vmcore /proc/kallsyms
>
> where the /proc/kallsyms is from the *primary* kernel, so option #2
> will *not* work when running from the secondary kernel.
>
> You didn't show any output of a live crash session (while running
> on the primary kernel), but I believe it should work without using
> the /proc/kallsyms as an argument or using --reloc=12m option.  There
> was a further fix for these configurations for running on live systems:
>
> http://people.redhat.com/anderson/crash.changelog.html#5_1_4
>
> 5.1.4    - Fix for RT kernels in which the schedule() function has become a
>            ... [ cut] ...
>
>          - Fix for running against live x86 kernels that were configured with
>            CONFIG_PHYSICAL_START containing a value that is greater than its
>            CONFIG_PHYSICAL_ALIGN value, and where the first symbol listed by
>            /proc/kallsyms is not "_text".  Without the patch, the crash session
>            fails during invocation with the error message "crash: vmlinux and
>            /dev/mem do not match!" (or "/dev/crash" if applicable).  As a work-
>            around, "/proc/kallsyms" can be entered on the command line, or the
>            "--reloc=<size>" option could be used, but the fix obviates that
>            requirement for live systems.  It should be noted that dumpfiles of
>            kernels configured that way still do require that "/proc/kallsyms",
>            or a copy of it, or alternatively the "--reloc=<size>" option, to
>            be entered on the command line, as detailed in this changelog entry:
>            http://people.redhat.com/anderson/crash.changelog.html#4_0_4_5
>            (anderson@redhat.com)
>
> So on the live system on the primary kernel, I believe this should just work:
>
>  $ crash vmlinux
>
> Normally you don't even need to put the vmlinux file on the command line for
> running on the live system because it will be "found" automatically unless
> you've put it in some non-standard location.
>
> Dave
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
