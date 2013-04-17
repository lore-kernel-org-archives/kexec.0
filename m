Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UST5s-0005fT-2Y
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 14:12:16 +0000
Date: Wed, 17 Apr 2013 16:12:05 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/5] kexec/xen: directly load images images into Xen
Message-ID: <20130417141205.GD906@debian70-amd64.local.net-space.pl>
References: <1365448014-12119-1-git-send-email-david.vrabel@citrix.com>
 <1365448014-12119-6-git-send-email-david.vrabel@citrix.com>
 <20130409212036.GE31533@debian70-amd64.local.net-space.pl>
 <20130417125602.GC906@debian70-amd64.local.net-space.pl>
 <516EA95D.8010200@citrix.com>
MIME-Version: 1.0
Content-Description: aniel.kiper@oracle.co
Content-Disposition: inline
In-Reply-To: <516EA95D.8010200@citrix.com>
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
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Wed, Apr 17, 2013 at 02:53:33PM +0100, David Vrabel wrote:
> On 17/04/13 13:56, Daniel Kiper wrote:
> > On Tue, Apr 09, 2013 at 11:20:36PM +0200, Daniel Kiper wrote:
> >>
> >> arch = (kexec_flags & KEXEC_ARCH_MASK) >> 16;
> >
> > What is wrong with this line?
> > Why did not you applied it?
>
> I haven't reposted the kexec-tools patches so it's not clear what you
> are expecting this to be applied to.

arch = (kexec_flags >> 16) & 0xffff;

should be changed to:

arch = (kexec_flags & KEXEC_ARCH_MASK) >> 16;

or add comment what are you doing but I think
that former is better.

Additionally I found in kexec-tools git tree something like that:

kexec/crashdump-xen.c:

...
#ifdef HAVE_LIBXENCTRL
int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
{
...
}

and in

kexec/crashdump.c:

...

#ifndef HAVE_LIBXENCTRL
int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
{
  return get_vmcoreinfo("/sys/hypervisor/vmcoreinfo", addr, len);
}
#endif

Move get_xen_vmcoreinfo() from kexec/crashdump.c to kexec/crashdump-xen.c
and make it return -1 ifndef HAVE_LIBXENCTRL. /sys/hypervisor/vmcoreinfo
is valid for legacy kexec implementation only.

Please repost next time Xen and kexec-tools patches.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
