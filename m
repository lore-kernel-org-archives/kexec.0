Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1biI7F-0002Pm-21
 for kexec@lists.infradead.org; Fri, 09 Sep 2016 09:28:57 +0000
Date: Fri, 9 Sep 2016 17:28:30 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] bnx2: Reset device during driver initialization
Message-ID: <20160909092830.GH11356@x1.redhat.com>
References: <1473408667-7107-1-git-send-email-bhe@redhat.com>
 <20160909082225.GE11356@x1.redhat.com>
 <20160909084106.GY1437@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160909084106.GY1437@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: Dept-HSGLinuxNICDev@qlogic.com, sony.chacko@qlogic.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, dyoung@redhat.com, kexec@lists.infradead.org

Hi Joerg,

On 09/09/16 at 10:41am, Joerg Roedel wrote:
> 
> Hi Baoquan,
> 
> On Fri, Sep 09, 2016 at 04:22:25PM +0800, Baoquan He wrote:
> > Recently I tried to fix the kdump failure in amd iommu system again, and
> > now the latest code works, IO_PAGE_FAULT can't be seen any more. But on
> > several amd iommu system with bnx2 NIC, always IO_PAGE_FAULT will be
> > printed out. After investegating I found out bnx2 driver doesn't reset
> > hardware/reg like other pci device, it does the reset job in bnx2_open
> > which is the net device up stage. So with this patch the IO_PAGE_FAULT
> > is away too on the system with bnx2 NIC. I will 
> > 
> > However when I got a intel system with vt-d and bnx2 NIC, kdump works
> > well, and no any error message can be seen. From code it clearly shows
> > the domain assignment is done in __intel_map_single, at this time bnx2
> > driver hasn't reset device, the on-flight DMA should still exist. Do you
> > have any idea on this? Or I missed anything? I also deferred the
> > set_dte_entry calling to __map_single calling, the principal should be
> > similar.
> 
> Did you make sure that all unity-mappings are in place in the newly
> assigned domain for the bnx2 device before domains are switched?

What I am doing is that in iommu driver init stage anything will keep
going forware as it does in normal kernel except for set_dte_entry
calling. If in kdump kernel and in iommu init stage, just return
directly at the beginning of set_dte_entry.

For identity mapping, the pass through handling will do everything but
return from the beginning of set_dte_entry too. Since it need install
pte_root into dev table entry too though its pte_root is NULL. The unity
mapping range only does iova reservation. It doesn't do dev table entry
handling before device driver init.

So unity mappings should be OK.

Thanks a lot!

Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
