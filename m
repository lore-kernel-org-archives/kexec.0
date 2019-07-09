Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hkdh8-0001U6-Dj
 for kexec@lists.infradead.org; Tue, 09 Jul 2019 00:09:20 +0000
Received: by mail-ed1-x541.google.com with SMTP id w13so16082209eds.4
 for <kexec@lists.infradead.org>; Mon, 08 Jul 2019 17:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
 <87sgrgjd6i.fsf@xmission.com>
In-Reply-To: <87sgrgjd6i.fsf@xmission.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 8 Jul 2019 20:09:04 -0400
Message-ID: <CA+CK2bAOPkN=qEdE38R0FRnrzRK0EqLid7eUVnTj1acmaFHY_w@mail.gmail.com>
Subject: Re: [v1 0/5] allow to reserve memory for normal kexec kernel
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net, Catalin Marinas <catalin.marinas@arm.com>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

> Something is very very wrong there.
>
> Last I measured memory bandwidth seriously I could touch a Gigabyte per
> second easily, and that was nearly 20 years ago.  Did you manage to
> disable caching or have some particularly slow code that does the
> reolocations.
>
> There is a serious cost to reserving memory in that it is simply not
> available at other times.  For kexec on panic there is no other reliable
> way to get memory that won't be DMA'd to.

Hi Eric,

Thank you for your comments.

Indeed, but sometimes fast reboot is more important than the cost of
reserving 32M-64M of memory.

>
> We have options in this case and I would strongly encourage you to track
> down why that copy in relocation is so very slow.  I suspect a 4KiB page
> size is large enough that it can swamp pointer following costs.
>
> My back of the napkin math says even 20 years ago your copying costs
> should be only 0.037s.  The only machine I have ever tested on where
> the copy costs were noticable was my old 386.
>
> Maybe I am out to lunch here but a claim that your memory only runs
> at 100MiB/s (the speed of my spinning rust hard drive) is rather
> incredible.

I agree,  my measurement on this machine was 2,857MB/s. Perhaps when
MMU is disabled ARM64 also has caching disabled? The function that
loops through array of pages and relocates them to final destination
is this:

https://soleen.com/source/xref/linux/arch/arm64/kernel/relocate_kernel.S?r=d2912cb1#29

A comment before calling it:

205   /*
206   * cpu_soft_restart will shutdown the MMU, disable data caches, then
207   * transfer control to the reboot_code_buffer which contains a copy of
208   * the arm64_relocate_new_kernel routine.  arm64_relocate_new_kernel
209   * uses physical addressing to relocate the new image to its final
210   * position and transfers control to the image entry point when the
211   * relocation is complete.
212   * In kexec case, kimage->start points to purgatory assuming that
213   * kernel entry and dtb address are embedded in purgatory by
214   * userspace (kexec-tools).
215   * In kexec_file case, the kernel starts directly without purgatory.
216   */
https://soleen.com/source/xref/linux/arch/arm64/kernel/machine_kexec.c?r=d2912cb1#206

So, as I understand at least data caches are disabled, and MMU is
disabled, perhaps this is why this function is so incredibly slow?

Perhaps, there is a better way to fix this problem by keeping caches
enabled while still relocating? Any suggestions from Aarch64
developers?

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
