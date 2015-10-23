Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZpYvy-0002r6-MZ
 for kexec@lists.infradead.org; Fri, 23 Oct 2015 09:46:51 +0000
Date: Fri, 23 Oct 2015 17:46:20 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec: Add --lite option
Message-ID: <20151023094620.GG11227@dhcp-129-115.nay.redhat.com>
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
Cc: panand@redhat.com, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Petitboot@lists.ozlabs.org, vgoyal@redhat.com

Hi, Geoff

On 10/22/15 at 11:57am, Geoff Levand wrote:
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

Problem is why they so desire to skip purgatory? what is the background?
If the only problem is the performace issue without cache enabled then
I think it is not a strong one. We have a design to verify the image and it
works why can't we maintain it and fix the issue instead of introducing
the --lite? 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
