Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fUn9h-0002z8-00
 for kexec@lists.infradead.org; Mon, 18 Jun 2018 05:56:46 +0000
Received: by mail-pg0-x243.google.com with SMTP id l65-v6so7006377pgl.8
 for <kexec@lists.infradead.org>; Sun, 17 Jun 2018 22:56:34 -0700 (PDT)
Date: Mon, 18 Jun 2018 14:57:12 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 0/3] arm64: kexec,kdump: fix boot failures on acpi-only
 system
Message-ID: <20180618055711.GE23681@linaro.org>
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
 <81a9a385-3b9f-113d-96f0-379be74c19f0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81a9a385-3b9f-113d-96f0-379be74c19f0@arm.com>
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
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, al.stone@linaro.org, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, tbaicar@codeaurora.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, akpm@linux-foundation.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

James,

Thank you for follow-up explanation.
I have nothing to add :)

-Takahiro AKASHI

On Fri, Jun 15, 2018 at 05:29:32PM +0100, James Morse wrote:
> Hi Akashi,
> 
> Thanks for putting this together,
> 
> On 15/06/18 08:56, AKASHI Takahiro wrote:
> > This patch series is a set of bug fixes to address kexec/kdump
> > failures which are sometimes observed on ACPI-only system and reported
> > in LAK-ML before.
> > 
> > In short, the phenomena are:
> > 1. kexec'ed kernel can fail to boot because some ACPI table is corrupted
> >    by a new kernel (or other data) being loaded into System RAM. Currently
> >    kexec may possibly allocate space ignoring such "reserved" regions.
> >    We will see no messages after "Bye!"
> > 
> > 2. crash dump (kdump) kernel can fail to boot and get into panic due to
> >    an alignment fault when accessing ACPI tables. This can happen because
> >    those tables are not always properly aligned while they are mapped
> >    non-cacheable (ioremap'ed) as they are not recognized as part of System
> >    RAM under the current implementation.
> > 
> > After discussing several possibilities to address those issues,
> > the agreed approach, in my understanding, is
> > * to add resource entries for every "reserved", i.e. memblock_reserve(),
> >   regions to /proc/iomem.
> >   (NOMAP regions, also marked as "reserved," remains at top-level for
> >   backward compatibility.)
> 
> This means user-space can tell the difference between reserved-system-ram and
> reserved-address-space.
> 
> 
> > * For case (1), user space (kexec-tools) should rule out such regions
> >   in searching for free space for loaded data.
> 
> ... but doesn't today, because it fails to account for second-level entries.
> We've always had second-level entries, so this is a user-space bug. We need both
> fixed to fix the issue.
> 
> Our attempts to fix this just in the kernel reached a dead end, because Kdump
> needs to include reserved-system-ram, whereas kexec has to avoid it. User-space
> needs to be able to tell reserved-system-ram and reserved-address-space apart.
> Hence we need to expose that information, and pick it up in user-space.
> 
> Patched-kernel and unpatch-user-space will work the same way it does today, as
> the additional reserved regions are ignored by user-space.
> 
> Unpatched-kernel and patched-user-space will also work the same way it does
> today as the additional reserved regions are missing.
> 
> I think this is the only way forwards on this issue...
> 
> 
> > * For case (2), the kernel should access ACPI tables by mapping
> >   them with appropriate memory attributes described in UEFI memory map.
> >   (This means that it doesn't require any changes in /proc/iomem, and
> >   hence user space.)
> 
> (this one is handled entirely in the kernel)
> 
> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
