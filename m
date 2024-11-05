Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B58D1CA15
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 03:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ybQ4xIS77eOfQ+/hbiqLiDMmNAXf5z2y72RF4bRlBwM=; b=f6Sy1IJdL0HqPK
	X7P/U7aZGRPLcw8jwmRjRGDl0+iSw82LFVmuEM9/r9SLXerBr0RWlkSOxPVFHcmseRyWU7Yn9S7SD
	LLhhxZjZvDRepn68GTbNgKMMwSV+DBbE+/om7NCMGnwPmpUiUoTbreeQYQNb0VhNcR9+5ZCcX+VrM
	v+GYNbeKWfcYvo1/PhbIsIL7ngqheF7FYGPfU/to99T7kP6KnaKUN2g5nTFYl+L0/rcM1a5fHkMoa
	mhBgRPqN+veXK7ToVaVTI2UnTmQvGB+mSvQt1UWMz/zToVPM8sPsxI5QNWHgs1CyQyX9zYJdwdvYb
	kM9S2cjPbj0ggBlIAwNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ahh-0000000Forw-0g0V;
	Tue, 05 Nov 2024 03:58:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ahe-0000000Foqt-0CSz
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 03:58:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730779081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5+ZXybd87LQtgyOq9OlQJ0N5dnQ5tIJP89oIlWk09U=;
	b=C3pgankdZMNO4N7otFcPSrJh1HKudcpCVJOYzaMoi6LNOniozTWd6dY0mmGPzi4VsSZHRe
	//77LV8i3zCXO3/bxdUJ72NFSfsc/PE4R61jf+RIfF1iA/aZS9u+gai+78BhnvFPXmMlHh
	BGIjyHqRpyKk+AyemCs/FaJemGBWoOY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-ZILyP4RyMYuqZjHdFIJfTQ-1; Mon,
 04 Nov 2024 22:57:38 -0500
X-MC-Unique: ZILyP4RyMYuqZjHdFIJfTQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E89D91955F28;
	Tue,  5 Nov 2024 03:57:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50CF619560A3;
	Tue,  5 Nov 2024 03:57:34 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Philipp Rudo <prudo@redhat.com>
Subject: [PATCH 3/3] x86_64: Support UKI image format
Date: Tue,  5 Nov 2024 11:57:07 +0800
Message-ID: <20241105035710.11384-4-piliu@redhat.com>
In-Reply-To: <20241105035710.11384-1-piliu@redhat.com>
References: <20241105035710.11384-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_195802_180024_105687E8 
X-CRM114-Status: UNSURE (   8.49  )
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
To: kexec@lists.infradead.org
---
 kexec/arch/x86_64/kexec-x86_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index 7b2453f..f7f59f6 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -43,6 +43,7 @@ struct file_type file_type[] = {
 	{ "bzImage", bzImage_probe, bzImage_load, bzImage_usage },
 	{ "beoboot-x86", beoboot_probe, beoboot_load, beoboot_usage },
 	{ "nbi-x86", nbi_probe, nbi_load, nbi_usage },
+	{"uki", uki_image_probe, uki_image_load, uki_image_usage},
 };
 int file_types = sizeof(file_type)/sizeof(file_type[0]);
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
