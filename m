Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cZIZh-0007Yr-3R
 for kexec@lists.infradead.org; Thu, 02 Feb 2017 14:41:26 +0000
Received: by mail-pg0-f41.google.com with SMTP id 3so6289478pgj.3
 for <kexec@lists.infradead.org>; Thu, 02 Feb 2017 06:41:03 -0800 (PST)
Date: Thu, 2 Feb 2017 23:39:58 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v31 09/12] arm64: kdump: provide /proc/vmcore file
Message-ID: <20170202143957.GB3078@fireball>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-8-takahiro.akashi@linaro.org>
 <20170201192121.GB30584@leverpostej>
 <20170202062408.GC13549@linaro.org>
 <20170202120320.GK31394@leverpostej>
 <20170202120850.GL31394@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170202120850.GL31394@leverpostej>
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
Cc: geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 02, 2017 at 12:08:50PM +0000, Mark Rutland wrote:
> On Thu, Feb 02, 2017 at 12:03:20PM +0000, Mark Rutland wrote:
> > On Thu, Feb 02, 2017 at 03:24:09PM +0900, AKASHI Takahiro wrote:
> > > On Wed, Feb 01, 2017 at 07:21:22PM +0000, Mark Rutland wrote:
> > > > On Wed, Feb 01, 2017 at 09:46:28PM +0900, AKASHI Takahiro wrote:
> 
> > > > > +/*
> > > > > + * reserve_elfcorehdr() - reserves memory for elf core header
> > > > > + *
> > > > > + * This function reserves elf core header given in "elfcorehdr=" kernel
> > > > > + * command line parameter. This region contains all the information about
> > > > > + * primary kernel's core image and is used by a dump capture kernel to
> > > > > + * access the system memory on primary kernel.
> > > > > + */
> 
> > Can you also fix the comment above reserve_elfcorehdr()? It refers to a
> > non-existent kernel command line option.
> 
> ... or rather, one that's handled by core code, not
> reserve_elfcorehdr().
> 
> So more specifically, it would be nicer to have something like:
> 
> 	/*
> 	 * reserve_elfcorehdr() - reserves memory for elf core header
> 	 *
> 	 * This function reserves the memory occupied by an elf core header
> 	 * described in the device tree. This region contains all the
> 	 * information about primary kernel's core image and is used by a dump
> 	 * capture kernel to access the system memory on primary kernel.
> 	 */

Perfect!

Thanks a lot,
-Takahiro AKASHI


> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
