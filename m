Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZktIi-0001Wh-2r
 for kexec@lists.infradead.org; Sat, 10 Oct 2015 12:31:00 +0000
Date: Sat, 10 Oct 2015 20:30:36 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 09/10] iommu/amd: Clear the iommu pre enabled setting
Message-ID: <20151010123036.GC31787@dhcp-16-116.nay.redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
 <1443076656-31776-10-git-send-email-bhe@redhat.com>
 <20150929160949.GP3036@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150929160949.GP3036@8bytes.org>
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
Cc: iommu@lists.linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 09/29/15 at 06:09pm, Joerg Roedel wrote:
> On Thu, Sep 24, 2015 at 02:37:35PM +0800, Baoquan He wrote:
> > @@ -2469,6 +2469,8 @@ static dma_addr_t __map_single(struct device *dev,
> >  	unsigned long align_mask = 0;
> >  	int i;
> >  
> > +	if (translation_pre_enabled())
> > +		clear_translation_pre_enabled();
> 
> There is probably a better place to do this somewhere in the
> initialization state machine of the AMD IOMMU driver.

Yeah, I put it in state_next().

static int __init state_next(void)
{
        int ret = 0;

        switch (init_state) {
        case IOMMU_START_STATE:
	......

	case IOMMU_DMA_OPS:
                if (translation_pre_enabled())
                        clear_translation_pre_enabled();
                init_state = IOMMU_INITIALIZED;
                break;
	......
}

> 
> 
> 	Joerg
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
