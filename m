Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8711073CB6
	for <kexec@archiver.kernel.org>; Wed,  8 Apr 2026 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r/Y23Y6+TgboGn8/LfXnsCxsQVQLxcWtArX86YcRaOc=; b=kOmFX0XwDUksibZK3kEMXRMR59
	kyDN+AcmVLLUycof+UCvH4yw6AQKSVqNN8aCxBclnZx3WrGhGVt7WI0lEw793mG7RaR4t5J3pYEVf
	bzRlsW3g6asVFy9Q01ZdsF9P46U2sGiIAL/EpKQpk3AAYPdHzoseJ0JRBVpd/AbR0vHa1uJtiivAK
	L4IgXD+Yv845yVaspxhZ3nS8vWJs+9ivGQ1xbGzAXnpbwQR1vSvKQwiI6y/0CIllg8oaL3OrX6jYj
	kWCF5F3GtefnTAGF0Pdyho62fDDESymu+OXkCSBsZODnOuB9eftUMMeTupZZEJnme7AXzBoTcuWFa
	eaI3Eh5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAT1j-00000008v29-26eJ;
	Wed, 08 Apr 2026 13:33:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAT1h-00000008v1q-26wQ
	for kexec@bombadil.infradead.org;
	Wed, 08 Apr 2026 13:33:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r/Y23Y6+TgboGn8/LfXnsCxsQVQLxcWtArX86YcRaOc=; b=gDwui6qBUudn1iM3FyTpMTenw/
	Oi/i/t4zyRti42AEq0zWpgLqz0qMD93+24F5TUqU4LDNjhk3W2qda2mhrxuHyn0THzZmPMicPoCx4
	02p5wk1wokhXQDP0YhEtoJ8kkKmwKiJZln8qinFWb70I+Ep5P4XOXmhCBBCKm9yg3CbSB0BzxQpNj
	92GKQnTFYznjT0HR3tLl5WaQolrg3cFtxYI0O7hi9hTML1X/I72aTP2l8f6PXw+6QcDFymeKHeBJ0
	LTRPpFqx1HxkhfiSiaCu7skDikD+kgUlG/Zl1mcoSuOg0BnrMNOsPhfXTKseVoyFhcWD6QRX8m0/h
	ciLYmnVQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAT1e-0000000A9XG-2RZ7
	for kexec@lists.infradead.org;
	Wed, 08 Apr 2026 13:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775655166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/Y23Y6+TgboGn8/LfXnsCxsQVQLxcWtArX86YcRaOc=;
	b=d7UYjvZ3nTVDal/mPbYnFJFF8sLakU2YVOFUkZrIoojU+YJvCXs0LPqq9oTW/gT8m+Ae6W
	6vKQJT72OyYIYmGLO2cjU6DVS2sGfvEf8vBHvqcuw1tSj8dI5L0N42VLMWzo7KZ+M3FeJg
	FJPUgzVdbvN7yzp5NWPq6TF0MXebdxM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775655175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/Y23Y6+TgboGn8/LfXnsCxsQVQLxcWtArX86YcRaOc=;
	b=ZJWspQaRzObULky31nFNhuKLkI0eZtEfUe8WB9VYSAXarK1z7mrVWczjPMcHmvOUpB0TV5
	7ZfrNfe1vAT/GSwdnLxFpjF+uCEisUMYya175shS93VoW80I38LlICv0PeiJchgykojePe
	VgE8XkXAMm8/YfCy5MjssJfSYhaZEAE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-8zcQoo72Ov26oEExhcMakA-1; Wed,
 08 Apr 2026 09:32:43 -0400
X-MC-Unique: 8zcQoo72Ov26oEExhcMakA-1
X-Mimecast-MFC-AGG-ID: 8zcQoo72Ov26oEExhcMakA_1775655160
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56753191DCC4;
	Wed,  8 Apr 2026 13:32:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACEB3195E499;
	Wed,  8 Apr 2026 13:32:11 +0000 (UTC)
Date: Wed, 8 Apr 2026 21:32:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Youling Tang <youling.tang@linux.dev>,
	Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] crash: Support high memory reservation for range syntax
Message-ID: <adZYpnwOxgvFMLaT@MiWiFi-R3L-srv>
References: <20260404074103.506793-1-youling.tang@linux.dev>
 <d584d383-1862-417d-9251-153d9bcf5626@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <d584d383-1862-417d-9251-153d9bcf5626@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: BJwa2DTMxWT-XrZJM1I2mydurm0x_wUs6dAQAI-Gm7Y_1775655160
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_143258_762128_A246B509 
X-CRM114-Status: GOOD (  14.69  )
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

On 04/08/26 at 10:01am, Sourabh Jain wrote:
> Hello Youling,
> 
> On 04/04/26 13:11, Youling Tang wrote:
> > From: Youling Tang <tangyouling@kylinos.cn>
> > 
> > The crashkernel range syntax (range1:size1[,range2:size2,...]) allows
> > automatic size selection based on system RAM, but it always reserves
> > from low memory. When a large crashkernel is selected, this can
> > consume most of the low memory, causing subsequent hardware
> > hotplug or drivers requiring low memory to fail due to allocation
> > failures.
> 
> 
> Support for high crashkernel reservation has been added to
> address the above problem.
> 
> However, high crashkernel reservation is not supported with
> range-based crashkernel kernel command-line arguments.
> For example: crashkernel=0M-1G:100M,1G-4G:160M,4G-8G:192M
> 
> Many users, including some distributions, use range-based
> crashkernel configuration. So, adding support for high crashkernel
> reservation with range-based configuration would be useful.

Sorry for late response. And I have to say sorry because I have some
negative tendency on this change. 

We use crashkernel=xM|G and crashkernel=range1:size1[,range2:size2,...]
as default setting, so that people only need to set suggested amount
of memory. While crashkernel=,high|low is for advanced user to customize 
their crashkernel value. In that case, user knows what's high memory and
low memory, and how much is needed separately to achieve their goal, e.g
saving low memory, taking away more high memory.

To be honest, above grammers sounds simple, right? I believe both of you
know very well how complicated the current crashkernel code is. I would
suggest not letting them becomre more and more complicated by extending
the grammer further and further. Unless you meet unavoidable issue with
the existing grammer.

Here comes my question, do you meet unavoidable issue with the existing
grammer when you use crashkernel=range1:size1[,range2:size2,...] and
think it's not satisfactory, and at the same time crashkernel=,high|low
can't meet your demand either?

Thanks
Baoquan


