Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31B7ECAAA1
	for <kexec@archiver.kernel.org>; Tue, 30 Aug 2022 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qTVBjj0dfMSCXf7odyyJ7il4zV6xRAscb/mlsS8+wus=; b=0PxtrKFqX63kCq
	Wu84m/dHpAvMk2QRp4k0L8MYaRXJwA5o2t24roEOQdcyZwwD0AnJfQYULKLe+vjMFXwHRO40UiO3L
	wHVsETXOSzxv+CVhvByS9+b3PMpVPrvcRsVCBl1aHNNn5ly+N+IV7GlhxqhhXtAoW+aKKh9pdha2N
	FsORD03eUgUm4jUXOEzA2Ktc9r1XvsctShqPUj/ayp6VuBfVa4jvZycde4WLtcNuUhoR3AbbXYFcx
	SQI7ZXRIpXsOMY17tRLA2NrEV0O1/M3WyHxvm2HxDFXTAHer9YKE9dac+5oKNsM6rNmjuXUqiVu2j
	/DIoschesS0CvzhiRMQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT4IZ-000bCF-Nd; Tue, 30 Aug 2022 16:41:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT4IW-000bBZ-Kj; Tue, 30 Aug 2022 16:41:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 90B47616D3;
	Tue, 30 Aug 2022 16:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCC8C433C1;
	Tue, 30 Aug 2022 16:41:03 +0000 (UTC)
Date: Tue, 30 Aug 2022 17:40:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Levi Yun <ppbuk5246@gmail.com>
Cc: bhe@redhat.com, will@kernel.org, nramas@linux.microsoft.com,
	thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw49m7Hpq+NIZYWw@arm.com>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220830092839.3197-1-ppbuk5246@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_094108_756615_BCB8E388 
X-CRM114-Status: UNSURE (   9.40  )
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

On Tue, Aug 30, 2022 at 06:28:39PM +0900, Levi Yun wrote:
> Like crashk_res, Calling crash_exclude_mem_range function with
> crashk_low_res area would need extra crash_mem range too.
> 
> Add one more extra cmem range slot in case of crashk_low_res is used.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Does this need a Fixes tag and cc stable?

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
