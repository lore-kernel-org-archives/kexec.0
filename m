Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fdqxo-00054u-Ot
 for kexec@lists.infradead.org; Fri, 13 Jul 2018 05:49:58 +0000
Received: by mail-it0-x241.google.com with SMTP id 188-v6so9960259ita.5
 for <kexec@lists.infradead.org>; Thu, 12 Jul 2018 22:49:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180713003434.GZ28220@linaro.org>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180712164918.GA26935@arm.com> <20180713003434.GZ28220@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 13 Jul 2018 07:49:45 +0200
Message-ID: <CAKv+Gu9PT75XTXGsh1jc5roRO_d2QYKEamq42mfbsXzmerAUzA@mail.gmail.com>
Subject: Re: [PATCH v3.1 0/4] arm64: kexec,kdump: fix boot failures on
 acpi-only system
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Bhupesh Sharma <bhsharma@redhat.com>, Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, Al Stone <al.stone@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>

On 13 July 2018 at 02:34, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> On Thu, Jul 12, 2018 at 05:49:19PM +0100, Will Deacon wrote:
>> Hi Akashi,
>>
>> On Tue, Jul 10, 2018 at 08:42:25AM +0900, AKASHI Takahiro wrote:
>> > This patch series is a set of bug fixes to address kexec/kdump
>> > failures which are sometimes observed on ACPI-only system and reported
>> > in LAK-ML before.
>>
>> I tried picking this up, along with Ard's fixup, but I'm seeing a build
>> failure for allmodconfig:
>>
>> arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
>> acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'
>>
>> I didn't investigate further. Please can you fix this?
>
> Because CONFIG_ACPI is on and CONFIG_EFI is off.
>
> This can happen in allmodconfig as CONFIG_EFI depends on
> !CONFIG_CPU_BIG_ENDIAN, which is actually on in this case.
>

Allowing both CONFIG_ACPI and CONFIG_CPU_BIG_ENDIAN to be configured
makes no sense at all. Things will surely break if you start using BE
memory accesses while parsing ACPI tables.

Allowing CONFIG_ACPI without CONFIG_EFI makes no sense either, since
on arm64, the only way to find the ACPI tables is through a UEFI
configuration table.

> Looking at __acpi_get_mem_attributes(), since there is no information
> available on memory attributes, what we can do at best is
>   * return PAGE_KERNEL (= cacheable) for mapped memory,
>   * return DEVICE_nGnRnE (= non-cacheable) otherwise
> (See a hunk to be applied on top of my patch#4.)
>
> I think that, after applying, acpi_os_ioremap() would work almost
> in the same way as the original before my patchset given that
> MAP memblock attribute is used only under CONFIG_EFI for now.
>
> Make sense?
>

Let's keep your code as is but fix the Kconfig dependencies instead.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
