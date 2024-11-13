Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135D1D41C3E
	for <kexec@archiver.kernel.org>; Wed, 13 Nov 2024 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G2yhQUhGfcSxhF4ffdBFF6pjGZdqv+LRXuSfSq/CZhg=; b=jPpj0QtWeJPvWW
	3q3vUdS64o7PsebulhwuCNWSpjiv+xpo2at8qSx9gU/6ClT0788aqUa5U10Dhks5kdem2ZMlnTEIY
	zKmlx54mq7SLcoBx4RWn05K1JT7oZ+TxyN9VlnNCOfld01p5rkgLZORKKKwhpb1R7NnSyos26IroY
	sY6TuQdUQsIcj06go+3HQBS9KKAYcCQBeADdl/9OACV5lUHCAkBKOIQ4HToHlOd5Q4hPHZiwOAuh3
	Ro5HgNl0KgJ++Cuz5fuqvvj4Va0NHSJojKOpD6hD15N2fI3TG8m8K8v72SW9VC4VTxjgArkChtGiM
	PmssSlt7k84j6HYSy7yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBDAQ-00000006sfj-2iZg;
	Wed, 13 Nov 2024 13:12:18 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBD9K-00000006sT0-37W9
	for kexec@lists.infradead.org;
	Wed, 13 Nov 2024 13:11:12 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 523F140E0220;
	Wed, 13 Nov 2024 13:10:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vuoekss1_OQ7; Wed, 13 Nov 2024 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731503450; bh=Sfzc03JVYWl2/fAcy2h3p7MYjG0zbRyB9F3VXqD2ySM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+0hAo59PhTUrskSe0BdZ/zZBYh/qtheA69kQzPV219hJ4ef4LnOp36m7tejA1uzu
	 wSlNCmRPJvtsw3sAITq9sXCy27+80Rcb3qDNZNhoStRbNfxe1OW/TyWUlcKw8LjHHK
	 zj+bdKa9MISwO/EKO0lJ5NC/9Sv4IS7eyyCO8Yobm/IvI+tO6QbWGviveDm2W5dBX1
	 h02b0X4cl8DJTecocLEmW0x4wmK1zg247d9zhgbzBZKTJ1t5RqGi7IUqYMddYK/zD2
	 XMupwUT5o1/gmpy1negiAAuRahyXyBAZe2+Lz81rwF0N/yCJXATwUOS0cgx3RiDlc8
	 serEms7L/sJLLXY6cbZJP9noL8sKYgfMtLNal9fPE//0KJwSwiFmZVgWSEQNfl9/VX
	 aMn+b0DMiTmsFI4VeP540DiuYtCN2Om8MDKBAeUHjtyzGTJ1f6/pzup1N413nWur0+
	 Q5ypYmSkaqnuMRJXDWjTH0MKeuQ0zvMP3kq9pIHhCcRfJV+p64dfTgDl0VeHR0+As5
	 A+f1w7PtMTJcalteJkqv1MF7wGHT9wHfnnYsx2Hraz+bU+SO6mHktiAGuGGArdg7VZ
	 M6QO5NpovUAGOJeNekKEwQ+Hhlz3sP9VnIhiNX0bpnje5WPRc1COmxa0HQ2+mV+Hxa
	 iyKzJyUuZSCSG1nQn/4xWlmE=
Received: from zn.tnic (p200300ea973a31a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:31a9:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABB6C40E0219;
	Wed, 13 Nov 2024 13:10:41 +0000 (UTC)
Date: Wed, 13 Nov 2024 14:10:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <20241113131032.GDZzSlSIWTB0zS9Zey@fat_crate.local>
References: <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
 <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
 <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
 <20241102110618.GAZyYHquhmVJd4yM9O@fat_crate.local>
 <20241106112052.GCZytRFKTESZI8_3qD@fat_crate.local>
 <ZzSh0/i0HXDnfUof@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZzSh0/i0HXDnfUof@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_051110_959460_5D4D5A23 
X-CRM114-Status: UNSURE (   7.65  )
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

On Wed, Nov 13, 2024 at 08:55:47PM +0800, Baoquan He wrote:
> I finally got an available machine to test below patch, I can confirm
> that without it the breakage can be reproduced stably; with below patch
> applied the breakage is gone and vmcore dumping is successful.

Thanks, lemme queue it.

> Will post cleanup patch later. Thanks.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
