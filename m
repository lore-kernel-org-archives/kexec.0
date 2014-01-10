Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1X8T-0002hV-RD
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 08:08:11 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id CFE573EE0B6
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 17:07:42 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id BD34345DD77
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 17:07:42 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id A453245DD76
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 17:07:42 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 815981DB8040
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 17:07:42 +0900 (JST)
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 332721DB803E
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 17:07:42 +0900 (JST)
Message-ID: <52CFAA20.2010109@jp.fujitsu.com>
Date: Fri, 10 Jan 2014 17:06:56 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: kdump failed because of hotplug memory adding in kdump kernel
References: <8500545.JVNPnKcyD1@vostro.rjw.lan>
 <1389226308.1792.39.camel@misato.fc.hp.com>
 <20140109145035.GB25897@redhat.com>
 <1389283439.1792.66.camel@misato.fc.hp.com>
 <20140109162427.GF25897@redhat.com>
 <1389288265.1792.108.camel@misato.fc.hp.com>
 <20140109182310.GG25897@redhat.com>
 <1389292470.1792.109.camel@misato.fc.hp.com>
 <20140109212705.GC12111@redhat.com>
 <1389304583.1792.139.camel@misato.fc.hp.com>
 <20140110071124.GA6464@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20140110071124.GA6464@dhcp-16-105.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Baoquan <bhe@redhat.com>
Cc: Toshi Kani <toshi.kani@hp.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tangchen@cn.fujitsu.com, linux-acpi@vger.kernel.org, zhangyanfei@cn.fujitsu.com, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>

(2014/01/10 16:11), Baoquan wrote:
> On 01/09/14 at 02:56pm, Toshi Kani wrote:
>> On Thu, 2014-01-09 at 16:27 -0500, Vivek Goyal wrote:
>>> On Thu, Jan 09, 2014 at 11:34:30AM -0700, Toshi Kani wrote:
>>>> On Thu, 2014-01-09 at 13:23 -0500, Vivek Goyal wrote:
>>>>> On Thu, Jan 09, 2014 at 10:24:25AM -0700, Toshi Kani wrote:
>>>>>
>>>>> [..]
>>>>>>> I think creating a new command line option is simpler as compared to
>>>>>>> creating a new flag in bootparam which in turn disables memory hotplug.
>>>>>>> More users can use that option. For example, if for some reason hotplug
>>>>>>> code is crashing, one can just disable it on command line as work around
>>>>>>> and move on.
>>>>>>
>>>>>> I do not have a strong opinion about having such option.  However, I
>>>>>> think it is more user friendly to keep the exactmap option works alone
>>>>>> on any platforms.
>>>>>
>>>>> I think we should create internally a variable which will disable memory
>>>>> hotplug. And set that variable based on memmap=exactmap, mem=X and also
>>>>> provide a way to disable memory hotplug directly using command line
>>>>> option.
>>>>>
>>>>> Current kexec-tools can use memmap=exactmap and be happy. I am writing
>>>>> a new kexec syscall and will not be using memmap=exactmap and would need
>>>>> to use that command line option to disable memory hotplug behavior.
>>>>
>>>> Sounds good to me.
>>>
>>> Nobody responded to my other question, so I would ask it again.
>>>
>>> Assume we have disabled hotplug memory in second kernel. First kernel
>>> saw hotplug memory and assume crash kernel reserved region came from
>>> there. We will pass this memory in bootparams to second kernel and it
>>> will show up in E820 map. It should still be accessible in second kernel,
>>> is that right?
>>
>> Yes.
>>
>>> Or there is some dependency on ACPI doing some magic before this memory
>>> range is available in second kernel?
>>
>> No.  The 1st kernel reserves the crash kernel region, which cannot be
>> hot-deleted.  So, this region continues to be accessible by the 2nd
>> kernel without any operation.
>

If my understanding is correct:

> Now what I understand is if a several memsection is reserved for
> crashkernel, then in 2nd kernel, they are just like normal memory.

correct.

> In ns
> object tree, they are not treated as hotplug memory.

wrong.
They are treated as hotplug memory. But the memory cannot hot removed
because the memory has kernel memory.

> Otherwise, any hotplug memory which is not reserved for 2nd kernel can
> be parsed and need be added as hotplug memory, and add them into movable
> zone.

wrong.
The memory is allocated as normal zone and it is offline.

>
> Am I right?
>

> The other question, e820 reserve is done earlier than acpi
> initialization, because acpi_early_init() invocation is very late in
> start_kernel(). Does that means at the very beginning all memorys are in
> e820, later when acpi_early_init is called, hotplug memory is detected,
> they will be moved to different place or need be marked with a specific
> flag?

No.

Thanks,
Yasuaki Ishimatsu

>
>
>
>>
>> I am more curious to know how makedumpfile decides what memory ranges to
>> dump.  The 1st kernel may have performed memory hot-add / delete
>> operations before a crash, so it needs to know the valid physical
>> address range at the time of crash, and may not rely on the E820 map
>> from BIOS (which is stale).  Am I right to assume that makedumpfile gets
>> it from the page tables of the 1st kernel?
>
> makedumpfile just do the dump, what memory ranges to dump is decided in
> 1st kernel by kexec-tools. In 1st kernel, if kexec-tools executed, it
> will find all System Ram memorys which exclude the reserved regions for
> kdump kernel, then build a logical elf file, each load segment is one of
> these System Ram memory regions, its addr and length is written into the
> program header.
>
> Then makedumpfile just read this elf file, and read all of them and
> dump.
>
> If after kexec-tools execution and before crash, a hotplug memory is
> removed, udev will check this and trigger a kdump restart, kexec-tools
> is executed again, System Ram region information are stored. The logical
> file header will be passed to 2nd kernel.
>
>
>>
>> Thanks,
>> -Toshi
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
