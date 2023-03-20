Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A909DC7618A
	for <kexec@archiver.kernel.org>; Mon, 20 Mar 2023 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WTV0oEHkYDE+6hqZW5T3c5/yP+bXDxctbWdeqNbmTz0=; b=pBFSwAqQmbssxv
	6JkbOlg9XWfC9kNMc+tEJ9PcLUSbry6mTIdn+ymqsT1ZyaS5WYVDr+rkz0XU7WsoZ9aKrP8K7cnYQ
	/eQCpUm5kGESaADQKAx3okTVe94eWh652FN4ges/4u+ZZPra5yaVpksl03p0L/xzutLRUmuFs1qmP
	INLWpnlZHdW8r4gDgnSAe/8N/9rV6xJkoz8NCfDHnB+e3lhWsV/x17RmFv8LZ2JgLGswMEt+wpHRY
	IjsuODU18HWku5WGh22Hoj/ToOUryUXZKvVClnk/OHCSeEaSrlEVpNeqlufzwzwIoVeUbdQ2ethLL
	Ho8IsHIP4zpGIE9TqSxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peGda-009LTU-2w;
	Mon, 20 Mar 2023 14:37:26 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peGdY-009LSb-0x;
	Mon, 20 Mar 2023 14:37:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D977FB80E79;
	Mon, 20 Mar 2023 14:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACE4C4339B;
	Mon, 20 Mar 2023 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679323041;
	bh=OfZgDqFXBUdIMyEH4oAv+asfs2VQIn/ZVquHlPB1Saw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mePrb7L1qo6GFjZ+3oszM9GYvUm5Z5vLScmvI8JzM/ZNKNBUfwEYNcKwzAzTLEOgm
	 Ckmn9rJmyHQIVVbogmyIwW8D+bzk77R1l+ZbjWZ+fuxY2ZmXjf3Tc4cQb2DO+XE3zQ
	 o6e65hvEssUKre2r+kDZswa7udIh9lAcYis4L8jp2nowJGyb6R26vhxZqVsoc9wRGX
	 eWg1GQRQIunmaKgvpBAJYph0Pgy7QSmOGpD4tIWXmQGczGazwKZ9vgYkE1hbHW1gmU
	 itlTWjoGRVPD46Y5ZLt/LCjyUHjkOggzmu+VdVH6c6zUldzOhVOl3V9NQ9LGPgbOE5
	 EX/xP5LIpIBCw==
Date: Mon, 20 Mar 2023 15:37:14 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Jiahao <chenjiahao16@huawei.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com,
	conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
	bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
	atishp@rivosinc.com, bhe@redhat.com, thunder.leizhen@huawei.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH -next 2/2] docs: kdump: Update the crashkernel
 description for riscv
Message-ID: <ZBhvmqlyyvLOUot1@kernel.org>
References: <20230320204244.1637821-1-chenjiahao16@huawei.com>
 <20230320204244.1637821-3-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230320204244.1637821-3-chenjiahao16@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_073724_483422_6B3C87F3 
X-CRM114-Status: UNSURE (   9.44  )
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

On Tue, Mar 21, 2023 at 04:42:44AM +0800, Chen Jiahao wrote:
> Now "crashkernel=" parameter on riscv has been updated to support
> crashkernel=X,[high,low]. Through which we can reserve memory region
> above/within 32bit addressible DMA zone.
> 
> Here update the parameter description accordingly.
> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
