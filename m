Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XM0VO-0001iv-36
 for kexec@lists.infradead.org; Mon, 25 Aug 2014 20:04:42 +0000
Date: Mon, 25 Aug 2014 16:04:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 8/8] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140825200418.GK14379@redhat.com>
References: <1408937592-2609-1-git-send-email-bhe@redhat.com>
 <1408937592-2609-9-git-send-email-bhe@redhat.com>
 <20140825063622.GB1501@dhcp-16-105.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140825063622.GB1501@dhcp-16-105.nay.redhat.com>
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

On Mon, Aug 25, 2014 at 02:36:22PM +0800, Baoquan He wrote:
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
> The created dumpfile may be incomplete.

I still think that above messages should go. It does not make
any sense with --mem-usage. No dumpfile is being created here.

> Excluding unnecessary pages        : [100.0 %] |


> 
> Page number of memory in different use
> --------------------------------------------------

I think above header can completely go away.  It kind of looks odd.

> TYPE		PAGES			EXCLUDABLE	DESCRIPTION
> ZERO		29149           	yes		Pages filled with zero
> CACHE		171288          	yes		Cache pages
> CACHE_PRIVATE	12051           	yes		Cache pages + private
> USER		31816           	yes		User process pages
> FREE		3700059         	yes		Free pages
> KERN_DATA	105305          	no		Dumpable kernel data 
> 
> Total pages on system:	4049668         
> 
> Showing page number of memory in different use successfully.

I think we don't need above line. I am not even sure what does it mean.
> 
> makedumpfile Completed.

We don't need above line either.

In output we should just show the actual table. If there is an error, 
we should output error and exit (no table).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
