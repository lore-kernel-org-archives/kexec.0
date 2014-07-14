Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X6Yj4-0004pZ-Fj
 for kexec@lists.infradead.org; Mon, 14 Jul 2014 05:22:59 +0000
Date: Mon, 14 Jul 2014 13:22:29 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 7/7] add a new interface to show the memory usage of 1st
 kernel
Message-ID: <20140714052229.GB1717@dhcp-17-102.nay.redhat.com>
References: <1405062964-11406-1-git-send-email-bhe@redhat.com>
 <1405062964-11406-7-git-send-email-bhe@redhat.com>
 <20140711143503.GH15611@redhat.com>
 <20140711143945.GC5851@dhcp-17-102.nay.redhat.com>
 <20140711144627.GJ15611@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140711144627.GJ15611@redhat.com>
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

On 07/11/14 at 10:46am, Vivek Goyal wrote:
> On Fri, Jul 11, 2014 at 10:39:45PM +0800, Baoquan He wrote:
> > On 07/11/14 at 10:35am, Vivek Goyal wrote:
> > > On Fri, Jul 11, 2014 at 03:16:04PM +0800, Baoquan He wrote:
> > > > ->$ ./makedumpfile  --mem-usage  /proc/kcore
> > > > Excluding unnecessary pages        : [100.0 %] |
> > > > 
> > > > Page number of memory in different use
> > > > --------------------------------------------------
> > > > TYPE			PAGES			EXCLUDABLE	DESCRIPTION
> > > > pfn_zero		0x0000000000000000	yes		Pages filled with zero
> > > > pfn_cache		0x000000000002b19f	yes		Cache pages
> > > > pfn_cache_private	0x0000000000042526	yes		Cache pages + private
> > > > pfn_user		0x0000000000026bc3	yes		User process data pages
> > > > pfn_free		0x0000000000133f79	yes		Free pages
> > > > pfn_hwpoison		0x0000000000000000	yes		Hwpoison pages
> > > 
> > > Is there a need to display hwpoison pages? I think they are excluded by
> > > default. Otherwise reading them might kill makedumpfile process.
> > 
> > You are right, hwpoison pages are excluded by default. But it truly
> > calculated in makedumpfile. I will change it as non-excludable like
> > below:
> > 
> > TYPE			PAGES			EXCLUDABLE	DESCRIPTION
> > pfn_hwpoison		0x0000000000000000	No		Hwpoison pages
> 
> I think we don't have to display hwpoison pages. It is of no use. Let us
> just display the pages which can be excluded using various filtering
> levels and total number of pages (without memory hole).
> 
> That way people can do some math.
> 
> amount of disk space required = total_pages - filtered pages;

Sounds reasonable! Will change.

> 
> Thanks
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
