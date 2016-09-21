Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmeeK-0008IZ-Dy
 for kexec@lists.infradead.org; Wed, 21 Sep 2016 10:21:10 +0000
Date: Wed, 21 Sep 2016 18:20:44 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v5 6/8] iommu/amd: Do not re-enable dev table entries in
 kdump
Message-ID: <20160921102044.GC13350@x1.redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
 <1473951806-25511-7-git-send-email-bhe@redhat.com>
 <20160920124241.GE3541@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160920124241.GE3541@8bytes.org>
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

On 09/20/16 at 02:42pm, Joerg Roedel wrote:
> On Thu, Sep 15, 2016 at 11:03:24PM +0800, Baoquan He wrote:
> > This enabling should have been done in normal kernel. It's unnecessary
> > to enable it again in kdump kernel.
> > 
> > And clean up the function comments of init_device_table_dma.
> 
> Well, no. We don't want to make any assumptions on what the previous
> kernel did and what it did not. The init_device_table_dma() code should
> run anyway.

Yes, right. I forget people could set amd_iommu=off in 1st kernel, but
remove it in kdump kernel. Will change and merge the comment clean up
into another patch.

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
