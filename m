Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2XEZ-0003kR-S6
 for kexec@lists.infradead.org; Tue, 27 Aug 2019 08:53:49 +0000
Received: by mail-ed1-x544.google.com with SMTP id z51so30263713edz.13
 for <kexec@lists.infradead.org>; Tue, 27 Aug 2019 01:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
 <20190826201313.246208e9@why>
 <CA+CK2bAS-jDwY-qKfZQD8TbvyAhS1+rBvcxGqkR4BHd5NR5BGQ@mail.gmail.com>
 <d7461fb3-0f6d-8abf-084d-ce0be1f1a18d@kernel.org>
In-Reply-To: <d7461fb3-0f6d-8abf-084d-ce0be1f1a18d@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 27 Aug 2019 04:53:35 -0400
Message-ID: <CA+CK2bAk4Xb_hxh2KLxWKa8ogM-jO1MpREmc02TmUMpdJ2ZbSA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Allow kexec reboot for GICv3 and device tree
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
To: Marc Zyngier <maz@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, kexec mailing list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

> > Running Linux without EFI is common, and there are scenarios which
> > make it appropriate. As I understand most of embedded linux do not
> > have EFI enabled, and thus I do not see a reason why we would not
> > support a first class feature of Linux (kexec) on non-EFI bootloaders.
>
> Define "most". All the arm64 systems I have around (and trust me, that's
> quite a number of them) can either use u-boot, which has more than
> enough EFI support to use this functionality, or use EDK-II natively.

OK. Is this the most common configuration in the embedded ARM64
devices currently deployed: phones, cameras, consoles, players, etc?

> > We (Microsoft) have a small highly secure device with a high uptime
> > requirement. The device also has PCIe and thus GICv3. The update for
>
> PCIe doesn't imply GICv3 at all.

My impression was that without PCIe GICv3 is rarely used, and this
could be the reason why this problem is not seen outside of larger
machines which normally have EFI enabled.

>
> > this device relies on kexec. For a number of reasons, it was decided
> > to use U-Boot and Linux without EFI enabled. One of those reasons is
> > to improve boot performance, enabling EFI in U-Boot alone reduces the
> > boot performance by half a second. Our total reboot budget is under a
> > second which makes that half a second unacceptable. Also, adding EFI
> > support to kernel increases its size and there are security
> > implications from enabling more code both in U-Boot and Linux.
>
> You're are missing the point. kexec with EFI has 0 overhead (no
> non-kernel EFI code gets executed), doesn't impact your time budget, and
> only relies on a single in-memory table. This can be pretty trivially
> provided by the dumbest EFI shim.

Thanks, this makes sense that the Linux boot time won't be affected. I
have not tested how u-boot was affected, but was told 0.5 second
longer to start.

> All you are describing above is a set of self imposed limitations in
> your bootloader, which you are fully in control of. So instead of
> reinventing a square wheel, I suggest you adopt the existing implementation.

I am not sure this analogy is correct, I do not think that non-EFI
enabled kernels became legacy.

> Another reason not to do this is interoperability: I want to be able to
> kexec whatever Linux kernel I want, without having to cope with all
> flavours of the same functionality. Effectively, the EFI table is a
> private ABI between two Linux kernels. We're not changing it.

This is exactly the problem: by having this region defined in signed
DTB file we reduce the amount of communication between the kernels.
Passing modified EFI Table causes us to pass more information from the
first kernel indefinitely through updates. Thus, increases a chance
for a security compromise. We are not changing EFI ABI between
kernels, it will stay as is. All this code does is enables kernels
that do not have EFI table communication between them a way to do
kexec updates with reduced amount of data exchange.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
