Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856E4FEA809
	for <kexec@archiver.kernel.org>; Wed, 25 Mar 2026 04:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oikZdq+IKhmOORXBWkEbQjmrrU1iP/ab33eIDNTFj58=; b=hJFPotXAzdkZRDLHwf6h+I74R3
	uXLXT/G8/+bbDQ4aJqoSXe3I8u2lid3+tsPBbKxtVj4vOpLdXm+3PKCngWwTah2meytb9JtUzDXBx
	hCDcOEBWrCbbpp5zDg6HGqEesWI+4bLo2vdKdvWnFnIjKN/ksy2waTrSVyFZhje3o3pL2qI/2gXbz
	W8M6B3Z296JD+bnyTjdnB9sTynQQ8E0j1WXrGOnXghU9zwNdo+0QhpwAtsZ3FsNfm8AMjiDeeeClU
	qLlt6cA5QCDPwHsbLZf+l5yQOUxFEPY3oF0BTewyhWcnMvSOhNFaQlpX+Cyz9tgEAphgBAN1x/4Jh
	DIKWyheA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5FW3-00000002eVT-40ve;
	Wed, 25 Mar 2026 04:06:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5FW1-00000002eV4-3Xjh;
	Wed, 25 Mar 2026 04:06:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E84BA4443D;
	Wed, 25 Mar 2026 04:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34CCC2BCB2;
	Wed, 25 Mar 2026 04:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774411604;
	bh=WsAQHOogDYWxLt316VoEo1PFk4jzaM4l6YS9sGhWqrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PfDGsqskD39pLcCQXbYS2QFRFghCe4BEZzYtdfA21xdxwIIR4FoeGIkM064eBeWyY
	 D40CifymkJxTpCyEpPpnuoQ9OggtlKZBCPGL6v20TO0xKp5+AhL5+CF3V7RgF7HOF0
	 NjgD1tu5pmsYOFLipjeAqvBHsr0IFVKdBckI3XFk=
Date: Tue, 24 Mar 2026 21:06:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/3] kdump: Enable LUKS-encrypted dump target support
 in ARM64 and PowerPC
Message-Id: <20260324210644.28f6cf77a26dfadcc4b642e7@linux-foundation.org>
In-Reply-To: <20260225060347.718905-1-coxu@redhat.com>
References: <20260225060347.718905-1-coxu@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_210645_910355_210A79D5 
X-CRM114-Status: GOOD (  15.61  )
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

On Wed, 25 Feb 2026 14:03:43 +0800 Coiby Xu <coxu@redhat.com> wrote:

> CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
> device dump target by addressing two challenges [1],
>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>    machines, a system administrator may not have a chance to enter the
>    password to decrypt the device in kdump initramfs after the 1st kernel
>    crashes
> 
>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>    which is quite memory-consuming compared to the limited memory reserved
>    for kdump.
> 
> To also enable this feature for ARM64 and PowerPC, we need to add a
> device tree property dmcryptkeys [2] as similar to elfcorehdr to pass
> the memory address of the stored info of dm-crypt keys to the kdump
> kernel.

We don't have any ack/review tags for this series.  Could someone
please help out?


