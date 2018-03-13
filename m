Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1evhmE-0005ok-Hn
 for kexec@lists.infradead.org; Tue, 13 Mar 2018 11:07:32 +0000
Received: by mail-pl0-x243.google.com with SMTP id 61-v6so11093775plf.3
 for <kexec@lists.infradead.org>; Tue, 13 Mar 2018 04:07:19 -0700 (PDT)
Date: Tue, 13 Mar 2018 20:07:49 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [Query] ARM64 kaslr support - randomness, seeding and kdump
Message-ID: <20180313110747.GJ25863@linaro.org>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On Tue, Mar 13, 2018 at 10:47:15AM +0000, Mark Rutland wrote:
> On Tue, Mar 13, 2018 at 07:22:03PM +0900, AKASHI Takahiro wrote:
> > On Mon, Mar 12, 2018 at 08:58:00PM +0000, Ard Biesheuvel wrote:
> > > On 12 March 2018 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> 
> > More importantly, neither arm64 _kexec_ supports kaslr.
> 
> The below is just considering this, and ignoring kdump (where I don't
> think we care at all about KASLR).
> 
> > Currently kexec-tools is set to determine where the kernel actually be
> > loaded, using a constant offset, text_offset, which comes from an image's
> > boot header and relocation of an image to the load address is performed
> > at the very end of the first kernel without knowing whether the 2nd kernel
> > has kaslr support enabled or not.
> 
> The kexec tools shouldn't need to know whether the kernel supports KASLR
> at all.
> 
> If the new kernel image has bit 3 (Kernel physical placement) set, kexec
> tools can choose to randomize the physical load address, regardless of
> whether that kernel has KASLR enabled.

So, by definition, is randomness, if we say so, in physical address not
part of KASLR?

> Note that the bootloader is responsible for physical randomization, and
> the kernel is responsible for virtual randomization. It just happens
> that the EFI stub acts as a bootloader when we use EFI.
> 
> > > > B. Regarding the arm64 kaslr support in kdump (I have Cc'ed AKASHI and
> > > > kexec list in this thread as well for their inputs), but currently we
> > > > don't seem to have a way to support kaslr in arm64 kdump kernel:
> > > >
> > > > - '/chosen/kaslr-seed' a property is zeroed out in the primary kernel
> > 
> > So, even if adding /chosen/kaslr-seed to dtb at kexec would not be
> > difficult, we would have to have efi_entry-like entry code.
> 
> The kaslr-seed property is used for *virtual* randomization, so we don't
> need more code in the kernel for this. The kexec tools can populate this
> property if desired.

Hmm, so saving/re-using kaslr-seed of the 1st kernel, as Bhupesh hinted,
is not important, anyway.

-Takahiro AKASHI


> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
