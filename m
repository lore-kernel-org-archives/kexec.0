Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a3eJ8-0005CL-B2
 for kexec@lists.infradead.org; Tue, 01 Dec 2015 06:20:59 +0000
Date: Tue, 1 Dec 2015 15:20:32 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH] crashdump/x86: Add option to get crash kernel region
 size
Message-ID: <20151201062032.GC16260@verge.net.au>
References: <1448741644-905-1-git-send-email-daniel.kiper@oracle.com>
 <20151129235532.GB13342@verge.net.au>
 <20151130073931.GZ4768@olila.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151130073931.GZ4768@olila.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: keir@xen.org, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, david.vrabel@citrix.com, jbeulich@suse.com, xen-devel@lists.xenproject.org

On Mon, Nov 30, 2015 at 08:39:31AM +0100, Daniel Kiper wrote:
> On Mon, Nov 30, 2015 at 08:55:32AM +0900, Simon Horman wrote:
> > On Sat, Nov 28, 2015 at 09:14:04PM +0100, Daniel Kiper wrote:
> > > Crash kernel region size is available via sysfs on Linux running on
> > > bare metal. However, this does not work when Linux runs as Xen dom0.
> > > In this case Xen crash kernel region size should be established using
> > > __HYPERVISOR_kexec_op hypercall (Linux kernel kexec functionality does
> > > not make a lot of sense in Xen dom0). Sadly hypercalls are not easily
> > > accessible using shell scripts or something like that. Potentially we
> > > can check "xl dmesg" output for crashkernel option but this is not nice.
> > > So, let's add this functionality, for Linux running on bare metal and
> > > as Xen dom0, to kexec-tools. This way kdump scripts may establish crash
> > > kernel region size in one way regardless of platform. All burden of
> > > platform detection lies on kexec-tools.
> > >
> > > Figure (and unit) displayed by this new kexec-tools functionality is
> > > the same as one taken from /sys/kernel/kexec_crash_size.
> > >
> > > This functionality is available on x86 platform only. If idea is acceptable
> > > then I can prepare patches for other platforms (if it is possible and make
> > > sense) and repost them as fully flagged patch series.
> > >
> > > Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> >
> > Thanks, applied.
> 
> Thanks a lot. However, this patch itself breaks build on other platforms.
> That is why I posted it as a RFC. To fix this I can post similar patches
> for other platforms (this will happen probably tomorrow or on Wednesday
> but no later than by the end of this week). Or you can revert this patch
> and than I repost it as a part of fully functional patch series.

Sorry for being a bit too hasty.

I will revert.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
