Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65144C27C50
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 18:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=szkzNiHK8wVg7U75TilU3d/vDvo+6Su8IpCYi/oZQ78=; b=HLzgOsggR/6x5Y
	WormqaKJS1d7lZ2hrorPYMdWEGBhWt8d2/O1RnWYUBFTYOArjqhXHrJi2bGYhKPR5ZTyxCY2069ZX
	8AKLeXudVsTAsanK4A/leiZ31ynJA1ecjJ/NdS0KC1SRA67bO+EcC70NlNH+m/eRm4yyPtvH+n/rp
	nY5IN+cxqK05z+QUxN7CUKgyz91N4hORG9txDUUiBifmJKictb0w5O1iaXL3bq03PpW/qYAtL7ozR
	PO9+A5D4+j9ZtXTe2bA6vi5AMIZHrjKPlFHekwx8HkyKPGQaZopGC78o66gHEV2vsG7V/0svV9hPH
	6avzDl7bcswFTZgQ6eCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEC4O-0000000HaEW-3zxC;
	Mon, 03 Jun 2024 18:06:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEC4K-0000000HaBX-28yg
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 18:06:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D42B260EF0;
	Mon,  3 Jun 2024 18:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C0EC2BD10;
	Mon,  3 Jun 2024 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717437963;
	bh=tp1SqLm2yQtPE/jD2etOrYZOoyWJCjYt5NO+8RliOhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UM5LkdHfgTqFLoeMvkg+mDcGopqbxOOQYSIkLXORh5FQXkoAuBzU0XE4hqGYGzVRF
	 OSQQuhEY/zmJp087McNjp+krYXz9TTL/+hSvlUk93KizQ7jrYOpp0XWd92TebrvO4z
	 0Uaj7t90BOpM5Y9gsoe0XXI4cTQIT2CHzmEB0Hg2/CvOmyqlwViofHsiGx3ub+S08/
	 RFB8jr1rCVSRo+iiFZYBCYK2YI8PNuicQ6ElEX33IzDZc/dL45I7shaszUkNmgpyhY
	 tcpbGjB+51Z9mYcRQrUNCSM4B3syjbkkXuN4jEEwEuylKocqeFZuXDxxHqLCMQjIed
	 GPmXXdT4phtYQ==
Date: Mon, 3 Jun 2024 19:06:00 +0100
From: Simon Horman <horms@kernel.org>
To: Ming Wang <wangming01@loongson.cn>
Cc: kexec@lists.infradead.org, chenhuacai@loongson.cn, gaojuxin@loongson.cn
Subject: Re: [PATCH] kexec: loongarch: fix load command line segment error
Message-ID: <20240603180600.GI491852@kernel.org>
References: <20240520014553.3787578-1-wangming01@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240520014553.3787578-1-wangming01@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_110604_688402_6E2F0001 
X-CRM114-Status: UNSURE (   7.56  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, May 20, 2024 at 09:45:53AM +0800, Ming Wang wrote:
> When kernel cmdline reserved multiple crash kernel segments, like:
> "crashkernel=4G,high crashkernel=256M,low".
> Cmdline segment may be loaded in locations larger than 4G of memory.
> So the parameter 'buf_max' of add_buffer function should be
> 'hole_max'.
> 
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Ming Wang <wangming01@loongson.cn>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
