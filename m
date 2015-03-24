Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YaFz5-0006yY-F3
 for kexec@lists.infradead.org; Tue, 24 Mar 2015 03:58:32 +0000
Message-ID: <5510E0CA.5000507@hitachi.com>
Date: Tue, 24 Mar 2015 12:58:02 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kernel/panic/kexec: fix "crash_kexec_post_notifiers"
 option issue in oops path
References: <54F9D645.2050008@jp.fujitsu.com>
 <20150323034752.GD2068@dhcp-16-105.nay.redhat.com>
 <20150323071943.GA22765@gmail.com> <20150323133710.GA3172@redhat.com>
 <20150323135046.GA25012@gmail.com> <20150323143158.GB3172@redhat.com>
In-Reply-To: <20150323143158.GB3172@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?B?IkhhdGF5YW1hLCBEYWlzdWtlL+eVkeWxsSDlpKfovJQi?= <d.hatayama@jp.fujitsu.com>, mingo@redhat.com, ebiederm@xmission.com, hidehiro.kawai.ez@hitachi.com, akpm@linux-foundation.org, bp@suse.de, Ingo Molnar <mingo@kernel.org>

(2015/03/23 23:31), Vivek Goyal wrote:
[...]
>>>> Secondly, and more importantly, the whole premise of commit 
>>>> f06e5153f4ae is broken IMHO:
>>>>
>>>>  "This can help rare situations where kdump fails because of unstable
>>>>   crashed kernel or hardware failure (memory corruption on critical
>>>>   data/code)"
>>>>
>>>> wtf?
>>>>
>>>> If the kernel crashed due to a kernel crash, then the kernel booting 
>>>> up in whatever hardware state should be able to do a clean bootup. The 
>>>> fix for those 'rare situations' should be to fix the real bug (for 
>>>> example by making hardware driver init (or deinit) sequences more 
>>>> robust), not to paper it over by ordering around crash-time sequences 
>>>> ...
>>>>
>>>> If it crashed due to some hardware failure, there's literally an 
>>>> infinite amount of failure modes that may or may not be impacted by 
>>>> kexec crash-time handling ordering. We don't want to put a zillion 
>>>> such flags into the kernel proper just to allow the perturbation of 
>>>> the kernel.
>>>
>>> I think one of the motivations behind this patch was call to kmsg_dump().
>>> Some vendors have been wanting to have the capability to save kernel logs
>>> to some NVRAM before transition to second kernel happens. Their argument
>>> is that kdump does not succeed all the time and if kdump does not succeed
>>> then atleast they have something to work with (kernel logs retrieved
>>> from pstore interface).
>>
>> Doesn't pstore attach itself to printk itself? AFAICS it does:
>>
>>  fs/pstore/platform.c:   register_console(&pstore_console);
>>
>> so the printk log leading up to and including the crash should be 
>> available, regardless of this patch. What am I missing?
> 
> That's a good point. I was not aware of it. I am Ccing Don Zickus as
> he has spent some time on this in the past.
> 
> Masami, would you have thougths on this? IIRC, one reason why kmsg_dump()
> was written so that one could dump kernel messages to an NVRAM. Of one
> could simple register pstore as console, then how kmsg_dump() will
> continue to be useful?

Yes, actually, kmsg_dump and pstore can help a lot to dump the last
message (even though kmsg_dump() is called only when setting
crash_kexec_post_notifiers...)

However, there are some machines which don't support pstore, but
only IPMI. pstore(kmsg) stores messages to a local NVRAM, and IPMI
stores messages to BMC(Board Management Controller)'s NVRAM (SEL:
System Event Log).
Some enterprise servers only have BMC, but no NVRAM. For such kind
of servers, we still need to call panic_notifier to store messages
via IPMI.
And also, using IPMI has another secondary feature, we can notice
machine failure from remote machine via IPMI over LAN by monitoring
SEL :)

You might want to integrate IPMI and pstore. But since IPMI SEL is
very limited and very slow, those are very different.

>>> Not that I agree fully with this as problem might happen while we 
>>> try to run panic_notifiers or kmsg_dump hooks and never transition 
>>> into kdump kernel.
>>
>> btw., this is the big problem with 'notifiers' in general: they are 
>> opaque with barely any semantics defined, and a source of constant 
>> confusion.
> 
> Agreed. That's the reason Eric never liked the idea of letting panic
> notifiers run before crash_kexec().

I see. thus I added a notice on documentation.

                        Note that this also increases risks of kdump failure,
                        because some panic notifiers can make the crashed
                        kernel more unstable.

I personally don't recommend to use this in usual situation. Only for
the machines which is very well configured and tested, this feature can
be enabled.

>>> And it has been literally years since some developers have been 
>>> pushing for allowing to run panic notifiers before crash_kexec(). 
>>> Eric Biederman has been pushing back saying it reduces the 
>>> reliability of kdump operation so this is not acceptable.
>>
>> So what do those notifiers do?
> 
> IIRC, two main reasons had come in the past.
> 
> - In a cluster of nodes, people wanted to send some sort of notifications
>   to main server that a node has crashed and don't fence it off as it
>   might be saving dump.
> 
> - And saving kernel logs to non volatile store.
> 
> There might be more and I might not be aware about these. Hatayama and
> Masami, can you shed more light on this.

Yes, as I described above, we'd like to use IPMI to write the log to SEL
and that also allow us to monitor the machine remotely.

> 
> BTW, first problem we faced in our clusters too and now it has been fixed.
> Basically we send notifications in second kernel in user space to master
> server that this node is still saving dump so don't fence it off.

Yeah, that's the usual way, I think. In some "mission-critical" use-cases,
we can't relay only on the kdump stability.

Thank you,



-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
