Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-px0-f194.google.com ([209.85.216.194])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Ng4rU-0004qi-7y
	for kexec@lists.infradead.org; Fri, 12 Feb 2010 23:23:52 +0000
Received: by pxi32 with SMTP id 32so1998811pxi.15
	for <kexec@lists.infradead.org>; Fri, 12 Feb 2010 15:23:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100212114052.GA27303@hmsreliant.think-freely.org>
References: <74ae4f6a1002051845i6a2787deve82963c5d258eda4@mail.gmail.com>
	<20100212114052.GA27303@hmsreliant.think-freely.org>
Date: Fri, 12 Feb 2010 15:23:45 -0800
Message-ID: <74ae4f6a1002121523k6c6e0cd7ha645a09f427786cc@mail.gmail.com>
Subject: Re: kdump cp /proc/vmcore exiting with "Invalid Argument" Error
From: Sujit V <sujit.linux@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: fastboot@lists.linux-foundation.org, kexec@lists.infradead.org

On Fri, Feb 12, 2010 at 3:40 AM, Neil Horman <nhorman@tuxdriver.com> wrote:
> On Fri, Feb 05, 2010 at 06:45:36PM -0800, Sujit V wrote:
>> I have integrated the kdump in our linux 2.6.23 based kernel. If I do
>> echo c > /proc/sysrq-trigger then it boots the kdump kernel & I use
>> the cp /proc/vmcore /local/crash/vmcore-incomplete
>>
>> On a new x86 based hardware (32 bit PAE kernel) =A0the "cp /proc/vmcore
>> " command exits prematurely.
>>
>> cp -v /proc/vmcore /local/crash/vmcore-incomplete
>> =A0 =A0 =A0 cp: reading `/proc/vmcore': Invalid argument =A0>>> Error >>
>>
>> ls -l /local/crash/
>> total 115588
>> -r-------- =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A02526724096 Feb =A0=
5 03:09 vmcore-incomplete
>>
>> ls -l /proc/vmcore
>> -r-------- =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A04153763584 Feb =A0=
5 03:16 /proc/vmcore
>>
>>
>> Every time I trigger kdump the cp command exits after copying
>> 2526724096 bytes. So I thought it might be a file size issue.
>> Googling pointed out a patch in include/linux/proc_fs.h
>>
>> struct vmcore {
>> struct list_head list;
>> unsigned long long paddr;
>> - unsigned long size;
>> + unsigned long long size;
>> loff_t offset;
>>
>> I checked my kernel & it already has this patch.
>>
>
> Do you use =A0the mem=3D kernel command line parameter anywhere?
>
> I ran into something awhile back in which, if memory was
> limited in the production kernel with a mem=3D parameter, the code that s=
etup
> /proc/vmcore would still size itself according to the full size of memory=
, but
> error out with -EINVAL after passing the size defined by the previous mem=
=3D
> command.

Checked the cmdline for the production kernel. It does not have the
mem=3D parameter.

>
> Neil
>
>>
>> ------------------------------------------------------------------------=
---------------
>> IOMEM output
>>
>> debugshell# cat /proc/iomem
>> 00000000-0009fbff : System RAM
>> 0009fc00-0009ffff : reserved
>> 000a0000-000bffff : Video RAM area
>> 000c0000-000dffff : pnp 00:01
>> 000f0000-000fffff : System ROM
>> 00100000-9e86afff : System RAM
>> =A0 00200000-006c1cec : Kernel code
>> =A0 006c1ced-008e68af : Kernel data
>> =A0 01000000-08ffffff : Crash kernel
>> 9e86b000-9e872fff : ACPI Non-volatile Storage
>> 9e873000-9e874fff : reserved
>> 9e875000-9e8acfff : System RAM
>> 9e8ad000-9e8b3fff : reserved
>> 9e8b4000-9e8d8fff : System RAM
>> 9e8d9000-9e8dbfff : ACPI Tables
>> 9e8dc000-9e8dcfff : System RAM
>> 9e8dd000-9e8eafff : ACPI Tables
>> 9e8eb000-9e8f6fff : System RAM
>> 9e8f7000-9e8f9fff : ACPI Tables
>> 9e8fa000-9e8fafff : ACPI Non-volatile Storage
>> 9e8fb000-9e8fbfff : System RAM
>> 9e8fc000-9e8fcfff : ACPI Tables
>> 9e8fd000-9e902fff : System RAM
>> 9e903000-9e903fff : ACPI Non-volatile Storage
>> 9e904000-9e947fff : System RAM
>> 9e948000-9e948fff : ACPI Tables
>> 9e949000-9e9e6fff : System RAM
>> 9e9e7000-9e9e7fff : reserved
>> 9e9e8000-9e9effff : System RAM
>> 9e9f0000-9e9f2fff : reserved
>> 9e9f3000-9e9f6fff : System RAM
>> 9e9f7000-9e9f9fff : reserved
>> 9e9fa000-9ea09fff : System RAM
>> 9ea0a000-9ea0cfff : reserved
>> 9ea0d000-9ea0efff : System RAM
>> 9ea0f000-9ec0ffff : ACPI Non-volatile Storage
>> 9ec10000-9ec3ffff : System RAM
>> 9ec40000-9ec40fff : ACPI Non-volatile Storage
>> 9ec41000-9ec42fff : System RAM
>> 9ec43000-9ec4cfff : ACPI Non-volatile Storage
>> 9ec4d000-9ec55fff : System RAM
>> 9ec56000-9ec57fff : ACPI Non-volatile Storage
>> 9ec58000-9ec58fff : System RAM
>> 9ec59000-9ec5ffff : ACPI Non-volatile Storage
>> 9ec60000-9ec69fff : System RAM
>> 9ec6a000-9ec6afff : ACPI Non-volatile Storage
>> 9ec6b000-9ec82fff : System RAM
>> 9ec83000-9ec83fff : ACPI Non-volatile Storage
>> 9ec84000-9fbfffff : System RAM
>> 9fc00000-9fffffff : reserved
>> a0000000-a4ffffff : PCI Bus #03
>> =A0 a0000000-a1ffffff : 0000:03:00.0
>> =A0 =A0 a0000000-a1ffffff : bnx2
>> =A0 a2000000-a3ffffff : 0000:03:00.1
>> =A0 =A0 a2000000-a3ffffff : bnx2
>> a5000000-a5ffffff : PCI Bus #01
>> a6000000-a70fffff : PCI Bus #02
>> =A0 a6000000-a6000fff : 0000:02:00.0
>> a7100000-a80fffff : PCI Bus #03
>> =A0 a7100000-a711ffff : 0000:03:00.0
>> =A0 a7120000-a713ffff : 0000:03:00.1
>> a8100000-a90fffff : PCI Bus #04
>> a9100000-aa0fffff : PCI Bus #05
>> aa100000-ab0fffff : PCI Bus #06
>> ab100000-ac0fffff : PCI Bus #06
>> ac100000-ad0fffff : PCI Bus #05
>> ad100000-ae0fffff : PCI Bus #04
>> ae100000-af0fffff : PCI Bus #02
>> af100000-b01fffff : PCI Bus #01
>> =A0 af100000-af11ffff : 0000:01:00.0
>> =A0 =A0 af100000-af11ffff : e1000e
>> =A0 af120000-af123fff : 0000:01:00.0
>> =A0 =A0 af120000-af123fff : e1000e
>> b0200000-b0203fff : 0000:00:1b.0
>> b0204000-b0204fff : 0000:00:1f.6
>> b0205000-b02053ff : 0000:00:1d.7
>> =A0 b0205000-b02053ff : ehci_hcd
>> b0205400-b02057ff : 0000:00:1a.7
>> =A0 b0205400-b02057ff : ehci_hcd
>> b0205800-b02058ff : 0000:00:1f.3
>> e0000000-efffffff : reserved
>> fec00000-fec00fff : reserved
>> fed00000-fed003ff : HPET 0
>> fed13000-fed13fff : pnp 00:01
>> fed1c000-fed1ffff : pnp 00:01
>> fee00000-fee00fff : reserved
>> fff00000-ffffffff : reserved
>> 100000000-15fffffff : System RAM
>> ------------------------------------------------------------------------=
---
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
