Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dqfMF-0005kc-8w
 for kexec@lists.infradead.org; Sat, 09 Sep 2017 12:59:37 +0000
Received: by mail-qk0-x244.google.com with SMTP id r66so2831432qke.4
 for <kexec@lists.infradead.org>; Sat, 09 Sep 2017 05:59:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALKbUJSrLuY3QmHhJu_yHDFPvjqsLtm1-GbnO_tYECUdtyfb+g@mail.gmail.com>
References: <CALKbUJQCd3C1NPxXba5jb9QYPUbEYNnx_dywxTsP+Rnejbt6YA@mail.gmail.com>
 <CALKbUJTmkJV-bq1mnzqR5Q-RrX6OpSniTZd=z26QxqtJttPVMg@mail.gmail.com>
 <cdbaee7b-0173-5171-67ec-5f685c16776d@redhat.com>
 <CALKbUJSrLuY3QmHhJu_yHDFPvjqsLtm1-GbnO_tYECUdtyfb+g@mail.gmail.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Sat, 9 Sep 2017 18:29:13 +0530
Message-ID: <CAFTCetRY9o1ss3-DcYyz941Hj4Up90O_5tSBeb8uyRnh40=X6Q@mail.gmail.com>
Subject: Re: Fwd: zImage support for ppc
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
To: Sunil Kumar <sukumar@mvista.com>
Cc: kexec@lists.infradead.org

Hi Sunil,

On Fri, Sep 8, 2017 at 5:20 PM, Sunil Kumar <sukumar@mvista.com> wrote:
> Hi ,
>
> Thanks for replying Pratyush.
>
> I have also seen the zImage support is present for the ppc64, earlier
> my plan was to take this source as reference and port it for ppc.
> But in zImage_ppc64_usage() its clearly written that "zImage support
> is still broken", which stop me.
>
> Is the zImage for ppc64 working properly ? Should I trust this ?
>
> Asking this because I don't have hardware to test for ppc64.
>
> If anyone else used the ppc64 zImage as secondary kernel. please
> provide your inputs here.

I was recently experimenting with the kexec zImage support for both
ppc/ppc64 systems, but I do not find it working reliably on ppc64 on
Power8 machines as well.

I am looking to work on a fix for the ppc64 zImage support first
(since I have real hardware to test the same on) and also looking to
extend it to ppc32 (for which I have only qemu systems to test on).

I plan to share a RFC patchset in a week or so and would need your
help to test it on ppc32 boards like the p2020.

Regards,
Bhupesh

>
> On Fri, Sep 8, 2017 at 8:58 AM, Pratyush Anand <panand@redhat.com> wrote:
>>
>>
>> On Thursday 07 September 2017 01:49 PM, Sunil Kumar wrote:
>>>
>>> $ kexec -e
>>>
>>> As the zImage is also and elf file format, but the control is not
>>> getting transferred to the zImage.
>>> I can see kexec is able to load all the segments properly, but looks
>>> like its not able to figure out the entry point to start execution
>>> with zImage.
>>>
>>> -------------------------------------------------------------------------------------------------------------------------------------------------------
>>> kexec_load: entry = 0x329678 flags = 0x0
>>>
>>> -------------------------------------------------------------------------------------------------------------------------------------------------------
>>>
>>> On the same board (i.e. Freescale p2020ds), uImage and vmlinux works fine.
>>
>>
>> Looking into upstream code: ppc has only support of elf and uImage,and so
>> they work.
>>
>>>
>>> Just curious to know , why the zImage support is still not provided in
>>> the kexec for ppc ??
>>
>>
>> Probably because no one needed it till now.
>>
>>> Is there any restriction from kexec design point of view ?
>>
>>
>> I do not think. You can write a patch. I see, ppc64 has zImage support, so
>> you can take that as example and can write code for ppc as well.
>>
>> --
>> Regards
>> Pratyush
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
