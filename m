Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpW5m-00063l-SU
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 07:49:19 +0000
Date: Thu, 29 Sep 2016 09:47:43 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: fix mem_regions_sort()
Message-ID: <20160929074743.GA19336@verge.net.au>
References: <7514609d50e28f6632e3a265fdd08020c33353b6.1469641659.git.panand@redhat.com>
 <CAHB_GuoySL5Dwns9a5OD8V1t2Eq3o6ZxXBZ5a35MfV216LaDvw@mail.gmail.com>
 <20160728143845.GR14726@flint.armlinux.org.uk>
 <20160729035219.GD27150@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160729035219.GD27150@localhost.localdomain>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Russell King <rmk@armlinux.org.uk>, Kexec Mailing List <kexec@lists.infradead.org>

On Fri, Jul 29, 2016 at 09:22:19AM +0530, Pratyush Anand wrote:
> Hi Simon,
> 
> Please take this fix for 2.0.13.
> 
> ~Pratyush
> On 28/07/2016:03:38:46 PM, Russell King wrote:
> > On Wed, Jul 27, 2016 at 11:22:24PM +0530, Pratyush Anand wrote:
> > > Missed CCing Russell because of --suppress-cc :(
> > > 
> > > CCing now.
> > > 
> > > On Wed, Jul 27, 2016 at 11:19 PM, Pratyush Anand <panand@redhat.com> wrote:
> > > > ranges->ranges is  "struct memory_range *", however each element which need
> > > > to be sorted is of type "struct memory_range". So, correct "size" argument
> > > > of qsort() as sizeof(*ranges->ranges).
> > 
> > Oops.  Yes, obviously correct.
> > 
> > Acked-by: Russell King <rmk@armlinux.org.uk>
> > 
> > > >
> > > > Signed-off-by: Pratyush Anand <panand@redhat.com>
> > > > Cc:Russell King <rmk@arm.linux.org.uk>
> > 
> > Please remove this Cc while adding my Acked-by.  Thanks.

Sorry, I completely missed this until now.
Applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
