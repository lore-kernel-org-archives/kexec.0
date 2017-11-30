Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-sn1nam02on0050.outbound.protection.outlook.com
 ([104.47.36.50] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eKNyH-0006zt-SX
 for kexec@lists.infradead.org; Thu, 30 Nov 2017 12:29:44 +0000
From: "Gurumurthy, Anil" <Anil.Gurumurthy@cavium.com>
Subject: RE: kdump issues with 4.11 kernel
Date: Thu, 30 Nov 2017 12:29:16 +0000
Message-ID: <BY2PR0701MB202353AA68A956CA64516B808E380@BY2PR0701MB2023.namprd07.prod.outlook.com>
References: <BY2PR0701MB202342812CFB9669B01930D98E3B0@BY2PR0701MB2023.namprd07.prod.outlook.com>
 <20171129073841.GA2129@dhcp-128-65.nay.redhat.com>
 <BY2PR0701MB2023DAF450CE2EB7270E05A38E3B0@BY2PR0701MB2023.namprd07.prod.outlook.com>
 <CACi5LpP9+5YVVh1DtnWXCMQbFMRJ1NVYh=_nQYcpShZS0es7hg@mail.gmail.com>
 <BY2PR0701MB2023FFA00EC7445B005BCB498E3B0@BY2PR0701MB2023.namprd07.prod.outlook.com>
 <CACi5LpNVRpHJW-AUuNnH0YQ-dTxD+fGjMAO_pL=2ieqzkG0mgw@mail.gmail.com> 
Content-Language: en-US
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Dave Young <dyoung@redhat.com>

Hi Bhupesh,
  I tried to get some log messages for the crash kernel, but unable to get anything.
echo c > /proc/sysrq-trigger
simply hangs w/o any messages on the console.

Thanks,
Anil
-----Original Message-----
From: Gurumurthy, Anil 
Sent: 29 November 2017 16:02
To: 'Bhupesh Sharma' <bhsharma@redhat.com>
Cc: Dave Young <dyoung@redhat.com>; kexec@lists.infradead.org
Subject: RE: kdump issues with 4.11 kernel



-----Original Message-----
From: Bhupesh Sharma [mailto:bhsharma@redhat.com]
Sent: 29 November 2017 15:50
To: Gurumurthy, Anil <Anil.Gurumurthy@cavium.com>
Cc: Dave Young <dyoung@redhat.com>; kexec@lists.infradead.org
Subject: Re: kdump issues with 4.11 kernel

On Wed, Nov 29, 2017 at 3:36 PM, Gurumurthy, Anil <Anil.Gurumurthy@cavium.com> wrote:
>
>
> -----Original Message-----
> From: Bhupesh Sharma [mailto:bhsharma@redhat.com]
> Sent: 29 November 2017 15:16
> To: Gurumurthy, Anil <Anil.Gurumurthy@cavium.com>
> Cc: Dave Young <dyoung@redhat.com>; kexec@lists.infradead.org
> Subject: Re: kdump issues with 4.11 kernel
>
> Hi Anil,
>
> On Wed, Nov 29, 2017 at 2:44 PM, Gurumurthy, Anil <Anil.Gurumurthy@cavium.com> wrote:
>> Thanks. That did help getting kexec to work.
>> However I still do not get a crash dump - echo c  > 
>> /proc/sysrq-trigger does not get a crash dump.
>>
>> Any thoughts?
>
> Cam you share the console messages you see when the crash kernel 
> boots? Or do you see nothing after the crash is introduced via echo c
>> /proc/sysrq-trigger
> [Anil]  I do not see any messages after introducing the crash.

There could be several reasons for this:

- crashkernel might be missing some arch/machine specific options.
- It may be that the purgatory sha verification has failed. If your arch supports a console in purgatory then it is easy to debug this.
- It might be that the crash kernel itself crashed very early. Pass some earlycon/earlyprintk option for your system to the second kernel command line.
- Also please share relevant dmesg log of both primary kernel boot and the commands you use to invoke the crashkernel.

[Anil] Thanks for the quick response

   This is what I have in the .config (for the primary kernel) CONFIG_EARLY_PRINTK=y CONFIG_EARLY_PRINTK_DBGP=y CONFIG_EARLY_PRINTK_EFI=y

The log for the primary kernel boot:

Nov 29 14:22:22 localhost journal: Runtime journal is using 8.0M (max 1.9G, leaving 2.9G of free 19.4G, current limit 1.9G).
Nov 29 14:22:22 localhost kernel: Linux version 4.11.12+ (root@localhost.localdomain) (gcc version 4.8.3 20140911 (Red Hat 4.8.3-9) (GCC) ) #4 SMP Thu Nov 23 12:11:02 IST 2017 Nov 29 14:22:22 localhost kernel: Command line: BOOT_IMAGE=/vmlinuz-4.11.12+ root=/dev/mapper/rhel-root ro rd.lvm.lv=rhel/swap crashkernel=128M rd.lvm.lv=rhel/root rhgb quiet Nov 29 14:22:22 localhost kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
Nov 29 14:22:22 localhost kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
Nov 29 14:22:22 localhost kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
Nov 29 14:22:22 localhost kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256 Nov 29 14:22:22 localhost kernel: x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
Nov 29 14:22:22 localhost kernel: e820: BIOS-provided physical RAM map:
Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000006bfff] usable Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000000006c000-0x000000000006cfff] ACPI NVS Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000000006d000-0x000000000009efff] usable Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] ACPI NVS Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x0000000000100000-0x000000005d184fff] usable Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000005d185000-0x000000005d185fff] ACPI data Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000005d186000-0x000000005fb77fff] usable Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000005fb78000-0x000000005fb7cfff] reserved Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000005fb7d000-0x000000005ffdffff] usable Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000005ffe0000-0x000000005ffe1fff] ACPI data Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000005ffe2000-0x000000005fffafff] usable Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000005fffb000-0x0000000060001fff] ACPI data Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x0000000060002000-0x0000000060009fff] usable Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000006000a000-0x000000006000efff] ACPI data Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x000000006000f000-0x000000006000ffff] usable Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x0000000060010000-0x0000000060011fff] ACPI data Nov 29 14:22:22 localhost kernel: BIOS-e820: [mem 0x0000000060012000-0x00000000600ddfff] usable


Will try to get the other details you needed too.

-Anil

Regards,
Bhupesh


> Generally, depending on your test machine arch, it is useful to use earlycon/earlyprintk to see if the crash kernel produced any useful message until the actual console device became operational.
>
> Can you try setting the earlycon/earlyprintk settings and share the crash kernel logs messages after the same?
>
> Thanks,
> Bhupesh
>
>> -----Original Message-----
>> From: Dave Young [mailto:dyoung@redhat.com]
>> Sent: 29 November 2017 13:09
>> To: Gurumurthy, Anil <Anil.Gurumurthy@cavium.com>
>> Cc: kexec@lists.infradead.org
>> Subject: Re: kdump issues with 4.11 kernel
>>
>> Hi,
>> On 11/29/17 at 05:29am, Gurumurthy, Anil wrote:
>>> Hello,
>>>   I was facing trouble getting a crash dump on 4.11 kernel. Debugging a bit, I see that the kexec run from the cmd line fails. Any ideas on what I could be missing?
>>>
>>> [root@localhost ~]# kexec -p /boot/vmlinuz-`uname -r` 
>>> --initrd=/boot/initramfs-`uname -r`kdump.img ELF core (kcore) parse 
>>> failed Cannot load /boot/vmlinuz-4.11.12+
>>>
>>
>> Can you try below kexec-tools commit:
>> commit ed15ba1b9977e506637ff1697821d97127b2c919
>> Author: Pratyush Anand <panand@redhat.com>
>> Date:   Wed Mar 1 11:19:42 2017 +0530
>>
>>     build_mem_phdrs(): check if p_paddr is invalid
>>
>> Thanks
>> Dave
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
