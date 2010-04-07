Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]
	helo=VA3EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NzS9U-0007tU-69
	for kexec@lists.infradead.org; Wed, 07 Apr 2010 10:06:28 +0000
Date: Wed, 7 Apr 2010 12:05:38 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 0/4] AMD IOMMU kdump fix plus cleanups (v2)
Message-ID: <20100407100538.GK28166@amd.com>
References: <20100403012751.834020949@sous-sol.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100403012751.834020949@sous-sol.org>
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
To: Chris Wright <chrisw@sous-sol.org>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, ebiederm@xmission.com, vgoyal@redhat.com

On Fri, Apr 02, 2010 at 06:27:51PM -0700, Chris Wright wrote:
> Series includes the following patches:
> 
>   x86/amd-iommu: enable iommu before attaching devices
>   x86/amd-iommu: warn when issuing command to uninitialized cmd buffer
>   Revert "x86: disable IOMMUs on kernel crash"
>   x86/amd-iommu: use for_each_pci_dev
> 
> First one is the primary bug fix.
> 
> v2
> - add disable_iommus on failure path
> - move removal of CMD_BUFFER_UNINITIALIZED to iommu_enable_command_buffer()
> - fix ";;" typo in patch 2
> - add Revert "x86: disable IOMMUs on kernel crash"
> - add x86/amd-iommu: use for_each_pci_dev

Applied all, thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
