Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xmh2k-0004iX-Vx
 for kexec@lists.infradead.org; Fri, 07 Nov 2014 10:45:28 +0000
Received: by mail-lb0-f182.google.com with SMTP id f15so2713588lbj.13
 for <kexec@lists.infradead.org>; Fri, 07 Nov 2014 02:45:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9kJ6GHcPm9fa6m84gse9DQat6D54zFD0G0X9od=sYVpw@mail.gmail.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
 <20141103194634.GA30366@leverpostej>
 <20141106015642.GA2569@darkstar.nay.redhat.com>
 <20141106150846.GE23706@leverpostej>
 <CACxGe6u=J_k3XZxyiyti=i=rtW+a5xxuukg3TgOyM+ra1vAACQ@mail.gmail.com>
 <20141107101642.GA4585@leverpostej>
 <CAKv+Gu9kJ6GHcPm9fa6m84gse9DQat6D54zFD0G0X9od=sYVpw@mail.gmail.com>
Date: Fri, 7 Nov 2014 11:45:04 +0100
Message-ID: <CAKv+Gu_uOJPHw0YX_uZVbpmLo+=vhp-PURCDbUgiLXdh5w53aQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] arm64 kexec kernel patches V5
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
Cc: Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Leif Lindholm <leif.lindholm@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>, Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On 7 November 2014 11:41, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 7 November 2014 11:16, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Fri, Nov 07, 2014 at 12:41:45AM +0000, Grant Likely wrote:
>>> On Thu, Nov 6, 2014 at 3:08 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> > On Thu, Nov 06, 2014 at 01:56:42AM +0000, Dave Young wrote:
>>> >> On 11/03/14 at 07:46pm, Mark Rutland wrote:
>>> >> > On Fri, Oct 31, 2014 at 07:52:09AM +0000, Dave Young wrote:
>>> >> > > Hi Geoff
>>> >> > >
>>> >> > > I tested your patches. The macihne is using spin-table cpu enable method
>>> >> > > so I tried maxcpus=1 as you suggested.
>>> >> > >
>>> >> > > There's below issues for me, thoughts?
>>> >> > >
>>> >> > > 1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
>>> >> > > to use.
>>> >> >
>>> >> > Are you absolutely certain of this?
>>> >> >
>>> >> > To use ACPI, you must have booted via EFI, as the only mechanism for
>>> >> > finding the ACPI tables is via EFI. If booted via EFI, the stub will
>>> >> > have created a stub DTB if there is no provided DTB, to pass the command
>>> >> > line and pointers to EFI data structures. This stub DTB should be
>>> >> > present in the usual place.
>>> >>
>>> >> Mark, I used kexec-tools from Geoff's git tree, it will create dtb from procfs
>>> >> maybe I can pass external dtb to kexec-tools. What you mentioned should be true
>>> >> though but I have not get idea how to get the dtb which kernel is using for boot
>>> >> since it is not unflattened.
>>> >
>>> > Ah, sorry. I see the problem now. For ACPI you don't unflatten the tree,
>>> > so there's nothing to expose at in sysfs/procfs.
>>> >
>>> > Somehow we need to unflatten the DTB without exposing it to drivers,
>>> > such that it can be exposed to userspace in the usual place but drivers
>>> > don't being probing based off of it.
>>>
>>> Is that even necessary? If the tree isn't unflattened, then it is just
>>> a stub tree. There really isn't anything interesting in it.
>>
>> We need to UEFI properties [1] from /chosen to access the memory map and
>> system table (both of which are necessary to access any ACPI tables).
>>
>>> Kexec should recreate the tree from scratch in that case.
>>
>> I'm not sure if the required information is exposed to userspace
>> elsewhere. Ard, Leif?
>>
>
> Personally, I think we should not be using /proc/device-tree at all,
> but instead retain the original blob in some way and expose that.
>
> We already have /sys/firmware/efi/systab which contains the physical
> addresses of the UEFI configuration tables. We should probably add an
> entry for the FDT there anyway, but we would still be looking at
> mmap(/dev/mem) to access it, which is not a practice we want to
> encourage, I suppose.
>

Nah, strike that. The configuration table entry contains the original
fdt, so with the device nodes etc still present. The stub makes
changes to the DTB, and /that/ is the version we want to retain so
subsequent kexec reboots can use it.

> Also, we *must* take the secure boot scenario into account. Booting
> with an arbitrary user generated DTB is nice, but if you are doing
> kexec without an initrd, for instance, it would also be nice if we
> could just reuse the existing DTB without bothering the user for it at
> all, which would be something we could also allow when running
> securely.
>
> --
> Ard.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
