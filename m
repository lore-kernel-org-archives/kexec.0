Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aG2wg-0001gc-3t
 for kexec@lists.infradead.org; Mon, 04 Jan 2016 11:05:03 +0000
Date: Mon, 4 Jan 2016 19:04:27 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 14/16] x86, nvdimm, kexec: Use walk_iomem_res_desc() for
 iomem search
Message-ID: <20160104110427.GA2965@dhcp-128-65.nay.redhat.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
 <20160104092545.GA7033@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160104092545.GA7033@dhcp-128-65.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: linux-arch@vger.kernel.org, linux-nvdimm@ml01.01.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bp@alien8.de, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>

On 01/04/16 at 05:25pm, Dave Young wrote:
> Hi, Toshi,
> =

> On 12/25/15 at 03:09pm, Toshi Kani wrote:
> > Change to call walk_iomem_res_desc() for searching resource entries
> > with the following names:
> >  "ACPI Tables"
> >  "ACPI Non-volatile Storage"
> >  "Persistent Memory (legacy)"
> >  "Crash kernel"
> > =

> > Note, the caller of walk_iomem_res() with "GART" is left unchanged
> > because this entry may be initialized by out-of-tree drivers, which
> > do not have 'desc' set to IORES_DESC_GART.
> =

> Found below commit which initialize the GART entry:
> commit 56dd669a138c40ea6cdae487f233430d12372767
> Author: Aaron Durbin <adurbin@google.com>
> Date:   Tue Sep 26 10:52:40 2006 +0200
> =

>     [PATCH] Insert GART region into resource map
>     =

>     Patch inserts the GART region into the iomem resource map. The GART w=
ill then
>     be visible within /proc/iomem. It will also allow for other users
>     utilizing the GART to subreserve the region (agp or IOMMU).
>     =

>     Signed-off-by: Aaron Durbin <adurbin@google.com>
> =

> But later it was reverted:
> commit 707d4eefbdb31f8e588277157056b0ce637d6c68
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Mar 18 14:26:12 2014 -0600
> =

>     Revert "[PATCH] Insert GART region into resource map"
>     =

>     This reverts commit 56dd669a138c, which makes the GART visible in
>     /proc/iomem.  This fixes a regression: e501b3d87f00 ("agp: Support 64=
-bit
>     APBASE") exposed an existing problem with a conflict between the GART
>     region and a PCI BAR region.
>     =

>     The GART addresses are bus addresses, not CPU addresses, and therefore
>     should not be inserted in iomem_resource.
>     =

>     On many machines, the GART region is addressable by the CPU as well a=
s by
>     an AGP master, but CPU addressability is not required by the spec.  O=
n some
>     of these machines, the GART is mapped by a PCI BAR, and in that case,=
 the
>     PCI core automatically inserts it into iomem_resource, just as it doe=
s for
>     all BARs.
>     =

>     Inserting it here means we'll have a conflict if the PCI core later t=
ries
>     to claim the GART region, so let's drop the insertion here.
>     =

>     The conflict indirectly causes X failures, as reported by Jouni in the
>     bugzilla below.  We detected the conflict even before e501b3d87f00, b=
ut
>     after it the AGP code (fix_northbridge()) uses the PCI resource (whic=
h is
>     zeroed because of the conflict) instead of reading the BAR again.
>     =

>     Conflicts:
>         arch/x86_64/kernel/aperture.c
>     =

>     Fixes: e501b3d87f00 agp: Support 64-bit APBASE
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D72201
>     Reported-and-tested-by: Jouni Mett=E4l=E4 <jtmettala@gmail.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> =

> =

> For amd64 agp, currently the region name is "aperture" instead:
> drivers/char/agp/amd64-agp.c: agp_aperture_valid()
> =

> This may not be the only case, but I doubt that anyone is testing this si=
nce
> long time ago kexec-tools excluding the 'GART' region. Kexec-tools and ke=
xec_file
> may need update to use "aperture" if someone can test it.
> =

> I think adding an enum value for compatibility is reasonable, we do not c=
are
> about third party drivers in mainline.

Hmm, rethink about it, the new kernel will not export "GART" regions thus t=
he in-kernel loader should never see such regions as long as there's no oth=
er drivers exporting it. Thus dropping the code chunk in crash.c about 'GAR=
T' should be fine.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
