Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11] helo=mx1.molgen.mpg.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9oXL-0002Kp-3R
 for kexec@lists.infradead.org; Mon, 16 Sep 2019 10:47:16 +0000
Subject: Re: [PATCH] x86: Fix PAGE_OFFSET for kernels since 4.20
References: <20190830091258.51133-1-buczek@molgen.mpg.de>
 <20190903144127.opmnw42pie6klghc@verge.net.au>
 <848555a3-5a1f-c0c0-ef50-e684cf70595a@molgen.mpg.de>
 <CACi5LpPe5ueNMdCObWvCLg+k_kDrvd-SkOvc8ACa1V9UfSD77g@mail.gmail.com>
 <20190916072333.7xma2kgjzucfes44@verge.net.au>
From: Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <1d8f474a-4ed1-4b83-7e70-36504dfa6f69@molgen.mpg.de>
Date: Mon, 16 Sep 2019 12:47:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190916072333.7xma2kgjzucfes44@verge.net.au>
Content-Language: en-US
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
To: Simon Horman <horms@verge.net.au>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

On 9/16/19 9:23 AM, Simon Horman wrote:
> On Mon, Sep 09, 2019 at 10:33:11AM +0530, Bhupesh Sharma wrote:
>> Sorry Guys,
>>
>> On Tue, Sep 3, 2019 at 11:36 PM Donald Buczek <buczek@molgen.mpg.de> wrote:
>>>
>>> Dear Simon,
>>>
>>> On 03.09.19 16:41, Simon Horman wrote:
>>>> On Fri, Aug 30, 2019 at 11:12:58AM +0200, Donald Buczek wrote:
>>>>> Linux kernel commit d52888aa2753 ("x86/mm: Move LDT remap out of KASLR
>>>>> region on 5-level paging") changed the base of the direct mapping
>>>>> from 0xffff880000000000 to 0xffff888000000000. This was merged
>>>>> into v4.20-rc2.
>>>>>
>>>>> Update to new address accordingly.
>>>>
>>>> Thanks, applied for inclusion in v2.0.20.
>>>
>>> I must admit, that I overlooked that d52888aa2753 ("x86/mm: Move LDT remap out of KASLR region on 5-level paging") was backported to 4.19.5 as 4074ca7d8a18 ("x86/mm: Move LDT remap out of KASLR region on 5-level paging").
>>>
>>> Bhupesh Sharma wanted to look into a a dynamic solution, which, of course, would be better. But if you still want to include this (e.g. as the fallback for the dynamic solution), you might want to replace the patch with the following one, which selects the new PAGE_OFFSET starting from kernel version 4.19.5 instead of 4.20.0.
>>
>> I was in a conference last week and was not able to connect to my test
>> machine(s) to develop and test a more generic fix, as I suggested in
>> my earlier message.
>>
>> I will try to work on and send a generic fix in a couple of days.
> 
> Thanks,
> 
> I think it would be best if this patch,
> 23b67f048dde ("x86: Fix PAGE_OFFSET for kernels since 4.20"),
> was reverted.
> 
> Donald, Bhupesh, what do you think?

The original patch is technically correct and fixes the problem for 4.20 kernels, so I don't know, why it should be reverted.

My replacement patch was to address 4.19 kernels as well. But if the original patch has already been comitted and published, it should not be replaced of course. 4.20 kernels should be addressed by a separate patch on top of it instead.

As I'm not subscribed to the kexec list, I may have missed the latest news, however.

Best
   Donald
-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
