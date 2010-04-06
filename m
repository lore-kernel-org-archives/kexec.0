Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NzG5K-0004lP-5i
	for kexec@lists.infradead.org; Tue, 06 Apr 2010 21:13:23 +0000
Date: Tue, 6 Apr 2010 17:13:15 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 3/4] Revert "x86: disable IOMMUs on kernel crash"
Message-ID: <20100406211315.GJ3029@redhat.com>
References: <20100403012820.229410717@sous-sol.org>
	<20100403174128.GQ24846@8bytes.org>
	<m1vdc8juju.fsf@fess.ebiederm.org> <4BB83EAE.5090609@bwalle.de>
	<20100404085338.GU24846@8bytes.org>
	<m17hond01n.fsf@fess.ebiederm.org>
	<20100404100101.GW24846@8bytes.org>
	<20100406174257.GG29241@sequoia.sous-sol.org>
	<20100406175106.GH28166@amd.com> <20100406203956.GI3029@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100406203956.GI3029@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, Bernhard Walle <bernhard@bwalle.de>, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Apr 06, 2010 at 04:39:56PM -0400, Vivek Goyal wrote:
> On Tue, Apr 06, 2010 at 07:51:06PM +0200, Joerg Roedel wrote:
> > On Tue, Apr 06, 2010 at 10:42:57AM -0700, Chris Wright wrote:
> > > * Joerg Roedel (joro@8bytes.org) wrote:
> > > > On Sun, Apr 04, 2010 at 02:44:36AM -0700, Eric W. Biederman wrote:
> > > > > Joerg Roedel <joro@8bytes.org> writes:
> > > > > 
> > > > > > On Sun, Apr 04, 2010 at 09:24:30AM +0200, Bernhard Walle wrote:
> > > > > >> Am 03.04.10 19:49, schrieb Eric W. Biederman:
> > > > > >> > Not a problem.  We require a lot of things of the kdump kernel,
> > > > > >> > and it is immediately apparent in a basic sanity test.
> > > > > >> 
> > > > > >> Also, in most cases (for example: distribution kernels), the kdump
> > > > > >> kernel nowadays is identical to the running kernel. So, if the running
> > > > > >> kernel has IOMMU support, the kdump kernel also has.
> > > > > >
> > > > > > Yes, I know. But is that a requirement for kexec?
> > > > > 
> > > > > For normal kexec no.  That path is expected to do a clean hardware
> > > > > shutdown.
> > > > > 
> > > > > For kexec on panic aka kdump the requirement is that your your crash
> > > > > kernel be able to initialize your hardware from any state it can be
> > > > > put in.
> > > > 
> > > > Ok, if you show me where this is documented for everybody then I am
> > > > probably convinced :-)
> > > > We should fixup the gart initialization anyway.
> > > 
> > > So, you planning to pull in all 4 patches then?
> > 
> > Yes, I will apply them tomorrow and write a fix for the GART issue this
> > may introduce.
> > 
> 
> Hi Joerg,
> 
> Going through the old mail thread, I think the commit you pointed to was
> primarily introduced to solve kexec + GART issue and not necessarily kdump
> issue.
> 
> In fact disabling IOMMU patch was introduced by you.
> 
> Author: Joerg Roedel <joerg.roedel@amd.com>
> Date:   Tue Jun 9 17:56:09 2009 +0200
> 
>     x86: disable IOMMUs on kernel crash
>     
>     If the IOMMUs are still enabled when the kexec kernel boots access to
>     the disk is not possible. This is bad for tools like kdump or anything
>     else which wants to use PCI devices.
>     
>     Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> 
> I am assuming you introduced this patch because you faced issues with
> amd-iommu and not GART.
> 
> So basically GART should have been working with kdump even before you
> introduced disabling iommu patch in kdump path.

Looking at following commit, we were still not shutting down GART and
fixing issues like second kernel accessing the GART aperture set by first
kernel.

commit aaf230424204864e2833dcc1da23e2cb0b9f39cd
Author: Yinghai Lu <Yinghai.Lu@Sun.COM>
Date:   Wed Jan 30 13:33:09 2008 +0100

    x86: disable the GART early, 64-bit
    
    For K8 system: 4G RAM with memory hole remapping enabled, or more than
    4G RAM installed.

So I guess it should be fine to not shutdown GART in crashing kernel and
then look at the fresh issues which crop up and figure out how to fix
those.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
