Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-f53.google.com ([209.85.214.53])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdUyB-00080A-4d
 for kexec@lists.infradead.org; Tue, 14 Feb 2017 04:44:05 +0000
Received: by mail-it0-f53.google.com with SMTP id c7so18751116itd.1
 for <kexec@lists.infradead.org>; Mon, 13 Feb 2017 20:43:41 -0800 (PST)
Subject: Re: [Makedumpfile Patch 0/6] Fix --mem-usage /proc/kcore
References: <cover.1486381805.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EA4B89@BPXM01GP.gisp.nec.co.jp>
 <db956357-414f-0efc-10b8-7864b88f5e00@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EA4D21@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <a71bda70-586e-ae26-c6ed-37427d4d71dd@redhat.com>
Date: Tue, 14 Feb 2017 10:13:34 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EA4D21@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>



On Monday 13 February 2017 01:58 PM, Atsushi Kumagai wrote:
>> On Monday 13 February 2017 11:56 AM, Atsushi Kumagai wrote:
>>> Hello Pratyush,
>>>
>>>> `makedumpfile --mem-usage /proc/kcore` has been broken after kaslr specific
>>>> modifications. I have proposed a kernel patch [0] which has been ACKed by
>>>> Andrew Morton and is available in next-2017020 now. Hopefully, it should be
>>>> part of upstream in v4.10 release. This kernel patch helps to fix this
>>>> issue for both the case of kaslr enabled and disabled.
>>>>
>>>> To seek other's feedback, I am sending makedumpfile patches before kernel
>>>> patch hits upstream.
>>>
>>> Thanks for taking care of this feature.
>>> I understand that the problem is:
>>>
>>>  - phys_base is necessary for VtoP, but:
>>>    - SYMBOL(phys_base) is unavailable since /proc/kcore doesn't export VMCOREINFO.
>>>    - get_phys_base() doesn't work well since current PT_LOAD doesn't have valid p_paddr.
>>
>> Yes, this is what the problem is.
>>
>>>
>>> The new makedumpfile with this patches can show unexpected behavior since it
>>> will refer to invalid p_paddr(always 0). Of course, also current makedumpfile cannot
>>> work if phys_base isn't 0.
>>>
>>> If we don't have any way to get phys_base in 1st kernel environment,
>>> I think we should disable this feature in older kernel (e.g. by checking kernel version).
>>
>> Hummm..I had thought that distros with old kernel will backport kernel
>> patch and then can use this feature. If we disable it for older kernel,
>> then they will not be able to do it.
>>
>> would it be fine if I cc kernel patch to stable mailing list? It seems
>> that patch can be easily applied all older kernel.
>
> Even if there are some "supported" older kernels, there is no guarantee
> that all of the kernels provide valid p_paddr. So makedumpfile have to
> know whether the target kernel supports --mem-usage or not in older kernel.
>
> Is it possible to add a new stuff into PT_NOTE of /proc/kcore to signify the
> kernel supports --mem-usage ? Otherwise, my only idea is --force option for
> older kernel, expert user can use it if he is sure that the kernel has valid
> p_paddr.
>

I think, we can go with --force. I will send next revision after kernel  
patch hits Linus's tree.


Thanks for your review.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
