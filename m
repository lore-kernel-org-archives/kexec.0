Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vtvnw-0003IH-4M
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 08:51:33 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 0B0CE3EE1DE
 for <kexec@lists.infradead.org>; Fri, 20 Dec 2013 17:51:05 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id ED23C45DD77
 for <kexec@lists.infradead.org>; Fri, 20 Dec 2013 17:51:04 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id CD5A245DE4D
 for <kexec@lists.infradead.org>; Fri, 20 Dec 2013 17:51:04 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BA716E38002
 for <kexec@lists.infradead.org>; Fri, 20 Dec 2013 17:51:04 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6223DE18004
 for <kexec@lists.infradead.org>; Fri, 20 Dec 2013 17:51:04 +0900 (JST)
Message-ID: <52B404A4.3000702@jp.fujitsu.com>
Date: Fri, 20 Dec 2013 17:49:40 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: memset() in cyclic bitmap initialization
 introduce segment fault
References: <20131218133402.GA23617@dhcp-17-89.nay.redhat.com>
 <52B39878.3030403@jp.fujitsu.com>
 <20131220021750.GA7962@dhcp-16-126.nay.redhat.com>
In-Reply-To: <20131220021750.GA7962@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, WANG Chao <chaowang@redhat.com>

(2013/12/20 11:17), Dave Young wrote:
>> Also, I'm interested in the memory map passed to from EFI in that
>>
>>> cat /proc/iomem:
>>> 00000000-00000fff : reserved
>>> 00001000-0009ffff : System RAM
>>> 000a0000-000bffff : PCI Bus 0000:00
>>> 000f0000-000fffff : System ROM
>>> 00100000-3d162017 : System RAM
>>>    01000000-015cab9b : Kernel code
>>>    015cab9c-019beb3f : Kernel data
>>>    01b4f000-01da9fff : Kernel bss
>>>    30000000-37ffffff : Crash kernel
>>> 3d162018-3d171e57 : System RAM
>>> 3d171e58-3d172017 : System RAM
>>> 3d172018-3d17ae57 : System RAM
>>> 3d17ae58-3dc10fff : System RAM
>>
>> this part is consecutive but somehow is divided into 4 entries.
>> You called your environment as ``EFI virtual machine'', could you tell
>> me precisely what it mean? qemu/KVM or VMware guest system? I do want
>> to understand how this kind of memory map was created. I think this
>> kind of memory mapping is odd and I guess this is caused by the fact
>> that the system is a virtual environment.
>
> This is not specific to EFI machine, it's the reserved setup_data regions
> They happened to be continous but they do not have to be continuous.
>

Thanks for pointing out that. I've just read Documentation/x86/boot.txt
and parse_setup_data().

But I don't understand well why these regions are divided as these.
I guess kernel divides the System RAM this way and the memory map first
passed to by EFI is all page aligned, right?

Also, looking at parse_setup_data(), currently handled data in setup_data
interface is extended e820 entries and dtb case only.

                 switch (data_type) {
                 case SETUP_E820_EXT:
                         parse_e820_ext(pa_data, data_len);
                         break;
                 case SETUP_DTB:
                         add_dtb(pa_data);
                         break;
                 default:
                         break;
                 }

Is it right that this kind of memory map doesn't occur as long as either
of information is passed to via setup_data? IOW, is this necessary
information?

>>
>> And for Vivek, this case is a concrete example of multiple RAM entries
>> appearing in a single page I suspected in the mmap failure patch,
>> although these entries are consecutive in physical address and can be
>> represented by a single entry by merging them in a single entry. But
>> then it seems to me that there could be more odd case that multiple
>> RAM entries but not consecutive. I again think this should be addressed
>> in the patch for the mmap failure issue. How do you think?
>
> They are different problems, the previous mmap bug is for cross page regions
> with different page flags.
>

I understand that. What I think problem here is the case where multiple
System RAM entries appear in a single page. In the above memory map, they
are 3d171000, 3d172000 and 3d17a000. My fixing patch is to copy fractional
pages in the 2nd kernel in order to make it possible to mmap without affecting
non-System RAM area as much as possible, and then if there is this kind of
System RAM entries, we need to use the same page in the 2nd kernel for
different System RAM entries that shares the same page in the 1st kernel. This
needs a little additional processing and we want to keep implementation as
simple as possible as long as there's no such system in real world. However,
I'm surprised to see the memory mapping above.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
