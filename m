Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XCgCB-0003vl-2d
 for kexec@lists.infradead.org; Thu, 31 Jul 2014 02:34:19 +0000
Date: Thu, 31 Jul 2014 10:32:37 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v3 7/7] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140731023237.GB4003@dhcp-16-105.nay.redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-8-git-send-email-bhe@redhat.com>
 <20140729124355.GA27389@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140729124355.GA27389@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On 07/29/14 at 08:43am, Vivek Goyal wrote:
> On Mon, Jul 28, 2014 at 04:20:06PM +0800, Baoquan He wrote:
> > Recently people complained that they don't know how to decide how
> > much disk size need be reserved for kdump. E.g there are lots of
> > machines with different memory size, if the memory usage information
> > of current system can be shown, that can help them to make an estimate
> > how much storage space need be reserved.
> > 
> > In this patch, a new interface is added into makedumpfile. By the
> > help of this, people can know the page number of memory in different
> > use. The implementation is analyzing the "System Ram" and "kernel text"
> > program segment of /proc/kcore excluding the crashkernel range, then
> > calculating the page number of different kind per vmcoreinfo.
> > 
> > The print is like below:
> > ->$ ./makedumpfile  --mem-usage  /proc/kcore
> > Excluding unnecessary pages        : [100.0 %] |
> 
> I think above message is now unnecessary. In fact we are not excluding
> any pages.

I reused the function get_num_dumpable_cyclic(). It will iterate each
pages to check whether it's dumpable or not based on the dump_level
specified. While above message is printed inside a internal function. I
don't think it's very necessary, but also I don't think it will misguide
people to think of too much about it. It just tell the progress of
filtering, and could be a little helpful if it's working on a large
memory, say more than 1T memory.

> 
> > 
> > Page number of memory in different use
> > --------------------------------------------------
> 
> Above is not required.

OK, will remove it.

> 
> 
> > TYPE		PAGES			EXCLUDABLE	DESCRIPTION
> 
> We probably should put dashes under these headers
> 
> TYPE		PAGES			EXCLUDABLE	DESCRIPTION
> ====		=====			==========	===========

I am fine with this, will add dashes to decorate it.


> 
> > ZERO		0               	yes		Pages filled with zero
> > CACHE		562006          	yes		Cache pages
> > CACHE_PRIVATE	353502          	yes		Cache pages + private
> > USER		225780          	yes		User process pages
> > FREE		2761884         	yes		Free pages
> > KERN_DATA	235873          	no		Dumpable kernel data
> 
> What's "Dumpable kernel data" ? Are we saying they are kernel pages which
> can't be filtered?
> 
> Why not simply call them "kernel data" or "kernel pages" 

Yes, it's misled. WIll change.


> 
> 
> > 
> > Total pages on system:	4139045
> 
> How about "Total number of pages".

Will change.

> 
> Otherwise this output looks much better than previous version. Thanks for
> the changes.
> 
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
