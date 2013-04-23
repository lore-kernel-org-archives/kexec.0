Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from 8bytes.org ([85.214.48.195] helo=mail.8bytes.org)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UUcf9-00082i-6i
 for kexec@lists.infradead.org; Tue, 23 Apr 2013 12:49:36 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 1BE1912B049
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 14:49:29 +0200 (CEST)
Date: Tue, 23 Apr 2013 14:49:27 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] intel-iommu: Disable translation if already enabled
Message-ID: <20130423124926.GC2589@8bytes.org>
References: <1366706103-2640-1-git-send-email-indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1366706103-2640-1-git-send-email-indou.takao@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, iommu@lists.linux-foundation.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org, wei@aristanetworks.com

On Tue, Apr 23, 2013 at 05:35:03PM +0900, Takao Indoh wrote:
> This patch disables translation(dma-remapping) before its initialization
> if it is already enabled.
> 
> This is needed for kexec/kdump boot. If dma-remapping is enabled in the
> first kernel, it need to be disabled before initializing its page table
> during second kernel boot. Wei Hu also reported that this is needed
> when second kernel boots with intel_iommu=off.
> 
> Basically iommu->gcmd is used to know whether translation is enabled or
> disabled, but it is always zero at boot time even when translation is
> enabled since iommu->gcmd is initialized without considering such a
> case. Therefor this patch synchronizes iommu->gcmd value with global
> command register when iommu structure is allocated.
> 
> Changelog:
> v2:
> - Change subject and patch description
> - Disable translation after dmar_table_init() so that it works when
>   intel_iommu=off is specified.
> 
> v1:
> https://lkml.org/lkml/2013/3/20/707
> 
> Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
> ---
>  drivers/iommu/dmar.c        |   11 ++++++++++-
>  drivers/iommu/intel-iommu.c |   15 +++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletions(-)

Looks good to me, applied to x86/vt-d, thanks Takao.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
