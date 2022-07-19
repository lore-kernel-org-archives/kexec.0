Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20233C433EF
	for <kexec@archiver.kernel.org>; Tue, 19 Jul 2022 12:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ytYVaKcVFO6h0no49VRNo14xfRazOr7t4AIViCiB2ZE=; b=eowvu1fYKA5aDy
	fuSDXL9ly3sa6CPpbN7YkZDKlRSPljryVZTV2rKRDMqH5BmZ1d6brD3LCyd38cwbOZI2JSNLwya/w
	lnvq8lmJVIaq605j+rTuDviq4MXstuwHQpgacqdKq5aL6ncQi/iJoG2c7V5wvGJxrrrOwxMtLQN0E
	16I1ied7EuQv0sSeYEOpCeB0eItTyLCxTw5Y51EA2koGJSofGAtvBRutyGpH74pQ9hudJXZqSgpp+
	8YcwGrDmWPyXm/pMYi7sJb13tJ657BRj9B1Rxg+zYdcnv3xP+3xkpPQAaCFOND6mQYuLfa8gIbMYe
	N/24bVwcBDSgGfB5Tfwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDmLR-008gnp-5z; Tue, 19 Jul 2022 12:28:57 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDmLL-008gmf-Qc
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 12:28:53 +0000
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 4AE2020087;
	Tue, 19 Jul 2022 12:28:50 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id C79A8940218; Tue, 19 Jul 2022 14:28:49 +0200 (CEST)
Date: Tue, 19 Jul 2022 14:28:49 +0200
From: Simon Horman <horms@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Simon Horman <horms@kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec-tools: Remove duplicate ultoa() definitions and
 redefine it
Message-ID: <YtajgS2XhWv4sAII@vergenet.net>
References: <1657879514-29377-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1657879514-29377-1-git-send-email-yangtiezhu@loongson.cn>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_052852_042474_D503890D 
X-CRM114-Status: UNSURE (   8.82  )
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

On Fri, Jul 15, 2022 at 06:05:14PM +0800, Tiezhu Yang wrote:
> There exist duplicate ultoa() definitions in many archs, remove them,
> and also redefine ultoa() in kexec/kexec.h to make it more readable.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks, this is very much appreciated.
Applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
