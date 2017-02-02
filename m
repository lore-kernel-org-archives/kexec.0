Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 2 Feb 2017 11:26:20 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v31 03/12] arm64: kdump: reserve memory for crash dump
 kernel
Message-ID: <20170202112619.GB31394@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-2-takahiro.akashi@linaro.org>
 <20170201152609.GE4756@leverpostej>
 <20170202045235.GB13549@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170202045235.GB13549@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, geoff@infradead.org, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Mark Salter <msalter@redhat.com>, Pratyush Anand <panand@redhat.com>

On Thu, Feb 02, 2017 at 01:52:36PM +0900, AKASHI Takahiro wrote:
> On Wed, Feb 01, 2017 at 03:26:09PM +0000, Mark Rutland wrote:
> > On Wed, Feb 01, 2017 at 09:46:22PM +0900, AKASHI Takahiro wrote:
> > > +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> > > +		crash_size >> 20, crash_base >> 20);
> > 
> > We only page-align the size, so the MB will be a little off, but that's
> > probably OK. However, it would also be nicer to log the base as an
> > address.
> 
> You might notice that the exact same message is used by all the other
> architectures, but

Almost all; I see arch/sh prints the address with %08x. ;)

> > Could we dump this as we do for the kernel memory layout? e.g.
> > 
> > 	pr_info("crashkernel reserved: 0x%016lx - 0x%016lx (%lld MB)\n",
> > 		crash_base, crash_base + crash_size, crash_size >> 20);
> 
> We can go either way.

Even if it's different from other archtiectures, I'd prefer to log as
above, with the range in hex.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
