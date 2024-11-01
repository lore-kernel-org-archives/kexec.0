Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1648E6F06C
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RW2ZN3Pa+l5dpLFCa+4MgY3htJWGBkoyZ/ezUY4BTwU=; b=TooI1YqAwslFaG
	JzEqbc6D6aso4Of5W+VRVmtmqCAw+YgOkrGRK/BkkAaurSdMOkQ9Zhee0YxK4pffhRSj/dHuf4img
	7ZspYI36PMQRSM1xwfPcktbMu2MMiyaHzRbqNIrLshYdDVgyDJ7B6OFMjT/XAJeaYD2pPtqxTr/gG
	v2yI3yO0KpjYWxrj3pbDbpWpJeqzdVva6JP54E/Umpl+ncsQhBbfl2CkmlAiXQFqRehZQUb4Wp+iT
	lnMnNHnm1WFHtweum4YzfqzUaEvJoT5YcFRJS5GmFl2mC3cxlnrgDf+aQQQTpxCx1VaOfPCf3zs4Q
	ONuxY01GbXLyhqXv+3dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6uQ4-00000007eXJ-3dtg;
	Fri, 01 Nov 2024 16:22:40 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6uMh-00000007drr-1rPC
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 16:19:13 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E752240E015F;
	Fri,  1 Nov 2024 16:19:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0KrUJmqolMCh; Fri,  1 Nov 2024 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730477944; bh=ga3EU5e3LwksEz0FqQ+0xvAlawIA21BzAgKw22O3GpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLVTrvFv1Kcd1oeV1zWXiHkv35eRo3qpkpEAgpWhWXB8HfSOnhhB+Au63RxpHFNGI
	 fodSE7M0iUFnzbiA6F7BJJLHhJU12JhwvEHwcBSPXRubvgVwsENtkDwtvlPIwJsaW8
	 Y1t5hpxM+6kJ/psHBQd7zMxewNUyJZbIKqIwTKArATUEYn0FFRxaWV8msbMneQprNj
	 /snidavlN2diEcfcNE5MA54WNsPQdjYV81/SPfMsO0Xgg+vW3CI1qwkZVVSC//GyqE
	 Y35O0ECSUYtR1yRQJGrApjh8N8TbkTEYfaVu9ELLr59qqxohbiPdo2XHayRwVzyCJ8
	 Xdgwb7YfrXJAhCuNPhM7PQ4wNO3+T3BY+kPxxq4AhuB0hdmGh+lJY8MseZMpBQxNcF
	 l9NMntdCANZlcXFlDVApdlgFMNIUXoa5XbCZWxL5qSzLJQmMjjMFex6Fklw4J7DrR3
	 Xudte7uQRmvJjdlRYl8DN2PhLaHobJA4wh29xuTWYytIb14ENlgU+IuHuGfb40NO3X
	 HdODACICW9EsLy4IeUS4K00CfXtKtHoTPrK79Gll5a3IIH0eBXXOBHS3CuL6T2FfbY
	 Vba7yBIeRsTkMmV95o//WBGygAS6tdffNtSlGVZGhdShh2iOJSLyGgCa5tMJQ4RDor
	 G9sTpr4zgz5NGWRLFy69DEQ8=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 907DD40E019C;
	Fri,  1 Nov 2024 16:18:55 +0000 (UTC)
Date: Fri, 1 Nov 2024 17:18:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_091911_660642_9B77020A 
X-CRM114-Status: UNSURE (   7.68  )
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

On Thu, Oct 31, 2024 at 11:41:12AM +0800, Baoquan He wrote:
> Should I send the fixing patch alone and clean up the useless argument
> 'size' later, or squash them into one patch?

First the fix, then the cleanup.

Btw, that fix wants to go to stable no? Seeing how it breaks certain machines
with IMA and kdump and SMe...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
