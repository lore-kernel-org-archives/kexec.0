Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7894ECCD18D
	for <kexec@archiver.kernel.org>; Wed, 18 Sep 2024 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tLGennQrTySE3x/zO2Khchu0H2WsGLOR/h6yydtsORI=; b=gJ6kwEofMqiwnC
	Yrcae2Nkwk0qyF7g2Avaw2hD6W2lW3YE4wKI+EDeLU3U9bTKuq/5jO6doaPKvLANN+wWR7fLCSHZe
	j1aEzbhDbME4zgeuWLXtyQMzluWQz5OkoTfs9I2NbpWxBVF3jpiwzO1EshrHaJGk9xyCt39yYlhCP
	MHQAsfhyIkdFjt3bHNihp5CeMpolyg1lfKHVuVy8IStPKs8tcLJEjYO+YN10KfX6iMinGYgYtmFaL
	dAfpprTOamzOmuO+fqIkyZp8MUqhroswOBOsV33yqASMPQAdJsp5XSQEIH4kbcu86D0+8fsW/3zWg
	xsQFL2jdvfKITEDkQXFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqpYh-00000007iqB-02RW;
	Wed, 18 Sep 2024 07:57:07 +0000
Received: from mail.bizluminar.com ([51.254.102.79])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqpYd-00000007ioM-07hN
	for kexec@lists.infradead.org;
	Wed, 18 Sep 2024 07:57:05 +0000
Received: by mail.bizluminar.com (Postfix, from userid 1002)
	id 8339E46342; Wed, 18 Sep 2024 09:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizluminar.com;
	s=mail; t=1726646147;
	bh=6NcQkAt3L/c3ZOW+QIgSy4I/Ko+FTVKMOtj9pZosTrQ=;
	h=Date:From:To:Subject:From;
	b=gCAaaFF1lpb9Alf/814OLMQaLjUoKpwEVL2Svn8WzZG9qVaEwPGyz6uiHWn6uB15O
	 2pJa+h3B3yig2CFHiY/qeTATm3uPexE33qAXuKt47SXhyqO2nAds3ETHu6ZNT5YP3F
	 kCJUWZOSVUnooWTCh8LFNSgGp+FOWfB4qbGEqC7cVU7ctrzOacJjoYXzdifyqVXua7
	 VnDj5g12hQq+IBFYzFQrXuIfwUmXunilQWB1hR8amCb/bjbgaAjKccQRC4qVS9sOzH
	 5QyM/EU6d5BSb+g2Fepsd6Wt1NDhC+dsS07yo+ue+C/1F62F0o8moGQsdHLwc2rlJr
	 5hw4LL/dKA5JA==
Received: by mail.bizluminar.com for <kexec@lists.infradead.org>; Wed, 18 Sep 2024 07:55:24 GMT
Message-ID: <20240918084500-0.1.ar.rd4c.0.fkpi6zbe9c@bizluminar.com>
Date: Wed, 18 Sep 2024 07:55:24 GMT
From: "Petr Kadlec" <petr.kadlec@bizluminar.com>
To: <kexec@lists.infradead.org>
Subject: Corrosion Protection
X-Mailer: mail.bizluminar.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_005703_773314_32023E79 
X-CRM114-Status: UNSURE (   1.30  )
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

I am writing to you to identify your needs related to steel constructions.

For 26 years, our family business has been handling orders for tanks, storage silos, hoppers, container technology stations (modules), sieves, separators, centrifuges, cyclones, tanks, silos, high-power transformers, and many other solutions.

By cooperating with us, you gain access to comprehensive and personalized support, starting from design and material procurement, through stages such as cutting, bending, welding, erosion protection, and up to delivery, installation, and spare parts.

Would you like to explore the production possibilities of constructions tailored to your needs?


Best regards
Petr Kadlec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
