Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E083DC48BF8
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=slu4PvdpL4jXHWMSYefiFEG6GA9aOfnAiHShy/A17rs=; b=cCck03JIj9lSfG
	U5Jc5dpe0/ySPAZWe3z9TNu15FL5cd6DZCNPNOfL1gcdI3zheD7WSvDFxMjFBbGsLjQv5EVyBKwPs
	8/8ACxZV0X25mG9QAA7Ar6N5GcqXHr92CjHC3FTNP41L+XchkZrVdHhbl4XGvhuUxbuk/pl7u2AeR
	Y6nnu9arWoDRt5KmG1CaYTOC/lZUYJUxl3nzfeCDWlQTk3K5Q+qC3edCQXb7Q00PdcwiM/2SQ3WJ8
	bMXzWQe/VfsBZYTZv6jMpCyufyzCv/kX3rSVhRFYuDvU8IDPQ7fWOSXvoii8lXAYp8n7yGUu66KWz
	YW3KjPQrlwPmfifOcQaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd4dW-000000044Hc-0yLE;
	Thu, 22 Feb 2024 08:40:58 +0000
Received: from mail.vexlyvector.com ([141.95.160.218])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd4dS-000000044FK-2DJ6
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 08:40:56 +0000
Received: by mail.vexlyvector.com (Postfix, from userid 1002)
	id 9E847A2F82; Thu, 22 Feb 2024 08:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vexlyvector.com;
	s=mail; t=1708591240;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Date:From:To:Subject:From;
	b=UCrZYrjgYZO39q91ja/BJdWTMArMeOgwmQRk3x9y9hmjDNCtfKiDnvI2lPV/ZBJcJ
	 VhM9G8UFEUiKHKfIkiIKZBQ1VWEZRkGWWeqMBKb2oS2SGV+DU3qP/0abvADVqjVUot
	 qxXGk/H18ef69c382YhY/kYrcF4KK3s4Bq9AUHhaituTVXAAzUfV8E5+qHlVE13202
	 67g0OAUKwLJtdWFYR971/hisM+RGFuC4eKqfdSfs8HnMNX0Ma4e9xCEvHMN6cAJDdL
	 Up3DYEIPG6zvssDOww9ysYptx63uYNkhDxmyqVQIljEd/KO2Fe79dKYmc0tCBmWB06
	 gickqXYFoAlfA==
Received: by mail.vexlyvector.com for <kexec@lists.infradead.org>; Thu, 22 Feb 2024 08:40:32 GMT
Message-ID: <20240222074500-0.1.c6.qhzq.0.nbom11cdqj@vexlyvector.com>
Date: Thu, 22 Feb 2024 08:40:32 GMT
From: "Ray Galt" <ray.galt@vexlyvector.com>
To: <kexec@lists.infradead.org>
Subject: Meeting with the Development Team
X-Mailer: mail.vexlyvector.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_004055_322051_BAA922D8 
X-CRM114-Status: UNSURE (   2.55  )
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

Hello,

I would like to reach out to the decision-maker in the IT environment within your company.

We are a well-established digital agency in the European market. Our solutions eliminate the need to build and maintain in-house IT and programming departments, hire interface designers, or employ user experience specialists.

We take responsibility for IT functions while simultaneously reducing the costs of maintenance. We provide support that ensures access to high-quality specialists and continuous maintenance of efficient hardware and software infrastructure.

Companies that thrive are those that leverage market opportunities faster than their competitors. Guided by this principle, we support gaining a competitive advantage by providing comprehensive IT support.

May I present what we can do for you?


Best regards
Ray Galt

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
