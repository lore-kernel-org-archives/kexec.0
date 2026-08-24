Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0F1C5DF81
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2JSlxwskXTbuoDvNvgTyyULaG2qnymU60jxRuo89A6s=; b=PPtSEcKJlQp7K/V75SEKgEOgc4
	Tap5blK/RiE8eiXb3LSWCbPC1wmb0dfw3IVK4IqXdRPYFMGIQn/dHk3zjk3rPpdDIBwwVtZtKSw6x
	YAOqZm7mEukL3RGsDZMs1EJv+at3UC3992WTHFW55pL/ZBiwwFRGDEITM8bxgNfEExqiNXRbOgo0g
	6shwLZEVYegeH9i2L4C5dXjXGnhr3QGx0QVmUaxgSYEm4ApC903niwM7ZuLs1+jAhtC+a0kQH/ntF
	YUboY5c5uDZVBMXzhcsicKyeNy4fwrXg1gmfzT7SV6+0te5q5S/Xalf2CvMVWfEDtxNn5eOnA9Tjc
	UTk+D9gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyasf-0000000HL34-2Icf;
	Mon, 24 Aug 2026 20:02:53 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyasc-0000000HL2G-2lRI
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 20:02:51 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2d3b445a84fso2795ad.1
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787601770; x=1788206570; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2JSlxwskXTbuoDvNvgTyyULaG2qnymU60jxRuo89A6s=;
        b=Kakm9+CcCOOI0u1UfSDZ3a+PrhQCqpFEZHLPfMrBhpLlIvAJdsTIHy4jMbkmeZLWjy
         OgmNeLKfMpJb8Vi8kPuWRrA3KBy1r2Cd32i1Mp9Jl/yMO6TYvIEwVrrLSKnCWUNuV2Po
         himNulgt2Kay91a+9AE9GeY7AP9mZvkCgwYlD8hk/wmWU18IZdq89PmO7fntkBR66XYf
         s1sBUlv6BmDx2Orh8BnahPw2qrIucHxkh0DxxaAeJJqkzo0vf/dDpHGaU6E6QSSFMVdI
         6GdeFP6CWr4Bin2Ir0o7ghlsYg60Yxwsq15RCI3SbeU3kUVhEsRpBy3fwoRR0z1Fr4ft
         +Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601770; x=1788206570;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JSlxwskXTbuoDvNvgTyyULaG2qnymU60jxRuo89A6s=;
        b=Y2yfQxR66J+0+R8avwEhu8v7aE011a7xuE9SR24IxZxCZ639xUjDolMIkB+9AzWDbz
         ceflhf8wmkISOF44K/BGZA7fiAuhTP3SJ1oDZgU74qBN9+3Wiecyqv84evKmiAGzphk5
         xOIvGICrfPnkUBqpdwuxMzcvzHPh2H9U/NchhQglq2Mvi0DODMUsFVdPRbaZc4c4iizW
         88V3b23NiYlBZD32Kq893CjkrTo4ThRSg0Zn9oCDPG6Q148AYl8x5Ypkl1qLeWCHHYN6
         NuY36+B+5w+D/ckzysxuYivMYYwrRcVNHmyCStGLtQA1GJ8dGAsjPUKC1w/Vcf5J6kg8
         yQ8g==
X-Gm-Message-State: AFuF++mzLUX8ECRLY30jn/ivrLashQQVfr/5gLPA39m3bBi6bVLu2et/
	2TPAF+UKBSLUSBJkVMElmkZ0MdIKTG2avvXI0iVC6OdIw/iuDPE1kP4ZReBDxi1uvg==
X-Gm-Gg: AR+sD118uP1sKXSDyT8feCltHVYNyQcclGMILO/Iuo3N4r5eQu/2nVle/CF3AMjAKVv
	bGXXQQ3fSes58htV45mikfc1V/MFe/FqCnJoljUC2fRSeIgm1U7lfFEY1rKXtxk2BJG4tmGtG+1
	3zDbwN4RusOiuWH19dhmsh6DI2bOH8whwXjHYpgL+FdHhMZoAD/HB3BVZo7wGUE+CIv8Lc7MLoa
	c2jZAHyIhjhgi0agLHHIRGvNw2n3Lu4x+8S1J57cnw5T+x7EAmDBddYG/X+28g2p/mZzeiQTk3g
	PTRv88VbiUJIPh+sHusvWzcaL7NrhSWZR2AcJ3FrYi5qfvf4n56iYPUF1mOstE02K3tHgEp1dUq
	NMUnJdKhV1MaJPI0mzpDV8hCfx+zqU6A5ssStzot3BaYLwLEeza9Ih+T8p/o+zYCpB+pzA5JfHw
	EYRWeAcUDwcyx9z6BaHDxZL0/ilJGdpCvzijH7JR0cGlE8TMm/Jt/HXbQ+3/wlHGqt6P6LJ6JvI
	ysVc+1vi4IU3ybSRQcvGNwPGoWoCxCKYVnEnJihcPvDt/6vcAfUvD2Kccc=
X-Received: by 2002:a17:902:cecb:b0:2d0:1aaf:daec with SMTP id d9443c01a7336-2d6e0830038mr894155ad.9.1787601769181;
        Mon, 24 Aug 2026 13:02:49 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645da08desm723671a91.17.2026.08.24.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:02:48 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:02:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 11/12] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Message-ID: <aoyjVL6sjG7xh9jB@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-12-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-12-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_130250_699924_CE419759 
X-CRM114-Status: GOOD (  11.34  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Jul 28, 2026 at 10:10:05PM +0000, David Matlack wrote:
>Do not disable bus mastering on outgoing preserved devices during
>pci_device_shutdown() for kexec.
>
>Preserved devices must be allowed to perform memory transactions during
>a Live Update to ensure continuous operation.  Clearing the bus
>mastering bit would prevent these devices from issuing any memory
>requests while the new kernel boots.
>
>Because bridges upstream of preserved endpoint devices are also
>automatically preserved, this change also avoids clearing bus mastering
>on them. This is critical because clearing bus mastering on an upstream
>bridge prevents the bridge from forwarding memory requests upstream (i.e.
>it would prevent the endpoint device from accessing system RAM and doing
>peer-to-peer transactions with devices not downstream of the bridge).
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/liveupdate.c | 11 +++++++++++
> drivers/pci/liveupdate.h |  6 ++++++
> drivers/pci/pci-driver.c |  7 +++++--
> 3 files changed, 22 insertions(+), 2 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

