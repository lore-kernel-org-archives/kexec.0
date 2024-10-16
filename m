Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6900D1AD48
	for <kexec@archiver.kernel.org>; Wed, 16 Oct 2024 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eYdEdkAdoHOlxDXgETWCR+xM6hrfZhXfxmFfOq8UDjU=; b=SPU64x39J7d0Ng
	VwQEx6axM4cM7NCfHfJbWve23yxywBYaCHiX5Nq2VeUrbYYrsf0oed9FmMEwoOxRXXSL1U4DP7Ka5
	25Mvk8s5CPPvKatAS+psXOw/ycoMqQiGl/sFuARikUwnQ+3aqGU4N1OYxk/AFqZiZBHat732LwCW7
	vR6Uz5dB0fTD3MRt8ptAWc0OjWceBAWql8HCM1MvMeo92ewF/5fboXGqVfSFOi9XZN/VwPePpZjgR
	8sAtRUpaoCPkj81bgLfS8fcKpPo5NyMXVQZ6AgmDOWyUu2zlxB8qBeJ+3G53j5/ai48TcM6PybW40
	FYn7IC8HvRwuv2FKzoBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t12Iq-0000000BbJs-1TnA;
	Wed, 16 Oct 2024 11:34:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t12In-0000000BbHY-03jW
	for kexec@lists.infradead.org;
	Wed, 16 Oct 2024 11:34:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729078492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsBmydN0KS1Osm23ZsGn+B6+OjUIj9BFKwaA2wvUy5I=;
	b=hYkydYk0GWqAqkIPtiG8wMxw08volHXaEIFBPcrIfwJRxqk7h0SUuZz+d2HQN+YLLYAOUJ
	9ivW8RVqXR8nd9yZF+lgfMZ8T3hNOzQ1wt8n6oiUYRnHhkuCcdWSKLbU6TIFyxWltFC2g7
	TCFWGOoLLVjHSPbaI5GS3/OD2nZzjUI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-pNONnWD5OqOzAF2DWnCIqg-1; Wed,
 16 Oct 2024 07:34:49 -0400
X-MC-Unique: pNONnWD5OqOzAF2DWnCIqg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC2491956096;
	Wed, 16 Oct 2024 11:34:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.65])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97C281956086;
	Wed, 16 Oct 2024 11:34:41 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: 
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	kexec@lists.infradead.org
Subject: [PATCHv2 3/3] arm64: Support UKI image format
Date: Wed, 16 Oct 2024 19:34:15 +0800
Message-ID: <20241016113418.22568-4-piliu@redhat.com>
In-Reply-To: <20241016113418.22568-1-piliu@redhat.com>
References: <20241016113418.22568-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_043453_151803_CEAF3E09 
X-CRM114-Status: UNSURE (   7.58  )
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

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
---
 kexec/arch/arm64/kexec-arm64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 55e822b..9091f40 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -75,6 +75,7 @@ struct file_type file_type[] = {
 	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
 	{"uImage", uImage_arm64_probe, uImage_arm64_load, uImage_arm64_usage},
 	{"vmlinuz", pez_arm64_probe, pez_arm64_load, pez_arm64_usage},
+	{"uki", uki_image_probe, uki_image_load, uki_image_usage},
 };
 
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
