Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XoZ61-0003HI-3p
 for kexec@lists.infradead.org; Wed, 12 Nov 2014 14:40:34 +0000
Message-ID: <54637140.9010605@redhat.com>
Date: Wed, 12 Nov 2014 15:40:00 +0100
From: Laszlo Ersek <lersek@redhat.com>
MIME-Version: 1.0
Subject: Re: [Qemu-devel] uniquely identifying KDUMP files that originate
 from QEMU
References: <5461F18C.2080400@redhat.com> <54624710.6070306@codeaurora.org>
 <20141112090554.6dc15b9f@hananiah.suse.cz> <54635E0C.5090802@codeaurora.org>
 <20141112142601.58a4c214@hananiah.suse.cz> <54636096.6020500@codeaurora.org>
In-Reply-To: <54636096.6020500@codeaurora.org>
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
To: Christopher Covington <cov@codeaurora.org>, Petr Tesarik <ptesarik@suse.cz>
Cc: Wen Congyang <wency@cn.fujitsu.com>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, kexec@lists.infradead.org, qemu devel list <qemu-devel@nongnu.org>, Qiao Nuohan <qiaonuohan@cn.fujitsu.com>, Dave Anderson <anderson@redhat.com>, kumagai-atsushi@mxc.nes.nec.co.jp, crash-utility@redhat.com

On 11/12/14 14:28, Christopher Covington wrote:
> On 11/12/2014 08:26 AM, Petr Tesarik wrote:
>> On Wed, 12 Nov 2014 08:18:04 -0500
>> Christopher Covington <cov@codeaurora.org> wrote:
>>
>>> On 11/12/2014 03:05 AM, Petr Tesarik wrote:
>>>> On Tue, 11 Nov 2014 12:27:44 -0500
>>>> Christopher Covington <cov@codeaurora.org> wrote:
>>>>
>>>>> On 11/11/2014 06:22 AM, Laszlo Ersek wrote:
>>>>>> (Note: I'm not subscribed to either qemu-devel or the kexec list; please
>>>>>> keep me CC'd.)
>>>>>>
>>>>>> QEMU is able to dump the guest's memory in KDUMP format (kdump-zlib,
>>>>>> kdump-lzo, kdump-snappy) with the "dump-guest-memory" QMP command.
>>>>>>
>>>>>> The resultant vmcore is usually analyzed with the "crash" utility.
>>>>>>
>>>>>> The original tool producing such files is kdump. Unlike the procedure
>>>>>> performed by QEMU, kdump runs from *within* the guest (under a kexec'd
>>>>>> kdump kernel), and has more information about the original guest kernel
>>>>>> state (which is being dumped) than QEMU. To QEMU, the guest kernel state
>>>>>> is opaque.
>>>>>>
>>>>>> For this reason, the kdump preparation logic in QEMU hardcodes a number
>>>>>> of fields in the kdump header. The direct issue is the "phys_base"
>>>>>> field. Refer to dump.c, functions create_header32(), create_header64(),
>>>>>> and "include/sysemu/dump.h", macro PHYS_BASE (with the replacement text
>>>>>> "0").
>>>>>>
>>>>>> http://git.qemu.org/?p=qemu.git;a=blob;f=dump.c;h=9c7dad8f865af3b778589dd0847e450ba9a75b9d;hb=HEAD
>>>>>>
>>>>>> http://git.qemu.org/?p=qemu.git;a=blob;f=include/sysemu/dump.h;h=7e4ec5c7d96fb39c943d970d1683aa2dc171c933;hb=HEAD
>>>>>>
>>>>>> This works in most cases, because the guest Linux kernel indeed tends to
>>>>>> be loaded at guest-phys address 0. However, when the guest Linux kernel
>>>>>> is booted on top of OVMF (which has a somewhat unusual UEFI memory map),
>>>>>> then the guest Linux kernel is loaded at 16MB, thereby getting out of
>>>>>> sync with the phys_base=0 setting visible in the KDUMP header.
>>>>>>
>>>>>> This trips up the "crash" utility.
>>>>>>
>>>>>> Dave worked around the issue in "crash" for ELF format dumps -- "crash"
>>>>>> can identify QEMU as the originator of the vmcore by finding the QEMU
>>>>>> notes in the ELF vmcore. If those are present, then "crash" employs a
>>>>>> heuristic, probing for a phys_base up to 32MB, in 1MB steps.
>>>>>
>>>>> What advantages does KDUMP have over ELF?
>>>>
>>>> It's smaller (data is compressed), and it contains a header with some
>>>> useful information (e.g. the crashed kernel's version and release).
>>>
>>> What if the ELF dumper used SHF_COMPRESSED or could dump an ELF.xz?
>>
>> Not the same thing. With KDUMP, each page is compressed separately, so
>> if a utility like crash needs a page from the middle, it can find it
>> and unpack it immediately. If we had an ELF.xz, then the whole file
>> must be unpacked before it can be used. And unpacking a few terabytes
>> takes ... a while. ;-)
> 
> Understood on the ELF.xz approach, but why couldn't each page (or maybe a
> configurable size) be a SHF_COMPRESSED section?

Perhaps it could, technically -- it's just not how Qiao Nuohan
implemented the feature. I didn't research the background for this.

Thanks
Laszlo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
