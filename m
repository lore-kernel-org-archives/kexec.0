Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962FBC77B6E
	for <kexec@archiver.kernel.org>; Thu, 13 Apr 2023 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wGRy8JzQkvUAeCDyCOSEuEtnoaXrcOqpg4oUpHbPA2Q=; b=AfJbCS78kd0BZS
	tDTU7zgn/ZG9A70AhZly441ZwcHVskDgS3FAOlivk7ytnJdNzHkNdtYBZx4anUXxr8VR8jRXURk5G
	kioK2zjY2jLusbBKnUINUm0NLb1cm4FC0o7zv+M5GUTtrDZ/GN6h8rPHYB9Ho/0OSjJcmNHPJfdBD
	uMEX+9NzSNYjteA4HTroLc/QoxJOFg1esojm5VCVu6Mxr8NW+dl0oH41eaJZwBfvw6bhe7TSnsNkP
	Tg9FATqZSMyTuHXLvNTi1RxUuaCbTx8JcPODD3OtzcGfrhrGMwKtxjzRhnlDq60m3BUIKNhvxsU7l
	g6zFk92DjKULhc79t1Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmxyE-006P03-2V;
	Thu, 13 Apr 2023 14:30:42 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmxyB-006Ozf-16;
	Thu, 13 Apr 2023 14:30:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CD3D563F06;
	Thu, 13 Apr 2023 14:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1B0C433D2;
	Thu, 13 Apr 2023 14:30:36 +0000 (UTC)
Date: Thu, 13 Apr 2023 15:30:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZDgSCfLMtL9heS8J@arm.com>
References: <20230407022419.19412-1-bhe@redhat.com>
 <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
 <ZDabRr/yyakrrDDO@arm.com>
 <ZDezLrWSg7qd5K08@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZDezLrWSg7qd5K08@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_073039_440240_A8B05B55 
X-CRM114-Status: GOOD (  11.74  )
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

On Thu, Apr 13, 2023 at 03:45:50PM +0800, Baoquan He wrote:
> I am OK with this version, or the version with min(SZ_4G,
> arm64_dma_phys_limit), or v4. Please help point out if I got your idea
> correctly. Thanks a lot.

I think we should stick to this patch. The disabling of the ZONE_DMA(32)
is fairly specialised and you are right that we should not introduce an
artificial 4GB crashkernel boundary on such systems. The slight
confusion may be that ,high triggers a search above 4GB where there's
not such boundary but this would match the documentation anyway.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
