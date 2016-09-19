Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bm19c-0006J9-Pn
 for kexec@lists.infradead.org; Mon, 19 Sep 2016 16:10:50 +0000
Received: by mail-io0-x234.google.com with SMTP id r145so96230292ior.0
 for <kexec@lists.infradead.org>; Mon, 19 Sep 2016 09:10:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57E00CDC.70403@arm.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <57DC1812.6040906@arm.com>
 <CAKv+Gu_UvFnPtFHggaO6Z_ePuArdchEK1qYWPkkwpcgLus3Epw@mail.gmail.com>
 <57E00CDC.70403@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 19 Sep 2016 17:10:27 +0100
Message-ID: <CAKv+Gu-pDS8C9uAkWq3mbuT2TZ9G6h-XTEd75fqaZv74kQ4WuQ@mail.gmail.com>
Subject: Re: [PATCH v26 0/7] arm64: add kdump support
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 19 September 2016 at 17:05, James Morse <james.morse@arm.com> wrote:
> On 16/09/16 21:17, Ard Biesheuvel wrote:
>> On 16 September 2016 at 17:04, James Morse <james.morse@arm.com> wrote:
>>> Mark, Ard, how does/will reserved-memory work on an APCI only system?
>>
>> It works by accident, at the moment. We used to ignore both
>> /memreserve/s and the /reserved-memory node, but due to some unrelated
>> refactoring, we ended up honouring the reserved-memory node when
>> booting via UEFI
>
> Okay, so kdump probably shouldn't rely on this behaviour...
>

No, but I would still like to keep /reserved-memory node support for
dynamic ranges, since they are guaranteed not to contain anything
'magic' left behind by the firmware. So if we keep /that/, keeping
static allocation support (with validation, as I proposed in the
series I quoted) is only a small step.

-- 
Ard.

> For an acpi-only system, we could get reserve_crashkernel() to copy the uefi
> memory map into the reserved region, changing the region types for existing
> kernel memory to EfiReservedMemoryType (for example) and fixing up the reserved
> region boundaries.
>
> This second memory map could then be added alongside the real one in the
> DT/chosen, and used in preference the second time we go through uefi_init() in
> the crash kernel.
>
> kexec-tools would still need to keep the '/reserved-memory' node for non-uefi
> systems.
>
> Doing this doesn't depend on userspace, and means the uefi memory map is still
> the one and only true source of memory layout information. If fixing it like
> this is valid I don't think it should block kdump.
>
> ... I will think about this some more before trying to put it together.
>
>
>
> Thanks,
>
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
