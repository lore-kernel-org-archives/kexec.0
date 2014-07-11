Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5VNP-0005mR-8y
 for kexec@lists.infradead.org; Fri, 11 Jul 2014 07:36:15 +0000
Date: Fri, 11 Jul 2014 15:35:43 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 7/7] add a new interface to show the memory usage of 1st
 kernel
Message-ID: <20140711073543.GC1547@dhcp-17-102.nay.redhat.com>
References: <1405062964-11406-1-git-send-email-bhe@redhat.com>
 <1405062964-11406-7-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1405062964-11406-7-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: vgoyal@redhat.com

Hi,

In this patch, I set info->dump_level=MAX_DUMP_LEVEL, and
info->flag_cyclic=TRUE; With MAX_DUMP_LEVEL all kinds of memory can be
calculated. And under cyclic mode, function get_num_dumpable_cyclic() is
ready to do the page number calculation of memory in different use.

There's miss in [patch 7/7 v1], please reivew [patch 7/7 v2].

Thanks
Baoquan

On 07/11/14 at 03:16pm, Baoquan He wrote:
> Recently people complained that they don't decide how much disk size
> need be reserved for kdump storing. E.g there are lots of machines
> with different memory size, if the memory usage information of current
> system can be shown, that can help them to make an estimate how much
> storage space need be reserved.
> 
> In this patch, a new interface is added into makedumpfile. With the
> help of this, people can know the page number of memory in different
> use. The implementation is analyzing the "System Ram" and "kernel text"
> program segment of /proc/kcore excluding the crashkernel range, then
> calculating the page number of different kind per vmcoreinfo.
> 
> The print is like below:
> ->$ ./makedumpfile  --mem-usage  /proc/kcore
> Excluding unnecessary pages        : [100.0 %] |
> 
> Page number of memory in different use
> --------------------------------------------------
> TYPE			PAGES			EXCLUDABLE	DESCRIPTION
> pfn_zero		0x0000000000000000	yes		Pages filled with zero
> pfn_cache		0x000000000002b19f	yes		Cache pages
> pfn_cache_private	0x0000000000042526	yes		Cache pages + private
> pfn_user		0x0000000000026bc3	yes		User process data pages
> pfn_free		0x0000000000133f79	yes		Free pages
> pfn_hwpoison		0x0000000000000000	yes		Hwpoison pages
> pfn_kernel_data		0x000000000001dd56	no		Dumpable kernel data
> 
> Total pages on system:	0x00000000001e5f57
> Excludable pages:	0x00000000001c8201
> Memory Hole: 		0x00000000000386a9
> --------------------------------------------------

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
