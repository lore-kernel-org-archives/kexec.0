Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD170C28B2E
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 08:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5Ag/W9YjfbFJOGLdiTXWgO7Nle+kHbv1rgCfGcU2GBw=; b=YHt87BWAJL+eqCXJUc++Fw8DV8
	3KUPEzsd/pdzDbeT46eebFn0QNrkV5/UQ0mB39uXTSyaD99clK6yRmbsz5ABDsXOLQRifwOg6gRWT
	AH/fdORyaANA0x8dyScpAbUUhKCElrkIakeDOJUQClD/TnlrFtjwxAAmqLtGWzpdfaJXKsUiqmC4T
	3y+0v8ipvtp/xpQ8ARJ4zFCSMfALdPv3a719Ztl2TvkK2lFT580N2X4NwqrBNOIlSh2uALgLj75sM
	OUlz3NN2fgMaAFBoZf9wkU1t5VjkhW1pOWceviXgQnfDzwggRtDMc16HJTBk5cpmJa78uq/5WzBET
	6f6Zs36w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsHoL-00000007sAO-18v5;
	Wed, 12 Mar 2025 08:51:33 +0000
Received: from mail.commetrax.com ([141.95.18.165])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsHoH-00000007s9l-3lFe
	for kexec@lists.infradead.org;
	Wed, 12 Mar 2025 08:51:31 +0000
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id 0B2E8244DA; Wed, 12 Mar 2025 09:50:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1741769445;
	bh=5Ag/W9YjfbFJOGLdiTXWgO7Nle+kHbv1rgCfGcU2GBw=;
	h=Date:From:To:Subject:From;
	b=bSAzs2p+2m9pHhWne2vCxmCN9+3mwxbxSgyTNfALv1Lo6HKeuLWQu3rrMkuJlQp4B
	 l1SSn9MIa8PqTWBPQFfj/wKt03g0g5uQdTVjUvppJ4heWFLgQPoPhfQjNQZj7Ltzci
	 3DkujqVWF6uQaBUkyA8bei5yLWC/FI6mK7yghpwrZFNhtLpVy16LuisLyjX71V3TFU
	 3ZCAN1sVmjDCTM+VBDaHlPmN37hj9gnQHzoxp6pyd6a6YHV7jyjZYTdAz4A8sV1mUv
	 QeQQ3nXElbkVANtdPKt0FfqiKHo9D6Zvtn3x4ZtgMGyU/0Dx7uL70ANESGef1fs7dn
	 Od4LTtdW/kiew==
Received: by mail.commetrax.com for <kexec@lists.infradead.org>; Wed, 12 Mar 2025 08:50:27 GMT
Message-ID: <20250312084500-0.1.8d.p5az.0.iek4039qoi@commetrax.com>
Date: Wed, 12 Mar 2025 08:50:27 GMT
From: "Vincenc Turek" <vincenc.turek@commetrax.com>
To: <kexec@lists.infradead.org>
Subject: Message from production
X-Mailer: mail.commetrax.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_015130_618143_61DC9782 
X-CRM114-Status: UNSURE (   1.46  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello,

We specialize in manufacturing packaging for the food industry, such as t=
hose for ketchup, mustard, and sauces.

We also offer solutions for household and construction chemicals =E2=80=93=
 packaging in various sizes and shapes to meet your requirements.

Our products are durable and resistant to damage, ensuring faster and has=
sle-free transportation of your goods.

How about a short presentation of our offer?


Best regards
Vincenc Turek

