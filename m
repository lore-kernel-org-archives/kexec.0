Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1A9C2D0CD
	for <kexec@archiver.kernel.org>; Fri, 16 May 2025 03:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ylx2tYr3O0mYWUy90qQPc3a/j5/iK6nT3+STy0Mf8rM=; b=WAq/0Jxyf9HNQeVNV/z5hVBQHt
	iPMIC8qXcrpC8FSRH2nKtEnz3WImVVkhZZV1HCw4QebApnb5BNVLnLod1kvkneUoS2WcgOcYntzss
	C85VHyHuZvRSRgFZHIa3LJoeN/SULvWLWSHFwKY2GSGHffBIfeqEgM1jEY2gm65oR//nE4YNPyzyr
	R+w0HtBKaobHp8RK+1B1eCFUSz05e6qVg/t5JJKBeY+LM14yfH6Allvl/0pza+mtrk9HREUIra/Yj
	D9Kz6uiHsbebbgisbyj43Lj07kGZdGUqCcTYSqpRHAI2vZe7uTzGkZcLXS/5ns2QIHGmdkEZn2MOc
	SY7QFy5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFlk8-00000002NwS-0W2I;
	Fri, 16 May 2025 03:28:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFlk4-00000002Nv6-3gZV
	for kexec@lists.infradead.org;
	Fri, 16 May 2025 03:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747366091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ylx2tYr3O0mYWUy90qQPc3a/j5/iK6nT3+STy0Mf8rM=;
	b=SSaA0Z2poGP930+csWbau9zQjt9k7lMbGnpL/utiIZAIIxni1ih7ovqBlOo7Hyg4rmGUBU
	cGmdzgDXUlGx+STPo7oIFjsTqeZzQwqA1Wcl7BiOQ6Q1UH5mpYq1ftxtcMq+pJwKmIQMvs
	CAvqjK51WPK2tPhxVJdcyBHm+EzOTEk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-OeuX-XSXNKiKTtKwl393_w-1; Thu,
 15 May 2025 23:28:05 -0400
X-MC-Unique: OeuX-XSXNKiKTtKwl393_w-1
X-Mimecast-MFC-AGG-ID: OeuX-XSXNKiKTtKwl393_w_1747366083
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80D801800361;
	Fri, 16 May 2025 03:28:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.140])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5440A1956066;
	Fri, 16 May 2025 03:27:59 +0000 (UTC)
Date: Fri, 16 May 2025 11:27:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH V2] ima: do not copy measurement list to kdump kernel
Message-ID: <aCawunqY+B5lvu5b@MiWiFi-R3L-srv>
References: <20250513143129.1165-1-chenste@linux.microsoft.com>
 <47edc9708d0ca75489d59ef4b9b6ef2f5de21fe9.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47edc9708d0ca75489d59ef4b9b6ef2f5de21fe9.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_202813_000870_24BC1E88 
X-CRM114-Status: GOOD (  13.56  )
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

On 05/14/25 at 08:40am, Mimi Zohar wrote:
> On Tue, 2025-05-13 at 07:31 -0700, steven chen wrote:
> > From: Steven Chen <chenste@linux.microsoft.com>
> > 
> > Kdump kernel doesn't need IMA to do integrity measurement.
> > Hence the measurement list in 1st kernel doesn't need to be copied to
> > kdump kernel.
> > 
> > Here skip allocating buffer for measurement list copying if loading
> > kdump kernel. Then there won't be the later handling related to
> > ima_kexec_buffer.
> > 
> > Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> > Tested-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Baoquan He <bhe@redhat.com>
> 
> Thanks, Boaquan, Steven.
> 
> This patch is now queued in next-integrity and next-integrity-testing.

Thanks for taking care of this.


