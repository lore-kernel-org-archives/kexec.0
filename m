Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 4 Nov 2014 11:35:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 05/10] arm64: Convert dts to use reserved-memory nodes
Message-ID: <20141104113542.GC31371@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <411296ab915959b862923d827e730a1db2ff9b4e.1414099246.git.geoff@infradead.org>
 <20141024105111.GD24265@leverpostej>
 <CACxGe6szzOXHkK9ukpcSBZgeyy5AgX3+7PgQseBnB9XWYLj-PQ@mail.gmail.com>
 <20141024122738.GH24265@leverpostej>
 <1414799092.23621.48.camel@smoke>
 <CAL_Jsq+V_tLkfwBKDQOOrkKtHWaRD5e1AHzbciwVYFYbpsAE=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+V_tLkfwBKDQOOrkKtHWaRD5e1AHzbciwVYFYbpsAE=w@mail.gmail.com>
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
To: Rob Herring <robherring2@gmail.com>
Cc: "Ian.Campbell@citrix.com" <Ian.Campbell@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Leif Lindholm <leif.lindholm@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Mon, Nov 03, 2014 at 10:26:02PM +0000, Rob Herring wrote:
> Adding Leif...

[...]

> I'm just wondering does UEFI being used for the memory information
> have any impact here as the DT would not have valid memory nodes
> either?

For UEFI, things should just work (TM). The dtb will be free of memory
nodes (and memreserves), and the next kernel will discover the UEFI
memory map via the linux,uefi-mmap-* properties as the first kernel did.

We shouldn't need to pass any additional data in this case.

> I'd assume reserved memory comes from UEFI (or both) in that
> case?

Yes. Any memory that should be reserved should be described as such in
the UEFI memory map.

One caveat is that reserved-memory nodes are preserved (because they can
be referred to by phandle for CMA and such). There are few potential
problems with this (we'll have to reconcile it with the UEFI memory map,
prevent overlap when the kernel is relocated, etc). The reserved-memory
nodes should only be used for CMA type carve outs rather than for
protecting firmware and similar.

> Perhaps we need to expose memory layout independent of DT, UEFI
> or anything else.

I can see that being useful for debugging, but I don't think that we
require it.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
