Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 20 Jan 2016 12:02:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 18/19] arm64: kdump: update a kernel doc
Message-ID: <20160120120257.GD25829@leverpostej>
References: <fb4506943bbaed8b0657ed367ebd57e4064d57ed.1452884156.git.geoff@infradead.org>
 <20160115201601.GR3262@leverpostej> <569CBDBC.5050500@linaro.org>
 <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej> <569F1A33.4000208@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <569F1A33.4000208@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: ard.biesheuvel@linaro.org, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, James Morse <james.morse@arm.com>, christoffer.dall@linaro.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 20, 2016 at 02:25:07PM +0900, AKASHI Takahiro wrote:
> On 01/19/2016 11:01 PM, Mark Rutland wrote:
> >For NUMA topology in !ACPI kernels, we might need to also retain and
> >parse memory nodes, but only for toplogy information. The kernel would
> >still only use memory as described by the EFI memory map.
> >
> >There's a horrible edge case I've spotted if performing a chain of
> >cross-endian kexecs: LE -> BE -> LE, as the BE kernel would have to
> >respect the EFI memory map so as to avoid corrupting it for the
> >subsequent LE kernel. Other than this I believe everything should just
> >work.
> 
> BE kernel doesn't support UEFI yet and cannot access UEFI memmap table. So,
> for LE -> BE, we don't use a dtb generated from /sys/firmware/fdt (or /proc/device-tree)
> (as in the case of LE -> LE) and require users to provide a dtb file explicitly.

As I mentioned above, the problem exists when memory nodes also exist
(for describing NUMA topology). In that case the BE kernel would try to
use the information from the memory nodes.

> For BE -> LE, BE kernel doesn't know wther UEFI memmap table is available or not
> and so use the same (explicitly-provided) dtb (as LE -> LE in !UEFI)

See above. The problem I imagine is:

LE kernel - uses EFI mmap, takes NUMA information from DT memory nodes

    v       kexec

BE kernel - uses DT memory nodes
          - clobbers EFI runtime regions as it sees them as available

    v       kexec

LE kernel - uses EFI mmap, takes NUMA information from DT memory nodes
          - tries to call EFI runtime services, and explodes.

> >>>A kexec'd kernel should simply inherit that. So long as the DTB and/or
> >>>UEFI tables in memory are the same, it would be the same as a cold boot.
> >>
> >>For kexec all memory ranges are same, for kdump we need use original reserved
> >>range with crashkernel= as usable memory and all other orignal usable ranges
> >>are not usable anymore.
> >
> >Sure. This is what I believe we should expose with an additional
> >property under /chosen, while keeping everything else pristine.
> >
> >The crash kernel can then limit itself to that region, while it would
> >have the information of the full memory map (which it could log and/or
> >use to drive other dumping).
> 
> FYI,
> all the original usable memory regions used by the 1st kernel are also
> described in an ELF core header specified by "elfcorehdr=" parameter to
> the crash dump kernel.

That only describes what the first kernel parsed and thus believed, not
exactly what the firmware described.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
