Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03B9C83035
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jYR+jOfosABoLC4ZrInLLNPge1Mn9hsIn+wcLzGqkWI=; b=2papz4fY3bb81o
	wBhYZon2iKBbWvxhIGi/AuhMfKoaovkyyO1LWjIBNGP/f/cMwEDVEc4sMqMQyBoYXHcUe7S7R09QY
	a77/LEek16cdnsdPq80puAPlJRT8acer+P/gCPg0/RfVJtzyZYNhwFCsJdJIbEjZnZxqhdHsdMHp5
	rVRS2MB3S+eAQmx8G1K4F0YaEZhs2kkrTBoLaYnsOOtLdQWHkZjE8bohq1PMTt0JK+ZpJ8hOaumqP
	lN6+uhfZCnHH1MLqMq/80KrkUdPZN0fpzHNU2B+s2YIGIHIis4JmICHFjL2smxIgIStOkKyffiLMU
	QSINoNmAdvriLUvXzu2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjcZt-00000001cRo-0x7b;
	Thu, 29 Aug 2024 10:40:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjcZq-00000001cRF-2S23
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 10:40:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724928029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3NA2za3mLWwZQgdkwnzS66f5eQJoKJP/wfMq+IdUpAY=;
	b=ahQguTn8Af4irxGoBZ1E+qrzJwxP2+eAdW22dtSAPXlr6fK9dNXllGCOg9/iHtFzyqp9H0
	EnVFf/6z0vpUHieGfIHIa8Vgg+aVfii+qp42KE5NjkvHcPjm5G5DjPahpz7yeqXmm7Kcx9
	PyWFo/tWlblJL/VEm9Gg0muX24YQmEw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-kQup8Y_wN6WRSA2waTXVeg-1; Thu,
 29 Aug 2024 06:40:26 -0400
X-MC-Unique: kQup8Y_wN6WRSA2waTXVeg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECAB51955D4E;
	Thu, 29 Aug 2024 10:40:24 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B6D919560AA;
	Thu, 29 Aug 2024 10:40:19 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com,
	dyoung@redhat.com,
	daniel.kiper@oracle.com,
	noodles@fb.com,
	lijiang@redhat.com,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/2] x86/mm/sme: fix the kdump kernel breakage on SME system when CONFIG_IMA_KEXEC=y
Date: Thu, 29 Aug 2024 18:40:14 +0800
Message-ID: <20240829104016.84139-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_034030_717026_8F673836 
X-CRM114-Status: UNSURE (   8.45  )
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

In this v2 posting,
- patch 2 is to fix the kdump kernel breakage;
- patch 1 is added to clean up the confusing local varibale naming because
people may mix up the local variable 'size' with the passed in parameter
in function early_memremap_is_setup_data(). This cleanup is suggested by
Dave and Tom during v1 patch reviewing.

V1 post can be found here:
===
[PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system when CONFIG_IMA_KEXEC=y
https://lore.kernel.org/all/20240826024457.22423-1-bhe@redhat.com/T/#u

Baoquan He (2):
  x86/mm: rename the confusing local variable in
    early_memremap_is_setup_data()
  x86/mm/sme: fix the kdump kernel breakage on SME system when
    CONFIG_IMA_KEXEC=y

 arch/x86/mm/ioremap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
