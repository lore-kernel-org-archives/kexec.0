Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XmXdE-0003LU-IA
 for kexec@lists.infradead.org; Fri, 07 Nov 2014 00:42:29 +0000
Received: by mail-ie0-f176.google.com with SMTP id rd18so4064031iec.7
 for <kexec@lists.infradead.org>; Thu, 06 Nov 2014 16:42:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141106150846.GE23706@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
 <20141103194634.GA30366@leverpostej>
 <20141106015642.GA2569@darkstar.nay.redhat.com>
 <20141106150846.GE23706@leverpostej>
From: Grant Likely <grant.likely@linaro.org>
Date: Fri, 7 Nov 2014 00:41:45 +0000
Message-ID: <CACxGe6u=J_k3XZxyiyti=i=rtW+a5xxuukg3TgOyM+ra1vAACQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] arm64 kexec kernel patches V5
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
Cc: Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Thu, Nov 6, 2014 at 3:08 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Nov 06, 2014 at 01:56:42AM +0000, Dave Young wrote:
>> On 11/03/14 at 07:46pm, Mark Rutland wrote:
>> > On Fri, Oct 31, 2014 at 07:52:09AM +0000, Dave Young wrote:
>> > > Hi Geoff
>> > >
>> > > I tested your patches. The macihne is using spin-table cpu enable method
>> > > so I tried maxcpus=1 as you suggested.
>> > >
>> > > There's below issues for me, thoughts?
>> > >
>> > > 1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
>> > > to use.
>> >
>> > Are you absolutely certain of this?
>> >
>> > To use ACPI, you must have booted via EFI, as the only mechanism for
>> > finding the ACPI tables is via EFI. If booted via EFI, the stub will
>> > have created a stub DTB if there is no provided DTB, to pass the command
>> > line and pointers to EFI data structures. This stub DTB should be
>> > present in the usual place.
>>
>> Mark, I used kexec-tools from Geoff's git tree, it will create dtb from procfs
>> maybe I can pass external dtb to kexec-tools. What you mentioned should be true
>> though but I have not get idea how to get the dtb which kernel is using for boot
>> since it is not unflattened.
>
> Ah, sorry. I see the problem now. For ACPI you don't unflatten the tree,
> so there's nothing to expose at in sysfs/procfs.
>
> Somehow we need to unflatten the DTB without exposing it to drivers,
> such that it can be exposed to userspace in the usual place but drivers
> don't being probing based off of it.

Is that even necessary? If the tree isn't unflattened, then it is just
a stub tree. There really isn't anything interesting in it. Kexec
should recreate the tree from scratch in that case.

g.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
