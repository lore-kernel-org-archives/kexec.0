Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bPiWQ-0006Fw-B8
 for kexec@lists.infradead.org; Wed, 20 Jul 2016 03:50:11 +0000
Date: Wed, 20 Jul 2016 11:48:40 +0800
From: Dennis Chen <dennis.chen@arm.com>
Subject: Re: [PATCH v22 1/8] arm64: kdump: reserve memory for crash dump kernel
Message-ID: <20160720034838.GB30575@arm.com>
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
 <20160712050514.22307-2-takahiro.akashi@linaro.org>
 <20160719093906.GA20732@arm.com>
 <20160719102815.GE20774@linaro.org>
 <20160719104103.GB20990@arm.com>
 <1468932537.27473.6.camel@redhat.com>
 <20160719132736.GB21007@leverpostej>
MIME-Version: 1.0
In-Reply-To: <20160719132736.GB21007@leverpostej>
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Pratyush Anand <panand@redhat.com>, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, robh+dt@kernel.org, james.morse@arm.com, Mark Salter <msalter@redhat.com>, bauerman@linux.vnet.ibm.com, nd@arm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Tue, Jul 19, 2016 at 02:27:54PM +0100, Mark Rutland wrote:
> On Tue, Jul 19, 2016 at 08:48:57AM -0400, Mark Salter wrote:
> > On Tue, 2016-07-19 at 18:41 +0800, Dennis Chen wrote:
> > > On Tue, Jul 19, 2016 at 07:28:16PM +0900, AKASHI Takahiro wrote:
> > > > On Tue, Jul 19, 2016 at 05:39:07PM +0800, Dennis Chen wrote:
> > > > > On Tue, Jul 12, 2016 at 02:05:07PM +0900, AKASHI Takahiro wrote:
> > > > > > +/*
> > > > > > + * reserve_crashkernel() - reserves memory for crash kernel
> > > > > > + *
> > > > > > + * This function reserves memory area given in "crashkernel=3D=
" kernel command
> > > > > > + * line parameter. The memory reserved is used by dump capture=
 kernel when
> > > > > > + * primary kernel is crashing.
> > > > > > + */
> > > > > > +static void __init reserve_crashkernel(void)
> > > > > > +{
> > > > > > +=A0=A0=A0=A0=A0int ret;
> > > > > > +
> > > > > > +=A0=A0=A0=A0=A0ret =3D parse_crashkernel(boot_command_line, me=
mblock_phys_mem_size(),
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0&crash_size, &crash_base);
> > > > > > +=A0=A0=A0=A0=A0/* no crashkernel=3D or invalid value specified=
 */
> > > > > > +=A0=A0=A0=A0=A0if (ret || !crash_size)
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > > > > > +
> > > > > > +=A0=A0=A0=A0=A0if (crash_base =3D=3D 0) {
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Current arm64 boot p=
rotocol requires 2MB alignment */
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0crash_base =3D memblock=
_find_in_range(0,
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0MEMBLOCK_ALLOC_ACCESSIBLE, crash_size, SZ_2M);
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (crash_base =3D=3D 0=
) {
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0crash_size);
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0return;
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0memblock_reserve(crash_=
base, crash_size);
> > > > > > =

> > > > > I am not pretty sure the context here, but
> > > > > can we use below code piece instead of the above lines?
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0if (crash_base =3D=3D 0)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0memblock_alloc(cr=
ash_size, SZ_2M);
> > > > Either would be fine here.
> > > > =

> > > Hello AKASHI, maybe you can succeed to find the base with memblock_fi=
nd_in_range(),=A0
> > > but that doesn't mean you will also succeed to reserve them with memb=
lock_reserve followed.
> > =

> > We avoid memblock_alloc() here because it panics on failure. This could=
 happen
> > if user asks for an unusually large crashkernel size. Better to print a=
 message
> > and keep booting. Checking the return value of memblock_reserve() seems=
 like a
> > good thing to do though.
> =

> Another option would be to add a memblock_try_alloc() function to the
> memblock API, which in case of failure returns 0 rather than triggering
> a panic(). We'd still have to check the return value, but all the
> memblock manipulation would be in one place.
> =

> It looks like adding that is fairly simple:
> =

> phys_addr_t __init memblock_try_alloc(phys_addr_t size, phys_addr_t align)
> {
> 	return __memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
> }
>
Hi Mark, memblock_alloc() should remove the panic just as we did in kmalloc=
 IMO, as a memory allocation
API, it should handover the failure case to the user and the latter should =
make the final decision.
Just take a look at the usage case of the memblock_alloc() in the kernel tr=
ee, codes have been messed
up by -- some codes check the return value of memblock_alloc, while others =
not.

Thanks,
Dennis =

> =

> Thanks,
> Mark.
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
