Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1evUWL-0003Nc-DT
 for kexec@lists.infradead.org; Mon, 12 Mar 2018 20:58:15 +0000
Received: by mail-it0-x244.google.com with SMTP id n136so12952170itg.5
 for <kexec@lists.infradead.org>; Mon, 12 Mar 2018 13:58:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 12 Mar 2018 20:58:00 +0000
Message-ID: <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
Subject: Re: [Query] ARM64 kaslr support - randomness, seeding and kdump
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 12 March 2018 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> Hi Ard,
>
> I remember we had a discussion on this topic some time ago, but I was
> working on enabling KASLR support on arm64 boards internally and
> wanted to check your opinion on the following points (especially to
> understand if there are any changes in the opinions of the ARM
> maintainers now):
>
> A. Randomness / Seeding for arm64 kaslr:
>
> - Currently the arm64 kernel requires a bootloader to provide entropy,
> by passing a
>  random u64 value in '/chosen/kaslr-seed' at kernel entry (please see [1])
>
> - On platforms which support UEFI firmware, its the responsibility of
> the UEFI firmware to implement EFI_RNG_PROTOCOL to supply the
> '/chosen/kaslr-seed' property.
>
> - I was wondering if we have any possibility to support a random seed
> generation like the x86 in the efistub only rather than relying on the
> UEFI firmwares with EFI_RNG_PROTOCOL for the same - for e.g. by using
> a randomness seed like the boot time or more proper entropy sources
> like arm64 system timer (see [2] for x86 example).
>
> - I guess that the main problem is that most arm64 UEFI firmware
> vendors still do not support EFI_RNG_PROTOCOL out of the box. We can
> use the ChaosKey (see [3]) EFI driver and use this USB key as the
> source of entropy on the arm64 systems for EFI firmwares which do not
> provide a EFI_RNG_PROTOCOL implementation, but it might not be very
> feasible to connect it to all boards in a production environment.
>

The problem is that arm64 does not have an architected means of
obtaining entropy, and we shouldn't rely on hacks to get pseudo
entropy.

Note that EFI_RNG_PROTOCOL is not only used for KASLR, it is also used
to seed the kernel entropy pool if the firmware provides an
implementation of the protocol.

Any UEFI system that can boot off USB should be able to use the
ChaosKey as well, but the best approach is obviously to implement
EFI_RNG_PROTOCOL natively if the platform has an entropy source
available.

If a platform vendor wants to hack something up based on the timer or
the performance counter, they are free to do so. But that doesn't mean
we should implement anything along those lines in the kernel.

> B. Regarding the arm64 kaslr support in kdump (I have Cc'ed AKASHI and
> kexec list in this thread as well for their inputs), but currently we
> don't seem to have a way to support kaslr in arm64 kdump kernel:
>
> - '/chosen/kaslr-seed' a property is zeroed out in the primary kernel
> (to avoid leaking out randomness secret), but how should this be then
> handed over to the kdump kernel.
> - We pass the dtb over to the kdump kernel for arm64 kdump, but the
> '/chosen/kaslr-seed' property would be zeroed out already by the
> primary kernel and the secondary would work in a *nokaslr* environment
> due to the same (see [4] for example)
>

What would be the point of randomizing the placement of the kdump
kernel? And don't say 'because x86 does it', because that is not a
good reason.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
