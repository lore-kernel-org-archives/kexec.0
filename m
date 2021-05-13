Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lh1rH-00Ayvl-4l
 for kexec@lists.infradead.org; Thu, 13 May 2021 03:17:56 +0000
Date: Thu, 13 May 2021 11:17:38 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/2] arm64: kexec_file_load vs memory reservations
Message-ID: <20210513031503.GC45898@dhcp-128-65.nay.redhat.com>
References: <20210429133533.1750721-1-maz@kernel.org>
 <87fsyroml3.wl-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87fsyroml3.wl-maz@kernel.org>
Content-Disposition: inline
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
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Moritz Fischer <mdf@kernel.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh Sharma <email.bhupesh@gmail.com>, Pingfan Liu <piliu@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kernel-team@android.com

Hi Marc,
On 05/12/21 at 07:04pm, Marc Zyngier wrote:
> + Dave Young, which I accidentally missed in my initial post
> 
> On Thu, 29 Apr 2021 14:35:31 +0100,
> Marc Zyngier <maz@kernel.org> wrote:
> > 
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
> > 
> > And in the meantime, it gets things going...
> > 
> > Marc Zyngier (2):
> >   firmware/efi: Tell memblock about EFI reservations
> >   ACPI: arm64: Reserve the ACPI tables in memblock
> > 
> >  arch/arm64/kernel/acpi.c   |  1 +
> >  drivers/firmware/efi/efi.c | 23 ++++++++++++++++++++++-
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> Any comment on this?
> 
> I've separately started working on using the resource tree to slice
> and dice the memblocks that are candidate for kexec_file_load(), but
> I'd like some consensus on whether this is the right way to address
> the issue.
> 
> Without something like this, kexec_file_load() is not usable on arm64,
> so I'm pretty eager to see the back of this bug.

The arm64 memory reservation is tricky, I do not think I understand it
correctly.  Previously there were a lot discussion, Ard and AKASHI
should know more about it, see if they can provide comments.

About the problem you see, another way is to just add an arch weak
function like powerpc: arch_kexec_locate_mem_hole, and walking resource
tree for kexec_file_load as well.  But I might be wrong since I did not
follow up the arm64 specific history.

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
