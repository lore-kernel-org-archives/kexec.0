Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 3 Feb 2017 11:51:59 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
Message-ID: <20170203115158.GD30497@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej>
 <20170201182506.GA30584@leverpostej>
 <20170202103905.GF13549@linaro.org>
 <20170202115425.GJ31394@leverpostej>
 <20170203014538.GA29585@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170203014538.GA29585@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Feb 03, 2017 at 10:45:39AM +0900, AKASHI Takahiro wrote:
> On Thu, Feb 02, 2017 at 11:54:25AM +0000, Mark Rutland wrote:
> > On Thu, Feb 02, 2017 at 07:39:06PM +0900, AKASHI Takahiro wrote:
> > > On Wed, Feb 01, 2017 at 06:25:06PM +0000, Mark Rutland wrote:
> > > > On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
> > > > Another question is (how) does hyp map this region?
> > > 
> > > I don't get your point here.
> > > Hyp mode does care only physical memory in intermediate address, doesn't it?
> > 
> > My concern was that hyp may map the region; and thus buggy code at hyp
> > can corrupt the region (and/or hyp may conflict w.r.t. attributes).
> 
> Grep'ing create_hyp_mappings() under arch/arm(64)/kvm shows that
> we have only a few small regions of memory mapped in hyp mode.
> I also confirmed that there is no active mapping for crash dump kernel
> memory by checking mmu tables with DS-5 debugger.

Ok, that sounds fine.

I was under the mistaken impression that hyp had a copy of the whole
linear mapping, but it seems it lazily maps that in (at page
granularity) as required. So there should be no alias for the
crashkernel region.

> > We mght have to ensure hyp doesn't map the crashkernel region, and to
> > case us pain, disallow freeing of any part of the region.
> 
> So I don't believe we need to worry such a case.

I agree.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
