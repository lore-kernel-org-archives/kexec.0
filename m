Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj0cz-00Ej2Y-8O
 for kexec@lists.infradead.org; Tue, 18 May 2021 14:23:22 +0000
Received: by mail-ot1-x32b.google.com with SMTP id
 n32-20020a9d1ea30000b02902a53d6ad4bdso8779678otn.3
 for <kexec@lists.infradead.org>; Tue, 18 May 2021 07:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210429133533.1750721-1-maz@kernel.org>
 <20210518114857.GA7914@willie-the-truck>
In-Reply-To: <20210518114857.GA7914@willie-the-truck>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Tue, 18 May 2021 19:53:08 +0530
Message-ID: <CAH=2NtwisNNBSN75-78AAFeW23oM-_zFqHdqw9YTcmQg5zRofQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: kexec_file_load vs memory reservations
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
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kernel-team@android.com

Hi Will,

On Tue, 18 May 2021 at 17:19, Will Deacon <will@kernel.org> wrote:
>
> [Fixing Bhupesh's email address]
>
> On Thu, Apr 29, 2021 at 02:35:31PM +0100, Marc Zyngier wrote:
> > It recently became apparent that using kexec with kexec_file_load() on
> > arm64 is pretty similar to playing Russian roulette.
> >
> > Depending on the amount of memory, the HW supported and the firmware
> > interface used, your secondary kernel may overwrite critical memory
> > regions without which the secondary kernel cannot boot (the GICv3 LPI
> > tables being a prime example of such reserved regions).
> >
> > It turns out that there is at least two ways for reserved memory
> > regions to be described to kexec: /proc/iomem for the userspace
> > implementation, and memblock.reserved for kexec_file. And of course,
> > our LPI tables are only reserved using the resource tree, leading to
> > the aforementioned stamping. Similar things could happen with ACPI
> > tables as well.
> >
> > On my 24xA53 system artificially limited to 256MB of RAM (yes, it
> > boots with that little memory), trying to kexec a secondary kernel
> > failed every times. I can only presume that this was mostly tested
> > using kdump, which preserves the entire kernel memory range.
> >
> > This small series aims at triggering a discussion on what are the
> > expectations for kexec_file, and whether we should unify the two
> > reservation mechanisms.
>
> Bhupesh, since you've been involved with kexec file on arm64 before, please
> could you take a look at these patches?

Thanks for adding me in Cc.
Yes, I will look and test these patches asap.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
