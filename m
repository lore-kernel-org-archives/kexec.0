Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpEUr-0007dV-HT
 for kexec@lists.infradead.org; Wed, 28 Sep 2016 13:02:02 +0000
Date: Wed, 28 Sep 2016 21:01:36 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v5 5/8] iommu/amd: copy old trans table from old kernel
Message-ID: <20160928130136.GA9185@x1.redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
 <1473951806-25511-6-git-send-email-bhe@redhat.com>
 <20160920124031.GD3541@8bytes.org>
 <20160928013702.GH14155@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160928013702.GH14155@x1.redhat.com>
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
Cc: kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, Vincent.Wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com

On 09/28/16 at 09:37am, Baoquan He wrote:
> Hi Joerg,
> 
> On 09/20/16 at 02:40pm, Joerg Roedel wrote:
> > > +	if ( !is_pre_enabled) {
> > > +		for_each_iommu(iommu)
> > > +			early_enable_iommu(iommu);
> > > +	} else {
> > > +		if (copy_dev_tables()) {
> > > +			pr_err("Failed to copy DEV table from previous kernel.\n");
> > > +			/*
> > > +			 * If failed to copy dev tables from old kernel, continue to proceed
> > > +			 * as it does in normal kernel.
> > > +			 */
> > > +			for_each_iommu(iommu) {
> > > +				clear_translation_pre_enabled(iommu);
> > > +				early_enable_iommu(iommu);
> > > +			}
> > > +		} else {
> > > +			pr_info("Copied DEV table from previous kernel.\n");
> > > +			for_each_iommu(iommu) {
> > > +				iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
> > > +		                iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
> > 
> > Could you move that into new helpers (iommu_disable_command_buffer...)?
> 
> Did you mean wraping iommu_feature_disable(iommu, CONTROL_CMDBUF_EN) into a
> helper function like iommu_disable_command_buffer(), and wraping
> iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN) into
> iommu_disable_event_buffer()?
> 
> I retest with not disabling command buffer and event log here, it works
> on amd iommu v1 and v2 systems. So if I understand your comment
> correctly, there's no need to add "iommu_feature_disable(iommu,
> CONTROL_CMDBUF_EN)"  and "iommu_feature_disable(iommu,
> CONTROL_EVT_LOG_EN)" here. I remember I added them here because more
> IO_PAGE_FAULT messages are printed without them. But now it seems not to
> related to them. So I will remove above two lines of code.

Oh, sorry, please ignore this. It will print many lines of below message
if do not disable cmd buffer and event log here.

[    0.455642] AMD-Vi: Completion-Wait loop timed out


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
