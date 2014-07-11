Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5c4c-0000oI-BD
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 14:45:18 +0000
Date: Fri, 11 Jul 2014 10:44:56 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 7/7] add a new interface to show the memory usage of 1st
 kernel
Message-ID: <20140711144456.GI15611@redhat.com>
References: <1405062964-11406-1-git-send-email-bhe@redhat.com>
 <1405062964-11406-7-git-send-email-bhe@redhat.com>
 <20140711142639.GG15611@redhat.com>
 <20140711143530.GB5851@dhcp-17-102.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140711143530.GB5851@dhcp-17-102.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On Fri, Jul 11, 2014 at 10:35:30PM +0800, Baoquan He wrote:

[..]
> > How about calling them just "User process pages" and not "user process
> > data pages" I am assuming that they could contain text too.
> 
> This function is based on the print_report() which is in makedumpfile.
> It has been defined like these already. But I will change this according
> reviewer's comments. After all, they are different.

Actually notation should match what's in makedumpfile man page. So that
a user can easily associate dump filtering levels with pages here.

> 
> > 
> > > pfn_free		0x0000000000133f79	yes		Free pages
> > > pfn_hwpoison		0x0000000000000000	yes		Hwpoison pages
> > > pfn_kernel_data		0x000000000001dd56	no		Dumpable kernel data
> > > 
> > > Total pages on system:	0x00000000001e5f57
> > > Excludable pages:	0x00000000001c8201
> > > Memory Hole: 		0x00000000000386a9
> > 
> > What is "Memory Hole" ?
> 
> That areas which are between "System Ram".

I think we should remove it from output. We are not concerned where memory
holes are. One can look up /proc/iomem to figure out where memory holes
are.

> 
> > 
> > > --------------------------------------------------
> > > Total pages:		0x000000000021e600
> > 
> > How this total pages is different from "Total pages on system"?
> 
> "Total pages on system" is all physical pages without hole. "Total pages"
> is equal to the max_pfn in current system. This is got from the
> print_report() too. It could be removed if people think it's useless.

We are just interested in total pages without memory hole. And can
remove total pages with memory hole.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
