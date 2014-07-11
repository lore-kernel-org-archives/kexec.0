Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5bvX-0003ji-0O
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 14:35:55 +0000
Date: Fri, 11 Jul 2014 22:35:30 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 7/7] add a new interface to show the memory usage of 1st
 kernel
Message-ID: <20140711143530.GB5851@dhcp-17-102.nay.redhat.com>
References: <1405062964-11406-1-git-send-email-bhe@redhat.com>
 <1405062964-11406-7-git-send-email-bhe@redhat.com>
 <20140711142639.GG15611@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140711142639.GG15611@redhat.com>
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
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On 07/11/14 at 10:26am, Vivek Goyal wrote:
> On Fri, Jul 11, 2014 at 03:16:04PM +0800, Baoquan He wrote:

> Hi Bao,
> 
> How about priting number of pages in decimal numbers. Humans read decimal
> numbers much better.

That's fine too. I can change it to decimal number. Just think that
maybe it's mainly used by script.


> 
> 
> > --------------------------------------------------
> > TYPE			PAGES			EXCLUDABLE	DESCRIPTION
> > pfn_zero		0x0000000000000000	yes		Pages filled with zero
> 
> I am wondering if we display TYPE of page as follows. Will it be more
> redable

OK, will change.

> 
> ZERO
> CACHE
> CACHE_PRIVATE
> ..
> ..
> 
> > pfn_cache		0x000000000002b19f	yes		Cache pages
> > pfn_cache_private	0x0000000000042526	yes		Cache pages + private
> > pfn_user		0x0000000000026bc3	yes		User process data pages
> 
> How about calling them just "User process pages" and not "user process
> data pages" I am assuming that they could contain text too.

This function is based on the print_report() which is in makedumpfile.
It has been defined like these already. But I will change this according
reviewer's comments. After all, they are different.

> 
> > pfn_free		0x0000000000133f79	yes		Free pages
> > pfn_hwpoison		0x0000000000000000	yes		Hwpoison pages
> > pfn_kernel_data		0x000000000001dd56	no		Dumpable kernel data
> > 
> > Total pages on system:	0x00000000001e5f57
> > Excludable pages:	0x00000000001c8201
> > Memory Hole: 		0x00000000000386a9
> 
> What is "Memory Hole" ?

That areas which are between "System Ram".

> 
> > --------------------------------------------------
> > Total pages:		0x000000000021e600
> 
> How this total pages is different from "Total pages on system"?

"Total pages on system" is all physical pages without hole. "Total pages"
is equal to the max_pfn in current system. This is got from the
print_report() too. It could be removed if people think it's useless.

> 
> Thanks
> Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
