Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F6CCCFA1A
	for <kexec@archiver.kernel.org>; Tue, 11 Nov 2025 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o7iVquRCsSK8fTZI//abqOQQYNcId3LHlW2ScL9MriU=; b=nPBpgLHA15+pA3u8TfI1KtQBV6
	n2NgPjB/jLjuHKE0HB2ROYU8+gnhzMKjzLfN1zJ4F7KC2ClJpKCsVkUn/jA7ktcxClT1XeKSd23pL
	rk6fgvKjygrHIoXkYOUacrblu8SZqXyUAWUq2vAHb8LJvi+vXt+tu1zEyOjyIYsl9yO8LoCNlE9b8
	GlvND+l31kYXH04T4s+ErJ0lPaFEJHjrMTBemmkW0JIRL+cDUp++4s6Kj9TfQzeiKylX/UnhOMHaR
	XUeutx3d1yaZbcfLlvW9oyWo5mXxs4v1vQ2gxGkd8xAbfJv3SpQ5MCbGjr6r/kEvrCEej9vZZwe+S
	RqNFXsfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIokn-00000007GK6-3MnR;
	Tue, 11 Nov 2025 13:49:49 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIokl-00000007GJZ-2cTY
	for kexec@lists.infradead.org;
	Tue, 11 Nov 2025 13:49:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B537A60214;
	Tue, 11 Nov 2025 13:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927D1C113D0;
	Tue, 11 Nov 2025 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762868986;
	bh=8MOgDcP+hzOoEsUBJ/yFGynorLiidim4fQ8MMVrhaXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5JbjAzbTiHxY4LVSBrpdYCVd4n9NVQagFVEOCITXh+8szyZPDPj2lKy6CkESm10e
	 yFiOswGDrE32yXBlwH72V07BSGTjROM9kOxlUAW9JXkWF9w8xjS5WQzfmEB7W4gmfF
	 uJsj563ercwG9bnlyj+UtUn33kIBoCaMmUmB2svsZ9wfF6QAj696qvqetz8bv269oA
	 avwF102KbPd9B3gwVROJwNUvFHUv51+awCfVlD6t0fbDDZcbR1RGvTlcBLKeqe5WJP
	 qUGOvuzxqBPvGhRxqa38tOOWthCvcy4wtrABO43jhwxYHkb2YTbDkGbIHa97oUIKK2
	 Ln9idSYzTBSTg==
Date: Tue, 11 Nov 2025 13:49:43 +0000
From: Simon Horman <horms@kernel.org>
To: Qiang Ma <maqianga@uniontech.com>
Cc: kexec@lists.infradead.org, bhe@redhat.com
Subject: Re: [PATCH] kexec: add kexec flag to support debug printing
Message-ID: <aRM-9xt_obIL1XpX@horms.kernel.org>
References: <20251104025959.1948450-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104025959.1948450-1-maqianga@uniontech.com>
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

On Tue, Nov 04, 2025 at 10:59:59AM +0800, Qiang Ma wrote:
> This add KEXEC_DEBUG to kexec_flags so that it can be passed
> to kernel when '-d' is added with kexec_load interface. With that
> flag enabled, kernel can enable the debugging message printing.
> 
> This patch requires support from the kexec_load debugging message
> of the Linux kernel[1].
> 
> [1]: https://lore.kernel.org/kexec/20251103063440.1681657-1-maqianga@uniontech.com/
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>

Thanks, applied.

- kexec: add kexec flag to support debug printing
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=71d6fd99af7e

