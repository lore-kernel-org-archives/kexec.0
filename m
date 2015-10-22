Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1445540240.30908.134.camel@infradead.org>
Subject: Re: [PATCH] kexec: Add --lite option
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 22 Oct 2015 11:57:20 -0700
In-Reply-To: <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
References: <1445469125.30908.105.camel@infradead.org>
 <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
Mime-Version: 1.0
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
Cc: panand@redhat.com, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Petitboot@lists.ozlabs.org, vgoyal@redhat.com

Hi Dave,

On Thu, 2015-10-22 at 11:17 +0800, Dave Young wrote:
> On 10/21/15 at 04:12pm, Geoff Levand wrote:
> > Add a new option --lite to kexec that allows for a fast reboot
> > by avoiding the purgatory integrity checks.  This option is
> > intended for use by kexec based bootloaders that load a new
> > image and then immediately transfer control to it.
> 
> I think Vivek was rejecting this --lite since kdump need the purgatory
> integrity checks. Ccing him.

As stated, this is not intended for use by kdump.

This is an optional feature.  It does not remove the integrity
checks, but provides the user a way to bypass them if they so
desire.

> > It was reported that on some systems where purgatory is running
> > without caches enabled the sha256 calculations would take several
> > minutes.  For bootloaders that just load a new image and
> > immediately jump into it the loss of the integrity check is worth
> > the increase in boot speed.  Please consider.  
> 
> Pratyush reported the arm64 issue, he sent a patch to fix it with
> enabling cache for purgatory. I think the patch can fix the problem.
> Why not fix it? The fix is simple enough and it does not introduce
> complicate logic.

This patch also is simple, and is architecture independent.  I see this
feature as an improvement to kexec, not necessarily as a fix for that
problem.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
