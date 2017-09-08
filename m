Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dqHom-0003il-81
 for kexec@lists.infradead.org; Fri, 08 Sep 2017 11:51:30 +0000
Received: by mail-oi0-x229.google.com with SMTP id l74so9109360oih.1
 for <kexec@lists.infradead.org>; Fri, 08 Sep 2017 04:51:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cdbaee7b-0173-5171-67ec-5f685c16776d@redhat.com>
References: <CALKbUJQCd3C1NPxXba5jb9QYPUbEYNnx_dywxTsP+Rnejbt6YA@mail.gmail.com>
 <CALKbUJTmkJV-bq1mnzqR5Q-RrX6OpSniTZd=z26QxqtJttPVMg@mail.gmail.com>
 <cdbaee7b-0173-5171-67ec-5f685c16776d@redhat.com>
From: Sunil Kumar <sukumar@mvista.com>
Date: Fri, 8 Sep 2017 17:20:26 +0530
Message-ID: <CALKbUJSrLuY3QmHhJu_yHDFPvjqsLtm1-GbnO_tYECUdtyfb+g@mail.gmail.com>
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
To: kexec@lists.infradead.org

Hi ,

Thanks for replying Pratyush.

I have also seen the zImage support is present for the ppc64, earlier
my plan was to take this source as reference and port it for ppc.
But in zImage_ppc64_usage() its clearly written that "zImage support
is still broken", which stop me.

Is the zImage for ppc64 working properly ? Should I trust this ?

Asking this because I don't have hardware to test for ppc64.

If anyone else used the ppc64 zImage as secondary kernel. please
provide your inputs here.

Regards
Sunil Kumar
Thanks & Regards,
Sunil Kumar
Technical Lead
Montavista Software
Bengaluru, India - 560008
www.mvista.com | +91-80-67228800 [+8865]


On Fri, Sep 8, 2017 at 8:58 AM, Pratyush Anand <panand@redhat.com> wrote:
>
>
> On Thursday 07 September 2017 01:49 PM, Sunil Kumar wrote:
>>
>> $ kexec -e
>>
>> As the zImage is also and elf file format, but the control is not
>> getting transferred to the zImage.
>> I can see kexec is able to load all the segments properly, but looks
>> like its not able to figure out the entry point to start execution
>> with zImage.
>>
>> -------------------------------------------------------------------------------------------------------------------------------------------------------
>> kexec_load: entry = 0x329678 flags = 0x0
>>
>> -------------------------------------------------------------------------------------------------------------------------------------------------------
>>
>> On the same board (i.e. Freescale p2020ds), uImage and vmlinux works fine.
>
>
> Looking into upstream code: ppc has only support of elf and uImage,and so
> they work.
>
>>
>> Just curious to know , why the zImage support is still not provided in
>> the kexec for ppc ??
>
>
> Probably because no one needed it till now.
>
>> Is there any restriction from kexec design point of view ?
>
>
> I do not think. You can write a patch. I see, ppc64 has zImage support, so
> you can take that as example and can write code for ppc as well.
>
> --
> Regards
> Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
