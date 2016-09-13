Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from shards.monkeyblade.net ([184.105.139.130])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bjpaY-0000A0-Rp
 for kexec@lists.infradead.org; Tue, 13 Sep 2016 15:25:37 +0000
Date: Tue, 13 Sep 2016 11:25:10 -0400 (EDT)
Message-Id: <20160913.112510.2054378133306191773.davem@davemloft.net>
Subject: Re: [PATCH] bnx2: Reset device during driver initialization
From: David Miller <davem@davemloft.net>
In-Reply-To: <1473408667-7107-1-git-send-email-bhe@redhat.com>
References: <1473408667-7107-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
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
To: bhe@redhat.com
Cc: netdev@vger.kernel.org, sony.chacko@qlogic.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Dept-HSGLinuxNICDev@qlogic.com

From: Baoquan He <bhe@redhat.com>
Date: Fri,  9 Sep 2016 16:11:07 +0800

> When system enters into kdump kernel because of kernel panic, it won't
> shutdown devices. On-flight DMA will continue transferring data until
> device driver initializes. All devices are supposed to reset during
> driver initialization. And this property is used to fix the kdump
> failure in system with intel iommu. Other systems with hardware iommu
> should be similar. Please check commit 091d42e ("iommu/vt-d: Copy
> translation tables from old kernel") and those commits around it.
> 
> But bnx2 driver doesn't reset device during driver initialization. The
> device resetting is deferred to net device up stage. This will cause
> hardware iommu handling failure on bnx2 device. And its resetting relies
> on firmware. So in this patch move the firmware requesting code to earlier
> bnx2_init_one(), then next call bnx2_reset_chip to reset device.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Applied, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
