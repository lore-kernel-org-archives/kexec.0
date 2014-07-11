Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qg0-x234.google.com ([2607:f8b0:400d:c04::234])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5VRX-0001DP-Vh
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 07:40:32 +0000
Received: by mail-qg0-f52.google.com with SMTP id f51so618610qge.39
 for <kexec@lists.infradead.org>; Fri, 11 Jul 2014 00:40:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1405013413.4264.11.camel@smoke>
References: <CAOdCjQt73aTLUpGzgQMuSs_aO4RnurArWQoTAFqymBMKTsHe0g@mail.gmail.com>
 <1404932264.26155.75.camel@smoke>
 <CAOdCjQvyzJiNbCijMHU+HowSZknNbEFWh74RM+bzUt2hzZw5Jw@mail.gmail.com>
 <1405013413.4264.11.camel@smoke>
Date: Fri, 11 Jul 2014 13:10:09 +0530
Message-ID: <CAOdCjQsHUBS9B_Wxe+qbc=k8L3bL145Y2rF+sN=DFvC2BByT9w@mail.gmail.com>
Subject: Re: kexec for aarch64_be
From: Pankaj Pandey <pankaj.embedded@gmail.com>
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
To: Geoff Levand <geoff@infradead.org>, kexec <kexec@lists.infradead.org>

Hi Geoff,

I have checkout the master branch and compile and execute the kexec.
Please find log below :-


# /home/kexec -l /home/vmlinux --command-line="`cat /proc/cmdline`"  -d
arch_process_options:79: command_line: root=/dev/nfs rw
nfsroot=10.162.103.123:/opt/rootfs_all/rootfs-complete
ip=10.162.10.45:10.162.103.123:10.162.103.123:255.255.0.0:aarch64_be:eth0:off
panic=1 console=ttyS0,115200
arch_process_options:85: initrd: (null)
arch_process_options:86: dtb: (null)
kernel: 0x7f85df8010 kernel_size: 0x729a63c
Modified cmdline: root=/dev/nfs
get_memory_ranges_dt: node_1552 memory
get_memory_ranges_dt:  RAM: 0000004000000000 - 0000004400000000
get_memory_ranges_dt:  RAM: 0000000000000000 - 0000000000000000
get_memory_ranges_dt:  RAM: 0000000000000000 - 0000000000000000
get_memory_ranges_dt:  RAM: 0000000000000000 - 0000000000000000
get_memory_ranges_dt: Success
p_vaddr: ffffffc000080000
kexec: kexec/arch/arm64/kexec-arm64.c:242: virt_to_phys: Assertion
`arm64_mem.memstart' failed.
Aborted

Regards,
Pankaj Pandey

On Thu, Jul 10, 2014 at 11:00 PM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Pankaj,
>
> On Thu, 2014-07-10 at 19:29 +0530, Pankaj Pandey wrote:
>> memory ranges:
>>  Skip: 000000001c020000 - 000000001c020020 : serial
>>  Add:  0000004000000000 - 0000004400000000 : System RAM
>>  Skip: 0000004000080000 - 00000040008ac5e4 : Kernel code
>>  Skip: 00000040008dc000 - 0000004000a8e4d8 : Kernel data
>>  Skip: 000000e0d0000000 - 000000e0d0200000 : cfg
>> elf_arm64_probe:27: ->
>> elf_arm64_probe:46: <-
>> elf_arm64_load:65: ->
>> add_segment:112: ->
>> virt_to_phys:104: ffffffc000080000 -> ffffffc080080000
>> Invalid memory segment 0xffffffc080080000 - 0xffffffc080a8efff
>
> This output does not look familiar.  I can only
> guess you are using an old version of my kexec-tools.
>
> Please use the latest from the 'master' branch here, and
> post the output:
>
>   git://git.linaro.org/people/geoff.levand/kexec-tools.git
>
> -Geoff
>
>
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
