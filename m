Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JyeXq-0004bp-Vd
	for kexec@lists.infradead.org; Wed, 21 May 2008 02:59:15 +0000
Date: Wed, 21 May 2008 12:59:06 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] PPC64: ensure that extra rtas segment is a multiple of
	PAGE_SIZE
Message-ID: <20080521025904.GC5126@verge.net.au>
References: <20080520152640.GB16652@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080520152640.GB16652@hmsreliant.think-freely.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, vgoyal@redhat.com

On Tue, May 20, 2008 at 11:26:40AM -0400, Neil Horman wrote:
> kexec on ppc64 systems, include an extra PT_LOAD segment if the rtas
> memory hits the stored kdump kernel image.  While the rtas area is
> memory mapped (implying that it begins and ends on a page boundary),
> the whole of the mapped region is not consumed by the rtas features
> (the remaining area just returns 0's).  This unused area is not
> accounted in the rtas prom, which is used to populate the proc files
> which export the size information that is used to define the mapped
> memory region (/proc/device-tree/rtas/rtas-size).  Since this is the
> data that kexec uses to generate the PT_LOAD segment, we wind up with
> a PT_LOAD segment that incorrectly contains a partial page.  This
> causes things like makedumpfile to fail, since it reads memory in page
> sized chunks, and fails on the inability to read only part of a page.
> This patch corrects that by rounding the extra segment size up the
> next whole page size.  This is safe, since the rtas area is mapped to
> a whole page range.  I've tested on both 4k and 64k configured kernels
> on ppc64 and found that it works well.
> 
> Regards Neil

Thanks Neil, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
