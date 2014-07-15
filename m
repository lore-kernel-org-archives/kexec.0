Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X74fA-0008Rn-EQ
 for kexec@lists.infradead.org; Tue, 15 Jul 2014 15:29:05 +0000
Received: by mail-yk0-f182.google.com with SMTP id q9so1367254ykb.13
 for <kexec@lists.infradead.org>; Tue, 15 Jul 2014 08:28:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1405375504.23043.40.camel@smoke>
References: <CAFdej01jQFS3MrSdiQCWwv36qzG4L301w0iNJgGeunt-_44okA@mail.gmail.com>
 <CAFdej03ziTTA5QGFjzKd6Kc4skWNTr5RECy69qtnQGVtE6ks3w@mail.gmail.com>
 <1404931759.26155.70.camel@smoke>
 <CAFdej02yHmsoEpcXBkiEZ9NXvwy4KF_ajN=nmC=E1q+YniPr1A@mail.gmail.com>
 <1405375504.23043.40.camel@smoke>
Date: Tue, 15 Jul 2014 20:58:40 +0530
Message-ID: <CAFdej02tudZBS+COS8TN4uafEvDwjyscn91XS9z94UK1de=dCQ@mail.gmail.com>
Subject: Re: Kexec on arm64
From: Arun Chandran <achandran@mvista.com>
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

Hi Geoff,

I think we should better discuss this in the arm mailing list as it is getting
more arm64 specific.

I will post my reply there.

--Arun

On Tue, Jul 15, 2014 at 3:35 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Arun,
>
> On Fri, 2014-07-11 at 21:13 +0530, Arun Chandran wrote:
>> I tried kexec reboot with my modified kexec-tools and got a nice kernel panic.
>> Please find the error log attached.
>> There is only dtb file related change in the kernel sources, as given below.
>>
>> ###########
>>                         cpu-release-addr = <0x1 0x0000fff8>;
>> -                       cpu-return-addr = <0 0>
>> +                       cpu-return-addr = <0x0 0x0>;
>> ###########
>>
>> I just assigned a random value to "cpu-return-addr" in my dtb file;
>
> You need the proper cpu-return-addr value.  Because cpu-return-addr
> was zero, kexec sent all your secondary processors back to
> secondary_startup, and is why you see that in your error log.
>
> I put in a hack for zero cpu-return-addr in my latest version.  Please
> try it.  If you use the same kernel for both the 1st and 2nd stage it
> should work.
>
>> Do you have any idea how to find out that value for my hardware?
>
> It is a property of your bootloader, not hardware.  Ask your
> bootloader maintainer if you can, or check the bootloader sources.
>
> For the rtsm_ve_aemv8a model bootwrapper I set cpu-return-addr to
> <0x0 0x80000000> because the bootwrapper linker script puts _start
> at PHYS_OFFSET, which is 0x80000000 for that platform.
>
> https://git.kernel.org/cgit/linux/kernel/git/mark/boot-wrapper-aarch64.git/tree/model.lds.S#n30
>
>> My hardware uses spin-table method for SMP. As you said there
>> is a bug in kexec for spin-table method, what about trying it without
>> CONFIG_SMP? Does your code support that?
>
> CONFIG_SMP=n should work, but I haven't tried it in a long time.
>
> -Geoff
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
