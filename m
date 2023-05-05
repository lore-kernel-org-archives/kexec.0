Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E599BC77B73
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 02:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QQaOJgUpfQEgrXjMJwFTuHnp8BXHpPuWi9YksZHGDB8=; b=yPNkZwCvY3IE6/
	SLAUnBz9/nkMaFWjHXfWtD7zuiEDo7qIrxAyVwBLRSu6j49noG6MkJfmEhymyavv//rWScwObBKy4
	wAQvQmjB83yKbpT7Lgblc0uoAvmUn4pCxbhFSf+h51MRfucpw2AWpLFhA1aXaX4eDutSNWEhJ8F/p
	CHnraEgV91lJlOq524JWo/qSp8Qw3uXlfQw6nIn1+Y+jzeUuowMJ5QbzgOHSJeye7rvuyF4GQGpry
	3rEYqWNDNuZP2BneAF5H5wQuTmaQGDY5+SuA3IzfhDp3Ol7Mjqx+pdexxSgSzBb9AJDthqb1YXr4f
	iCmA/OPpnv926ITqikqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pulce-009aPd-27;
	Fri, 05 May 2023 02:56:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pulcZ-009aP3-2n
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 02:56:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683255393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgkPtKrRU7OJn79pDvm5Fz9kKFsvWkOrlWZOPKC2tME=;
	b=QZGLf7OsfBuhx1gcxm5WIXNkJHzkrK0xYj5jrSlIWMmSDzWu4an0YZf3qROpCK7NIvE18T
	MB3nm2/gwuW9IAv4oOT1kx4BQc7AJYf52+HQPnrn74vMCpyREGH5xtzkDYNRt35AQ92akp
	By4Gp1xM6D1YzG18uly1fQLxN+HHO/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-Vakv-6KJM6eThvLoV4qo6A-1; Thu, 04 May 2023 22:54:58 -0400
X-MC-Unique: Vakv-6KJM6eThvLoV4qo6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 311B3A0F387;
	Fri,  5 May 2023 02:54:58 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5BD1407D450;
	Fri,  5 May 2023 02:54:55 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCH 1/5] kexec: Adding missing free for kernel_buf
Date: Fri,  5 May 2023 10:54:33 +0800
Message-Id: <20230505025438.11943-2-piliu@redhat.com>
In-Reply-To: <20230505025438.11943-1-piliu@redhat.com>
References: <20230505025438.11943-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_195635_990614_2C7FF411 
X-CRM114-Status: UNSURE (   9.46  )
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

slurp_decompress_file() allocates memory but nowhere to free it.
Adding that missing free.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 36bb2ad..614cd1d 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1379,6 +1379,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 		}
 	}
 
+	free(kernel_buf);
 	close(kernel_fd);
 	return ret;
 }
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
