Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TwIx9-0008EK-Lz
 for kexec@lists.infradead.org; Fri, 18 Jan 2013 20:54:20 +0000
Date: Fri, 18 Jan 2013 15:54:13 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH v1 0/3] kdump, vmcore: Map vmcore memory in direct
 mapping region
Message-ID: <20130118205413.GB10969@redhat.com>
References: <20130110115615.645.56499.stgit@localhost6.localdomain6>
 <20130117221348.GJ2237@redhat.com>
 <20130118.230659.282304499.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130118.230659.282304499.d.hatayama@jp.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Rik Van Riel <riel@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

On Fri, Jan 18, 2013 at 11:06:59PM +0900, HATAYAMA Daisuke wrote:

[..]
> > These are impressive improvements. I missed the discussion on mmap().
> > So why couldn't we provide mmap() interface for /proc/vmcore. If that
> > works then application can select to mmap/unmap bigger chunks of file
> > (instead ioremap mapping/remapping a page at a time). 
> > 
> > And if application controls the size of mapping, then it can vary the
> > size of mapping based on available amount of free memory. That way if
> > somebody reserves less amount of memory, we could still dump but with
> > some time penalty.
> > 
> 
> mmap() needs user-space page table in addition to kernel-space's,

[ CC Rik van Riel] 

I was chatting with Rik and it does not look like that there is any
fundamental requirement that range of pfn being mapped in user tables
has to be mapped in kernel tables too. Did you run into specific issue.

> and
> it looks that remap_pfn_range() that creates the user-space page
> table, doesn't support large pages, only 4KB pages.

This indeed looks like the case. May be we can enahnce remap_pfn_range()
to take an argument and create larger size mappings.

> If mmaping small
> chunks only for small memory programming, then we would again face the
> same issue as with ioremap.

Even if it is 4KB pages, I think it will still be faster than current
interface. Because we will not be issuing these many tlb flushes.
(Assuming makedumpfile has been modified to map/unap large areas of
/proc/vmcore).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
