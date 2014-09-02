Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XOmdp-0002bD-H7
 for kexec@lists.infradead.org; Tue, 02 Sep 2014 11:52:53 +0000
Date: Tue, 2 Sep 2014 07:52:30 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 8/8] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140902115230.GA2181@redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <1409541340-2719-9-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409541340-2719-9-git-send-email-bhe@redhat.com>
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

On Mon, Sep 01, 2014 at 11:15:40AM +0800, Baoquan He wrote:
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
> 
> ~$ ./makedumpfile --mem-usage /proc/kcore
> The kernel version is not supported.
> The makedumpfile operation may be incomplete.
> Excluding unnecessary pages        : [100.0 %] |
> 
> ----------------------------------------------------------------------
^^^^^

Why this line is there?

> TYPE		PAGES			EXCLUDABLE	DESCRIPTION
> ZERO		28823           	yes		Pages filled with zero
> CACHE		197932          	yes		Cache pages
> CACHE_PRIVATE	15862           	yes		Cache pages + private
> USER		30778           	yes		User process pages
> FREE		3671105         	yes		Free pages
> KERN_DATA	105168          	no		Dumpable kernel data
> 
> Total pages on system:	4049668

So this is assuming page size 4K? If some arch is using 16K or 64K,
will it still work correctly.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
