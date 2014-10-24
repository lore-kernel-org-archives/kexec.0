Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 24 Oct 2014 11:54:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 06/10] arm64: Update booting.txt to reserved-memory nodes
Message-ID: <20141024105432.GE24265@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <b56c0def845535b41b6c00bffdd9d91de5ddae5c.1414099246.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b56c0def845535b41b6c00bffdd9d91de5ddae5c.1414099246.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
> Change any reference of device tree '/memreserve/' entries in the arm64
> booting.txt to refer to 'reserved-memory nodes'.  Reserved-memory nodes
> are the preferred method of specifying reserved memory.

Per my comments on patch 5, I don't think this change is sufficient.

However, we should probably update the document to allow reserved-memory
nodes.

On an unrelated note we probably need to work out how reserved-memory
interacts with the UEFI memory map -- unmappable regions shouldn't be
described by UEFI and I hope people don't use reserved-memory as a
workaround for broken UEFI tables.

Thanks,
Mark.

> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  Documentation/arm64/booting.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index f3c05b5..7446822 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -196,7 +196,7 @@ following manner:
>    naturally-aligned 64-bit zero-initalised memory location.
>  
>    These CPUs should spin outside of the kernel in a reserved area of
> -  memory (communicated to the kernel by a /memreserve/ region in the
> +  memory (communicated to the kernel by a reserved-memory node in the
>    device tree) polling their cpu-release-addr location, which must be
>    contained in the reserved region.  A wfe instruction may be inserted
>    to reduce the overhead of the busy-loop and a sev will be issued by
> @@ -209,7 +209,7 @@ following manner:
>  - CPUs with a "psci" enable method should remain outside of
>    the kernel (i.e. outside of the regions of memory described to the
>    kernel in the memory node, or in a reserved area of memory described
> -  to the kernel by a /memreserve/ region in the device tree).  The
> +  to the kernel by a reserved-memory node in the device tree).  The
>    kernel will issue CPU_ON calls as described in ARM document number ARM
>    DEN 0022A ("Power State Coordination Interface System Software on ARM
>    processors") to bring CPUs into the kernel.
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
