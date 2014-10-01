Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 1 Oct 2014 14:31:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 6/7] arm64/kexec: Add core kexec support
Message-ID: <20141001183142.GF14991@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001161621.GA28440@leverpostej>
 <20141001174714.GD14991@redhat.com>
 <20141001180304.GC5788@leverpostej>
 <20141001180909.GE14991@redhat.com>
 <20141001181959.GD5788@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141001181959.GD5788@leverpostej>
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
Cc: Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Wed, Oct 01, 2014 at 07:19:59PM +0100, Mark Rutland wrote:
> On Wed, Oct 01, 2014 at 07:09:09PM +0100, Vivek Goyal wrote:
> > On Wed, Oct 01, 2014 at 07:03:04PM +0100, Mark Rutland wrote:
> > > On Wed, Oct 01, 2014 at 06:47:14PM +0100, Vivek Goyal wrote:
> > > > On Wed, Oct 01, 2014 at 05:16:21PM +0100, Mark Rutland wrote:
> > > > 
> > > > [..]
> > > > > I'm still rather unhappy about the mechanism by which the DTB is passed
> > > > > by userspace and detected by the kernel, as I'd prefer that the user
> > > > > explictly stated which segment they wanted to pass to the (Linux)
> > > > > kernel, but that would require reworking the kexec syscall to allow
> > > > > per-segment info/flags.
> > > > 
> > > > Why does the running kernel need to know about dtb segment.  I see following.
> > > > 
> > > > ldr     x0, kexec_dtb_addr
> > > > 
> > > > IIUC, we are loading this address in x0. Can't we do something similar
> > > > in user space with purgatory. I mean first jump to purgatory (code
> > > > compiled in user space but runs prviliged) and that code takes care
> > > > of loading x0 with right dtb addr and then jump to final kernel.
> > > 
> > > I believe the fundamental issue here is a lack of a userspace-provided
> > > purgatory.
> > > 
> > > I agree that userspace purgatory code could set this up. That would
> > > address my concerns w.r.t. detecting the DTB kernel-side, as there would
> > > be no need. It would also address my concerns with booting OSs other
> > > than Linux, as the purgatory code could do whatever was appropriate for
> > > whatever OS image was loaded.
> > > 
> > > So in my view, a userspace-provided purgatory that set up the state the
> > > next kernel expected would be preferable. That could be as simple as
> > > setting up the registers and branching -- I assume we'd have the first
> > > kernel perform the required cache maintenance.
> > 
> > Apart from setting various registers, we also verify the sha256 checksums
> > of loaded segments in purgatory to make sure segments are not corrupted.
> > On x86, we also take care of backing up first 640KB of memory in reserved
> > area in kdump case. 
> 
> I was under the (possibly mistaken) impression that for kdump the second
> kernel lived and ran at a high address so as to preserve memory in use
> by the first kernel. Is the first 640KiB is special on x86, or is does
> it have some kdump-specific use?

Use of first 640KB by second kernel is x86 specific. And it was long back
and I am not sure if this requirement exists today or not. Just that
things have been working and nobody has bothered to look into optimizing
it further.

Kdump kernel does run from reserved memory. This memory is reserved
very early during boot so that first kernel does not end up using it.
So it does not matter whether that memory is reserved high or low. First
kernel is not going to use it as it is reserved. Hence memory contents
of first kernel will be preserved.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
