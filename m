Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87419E66886
	for <kexec@archiver.kernel.org>; Mon, 22 Dec 2025 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTiTJP9bxiFe7cenEwFXRKuMhOl99enu+VnKq8sFL2w=; b=qd7MEB3BCIeN5n5s+yKVNdqrGK
	OL/kawiR+xe16P4t07cPBMEciGrpS4KULzmJ/b7UJAlc7Z28k6CqWmNT5NMDuPjgcq45LBrRiXdZu
	MWvA3iLrCQ3F1DAIqCfnKw1VAR6x/HwnFWYs+Fc1HskqZClVUxS6I3fc3NsNDeSTZaqmtLULPKs4S
	tCRJGo/xrdrobEWVoAuj94LdThPw+hvHiKrcwRHIRCoehquZBJaNxXCbnPEoo4Xu12U4Bch97z7ZG
	n7blLt0UIpAxomMb/rx8jgDoCYuv/lOiO4Z/vvs5XGtIwj/NXxJe1aOS8mYWHFcuS20pBEFnopV41
	g8cSW1sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXVNK-0000000CyfL-33h0;
	Mon, 22 Dec 2025 02:10:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXVNC-0000000CyeR-0tBN
	for kexec@lists.infradead.org;
	Mon, 22 Dec 2025 02:10:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766369406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RTiTJP9bxiFe7cenEwFXRKuMhOl99enu+VnKq8sFL2w=;
	b=JLKx6VeKK8W7VafkxzskWDTxQw/pT918FgfhJRrN3qeLBr+w7Ss5iurLf3gXQMSYO0wLOy
	CJcauYH914CDF/0Tdzq2HFhwhJIctT0g2kgXMDi/QJ7PX+JXZvbXFqOmNFCmCJkT9Rzg8D
	KdFdRskAKUo77QkSUGv4CQk0Nh8fgn4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-a6snkLrMP0yGYdSshfcOLg-1; Sun,
 21 Dec 2025 21:10:02 -0500
X-MC-Unique: a6snkLrMP0yGYdSshfcOLg-1
X-Mimecast-MFC-AGG-ID: a6snkLrMP0yGYdSshfcOLg_1766369400
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 079A0195609D;
	Mon, 22 Dec 2025 02:10:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.76])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86E57180049F;
	Mon, 22 Dec 2025 02:09:57 +0000 (UTC)
Date: Mon, 22 Dec 2025 10:09:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv3 1/2] kernel/kexec: Change the prototype of
 kimage_map_segment()
Message-ID: <aUiocTZx986boBQX@MiWiFi-R3L-srv>
References: <20251216014852.8737-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216014852.8737-1-piliu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251221_181010_332820_8AF49693 
X-CRM114-Status: GOOD (  11.41  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 12/16/25 at 09:48am, Pingfan Liu wrote:
> The kexec segment index will be required to extract the corresponding
> information for that segment in kimage_map_segment(). Additionally,
> kexec_segment already holds the kexec relocation destination address and
> size. Therefore, the prototype of kimage_map_segment() can be changed.
> 
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org>
> To: kexec@lists.infradead.org
> To: linux-integrity@vger.kernel.org
> ---
>  include/linux/kexec.h              | 4 ++--
>  kernel/kexec_core.c                | 9 ++++++---
>  security/integrity/ima/ima_kexec.c | 4 +---
>  3 files changed, 9 insertions(+), 8 deletions(-)

Ack the series:

Acked-by: Baoquan He <bhe@redhat.com>


