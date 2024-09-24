Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4F3CF9C69
	for <kexec@archiver.kernel.org>; Tue, 24 Sep 2024 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	Subject:To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sarUvsIfRdmk6S+CpVB2gNgM56rCyyMNNIxeXoeekig=; b=EEmrmopaNovQSP
	Rv3qIQIcplQ5xpWgxLEiZcWqG24qBK89ZDIICnWuH49kMEea7z1Sy0Bx92m1sk65PZ8WpJpe4w0Y3
	nk6EB7RggAVhBtX6RZVr9GDhD7HnDpUNI97+4vHdfaNCir3ZBXEAIJcEAhKcDLgOjcV72uurn6oRx
	hQ9FxIq3Gyow9orek2Zz0ALRLuBq38Btc1osnMBFx1XLR7oiraSfTv/8fK0jPnS4el7H8w0hDHq58
	QnHGQuDzpoZr1Fkh/eQ3LYI+SOsHd+TV6jI3/mY+j4+TWmF7VX5A5k18SZ7U8JtAlifrpppNFWK2f
	al7iSDR/Nf/d1aXIAj9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stEnk-00000003YVy-1xy9;
	Tue, 24 Sep 2024 23:18:36 +0000
Received: from [2a0e:1d80:25:906a::1] (helo=mail.quicksendemail77.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stEnh-00000003YVT-3dCj
	for kexec@lists.infradead.org;
	Tue, 24 Sep 2024 23:18:35 +0000
Received: from quicksendemail77.com (unknown [172.245.243.31])
	by mail.quicksendemail77.com (Postfix) with ESMTPSA id E689356100
	for <kexec@lists.infradead.org>; Wed, 25 Sep 2024 03:27:53 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.quicksendemail77.com E689356100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=quicksendemail77.com; s=202408; t=1727215074;
	bh=YAm+/wMewq4n/KGCg5iIwIAvqCbpmLa9gBiqt7IzELw=;
	h=Reply-To:From:To:Subject:Date:From;
	b=dYgbX0w6udZBjoDF9kxEN0BH3dNtcpX6y7GLWZPg3UL8tpK1ZAe+BuBw6e34SptSO
	 rWRWrF/erZIZwW2qbNT7sIoLdXVpg1Wl6c2nD+4ubrhjB9AquOZKJxCxyiWx++QNma
	 Kqmeo5w4nyQ02OOjMr8kZLrFX+G7gu7NOYl6tqnTVLqLIDYzbE7jn7msjA1H5jsGqT
	 63+N4pxPLPLT9mnbkw0qtYyxgml8v91Y1AwCiN3YPfnIACAqYvsi7K4HXlZ+4eCpmf
	 T2OoMu5lSzMojGtjWRXa5GSs+b5kUMcLxgm4AIulVWLiwHU7g4964FFQb9DV4DD099
	 mQ/zPjpRdEz1A==
From: Marvin Jack<info@quicksendemail77.com>
To: kexec@lists.infradead.org
Subject: New order
Date: 24 Sep 2024 12:57:53 -0900
Message-ID: <20240924125753.BFD23089F009C651@quicksendemail77.com>
MIME-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (mail.quicksendemail77.com [0.0.0.0]); Wed, 25 Sep 2024 03:27:54 +0530 (IST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_161834_055325_7DDC3E7F 
X-CRM114-Status: UNSURE (   0.45  )
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
Reply-To: info@marvin-group.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Dear kexec , .

Please email us your company's most recent catalog. We would like
to make a purchase from you.
Looking forward to hearing from you.

Marvin Jack
Export Manager 
MARVINSGROUP NL
Zeekant 125 - 3151 
HW - Hoek van Holland
Tel.: +31 75 7112400

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
