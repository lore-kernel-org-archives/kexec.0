Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E677D6E2CF
	for <kexec@archiver.kernel.org>; Wed, 20 Nov 2024 08:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gh6m/YaiQcWez3DW3gpI7yQKGyz075BISLGCEYs6JIY=; b=0RWzRNGQSavIBZg5FfSVIbit3R
	PLigG9rb6E7QLuAunNOjs/ABgOQMJeXMkrhFYpEmxXsz141QY22jINbH4kzgFa8zVmlab2kPlTJJY
	ZRiBkI0NdommbFN/e6wkemLW+ot2PWupxi4VR4IYYu3893Iuw9BVWQ7NXwZ1LHT/mak9aqL1XbKRo
	vKlPhjWtdzdFuF2UjpSTgm56NdGMaF/Kk7OjtnfzuWL4Bik+MzToPVVTNivHUN3SJONbdPorYXS7e
	n2mHQWwd2EJehX786hn39V+iND6gLPJdcLk4JRw3a6rV9N22rbdX6IJqP+VqQTS4o54DPiuBb10/w
	lQz3xpjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDfri-0000000EiHh-0Ugt;
	Wed, 20 Nov 2024 08:15:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDfre-0000000EiFN-2GS3
	for kexec@lists.infradead.org;
	Wed, 20 Nov 2024 08:15:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732090503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gh6m/YaiQcWez3DW3gpI7yQKGyz075BISLGCEYs6JIY=;
	b=AxTXJX7sFRjPxKptNgJpKUiZdPvNvaZnBXdt78lybn9GvMFz5+/ltTl0jFL21tYRNdqtyo
	um60Jp1nNKrnILjUJwba6QUUOkJ0qH2QW1yvyHipO27F3D8qEn+mXKquVSO+9XItCElpeZ
	FLIDC4lhCSF0onQG8T2UOdmGZ25Ps2Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-pqFBDy8RM8a5-PwqnLhryw-1; Wed,
 20 Nov 2024 03:14:59 -0500
X-MC-Unique: pqFBDy8RM8a5-PwqnLhryw-1
X-Mimecast-MFC-AGG-ID: pqFBDy8RM8a5-PwqnLhryw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D3F9195608B;
	Wed, 20 Nov 2024 08:14:57 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9E9B19560A3;
	Wed, 20 Nov 2024 08:14:54 +0000 (UTC)
Date: Wed, 20 Nov 2024 16:14:50 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 02/11] fs/proc/vmcore: replace vmcoredd_mutex by
 vmcore_mutex
Message-ID: <Zz2aekArHaIT4JU5@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-3-david@redhat.com>
 <ZzcVGrUcgNMXPkqw@MiWiFi-R3L-srv>
 <9160c6b4-f8a0-431d-8a21-ead510a887a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9160c6b4-f8a0-431d-8a21-ead510a887a1@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_001506_658318_A0B814A3 
X-CRM114-Status: GOOD (  18.19  )
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

On 11/15/24 at 11:04am, David Hildenbrand wrote:
> On 15.11.24 10:32, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > Let's use our new mutex instead.
> > 
> > Is there reason vmcoredd_mutex need be replaced and integrated with the
> > vmcore_mutex? Is it the reason the concurrent opening of vmcore could
> > happen with the old vmcoredd_mutex?
> 
> Yes, see the next patch in this series. But I consider this valuable on its
> own: there is no need to have two mutexes.
> 
> I can make that clearer in the patch description.

That would be great and more helpful. Because I didn't find the reason
about the lock integration and avoid concurrent opening of vmcore in
cover-letter and logs of the first few patches, I thought there have
been potential problems and the first few patches are used to fix them.


