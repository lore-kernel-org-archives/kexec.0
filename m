Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1YW6-0004RR-SJ
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 09:36:40 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id D33453EE1D8
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 18:36:11 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C389C45DE55
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 18:36:11 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id A08CD45DE65
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 18:36:11 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 914371DB804E
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 18:36:11 +0900 (JST)
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 455301DB8049
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 18:36:11 +0900 (JST)
Message-ID: <52CFBECB.9040309@jp.fujitsu.com>
Date: Fri, 10 Jan 2014 18:35:07 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: kdump failed because of hotplug memory adding in kdump kernel
References: <20140109145035.GB25897@redhat.com>
 <1389283439.1792.66.camel@misato.fc.hp.com>
 <20140109162427.GF25897@redhat.com>
 <1389288265.1792.108.camel@misato.fc.hp.com>
 <20140109182310.GG25897@redhat.com>
 <1389292470.1792.109.camel@misato.fc.hp.com>
 <20140109212705.GC12111@redhat.com>
 <1389304583.1792.139.camel@misato.fc.hp.com>
 <20140110071124.GA6464@dhcp-16-105.nay.redhat.com>
 <52CFAA20.2010109@jp.fujitsu.com>
 <20140110091433.GA14074@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20140110091433.GA14074@dhcp-16-105.nay.redhat.com>
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

(2014/01/10 18:14), Baoquan wrote:
>
>   >In ns
>>> object tree, they are not treated as hotplug memory.
>>
>> wrong.
>> They are treated as hotplug memory. But the memory cannot hot removed
>> because the memory has kernel memory.
>>
>>> Otherwise, any hotplug memory which is not reserved for 2nd kernel can
>>> be parsed and need be added as hotplug memory, and add them into movable
>>> zone.
>>
>> wrong.
>> The memory is allocated as normal zone and it is offline.
>
> Hi,
>
> Thanks for answering.
>


> I am confused. Now the fact is in 1st kernel memory is reserved for
> crashkernel and passed to 2nd kernel by exactmap. Then in 2nd kernel,
> reserved memory regions are added into e820. Later hotplug memory still
> trigger add_memory, and cause bug I reported.

Does the issue occur even if you apply the following Prarit's patch to
your kernel and add no_memory_hotplug boot option to 2nd kernel?

http://marc.info/?l=linux-acpi&m=138922019607796&w=2

Thanks,
Yasuaki Ishimatsu

>
>
>>
>>>
>>> Am I right?
>>>
>>
>>> The other question, e820 reserve is done earlier than acpi
>>> initialization, because acpi_early_init() invocation is very late in
>>> start_kernel(). Does that means at the very beginning all memorys are in
>>> e820, later when acpi_early_init is called, hotplug memory is detected,
>>> they will be moved to different place or need be marked with a specific
>>> flag?
>>
>> No.
>>
>> Thanks,
>> Yasuaki Ishimatsu
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
