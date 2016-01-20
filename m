Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aLnhv-0001DQ-P4
 for kexec@lists.infradead.org; Wed, 20 Jan 2016 08:01:37 +0000
Received: by mail-pf0-x230.google.com with SMTP id q63so747786pfb.1
 for <kexec@lists.infradead.org>; Wed, 20 Jan 2016 00:01:12 -0800 (PST)
Subject: Re: [PATCH 18/19] arm64: kdump: update a kernel doc
References: <569CBDBC.5050500@linaro.org>
 <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org>
 <20160120063856.GA3725@dhcp-128-65.nay.redhat.com>
 <20160120070044.GF2999@dhcp-128-65.nay.redhat.com>
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Message-ID: <569F3EC2.4020807@linaro.org>
Date: Wed, 20 Jan 2016 17:01:06 +0900
MIME-Version: 1.0
In-Reply-To: <20160120070044.GF2999@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, ard.biesheuvel@linaro.org, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, James Morse <james.morse@arm.com>, christoffer.dall@linaro.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 01/20/2016 04:00 PM, Dave Young wrote:
>>> So I'm not still sure about what are advantages of a property under /chosen
>>> over "memmap=" kernel parameter.
>>> Both are simple and can have the same effect with minimizing changes to dtb.
>>> (But if, in the latter case, we have to provide *all* the memory-related information
>>> through "memmap=" parameters, it would be much complicated.)
>>
>> Maybe I did not say it clearly, I prefer kexec syscall/tool to modifiy dtb
>> or uefi-memmap so that we do not need any extra kernel cmdline.

Yes, I understand.
But on arm64, kexec-tools can generate a "memmap=" parameter for crash kernel's
memory region without any user's interaction.
(please note that this parameter eventually goes into dtb's cmdline property in
/chosen.)

In this sense, it is no different from an extra property under /chosen
as kexec-tools can also add it to dtb passed to the crash dump kernel.

(See what I mean?)

>> For x86 we would like to drop the memmap= usage in kexec-tools

I didn't know that :)

>> but we can not
>> do that for a compatibility problem about calgary iommu. So that currently
>> kexec-tools supports both recreating E820 maps and passing memmap=.
>>
>> We should think it carefully because it will be hard to remove once we support it.

Absolutely.

>> IMO handling it in code is better than using an external interface.
>
> Also seems semantic of memmap=exactmap is different than current use in the implementation
> exactmap means we need pass each range seperately including reserved, acpi and other types
> We can not reuse ranges in uefi memmap for other than usable memory.


If necessary, we may use a different name, say, "usablememmap=" for arm64
or just extend "mem=" semantics (allowing XX@YY format) to avoid any confusion.

Thanks,
-Takahiro AKASHI

> It will also have the cmdline array size issue.k
 >
> Thanks
> Dave
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
