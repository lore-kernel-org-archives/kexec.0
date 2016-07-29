Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bSyqq-00050V-2l
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 03:52:46 +0000
Received: by mail-pa0-f44.google.com with SMTP id ks6so27036123pab.0
 for <kexec@lists.infradead.org>; Thu, 28 Jul 2016 20:52:22 -0700 (PDT)
Date: Fri, 29 Jul 2016 09:22:19 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] kexec: fix mem_regions_sort()
Message-ID: <20160729035219.GD27150@localhost.localdomain>
References: <7514609d50e28f6632e3a265fdd08020c33353b6.1469641659.git.panand@redhat.com>
 <CAHB_GuoySL5Dwns9a5OD8V1t2Eq3o6ZxXBZ5a35MfV216LaDvw@mail.gmail.com>
 <20160728143845.GR14726@flint.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160728143845.GR14726@flint.armlinux.org.uk>
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

Please take this fix for 2.0.13.

~Pratyush
On 28/07/2016:03:38:46 PM, Russell King wrote:
> On Wed, Jul 27, 2016 at 11:22:24PM +0530, Pratyush Anand wrote:
> > Missed CCing Russell because of --suppress-cc :(
> > 
> > CCing now.
> > 
> > On Wed, Jul 27, 2016 at 11:19 PM, Pratyush Anand <panand@redhat.com> wrote:
> > > ranges->ranges is  "struct memory_range *", however each element which need
> > > to be sorted is of type "struct memory_range". So, correct "size" argument
> > > of qsort() as sizeof(*ranges->ranges).
> 
> Oops.  Yes, obviously correct.
> 
> Acked-by: Russell King <rmk@armlinux.org.uk>
> 
> > >
> > > Signed-off-by: Pratyush Anand <panand@redhat.com>
> > > Cc:Russell King <rmk@arm.linux.org.uk>
> 
> Please remove this Cc while adding my Acked-by.  Thanks.
> 
> -- 
> Russell King

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
