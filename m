Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cZHi1-0003Gp-Ey
 for kexec@lists.infradead.org; Thu, 02 Feb 2017 13:45:59 +0000
Received: by mail-pf0-f173.google.com with SMTP id e4so5537898pfg.1
 for <kexec@lists.infradead.org>; Thu, 02 Feb 2017 05:45:35 -0800 (PST)
Date: Thu, 2 Feb 2017 22:44:24 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v31 03/12] arm64: kdump: reserve memory for crash dump
 kernel
Message-ID: <20170202134423.GA22545@fireball>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-2-takahiro.akashi@linaro.org>
 <20170201152609.GE4756@leverpostej>
 <20170202045235.GB13549@linaro.org>
 <20170202112619.GB31394@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170202112619.GB31394@leverpostej>
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
Cc: Pratyush Anand <panand@redhat.com>, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, Mark Salter <msalter@redhat.com>, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 02, 2017 at 11:26:20AM +0000, Mark Rutland wrote:
> On Thu, Feb 02, 2017 at 01:52:36PM +0900, AKASHI Takahiro wrote:
> > On Wed, Feb 01, 2017 at 03:26:09PM +0000, Mark Rutland wrote:
> > > On Wed, Feb 01, 2017 at 09:46:22PM +0900, AKASHI Takahiro wrote:
> > > > +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> > > > +		crash_size >> 20, crash_base >> 20);
> > > 
> > > We only page-align the size, so the MB will be a little off, but that's
> > > probably OK. However, it would also be nicer to log the base as an
> > > address.
> > 
> > You might notice that the exact same message is used by all the other
> > architectures, but
> 
> Almost all; I see arch/sh prints the address with %08x. ;)
> 
> > > Could we dump this as we do for the kernel memory layout? e.g.
> > > 
> > > 	pr_info("crashkernel reserved: 0x%016lx - 0x%016lx (%lld MB)\n",
> > > 		crash_base, crash_base + crash_size, crash_size >> 20);
> > 
> > We can go either way.
> 
> Even if it's different from other archtiectures, I'd prefer to log as
> above, with the range in hex.

OK.

-Takhiro AKASHI

> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
