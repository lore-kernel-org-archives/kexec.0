Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4341FC3DA49
	for <kexec@archiver.kernel.org>; Tue, 23 Jul 2024 09:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=U6r2q09xUbgwTiCIV77BIHoGuRUbNjHxvQsgrL0CkIE=; b=MwJTfvdSwflEXS
	OMeP8RTwzCq98UuRhl3kiko2T2HQGfQ9h7bXzgQm9SAUOIXIYzWd4UXvPUDpnl8UjBNpCcM3vYnuH
	s2+SMCWlZ5dlvXNRKBxYu6vnCOf/34H8Fpy4IotJzv92t/wqoyAR64vzgA8QKwbGu5SQDDZMYEb00
	cuxZW5aesZhwxrovAAUs+/lMWamSGG2N+b+Gt7IeDyV7Jb0mW+df0a1ki/dayQzIPq8Ko6UHS9D/k
	Ztp/Adu6hz36tAnDRe75Fbq/GyWEjq3zzcRCo6bV3w2qjsU0oeEnSWHy8fqRwzqxqXEZ5RZMn0vKD
	IQuAmkOIceRlulagNa6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWBTO-0000000BvrG-3bkj;
	Tue, 23 Jul 2024 09:06:18 +0000
Received: from mail.datadreamdynamics.com ([217.61.97.202])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWBTB-0000000Bvmr-1u9h
	for kexec@lists.infradead.org;
	Tue, 23 Jul 2024 09:06:17 +0000
Received: by mail.DataDreamDynamics.com (Postfix, from userid 1002)
	id 9AE6A82697; Tue, 23 Jul 2024 10:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=DataDreamDynamics.com; s=mail; t=1721725161;
	bh=WXN0Rv0ZZvaB0h6WQxYHTQ3BphY3oLwmoUdDK3WE7CU=;
	h=Date:From:To:Subject:From;
	b=20hR1qPlEM+D7vKe8dxgkjhcDZu3qudJUKMfivb+iISiRPKIleEWww5gq08ay56qL
	 BTEDvrf0ZADQjXlO2c9H34Em4jg1zMtRPr0wMyxZJQ5tyWzD6hixMArGp7pGnoiPAX
	 yJbXS/WBOf6CcSmLhBV1/bPpsD7pEUqLx+qKqme1/ZkOu1+oRFTLC+gIU3PVy1IeGV
	 S8Vq09oa8IR+DiReqrrZoGcAs5Vc0cLX4HzjOZeemWTDudAr2Z79d7qkh019Jd2hiQ
	 bo80VR6AqxUEBjZXAaYBAiWYtfWoNjpUAEDvlIkDHRQhuasFSYz1qhJonFN5X8Ww3d
	 IzFqTM7itSm+w==
Received: by mail.DataDreamDynamics.com for <kexec@lists.infradead.org>; Tue, 23 Jul 2024 08:59:01 GMT
Message-ID: <20240723095858-0.1.4v.chpv.0.mjutp6cff0@DataDreamDynamics.com>
Date: Tue, 23 Jul 2024 08:59:01 GMT
From: "Austyn Roth" <austyn.roth@datadreamdynamics.com>
To: <kexec@lists.infradead.org>
Subject: Ceramic components
X-Mailer: mail.DataDreamDynamics.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_020605_691584_F489558B 
X-CRM114-Status: UNSURE (   0.67  )
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

Dear Sir/Madam,

I represent a leader in the production of ceramic components with exceptional resistance to wear, high temperatures, and aggressive chemical environments.

We offer a wide range of ceramic products: elbows, bends, distributors, pipelines with wear-resistant ceramic lining, as well as bearings, valves, pumps, guides, and plungers.

The advantage of ceramic components lies in their exceptional durability compared to steel parts. This not only significantly reduces downtime but also results in real savings for your company.

We support you from the project stage, through production, to service. Our warehouse holds over 100,000 products ready for shipment within 24 hours.

You gain not only durable components but above all, long-term and trouble-free operation of machines and equipment.

Do you have any needs in this area?


Best regards
Austyn Roth

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
