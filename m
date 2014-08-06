Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XEqd0-0001LA-R0
 for kexec@lists.infradead.org; Wed, 06 Aug 2014 02:07:00 +0000
Message-ID: <53E18D89.7050007@huawei.com>
Date: Wed, 6 Aug 2014 10:06:01 +0800
From: Hu Keping <hukeping@huawei.com>
MIME-Version: 1.0
Subject: Fwd: Re: [PATCH] ARM: Add arm description to
 Documentation/kdump/kdump.txt
References: <53E03992.1030000@huawei.com>
In-Reply-To: <53E03992.1030000@huawei.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: hbabu@us.ibm.com, kexec@lists.infradead.org

sorry forget to cc.

-------- Original message --------
Theme: Re: [PATCH] ARM: Add arm description to Documentation/kdump/kdump.txt
On: Tue, 05 Aug 2014 09:55:30 +0800
From: Hu Keping <hukeping@huawei.com>
To: vgoyal@redhat.com
Cc: sdu.liu@huawei.com, peifeiyue@huawei.com

on 2014/7/31 20:39, Vivek Goyal wrote:
> On Thu, Jul 31, 2014 at 02:03:31PM +0800, HuKeping wrote:
>> Add arm specific parts to kdump kernel documentation.
>>
>
> Hi Hu,
>
> So kexec on arm (32bit) now works? All the kernel pieces and kexec-tools
> pieces are upstream? (Sorry, I have not been able to keeptrack of arm
> development).
>
>

Yes,I run the routine on vexpress(v2p-ca9) with Cortex-A9 MPCore and it
works fine

>> ----------------------------------------
>> Signed-off-by: Hu Keping <hukeping@huawei.com>
>> ---
>>   Documentation/kdump/kdump.txt | 25 ++++++++++++++++++++++---
>>   1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
>> index 88d5a86..5fc98d6 100644
>> --- a/Documentation/kdump/kdump.txt
>> +++ b/Documentation/kdump/kdump.txt
>> @@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
>>   a remote system.
>>
>>   Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
>> -and s390x architectures.
>> +s390x and arm architectures.
>>
>>   When the system kernel boots, it reserves a small section of memory for
>>   the dump-capture kernel. This ensures that ongoing Direct Memory Access
>> @@ -112,7 +112,7 @@ There are two possible methods of using Kdump.
>>   2) Or use the system kernel binary itself as dump-capture kernel and there is
>>      no need to build a separate dump-capture kernel. This is possible
>>      only with the architectures which support a relocatable kernel. As
>> -   of today, i386, x86_64, ppc64 and ia64 architectures support relocatable
>> +   of today, i386, x86_64, ppc64, ia64 and arm architectures support relocatable
>>      kernel.
>
> So zImage is relocatable on arm?
>

Yes, only if the CONFIG_AUTO_ZRELADDR selected.

>>
>>   Building a relocatable kernel is advantageous from the point of view that
>> @@ -296,6 +296,12 @@ Boot into System Kernel
>>      on the memory consumption of the kdump system. In general this is not
>>      dependent on the memory size of the production system.
>>
>> +   On arm, use "crashkernel=Y@X".
>
> Do you support other forms of crashkernel= parameter? Like crashkernel=X.
> A longer list of parameters is available in kernel-parameters.txt.
>

Assume [0x60000000-0x7fffffff] : System RAM

The forms of, for example crashkernel=128M@1792M and
crashkernel=128M@0x70000000 are both OK.

But there will be a panic if use crashkernel=Y or crashkernal=YM@Z where
Z is NOT in the System RAM range.

The extended crashkernel syntax is okay, but again, "@offset" is
required. Like:
crashkernel=<range1>:<size1>[,<range2>:<size2>,...]@offset
range=start-[end]

different with the old

crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
range=start-[end]


>> Note that the start address of the kernel
>> +   will be aligned to 128MiB (0x08000000),
>
> x86 kernel is 2MB aligned. 128MB aligned seems to be huge. Where does
> that restriction come from.
>

ZRELADDR is the physical address where the decompressed kernel
image(from zImage) will be placed, If AUTO_ZRELADDR is selected, the
address will be determined at run-time by masking the current IP with
0xf8000000.

One can refers to LINUX/arch/arm/boot/compressed/head.S

  168 #ifdef CONFIG_AUTO_ZRELADDR
  169         @ determine final kernel image address
  170         mov r4, pc
  171         and r4, r4, #0xf8000000
  172         add r4, r4, #TEXT_OFFSET
  173 #else
  174         ldr r4, =zreladdr
  175 #endif


>> so if the start address is not then
>> +   any space blow the alignment point may be overwrited by the dump-caputre kernel,
>> +   which means it is possible that the vmcore is not that precise as expected.
>
> What does above statement mean? I think it requires some work. And also
> some examples of what's a reasonable crashkernel=X@Y values for arm.
>
>

As the statement above, one can also set the parameter like
crashkernel=128M@0x69000000, but it will be reset to 128M@0x68000000.
Then what will happen to 0x68000000-0x68ffffff is UNPREDICTABLE.

Same with using the extended crashkernel syntax.

>> +
>> +
>>   Load the Dump-capture Kernel
>>   ============================
>>
>> @@ -315,7 +321,8 @@ For ia64:
>>   	- Use vmlinux or vmlinuz.gz
>>   For s390x:
>>   	- Use image or bzImage
>> -
>> +For arm:
>> +	- Use zImage
>>
>>   If you are using a uncompressed vmlinux image then use following command
>>   to load dump-capture kernel.
>> @@ -331,6 +338,15 @@ to load dump-capture kernel.
>>      --initrd=<initrd-for-dump-capture-kernel> \
>>      --append="root=<root-dev> <arch-specific-options>"
>>
>> +If you are using a compressed zImage, then use following command
>> +to load dump-capture kernel.
>> +
>> +   kexec --type zImage -p <dump-capture-kernel-bzImage> \
>> +   --initrd=<initrd-for-dump-capture-kernel> \
>> +   --dtb=<dtb-for-dump-capture-kernel> \
>> +   --append="root=<root-dev> <arch-specific-options>"
>> +
>> +
>>   Please note, that --args-linux does not need to be specified for ia64.
>>   It is planned to make this a no-op on that architecture, but for now
>>   it should be omitted
>> @@ -347,6 +363,9 @@ For ppc64:
>>   For s390x:
>>   	"1 maxcpus=1 cgroup_disable=memory"
>>
>> +For arm:
>> +	"1 maxcpus=1 reset_devices"
>> +
>
> nr_cpus=1 does not work on arm? We prefer that over maxcpus=1.
>

It does works, but I think there is a little bug with using nr_cpus.
There will be a warning when dump-caputre kernel booting if use nr_cpus:

"[	0.000000] DT/cpu 2nodes greater than max cores 1, capping them"

This is from arch/arm/kernel/devtree.c, in function
void __init arm_dt_init_cpu_maps(void)

145    	if (WARN(cpuidx > nr_cpu_ids, "DT /cpu %u nodes greater than "
146					"max cores %u, capping them\n",
147					cpuidx, nr_cpu_ids)) {
148		cpuidx = nr_cpu_ids;
149             break;
150	}

Since we have already using nr_cpus to specify the number of cpus we
want to be online, kdump should not to make the comparison with dtb
(which is strongly recommended on arm-32bit ) again, but it does, so the
warning out.
Meanwhile the maxcpus works fine.

> Thanks
> Vivek
>
> .
>

Sincerely yours,
Hu Keping






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
