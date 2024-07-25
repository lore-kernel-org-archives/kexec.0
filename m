Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED08C3DA63
	for <kexec@archiver.kernel.org>; Thu, 25 Jul 2024 01:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MevtXtAw1qAzy4fcMoUVpmdnwSz/0rgvJmV1CH4e+KM=; b=xC5Y+QlrMLRr6z
	dSo/sV9nLDDU2OhCVyo9+MKaA79qzLYJcGbvNVXmGPhXFYNLL9QMUNfRPwSj3Z7OvYMaBRBcPtI13
	AJYKRqZ5p2kclc9k0mcgEV2akyfErqOYLkuP8AvEhUKTrTdmPdIoQcIMXnv3qoo208UbShr32Lrg/
	C9Al7+ejjXWoTV72XZoJ4Pvz/6+fll1sIFb8qNotI8JUNNX1qcHzVPkJk/SrYdqK1obvhm/JA81Su
	EpjFN6saMUCtGURsl4G1Fq+8spfgQsMXbwY5fZ9udMZQWGFVzp2wzUv2HYx7uaoP+nyWDs6UEl12r
	kYCRQ7tYe4sEhDpcTLKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWnEQ-0000000GzDQ-49Ts;
	Thu, 25 Jul 2024 01:25:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWnEN-0000000GzCN-3t7S
	for kexec@lists.infradead.org;
	Thu, 25 Jul 2024 01:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721870717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+Iv4BdjaJQ3TQQMegE3encsjhBfxvP8emf97KTJrdg=;
	b=i8kmkMEy4EifcMrecV7ZuoVcv0qVMnx4xutJ5WzYzdfamzR605VubHC7vFV5vaby+m5+VR
	gADJOSOlAZkmQKCr2GtwF6308mGmQ/S+vzpjx3tjqYMagejNY7FE5K4vtZ9IngUfh0RptE
	xprezUgz/HyKEofCIGtH97n8cjMnTlg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-vNDifbw6MpqshA_d4k0Ftg-1; Wed,
 24 Jul 2024 21:25:11 -0400
X-MC-Unique: vNDifbw6MpqshA_d4k0Ftg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 440131955D4C;
	Thu, 25 Jul 2024 01:25:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DCEB1955F6E;
	Thu, 25 Jul 2024 01:25:07 +0000 (UTC)
Date: Thu, 25 Jul 2024 09:25:03 +0800
From: Baoquan He <bhe@redhat.com>
To: akpm@linux-foundation.org, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v4 0/3] crash: Fix x86_32 memory reserve dead loop bug
Message-ID: <ZqGpb3d3Bk0LnbGR@MiWiFi-R3L-srv>
References: <20240719095735.1912878-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20240719095735.1912878-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_182520_202986_65822243 
X-CRM114-Status: UNSURE (   7.39  )
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

Hi Andrew,

On 07/19/24 at 05:57pm, Jinjie Ruan wrote:
> Fix two bugs for x86_32 crash memory reserve, and prepare to apply generic
> crashkernel reservation to 32bit system. Then use generic interface to
> simplify crashkernel reservation for ARM32.

This is the final version v4 we agree on.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
