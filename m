Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxMmV-0007Eg-NI
 for kexec@lists.infradead.org; Tue, 13 Aug 2019 02:43:29 +0000
Date: Tue, 13 Aug 2019 10:43:17 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: Crash kernel with 256 MB reserved memory runs into OOM condition
Message-ID: <20190813024317.GA2862@dhcp-128-65.nay.redhat.com>
References: <d65e4a42-1962-78c6-1b5a-65cb70529d62@molgen.mpg.de>
 <20190812095029.GE5117@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190812095029.GE5117@dhcp22.suse.cz>
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
To: Michal Hocko <mhocko@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, kasong@redhat.com, bhe@redhat.com, linux-pci@vger.kernel.org, =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Donald Buczek <buczek@molgen.mpg.de>, lijiang@redhat.com

Hi,

On 08/12/19 at 11:50am, Michal Hocko wrote:
> On Mon 12-08-19 11:42:33, Paul Menzel wrote:
> > Dear Linux folks,
> > 
> > 
> > On a Dell PowerEdge R7425 with two AMD EPYC 7601 (total 128 threads) and
> > 1 TB RAM, the crash kernel with 256 MB of space reserved crashes.
> > 
> > Please find the messages of the normal and the crash kernel attached.
> 
> You will need more memory to reserve for the crash kernel because ...
> 
> > [    4.548703] Node 0 DMA free:484kB min:4kB low:4kB high:4kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:568kB managed:484kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> > [    4.573612] lowmem_reserve[]: 0 125 125 125
> > [    4.577799] Node 0 DMA32 free:1404kB min:1428kB low:1784kB high:2140kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:15720kB writepending:0kB present:261560kB managed:133752kB mlocked:0kB kernel_stack:2496kB pagetables:0kB bounce:0kB free_pcp:212kB local_pcp:212kB free_cma:0kB
> 
> ... the memory is really depleted and nothing to be reclaimed (no anon.
> file pages) Look how tht free memory is below min watermark (node zone DMA has
> lowmem protection for GFP_KERNEL allocation).

We found similar issue on our side while working on kdump on SME enabled
systemd.  Kairui is working on some patches.

Actually on those SME/SEV enabled machines, swiotlb is enabled
automatically so at least we need extra 64M+ memory for kdump other
than the normal expectation.

Can you check if this is also your case?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
