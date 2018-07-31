Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fkRgx-0002j1-Dn
 for kexec@lists.infradead.org; Tue, 31 Jul 2018 10:15:50 +0000
Received: by mail-lj1-f196.google.com with SMTP id w16-v6so9614747ljh.12
 for <kexec@lists.infradead.org>; Tue, 31 Jul 2018 03:15:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180731092629.GD4680@arm.com>
References: <1532931883-16132-1-git-send-email-bhsharma@redhat.com>
 <303e32f7-ff47-ea9b-d5a0-45a22e44d0a9@arm.com> <20180731092629.GD4680@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 31 Jul 2018 15:45:33 +0530
Message-ID: <CACi5LpMkuq78Vn6uncZ=StR8dSHzptiZnT9mmQR+OcaLv-ck_Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64, kaslr: export offset in VMCOREINFO ELF notes
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
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Will, James,

On Tue, Jul 31, 2018 at 2:56 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 31, 2018 at 10:19:35AM +0100, James Morse wrote:
>> Hi Bhupesh,
>>
>> On 30/07/18 07:24, Bhupesh Sharma wrote:
>> > Include KASLR offset in arm64 VMCOREINFO ELF notes to assist in
>> > debugging. vmcore parsing in user-space already expects this value in
>> > the notes and we are providing it for portability of those existing
>> > tools with x86.
>> >
>> > Ideally we would like core code to do this (so that way this
>> > information won't be missed when an architecture adds KASLR support),
>> > but mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
>> > so I am not sure if this is needed for mips (and other such similar arch
>> > cases in future). So, lets keep this architecture specific for now.
>>
>> (heh, I assumed you would rewrite my train-of-thought, but I guess this works!)
>>
>>
>> > As an example of a user-space use-case, consider the
>> > makedumpfile user-space utility which will need fixup to use this
>> > KASLR offset to work with cases where we need to find a way to
>> > translate symbol address from vmlinux to kernel run time address
>> > in case of KASLR boot on arm64.
>>
>> Acked-by: James Morse <james.morse@arm.com>

Thanks James.

>> If we want to send this to stable, it looks like it should have been part of the
>> KASLR series, f80fb3a3d5084 ("arm64: add support for kernel ASLR") was merged
>> for v4.6.
>> CC: <stable@vger.kernel.org> # 4.6.x
>
> Hmm, does this warrant a stable backport? This hasn't ever worked, right?

Yes, it is a new feature being enabled/tested in user-space utilities
now for arm64 (although it's being used for x86_64 since some time).

I would like the user-space utilities to do away with the arch
specific code (as much as possible) for KASLR features, but we are
still kind of stabilizing the same on various archs, so the user-space
cleanup is one of items on my to-do list.

However, since kernel and user-space features are frequently
backported to older versions (e.g. RHEL and OpenSuse), so it would
help to send this patch to stable as well, so that stable kernels >=
4.6.x can work well with such backported user-space utilities and
utilize KASLR features on arm64 well.

As such, I see no side-effect of adding this information to the
vmcoreinfo in the stable kernels as well.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
