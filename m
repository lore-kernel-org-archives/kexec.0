Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB47C5B552
	for <kexec@archiver.kernel.org>; Mon,  9 Jun 2025 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ijZeolarUTtqmy4GxxtNrTYwrNFMDVmIVcgrPMPb5JU=; b=KuSp7kMmlDRuRS55wUlaLoS5fD
	l1KBTfMtd3+J0aBH96eBbA+agcImrNCWEB6GkPWunmgLAsrKE9xxHlxO88qpIXBdd0jk6+/2uyKOZ
	zkk8F1mZHTdDOLP5HfQSATJEpw04waDjcUXbU6pQyfsMvsOvp45UKdGHsOkMzm6K54HLzss2QYTW8
	bPNcEq5XCiDnJ6hzorr0ErTxvgTsad/yqqy616tFt/RO2S9XbBmGIDVyGSU19bBVhMagVocX5S5xI
	/KCOLRbkHDTUvOsM9HLoUlcsnm8oj8pYvb+i+8UZQpBYyNYUZZXfbZLzqg/a4PeO94OALFbflMCDG
	26xS3/kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOlkq-00000005Qjd-0Wnm;
	Mon, 09 Jun 2025 23:18:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOlkn-00000005Qj9-1Eve
	for kexec@lists.infradead.org;
	Mon, 09 Jun 2025 23:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749511086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijZeolarUTtqmy4GxxtNrTYwrNFMDVmIVcgrPMPb5JU=;
	b=T0hzl6Ym3KWKTHpKN/bpbFCWffoq+CX05qv+AUEFDSMELQ18DNgYH6goAxsSi9FwJXJPmW
	MGRUu70Uj4lvPuyw11x5lg+2tC0ZfEsFPFt1zuYftrKYhgWdU6KWD7PEkaA89ITKsTNEDw
	mHysBKBdvZD+Gg0vwHgDqMb54ms9e60=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-l06piRltPdW19Y3G1SVI6g-1; Mon,
 09 Jun 2025 19:18:03 -0400
X-MC-Unique: l06piRltPdW19Y3G1SVI6g-1
X-Mimecast-MFC-AGG-ID: l06piRltPdW19Y3G1SVI6g_1749511082
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E686A19560AD;
	Mon,  9 Jun 2025 23:18:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.181])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84FDF19560A3;
	Mon,  9 Jun 2025 23:17:59 +0000 (UTC)
Date: Tue, 10 Jun 2025 07:17:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	nh-open-source@amazon.com,
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Bcc: bhe@redhat.com;
Subject: Re: [PATCH v4] kexec: Enable CMA based contiguous allocation
Message-ID: <aEdroxwd/TOyxxIr@MiWiFi-R3L-srv>
References: <20250521152934.48841-1-graf@amazon.com>
 <f609d5a0-99d5-4328-8a18-00f6a9e1a48c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f609d5a0-99d5-4328-8a18-00f6a9e1a48c@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_161809_411464_4C1CE0C4 
X-CRM114-Status: GOOD (  15.36  )
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

On 06/09/25 at 09:03am, Alexander Graf wrote:
> 
> On 21.05.25 17:29, Alexander Graf wrote:
...... 
> > Using CMA allocations has two advantages:
> > 
> >    1) Faster by 4-50 ms per 100 MiB. There is no more need to copy in the
> >       hot phase.
> >    2) More robust. Even if by accident some page is still in use for DMA,
> >       the new kernel image will be safe from that access because it resides
> >       in a memory region that is considered allocated in the old kernel and
> >       has a chance to reinitialize that component.
> > 
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> 
> Ping? Not seeing this patch in Linus' master tree :)

I saw Andrew had added this to his mm-nonmem-unstable, it could be
dropped later because of new version posting.

I would like to ACK this patch, let's see how it's going. One thing is
if IOMMU is on, the devices of no .shutdown method could still be on
flight and look up the IO page table and corrupt kernel, that's another
story. 

Acked-by: Baoquan He <bhe@redhat.com>


