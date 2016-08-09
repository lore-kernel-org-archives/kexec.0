Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bWxfp-0006b9-Aq
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 03:25:50 +0000
Received: by mail-pa0-f44.google.com with SMTP id pp5so837736pac.3
 for <kexec@lists.infradead.org>; Mon, 08 Aug 2016 20:25:28 -0700 (PDT)
Date: Tue, 9 Aug 2016 08:55:25 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] kexec: fix mem_regions_sort()
Message-ID: <20160809032525.GA32460@localhost.localdomain>
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
To: Simon Horman <horms@verge.net.au>
Cc: Russell King <rmk@armlinux.org.uk>, Kexec Mailing List <kexec@lists.infradead.org>

Hi Simon,

This was a fixup which got missed in 2.0.13.
Anyway, it can be taken now.

Thanks

~Pratyush

On 29/07/2016:09:22:19 AM, Pratyush Anand wrote:
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
> > 
> > -- 
> > Russell King

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
