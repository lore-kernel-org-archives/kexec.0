Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZpLAh-0002D1-Gu
 for kexec@lists.infradead.org; Thu, 22 Oct 2015 19:05:08 +0000
Date: Thu, 22 Oct 2015 15:04:45 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec: Add --lite option
Message-ID: <20151022190445.GE20847@redhat.com>
References: <1445469125.30908.105.camel@infradead.org>
 <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
 <1445540240.30908.134.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1445540240.30908.134.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: panand@redhat.com, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, Petitboot@lists.ozlabs.org

On Thu, Oct 22, 2015 at 11:57:20AM -0700, Geoff Levand wrote:
> Hi Dave,
> 
> On Thu, 2015-10-22 at 11:17 +0800, Dave Young wrote:
> > On 10/21/15 at 04:12pm, Geoff Levand wrote:
> > > Add a new option --lite to kexec that allows for a fast reboot
> > > by avoiding the purgatory integrity checks.  This option is
> > > intended for use by kexec based bootloaders that load a new
> > > image and then immediately transfer control to it.
> > 
> > I think Vivek was rejecting this --lite since kdump need the purgatory
> > integrity checks. Ccing him.
> 
> As stated, this is not intended for use by kdump.
> 
> This is an optional feature.  It does not remove the integrity
> checks, but provides the user a way to bypass them if they so
> desire.

Why would somebody like to bypass these checks?

> 
> > > It was reported that on some systems where purgatory is running
> > > without caches enabled the sha256 calculations would take several
> > > minutes.  For bootloaders that just load a new image and
> > > immediately jump into it the loss of the integrity check is worth
> > > the increase in boot speed.  Please consider.  
> > 
> > Pratyush reported the arm64 issue, he sent a patch to fix it with
> > enabling cache for purgatory. I think the patch can fix the problem.
> > Why not fix it? The fix is simple enough and it does not introduce
> > complicate logic.
> 
> This patch also is simple, and is architecture independent.  I see this
> feature as an improvement to kexec, not necessarily as a fix for that
> problem.

I am not sure why does somebody care if segments are being checked
during transition or not?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
