Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68821C3DA7F
	for <kexec@archiver.kernel.org>; Mon,  5 Aug 2024 07:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=n0O7J700p2rEEOmYcebOJxTinXSUF7Si3/jo92aGGZg=; b=CwPKZ/Uweq0l1p
	wQrCON8cQ4kYVGlRA3+2fuKgyBiSJUO6eVMVJswLQ2zlhoJWkmmNzgYbHHr8biOHpjEpILC2SjaAZ
	uMEV6usRmcfKfdTg2oSysfNeKFnZu0pO946O7E42eZB+B0enyao4fJuprZZPlfRwytI3JhRSpzKy8
	pA9vt1+JDInKfD00cailI7Jr8lXlwF4SizcK4WJ/BIVZ6fPB8hcat6CQFN8CfB5RE+sV1f2/7BQEZ
	Wa7hkc4D+ZNOC5KAp4GtvRflqwesZFaATPeHek+i1B83fRm0nPG3K6oYP99M8kA7z2fN8FkKlLyUk
	Ji+PD1m9xrvWTxFVqTTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sasLC-0000000EyuW-3uq3;
	Mon, 05 Aug 2024 07:41:14 +0000
Received: from mail.vectorspeedbiz.com ([89.40.118.23])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sasL9-0000000Eytv-2tII
	for kexec@lists.infradead.org;
	Mon, 05 Aug 2024 07:41:13 +0000
Received: by mail.vectorspeedbiz.com (Postfix, from userid 1002)
	id C42DF840C7; Mon,  5 Aug 2024 09:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vectorspeedbiz.com;
	s=mail; t=1722843666;
	bh=xrNEpnWQZ8snhxPgU3EBuIKpICs42jmB6iTHM0+PLvw=;
	h=Date:From:To:Subject:From;
	b=EcwinrrRmEkVBgs4g0vA/61EZBGvWWSSXsiB50gh2/pWDyJCULA7CNlPuSDH5Z7wT
	 oBCUKJPlB6uECh2cEWoBH4v2IGgF+VHHvm97K9inYLSz5oc3LtlXOTH323e+KNR+tj
	 aRqu8QY2sXr0v1gZbHncOSlRgcKE32l4dFBOY8CWMQ0zHwNakaGMzIQGsdWpTQBjr7
	 /hd61zwwltpi2jkFMQkaqeyCGa7T+nlefXoZDpqXF2b80vQX+jlUTfYBYJi0vNPj+H
	 cJOKKvl+f8rQxgFPpEzAOU+IpJXgToTIpevYqkFxJC0mXCxhHvUIebaTAl4kqfeGpw
	 PKyhJfHiChc6w==
Received: by mail.vectorspeedbiz.com for <kexec@lists.infradead.org>; Mon,  5 Aug 2024 07:41:00 GMT
Message-ID: <20240805084500-0.1.4p.3d2p.0.nxfgerf3ft@vectorspeedbiz.com>
Date: Mon,  5 Aug 2024 07:41:00 GMT
From: "Julien Keller" <julien.keller@vectorspeedbiz.com>
To: <kexec@lists.infradead.org>
Subject: Mobile Phone Wholesale
X-Mailer: mail.vectorspeedbiz.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_004112_427752_C7A4026A 
X-CRM114-Status: UNSURE (   1.07  )
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

Good morning, 

As a wholesaler of GSM mobile phones and accessories, we offer smartphones such as Motorola, Google, Honor, OnePlus, Oppo, POCO, Samsung and Xiaomi. 

By eliminating intermediaries, we provide truly competitive prices.

All phones are in stock and ready for immediate shipment. We guarantee delivery within 48 hours.

If you are interested in cooperation or have questions, please reply to this e-mail address.


Best regards
Julien Keller

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
