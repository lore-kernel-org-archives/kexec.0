Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00350D6E2CF
	for <kexec@archiver.kernel.org>; Wed, 20 Nov 2024 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gLoIyx3MwjYje1cCzOJ5zph/jdarSH9KY05cS8kqUro=; b=yHNGRULXH1su1JqnNxUgSI+Lr9
	SNagyGXxCz4dbyAgJDUuTMivEA63kdKx/mHf7jeyS6wDJN6rQDaS/HOB84Lr0WYXM7521osUtnotM
	/zM3/PZbVrHOhZBvcK/6QKnI8Fj+PknlYF+IHckKKjFL0vP3zgKDsf83alDp9A6x+Qvnja5DS2c/R
	LH5sUQ4nMY5sD1VYFoy0C5XKUEC5GVOm+JW9vZSMoHOuaJeZniAXOfi7cr/gOXBpeM6vocGT2JDhC
	Oh1Y0IPpRhFAlgkhG8pAVvP26AlGhiXjMTTxp6HN9Y1QJ2mG0ZtjBmW5/Wrbf7ysTjD+d2C31NCfF
	bEAI+EOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDftZ-0000000EieT-2iGb;
	Wed, 20 Nov 2024 08:17:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDftW-0000000Eidi-33gX
	for kexec@lists.infradead.org;
	Wed, 20 Nov 2024 08:17:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732090621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLoIyx3MwjYje1cCzOJ5zph/jdarSH9KY05cS8kqUro=;
	b=YcqAYNOG81H1DcDRMtZMLyD2U75DQ9FwVrBEg9/LaplUh8B0jV3m1rdlejw35CvyMQfB0E
	erpvfkGAAHe1jjq17BqjHUeHwXGk7eCr4D3rgiIF8I9FGnDwkhWL8/QBIThWbw23ROnoEl
	Vls/U4VI66YnnmLasF0of9HeDBZgydA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-xwZYZB6JPMep3tIsEwHwCg-1; Wed,
 20 Nov 2024 03:16:58 -0500
X-MC-Unique: xwZYZB6JPMep3tIsEwHwCg-1
X-Mimecast-MFC-AGG-ID: xwZYZB6JPMep3tIsEwHwCg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5768E19560A1;
	Wed, 20 Nov 2024 08:16:55 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 790CA1955F43;
	Wed, 20 Nov 2024 08:16:53 +0000 (UTC)
Date: Wed, 20 Nov 2024 16:16:38 +0800
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
Subject: Re: [PATCH v1 01/11] fs/proc/vmcore: convert vmcore_cb_lock into
 vmcore_mutex
Message-ID: <Zz2a5gZq81ZVdFOx@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-2-david@redhat.com>
 <ZzcUpoDJ2xPc3FzF@MiWiFi-R3L-srv>
 <2b5c2b71-d31b-406d-abc5-d9a0a67712f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b5c2b71-d31b-406d-abc5-d9a0a67712f5@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_001702_835308_0B545710 
X-CRM114-Status: GOOD (  21.28  )
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

On 11/15/24 at 11:03am, David Hildenbrand wrote:
> On 15.11.24 10:30, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > We want to protect vmcore modifications from concurrent opening of
> > > the vmcore, and also serialize vmcore modiciations. Let's convert the
> > 
> > 
> > > spinlock into a mutex, because some of the operations we'll be
> > > protecting might sleep (e.g., memory allocations) and might take a bit
> > > longer.
> > 
> > Could you elaborate this a little further. E.g the concurrent opening of
> > vmcore is spot before this patchset or have been seen, and in which place
> > the memory allocation is spot. Asking this becasue I'd like to learn and
> > make clear if this is a existing issue and need be back ported into our
> > old RHEL distros. Thanks in advance.
> 
> It's a preparation for the other patches, that do what is described here:
> 
> a) We can currently modify the vmcore after it was opened. This can happen
> if the vmcoredd is added after the vmcore was loaded. Similar things will
> happen with the PROC_VMCORE_DEVICE_RAM extension.
> 
> b) To handle it cleanly we need to protect the modifications against
> concurrent opening. And the modifcations end up allocating memory and cannot
> easily take the spinlock.
> 
> So far a spinlock was sufficient, now a mutex is required.

I see, as we talked in patch 2 sub-thread, these information are very
valuable to help people get the background information when they read
code. Let's put it in patch log. Thanks.

> 
> Maybe we'd want to backport 1,2,3, but not sure if we consider this critical
> enough.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


