Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 6 Nov 2014 15:08:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 00/10] arm64 kexec kernel patches V5
Message-ID: <20141106150846.GE23706@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
 <20141103194634.GA30366@leverpostej>
 <20141106015642.GA2569@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141106015642.GA2569@darkstar.nay.redhat.com>
Content-Language: en-US
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
To: Dave Young <dyoung@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Thu, Nov 06, 2014 at 01:56:42AM +0000, Dave Young wrote:
> On 11/03/14 at 07:46pm, Mark Rutland wrote:
> > On Fri, Oct 31, 2014 at 07:52:09AM +0000, Dave Young wrote:
> > > Hi Geoff
> > > 
> > > I tested your patches. The macihne is using spin-table cpu enable method
> > > so I tried maxcpus=1 as you suggested.
> > > 
> > > There's below issues for me, thoughts?
> > > 
> > > 1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
> > > to use.
> > 
> > Are you absolutely certain of this?
> > 
> > To use ACPI, you must have booted via EFI, as the only mechanism for
> > finding the ACPI tables is via EFI. If booted via EFI, the stub will
> > have created a stub DTB if there is no provided DTB, to pass the command
> > line and pointers to EFI data structures. This stub DTB should be
> > present in the usual place.
> 
> Mark, I used kexec-tools from Geoff's git tree, it will create dtb from procfs
> maybe I can pass external dtb to kexec-tools. What you mentioned should be true
> though but I have not get idea how to get the dtb which kernel is using for boot
> since it is not unflattened.

Ah, sorry. I see the problem now. For ACPI you don't unflatten the tree,
so there's nothing to expose at in sysfs/procfs.

Somehow we need to unflatten the DTB without exposing it to drivers,
such that it can be exposed to userspace in the usual place but drivers
don't being probing based off of it.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
