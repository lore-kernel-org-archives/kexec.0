Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qc0-x236.google.com ([2607:f8b0:400d:c01::236])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5Eso-0004Q3-1t
 for kexec@lists.infradead.org; Thu, 10 Jul 2014 13:59:34 +0000
Received: by mail-qc0-f182.google.com with SMTP id m20so7965058qcx.13
 for <kexec@lists.infradead.org>; Thu, 10 Jul 2014 06:59:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1404932264.26155.75.camel@smoke>
References: <CAOdCjQt73aTLUpGzgQMuSs_aO4RnurArWQoTAFqymBMKTsHe0g@mail.gmail.com>
 <1404932264.26155.75.camel@smoke>
Date: Thu, 10 Jul 2014 19:29:12 +0530
Message-ID: <CAOdCjQvyzJiNbCijMHU+HowSZknNbEFWh74RM+bzUt2hzZw5Jw@mail.gmail.com>
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec <kexec@lists.infradead.org>

Hi Geoff,

Please find output of kexec with the -d (debug)

# /home/kexec -l /home/vmlinux --command-line="`cat /proc/cmdline`"  -d
arch_process_options:79: command_line: root=/dev/nfs rw
nfsroot=10.162.103.123:/opt/rootfs_all/rootfs-complete
ip=10.162.10.45:10.162.103.123:10.162.103.123:255.255.0.0:aarch64_be:eth0:off
panic=1 console=ttyS0,115200
arch_process_options:81: ramdisk: (null)
arch_process_options:82: dtb: (null)
kernel: 0x7f99470010 kernel_size: 0x729a63c
memory ranges:
 Skip: 000000001c020000 - 000000001c020020 : serial
 Add:  0000004000000000 - 0000004400000000 : System RAM
 Skip: 0000004000080000 - 00000040008ac5e4 : Kernel code
 Skip: 00000040008dc000 - 0000004000a8e4d8 : Kernel data
 Skip: 000000e0d0000000 - 000000e0d0200000 : cfg
elf_arm64_probe:27: ->
elf_arm64_probe:46: <-
elf_arm64_load:65: ->
add_segment:112: ->
virt_to_phys:104: ffffffc000080000 -> ffffffc080080000
Invalid memory segment 0xffffffc080080000 - 0xffffffc080a8efff

Regards,
Pankaj Pandey

On Thu, Jul 10, 2014 at 12:27 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Pankaj,
>
> On Wed, 2014-07-09 at 18:15 +0530, Pankaj Pandey wrote:
>> I have found the support for aarch64_be in kexec-tool.git under "master" branch.
>>
>> During executing kexec for aarch64_be I am facing "Invalid memory
>> segment 0xffffffc080080000 - 0xffffffc080a8efff"  error.
>>
>> Any tips or pointers would  be highly appreciated. Thanks in advance !!
>
> Please run kexec with the -d (debug) option and post all the output
> including the kexec command line.
>
> -Geoff
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
