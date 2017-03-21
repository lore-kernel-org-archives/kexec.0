Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cq98I-0004ho-RO
 for kexec@lists.infradead.org; Tue, 21 Mar 2017 02:02:48 +0000
Subject: Re: [PATCH] kexec: Update vmcoreinfo after crash happened
References: <1489666587-24103-1-git-send-email-xlpang@redhat.com>
 <20170316122730.GB23625@x1> <58CA86D2.70800@redhat.com>
 <20170316131809.GC23625@x1> <58CA95EA.1040807@redhat.com>
 <20170318192328.31dc1fde@hananiah.suse.cz> <58CF3BC6.3060808@redhat.com>
 <20170320140437.3e9d4955@hananiah.suse.cz>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58D08A52.3080004@redhat.com>
Date: Tue, 21 Mar 2017 10:05:06 +0800
MIME-Version: 1.0
In-Reply-To: <20170320140437.3e9d4955@hananiah.suse.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

On 03/20/2017 at 09:04 PM, Petr Tesarik wrote:
> On Mon, 20 Mar 2017 10:17:42 +0800
> Xunlei Pang <xpang@redhat.com> wrote:
>
>> On 03/19/2017 at 02:23 AM, Petr Tesarik wrote:
>>> On Thu, 16 Mar 2017 21:40:58 +0800
>>> Xunlei Pang <xpang@redhat.com> wrote:
>>>
>>>> On 03/16/2017 at 09:18 PM, Baoquan He wrote:
>>>>> On 03/16/17 at 08:36pm, Xunlei Pang wrote:
>>>>>> On 03/16/2017 at 08:27 PM, Baoquan He wrote:
>>>>>>> Hi Xunlei,
>>>>>>>
>>>>>>> Did you really see this ever happened? Because the vmcore size estimate
>>>>>>> feature, namely --mem-usage option of makedumpfile, depends on the
>>>>>>> vmcoreinfo in 1st kernel, your change will break it.
>>>>>> Hi Baoquan,
>>>>>>
>>>>>> I can reproduce it using a kernel module which modifies the vmcoreinfo,
>>>>>> so it's a problem can actually happen.
>>>>>>
>>>>>>> If not, it could be not good to change that.
>>>>>> That's a good point, then I guess we can keep the crash_save_vmcoreinfo_init(),
>>>>>> and store again all the vmcoreinfo after crash. What do you think?
>>>>> Well, then it will make makedumpfile segfault happen too when execute
>>>>> below command in 1st kernel if it existed:
>>>>> 	makedumpfile --mem-usage /proc/kcore
>>>> Yes, if the initial vmcoreinfo data was modified before "makedumpfile --mem-usage", it might happen,
>>>> after all the system is going something wrong. And that's why we deploy kdump service at the very
>>>> beginning when the system has a low possibility of going wrong.
>>>>
>>>> But we have to guarantee kdump vmcore can be generated correctly as possible as it can.
>>>>
>>>>> So we still need to face that problem and need fix it. vmcoreinfo_note
>>>>> is in kernel data area, how does module intrude into this area? And can
>>>>> we fix the module code?
>>>>>
>>>> Bugs always exist in products, we can't know what will happen and fix all the errors,
>>>> that's why we need kdump.
>>>>
>>>> I think the following update should guarantee the correct vmcoreinfo for kdump.
>>> I'm still not convinced. I would probably have more trust in a clean
>>> kernel (after boot) than a kernel that has already crashed (presumably
>>> because of a serious bug). How can be reliability improved by running
>>> more code in unsafe environment?
>> Correct, I realized that, so used crc32 to protect the original data,
>> but since Eric left a more reasonable idea, I will try that later.
>>
>>> If some code overwrites reserved areas (such as vmcoreinfo), then it's
>>> seriously buggy. And in my opinion, it is more difficult to identify
>>> such bugs if they are masked by re-initializing vmcoreinfo after crash.
>>> In fact, if makedumpfile in the kexec'ed kernel complains that it
>>> didn't find valid VMCOREINFO content, that's already a hint.
>>>
>>> As a side note, if you're debugging a vmcoreinfo corruption, it's
>>> possible to use a standalone VMCOREINFO file with makedumpfile, so you
>>> can pre-generate it and save it in the kdump initrd.
>>>
>>> In short, I don't see a compelling case for this change.
>> E.g. 1) wrong code overwrites vmcoreinfo_data; 2) further crashes the
>> system; 3) trigger kdump, then we obviously will fail to recognize the
>> crash context correctly due to the corrupted vmcoreinfo.  Everyone
>> will get confused if met such unfortunate customer-side issue.
>>
>> Although it's corner case, if it's easy to fix, then I think we better do it.
>>
>> Now except for vmcoreinfo, all the crash data is well protected (including
>> cpu note which is fully updated in the crash path, thus its correctness is
>> guaranteed).
> Hm, I think we shouldn't combine the two things.
>
> Protecting VMCOREINFO with SHA (just as the other information passed to
> the secondary kernel) sounds right to me. Re-creating the info while
> the kernel is already crashing does not sound particularly good.
>
> Yes, your patch may help in some scenarios, but in general it also
> increases the amount of code that must reliably work in a crashed
> environment. I can still recall why the LKCD approach (save the dump
> directly from the crashed kernel) was abandoned...

Agree on this point, there is nearly no extra code added to the crash path in v3,
maybe you can have a quick look.

>
> Apart, there's a lot of other information that might be corrupted (e.g.
> the purgatory code, elfcorehdr, secondary kernel, or the initrd).

Those are located at the crash memory, they can be protected by either
SHA or the arch_kexec_protect_crashkres() mechanism(if implemented).

>
> Why is this VMCOREINFO so special?

It is also a chunk passed to 2nd kernel like the above-mentioned information,
we better treat it like them as well.

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
