Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZqZRd-0007Sf-GV
 for kexec@lists.infradead.org; Mon, 26 Oct 2015 04:31:42 +0000
Date: Mon, 26 Oct 2015 13:31:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: do not copy 1st kernel root= param in fs2dt.c
Message-ID: <20151026043119.GB2411@verge.net.au>
References: <20151009055722.GA6248@dhcp-129-237.nay.redhat.com>
 <20151016013331.GB20667@verge.net.au>
 <20151019082246.GC31886@dhcp-129-115.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151019082246.GC31886@dhcp-129-115.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: jstodola@redhat.com, kexec@lists.infradead.org

On Mon, Oct 19, 2015 at 04:22:46PM +0800, Dave Young wrote:
> Hi, Simon
> 
> On 10/16/15 at 10:33am, Simon Horman wrote:
> > Hi Dave,
> > 
> > On Fri, Oct 09, 2015 at 01:57:22PM +0800, Dave Young wrote:
> > > Jan Stodola <jstodola@redhat.com> reported ppc64 root= is always added in kexec
> > > kernel cmdline. But sometimes we need boot without root= for example we use
> > > kexec to boot into installation initramfs image like below:
> > > kexec --load vmlinuz --initrd=initrd.img --command-line=\
> > > "inst.repo=http://<server>/<path>/Server/ppc64le/os/"
> > > 
> > > While creating dtb, in case there's no root= in user provided cmdline params 
> > > kexec-tools will find the original root= param used in 1st kernel and pass it
> > > to 2nd kernel. This caused that user have no way to remove root= cmdline.
> > > 
> > > Dropping that part of code so that one can get chance to kexec into 2nd kernel
> > > without root= param. One can still provide root= in --command-line=""
> > 
> > I'm a little concerned about the backwards-compatibility implications of
> > this change. Though I agree the new behaviour is entirely sane perhaps
> > it should be activated via a new command line option.
> 
> I did not notice this problem until Jan reported it so I thouhgt that it
> is just a hidden assumption, people might not notice it and use it that
> way.
> 
> For Fedora/RHEL kdump we will copy 1st kernel cmdline by default so one
> do not need to use it. For kexec and other distributions I'm not sure..
> 
> Since it is more of a fix to original logic, personally I tend to not
> introducing a new option. But if you think we need to add a new option I
> can do it.

> > Also, won't this affect other architectures that use DT.
> > I'm thinking about ARM. If so it might be good to tweak the changelog.
> 
> arm also uses the function, but I need verify the behavior. Will tune the
> changelog after I confirming it.

Thanks

I'm still concerned that people may be relying on this behaviour.
But I agree it seems painful to add an option to get what
should have been the default.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
