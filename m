Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-x22f.google.com ([2607:f8b0:4002:c05::22f])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bQJjh-00029B-J1
 for kexec@lists.infradead.org; Thu, 21 Jul 2016 19:34:22 +0000
Received: by mail-yw0-x22f.google.com with SMTP id r9so84290355ywg.0
 for <kexec@lists.infradead.org>; Thu, 21 Jul 2016 12:33:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5790E80F.7080109@cisco.com>
References: <57841399.1030703@cisco.com> <578FCE9A.50305@cisco.com>
 <CAJGZr0KwbB+2Qdv4AAp1qVr60PQPGiJqQum5awSFrptATmHYUA@mail.gmail.com>
 <5790E80F.7080109@cisco.com>
From: Maxim Uvarov <muvarov@gmail.com>
Date: Thu, 21 Jul 2016 22:33:58 +0300
Message-ID: <CAJGZr0LrWsQzM-UYS6chQsRYeLNzgyENpzaNxQGHjWfJ+w232g@mail.gmail.com>
Subject: Re: IO memory read from /proc/vmcore leads to hang.
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
To: Daniel Walker <danielwa@cisco.com>
Cc: "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

2016-07-21 18:19 GMT+03:00 Daniel Walker <danielwa@cisco.com>:
>
>  There appears to be no code which checks what is or is not System ram,
> there is nothing that checks the device tree to see what is IO memory, and
> nothing reads /proc/iomem .. So AFAIK nothing cares if it's IO memory, or
> system ram, and there's no method to config things to skip any memory in the
> system, except in makedumpfile which can skip symbols not IO memory.
>
>

Daniel,  unfortunately it's long time for me when I looked to powerpc
code. But I just
checked that here:

kexec-tools-2.0.6/kexec/arch/ppc64/kexec-ppc64.c

is probably what you need.

Maxim.

>
> On 07/21/2016 12:34 AM, Maxim Uvarov wrote:
>>
>> Second kernel should already know that it's not system ram of the
>> first kernel and in that case makedumpfile will not dump that memory.
>> Simple way is to pass additional kernel argument to kexec is when you
>> load the kernel. If it works than you can think how it's better to
>> pass this parameter.  Variants might be request_resource() in first
>> kernel or add some logic to kexec tools.
>>
>> Best regards,
>> Maxim.
>>
>> 2016-07-20 22:18 GMT+03:00 Daniel Walker <danielwa@cisco.com>:
>>>
>>> Mahesh, I didn't get your email for some reason . I saw it in the
>>> Archives.
>>>
>>> makedumpfile doesn't appear to have a way to drop free form memory areas.
>>> So
>>> I need to drop 00800000 to 00807fff , but I don't see a way to do that.
>>> Any
>>> other suggestions on how to prevent this hang ?
>>>
>>>
>>>
>>> On 07/11/2016 02:46 PM, Daniel Walker wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> I found found that on my Powerpc machine there is some IO memory which
>>>> will cause the box to hang if I read it. It's a custom device that was
>>>> added
>>>> to the board for a special purpose.
>>>>
>>>> I was looking for a way to exclude this memory from the dump, and while
>>>> doing that I found that kexec makes a list of memory segments that go
>>>> into
>>>> the core file. I was wondering why most of the kexec architecture don't
>>>> appear to exclude device memory like what's listed in /proc/iomem.
>>>>
>>>> Is there a good reason why that's not the case?
>>>>
>>>> Daniel
>>>
>>>
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>>
>>
>



-- 
Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
