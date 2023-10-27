Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A50C25B47
	for <kexec@archiver.kernel.org>; Fri, 27 Oct 2023 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cGyfhumXTkIIJniGxrLkM2DfMoyOGqZbL8z9uU/BAHk=; b=2mBFbUcWjHfI8y
	WMSY8qMXoAKX0jHfXXmVjwSGxjlBVpIZ5yu2baiHmBnCPdTeh/sIWzahtSkBbj+1KBRdNfZqLEp2x
	TEmSeMuPtyPebt6dsfo3+V20y2bVsIja1n4o/WTxQzFJ+zjnH2U7BFYdXSvCbCaab+GckTpkvfgTI
	huxCAt8sEA7wpP9YO3B0xcOIBBgHTPIEyEWFkJfokAT4Cqu2XlOrYagLtzzKpRkuZgvGOsf21u3+I
	JiWeFhh89gjGBemhjbZp16TlylE4mPrIZk+aJQKNZNSn2eyJQ85OPMwexynqGaavVjAXSljZh8jAE
	biTp0F5tdaiPvf8d28RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwJDY-00G2Y6-0F;
	Fri, 27 Oct 2023 09:33:24 +0000
Received: from mail.antaris-organics.com ([91.227.220.155])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwJDV-00G2Wh-1Z
	for kexec@lists.infradead.org;
	Fri, 27 Oct 2023 09:33:22 +0000
Date: Fri, 27 Oct 2023 11:33:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1698399196;
	bh=TCOrvOzK4dRFE5bYJ4UUf2DElWrT9Zwd1Pb3oIMfSTs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:Cc:Cc:
	 content-type:content-type:date:date:From:from:in-reply-to:
	 in-reply-to:message-id:mime-version:references:reply-to:Sender:
	 Subject:Subject:To:To;
	b=wNcNukvLiMvl3bxuDcLgcjldyunoJhjl2+cLeHca/3ZIWw+LZ16QXizAnmnDPWy3D
	 yk7TxzqOaZHjFdxxUPTjFjw6Sd01zKh4iypMuLDu+ATDKFgifK2eNbDYIOvq2v/NXO
	 LJDb4ZiHwFFUhgKHCpe7LWc9ZCKUMEEUVRGMHBDSRG2EJF8ZszSPlSXOK1hT5uL1u/
	 dTbKzkpCnvL+eI5N0vWdYn6uqlv1Ip+pzJpH+e9o8vbKimRgLWz3OZC1bDrr8qXr8w
	 dNEE9m3s0lZLy+aTLzCS9CmtwQWptsCJ+ewEbn4q4JtQrxuPXaIUt/qaRNz8BRIkvp
	 m0Tky9XDR2c4g==
From: Markus Reichelt <ml@mareichelt.com>
To: kexec@lists.infradead.org
Subject: use one cert for all; modules, kernel, kexec
Message-ID: <20231027093315.GA2560@pc21.mareichelt.com>
MIME-Version: 1.0
Content-Disposition: inline
Organization: still stuck in reorganization mode
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_023321_671286_E3692834 
X-CRM114-Status: UNSURE (   4.85  )
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

Hi,

I already use signed modules and do wonder if the same cert can be used
to sign the kernel, and verified by kexec when loading such a kernel.
Failing to verify a signed kernel, kexec shall not load it.

Is that doable with current kexec-tools?
If not, is there a real chance this could be added?

My trust scenario is simple, use one cert for all.

Thanks,
Markus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
