Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E58C54756
	for <kexec@archiver.kernel.org>; Thu, 22 May 2025 03:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pP0gCOXOC50Z/0xxYAr7ydbCoPDt1OcdK6DtbcZyLKM=; b=S2rk5xn/vdgcDOLa1CZFpFiAoJ
	oBJQLQvgE2TPxmDXi1Llor1+M/ihGDBybaOD+9djHiHn9rrTl2SVwES3docfZEfXHZzohHo1/+n2z
	63UAxa75nr3sMqKoUW1s4mH+mcVWGlZjeyJyQIaQ03fOJh8QyVZctwBCY0X4817uAsG9Gebd9GQ6X
	i8d516aE80VS+haaUjQnesvnL4t/3Gik4Jd/NaoIQ6m1vT4NhHXn5GRu9Pc5kmi4USVGy6U+X3L9W
	bG+jWeRV76IZ2l9BIyK/nlhskxQLxTUkaG7j7strhT+WM5DREF+DUig4oQShAvNHvAepUoLwqjwfc
	l8JkgcNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHwwG-0000000HMnk-31aZ;
	Thu, 22 May 2025 03:49:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHwwD-0000000HMnN-1xdb
	for kexec@lists.infradead.org;
	Thu, 22 May 2025 03:49:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747885783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pP0gCOXOC50Z/0xxYAr7ydbCoPDt1OcdK6DtbcZyLKM=;
	b=DHeNByC1wOsPJXox/AJ3h//Efx6gLszfj62/lUk6fTy1+q9YFgOkZDkg1M9hhyO19Xxquk
	vEApigB48Cqt5Swkrfuds0ICA69EKoOTKrq5zI7YTa/toxEkXf5mJpyU0peg2OeavY7qP3
	aLt3RxL6L3Cvsc9ncf6Zcnx5SllgruA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-5Ihd1d0fOMS9kWgG_6x3aQ-1; Wed,
 21 May 2025 23:49:40 -0400
X-MC-Unique: 5Ihd1d0fOMS9kWgG_6x3aQ-1
X-Mimecast-MFC-AGG-ID: 5Ihd1d0fOMS9kWgG_6x3aQ_1747885779
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24CCB195608D;
	Thu, 22 May 2025 03:49:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.172])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C317A19560AE;
	Thu, 22 May 2025 03:49:37 +0000 (UTC)
Date: Thu, 22 May 2025 11:49:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
	coxu@redhat.com, ruyang@redhat.com, chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <aC6ezNcUZ/ulKgpv@MiWiFi-R3L-srv>
References: <20250515233953.14685-1-bhe@redhat.com>
 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <02e5091f96404a86073abacb2861a07cf1deb439.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e5091f96404a86073abacb2861a07cf1deb439.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_204945_588566_DF8DE655 
X-CRM114-Status: UNSURE (   6.01  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 05/21/25 at 08:58am, Mimi Zohar wrote:
> In addition, please update the Subject line to be less generic.

Sure, will change subject as below:

ima: add a knob ima= to allow disabling IMA in kdump kernel


