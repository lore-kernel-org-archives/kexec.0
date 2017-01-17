Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 17 Jan 2017 11:13:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v29 9/9] Documentation: dt: chosen properties for arm64
 kdump
Message-ID: <20170117111323.GB11939@leverpostej>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043734.27535-1-takahiro.akashi@linaro.org>
 <20170112153944.GB12249@leverpostej>
 <20170113091339.GK20972@linaro.org>
 <20170113111756.GC26120@leverpostej>
 <20170116082505.GL20972@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170116082505.GL20972@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, james.morse@arm.com, geoff@infradead.org, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Mon, Jan 16, 2017 at 05:25:07PM +0900, AKASHI Takahiro wrote:
> On Fri, Jan 13, 2017 at 11:17:56AM +0000, Mark Rutland wrote:
> > On Fri, Jan 13, 2017 at 06:13:49PM +0900, AKASHI Takahiro wrote:
> > > On Thu, Jan 12, 2017 at 03:39:45PM +0000, Mark Rutland wrote:

> > > > arm64 we should either ensure that /proc/iomem is consistently usable
> > > > (and have userspace consistently use it), or we should expose a new file
> > > > specifically to expose this information.
> > > 
> > > The thing that I had in my mind when adding this property is that
> > > /proc/iomem would be obsolete in the future, then we should have
> > > an alternative in hand.
> > 
> > Ok.
> > 
> > My disagreement is with using the DT as a channel to convey information
> > from the kernel to userspace.
> > 
> > I'm more than happy for a new file or other mechanism to express this
> > information. For example, we could add
> > /sys/kernel/kexec_crash_{base,size} or similar.
> 
> It may make sense because /sys/kernel/kexec_crash_size already exists,
> so why not kexec_crash_base?
> My concern, however, is that this kind of interface might prevent us from
> allowing multiple regions to be reserved for crash dump kernel in the future.
> (There is an assumption that we have only one region at least on arm64 though.)

Ok.

If we need to handle that, we should also update the description of
linux,usable-memory-range to allow multiple entries (and probably
s/range/ranges).

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
