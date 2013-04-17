Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USTkI-0006jn-Gz
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 14:54:03 +0000
Date: Wed, 17 Apr 2013 16:53:51 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCHv4 0/8] kexec: extend kexec hypercall for use with pv-ops
 kernels
Message-ID: <20130417145351.GE906@debian70-amd64.local.net-space.pl>
References: <1366132390-5269-1-git-send-email-david.vrabel@citrix.com>
 <20130417123437.GA906@debian70-amd64.local.net-space.pl>
 <516EAE8B.8030200@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <516EAE8B.8030200@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Keir (Xen.org)" <keir@xen.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Wed, Apr 17, 2013 at 03:15:39PM +0100, David Vrabel wrote:
> On 17/04/13 13:34, Daniel Kiper wrote:
> > On Tue, Apr 16, 2013 at 06:13:02PM +0100, David Vrabel wrote:
> >>
> >> The required patch series for kexec-tools have previously been posted
> >> and this series has been rebased on the latest kexec-tools and is
> >> available from the xen-v3 branch of:
> >>
> >> http://xenbits.xen.org/gitweb/?p=people/dvrabel/kexec-tools.git;a=summary
> >
> > kexec -e still does not work. I see in my console:
> >
> > I'm in purgatory
> > sha256 digests do not match :(
>
> Some recent updates to kexec-tools has broken this.  If you use the
> xen-v2 branch of kexec-tools it should be fine.

xen-v2 works without any issue...

> I suspect the recent change to load 64-bit images about 4G but my unit
> testing says images above 4G work fine.
>
> Working out what's wrong here is going to push the final patches even
> further into the code freeze so this will now be a Xen 4.4 candidate.

If you wish I could put my Reviewed-by and Tested-by for all Xen
patches. But please add this fix for memcpy() for patch 5 and repost
all Xen patches. However, I could not add Reviewed-by and Tested-by
for kexec-tools patches until all problems will be solved.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
