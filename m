Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dGjIn-0000wE-K2
 for kexec@lists.infradead.org; Fri, 02 Jun 2017 09:55:31 +0000
Received: by mail-it0-x22c.google.com with SMTP id m47so1204049iti.1
 for <kexec@lists.infradead.org>; Fri, 02 Jun 2017 02:55:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <59312080.1090906@arm.com>
References: <cover.1495514291.git.panand@redhat.com> <59312080.1090906@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 2 Jun 2017 09:55:07 +0000
Message-ID: <CAKv+Gu--N4Pef6z=G4ePTgF3CcKhmmSfrvJBY-5p0CLL_PZ=3Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
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
Cc: Pratyush Anand <panand@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2 June 2017 at 08:23, James Morse <james.morse@arm.com> wrote:
> Hi Pratyush,
>
> On 23/05/17 06:02, Pratyush Anand wrote:
>> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
>> is around 13MB and initramfs is around 30MB. It takes more than 20 second
>> even when we have -O2 optimization enabled. However, if dcache is enabled
>> during purgatory execution then, it takes just a second in SHA
>> verification.
>>
>> Therefore, these patches adds support for dcache enabling facility during
>> purgatory execution.
>
> I'm still not convinced we need this. Moving the SHA verification to happen
> before the dcache+mmu are disabled would also solve the delay problem, and we
> can print an error message or fail the syscall.
>
> For kexec we don't expect memory corruption, what are we testing for?

This is a very good question. SHA-256 is quite a heavy hammer if all
you need is CRC style error detection. Note that SHA-256 uses 256
bytes of round keys, which means that in the absence of a cache, each
64 byte chunk of data processed involves (re)reading 320 bytes from
DRAM. That also means you could write a SHA-256 implementation for
AArch64 that keeps the round keys in NEON registers instead, and it
would probably be a lot faster.

> I can see the use for kdump, but the kdump-kernel is unmapped so the kernel
> can't accidentally write over it.
>
> (we discussed all this last time, but it fizzled-out. If you and the
>  kexec-tools maintainer think its necessary, fine by me!)
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
