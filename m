Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1drO9U-0007Jp-Hq
 for kexec@lists.infradead.org; Mon, 11 Sep 2017 12:49:33 +0000
Received: by mail-io0-x236.google.com with SMTP id d16so25271464ioj.3
 for <kexec@lists.infradead.org>; Mon, 11 Sep 2017 05:49:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFTCetRY9o1ss3-DcYyz941Hj4Up90O_5tSBeb8uyRnh40=X6Q@mail.gmail.com>
References: <CALKbUJQCd3C1NPxXba5jb9QYPUbEYNnx_dywxTsP+Rnejbt6YA@mail.gmail.com>
 <CALKbUJTmkJV-bq1mnzqR5Q-RrX6OpSniTZd=z26QxqtJttPVMg@mail.gmail.com>
 <cdbaee7b-0173-5171-67ec-5f685c16776d@redhat.com>
 <CALKbUJSrLuY3QmHhJu_yHDFPvjqsLtm1-GbnO_tYECUdtyfb+g@mail.gmail.com>
 <CAFTCetRY9o1ss3-DcYyz941Hj4Up90O_5tSBeb8uyRnh40=X6Q@mail.gmail.com>
From: Sunil Kumar <sukumar@mvista.com>
Date: Mon, 11 Sep 2017 18:18:22 +0530
Message-ID: <CALKbUJRqrYG_6xY63_0d1CSTQUpwK5dM=Q4ZHqNk-pwyQyJ=Jg@mail.gmail.com>
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
To: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc: kexec@lists.infradead.org

Hi,

Thanks Bhupesh for confirmation about the ppc64 zImage support.

As of now I am thinking of using 'uImage' as secondary kernel, because
porting zImage changes for ppc will take more time for me.

>>I plan to share a RFC patchset in a week or so and would need your
>> help to test it on ppc32 boards like the p2020.
Surely I will test it on p2020 once you release RFC patch.

Regards
Sunil Kumar
Thanks & Regards,
Sunil Kumar
Technical Lead
Montavista Software
Bengaluru, India - 560008
www.mvista.com | +91-80-67228800 [+8865]


On Sat, Sep 9, 2017 at 6:29 PM, Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
> Hi Sunil,
>
> On Fri, Sep 8, 2017 at 5:20 PM, Sunil Kumar <sukumar@mvista.com> wrote:
>> Hi ,
>>
>> Thanks for replying Pratyush.
>>
>> I have also seen the zImage support is present for the ppc64, earlier
>> my plan was to take this source as reference and port it for ppc.
>> But in zImage_ppc64_usage() its clearly written that "zImage support
>> is still broken", which stop me.
>>
>> Is the zImage for ppc64 working properly ? Should I trust this ?
>>
>> Asking this because I don't have hardware to test for ppc64.
>>
>> If anyone else used the ppc64 zImage as secondary kernel. please
>> provide your inputs here.
>
> I was recently experimenting with the kexec zImage support for both
> ppc/ppc64 systems, but I do not find it working reliably on ppc64 on
> Power8 machines as well.
>
> I am looking to work on a fix for the ppc64 zImage support first
> (since I have real hardware to test the same on) and also looking to
> extend it to ppc32 (for which I have only qemu systems to test on).
>
> I plan to share a RFC patchset in a week or so and would need your
> help to test it on ppc32 boards like the p2020.
>
> Regards,
> Bhupesh
>
>>
>> On Fri, Sep 8, 2017 at 8:58 AM, Pratyush Anand <panand@redhat.com> wrote:
>>>
>>>
>>> On Thursday 07 September 2017 01:49 PM, Sunil Kumar wrote:
>>>>
>>>> $ kexec -e
>>>>
>>>> As the zImage is also and elf file format, but the control is not
>>>> getting transferred to the zImage.
>>>> I can see kexec is able to load all the segments properly, but looks
>>>> like its not able to figure out the entry point to start execution
>>>> with zImage.
>>>>
>>>> -------------------------------------------------------------------------------------------------------------------------------------------------------
>>>> kexec_load: entry = 0x329678 flags = 0x0
>>>>
>>>> -------------------------------------------------------------------------------------------------------------------------------------------------------
>>>>
>>>> On the same board (i.e. Freescale p2020ds), uImage and vmlinux works fine.
>>>
>>>
>>> Looking into upstream code: ppc has only support of elf and uImage,and so
>>> they work.
>>>
>>>>
>>>> Just curious to know , why the zImage support is still not provided in
>>>> the kexec for ppc ??
>>>
>>>
>>> Probably because no one needed it till now.
>>>
>>>> Is there any restriction from kexec design point of view ?
>>>
>>>
>>> I do not think. You can write a patch. I see, ppc64 has zImage support, so
>>> you can take that as example and can write code for ppc as well.
>>>
>>> --
>>> Regards
>>> Pratyush
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
