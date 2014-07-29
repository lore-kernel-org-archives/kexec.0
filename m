Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XC6lO-0008ME-27
 for kexec@lists.infradead.org; Tue, 29 Jul 2014 12:44:18 +0000
Date: Tue, 29 Jul 2014 08:43:55 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch v3 7/7] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140729124355.GA27389@redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-8-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1406535606-16303-8-git-send-email-bhe@redhat.com>
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

On Mon, Jul 28, 2014 at 04:20:06PM +0800, Baoquan He wrote:
> Recently people complained that they don't know how to decide how
> much disk size need be reserved for kdump. E.g there are lots of
> machines with different memory size, if the memory usage information
> of current system can be shown, that can help them to make an estimate
> how much storage space need be reserved.
> 
> In this patch, a new interface is added into makedumpfile. By the
> help of this, people can know the page number of memory in different
> use. The implementation is analyzing the "System Ram" and "kernel text"
> program segment of /proc/kcore excluding the crashkernel range, then
> calculating the page number of different kind per vmcoreinfo.
> 
> The print is like below:
> ->$ ./makedumpfile  --mem-usage  /proc/kcore
> Excluding unnecessary pages        : [100.0 %] |

I think above message is now unnecessary. In fact we are not excluding
any pages.

> 
> Page number of memory in different use
> --------------------------------------------------

Above is not required.


> TYPE		PAGES			EXCLUDABLE	DESCRIPTION

We probably should put dashes under these headers

TYPE		PAGES			EXCLUDABLE	DESCRIPTION
====		=====			==========	===========

> ZERO		0               	yes		Pages filled with zero
> CACHE		562006          	yes		Cache pages
> CACHE_PRIVATE	353502          	yes		Cache pages + private
> USER		225780          	yes		User process pages
> FREE		2761884         	yes		Free pages
> KERN_DATA	235873          	no		Dumpable kernel data

What's "Dumpable kernel data" ? Are we saying they are kernel pages which
can't be filtered?

Why not simply call them "kernel data" or "kernel pages" 


> 
> Total pages on system:	4139045

How about "Total number of pages".

Otherwise this output looks much better than previous version. Thanks for
the changes.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
