Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hTCis-0002Q1-8Q
 for kexec@lists.infradead.org; Tue, 21 May 2019 21:55:03 +0000
Received: by mail-pg1-x541.google.com with SMTP id t187so154980pgb.13
 for <kexec@lists.infradead.org>; Tue, 21 May 2019 14:55:01 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv> <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv> <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv> <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514033338.GA6612@MiWiFi-R3L-srv>
From: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Message-ID: <c640061a-a7c5-5bc3-87b6-0ee7af5a4b43@netronome.com>
Date: Tue, 21 May 2019 14:53:52 -0700
MIME-Version: 1.0
In-Reply-To: <20190514033338.GA6612@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, j-nomura@ce.jp.nec.com
Cc: fanc.fnst@cn.fujitsu.com, kasong@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, tglx@linutronix.de


On 5/13/19 8:33 PM, Baoquan He wrote:
> On 05/14/19 at 11:22am, Dave Young wrote:
>> On 05/13/19 at 04:06pm, Baoquan He wrote:
>>> Hi Dave,
>>>
>>> On 05/13/19 at 09:50am, Borislav Petkov wrote:
>>>> On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
>>>>> This is a critical bug which breaks memory hotplug,
>>>> Please concentrate and stop the blabla:
>>>>
>>>> 36f0c423552d ("x86/boot: Disable RSDP parsing temporarily")
>>>>
>>>> already explains what the deal is. This code was *purposefully* disabled
>>>> because we ran out of time and it broke a couple of machines. Don't make
>>> I remember your machine is the one on whihc the issue is reported. Could
>>> you also test it and confirm if these all things found ealier are
>>> cleared out?
>>>
>> I did some tests on the laptop,  thing is:
>> 1. apply the 3 patches (two you posted + Boris's revert commit 52b922c3d49c)
>>     on latest Linus master branch, everything works fine.
>>
>> 2. build and test the tip/next-merge-window branch, kernel hangs early
>> without output, (both 1st boot and kexec boot)
> Thanks, Dave.
>
> Yeah, I also tested on a HP machine, problem reprodued on the current
> master branch when revert commit 52b922c3d49c.
>
> Then apply these two patches, problem solved.
>
> Tried boris's next-merge-window branch too, kexec works very well.
>
> Dirk, Junichi, feel free to add your test result if you have time.


I tested this with the patches (plus revert of the workaround) applied 
against stable 5.1 and it works fine for me there. Thanks!

Where can I find the next-merge-window tree?

I can test against that too.


Best regards

Dirk


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
