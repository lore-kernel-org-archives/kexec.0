Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1445540891.30908.144.camel@infradead.org>
Subject: Re: [PATCH] kexec: Add --lite option
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 22 Oct 2015 12:08:11 -0700
In-Reply-To: <20151022125012.GB20847@redhat.com>
References: <1445469125.30908.105.camel@infradead.org>
 <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
 <20151022125012.GB20847@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: panand@redhat.com, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Petitboot@lists.ozlabs.org

Hi Vivek,

On Thu, 2015-10-22 at 08:50 -0400, Vivek Goyal wrote:
> On Thu, Oct 22, 2015 at 11:17:18AM +0800, Dave Young wrote:
> > On 10/21/15 at 04:12pm, Geoff Levand wrote:
> > > Add a new option --lite to kexec that allows for a fast reboot
> > > by avoiding the purgatory integrity checks.  This option is
> > > intended for use by kexec based bootloaders that load a new
> > > image and then immediately transfer control to it.
> > 
> > I think Vivek was rejecting this --lite since kdump need the purgatory
> > integrity checks. Ccing him.
> 
> Right. Why are we trying to bypass sha256 hash verification of loaded
> segments at run time, that needs to be justified. 

Please see my reply to Dave.

> Atleast on x86, this integrity verification was fast and we did not
> notice any siginificant delays in purgatory. And in that case extra knob
> like this is hard to justify.

I notice the difference on the my arm64 system, so I guess we
are even on that.

In general, faster boot times are desirable.  This option allows
a faster system boot for kexec based bootloaders that use
kexec-tools.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
