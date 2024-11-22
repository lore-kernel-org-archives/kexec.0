Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5076E65D39
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iTleGtvdq1osypVXWqisdoYoTofXyVXhiRbJdgp9AcQ=; b=ZFvXxN8EYLSm9ZbwZbWhmhG9qd
	AQPiOZaWFtGcTvMPCpUovakMJHbCGgwYrewkE/t6PeLCbNyNG+0wDwABkE30NQ46HVD41XcWygSCJ
	7YgrQPZRJoZHkWFlpmaNwu7PkETAZU7FAt4FL28crCTWSZMRvjlJnrsc+K/TUBZn1/JuOEIXn2yG0
	h4iPEMxenqxDZfZ4+HrmkjtfPaTJq6/C2wx2CFEPuE+oy/WlFWJtA+Ff59L5cO5dcKw2BmFcJuu+Z
	eu1LWePkPhfBegPNPIOPAzfiRYm15oSHH6PzHSCgOfGZhCoMaGnGAHrpugKKIoTcyezCZt/dcJBgZ
	9lCXj3/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEPv2-000000025Vk-3BSj;
	Fri, 22 Nov 2024 09:25:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEPmc-0000000237q-2zef
	for kexec@lists.infradead.org;
	Fri, 22 Nov 2024 09:17:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732267017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTleGtvdq1osypVXWqisdoYoTofXyVXhiRbJdgp9AcQ=;
	b=Yj6XxDNg6rlbvKUFC4CE5Komoqi8eaSpGNl/FMUWQqwF8q3DJ1TPMJUbBin20v2myXqS40
	n0Ato1SoarCTBjOmto0/LifaYE98g6NiJ0y8LULY4n6kc0rel8TyNvGZE2+VvUD0U2DRT/
	l7eq0CKDDbqydR5NZVi89tY3tKd1iDY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-yqNZKyvGM92oYIoNe2PX8A-1; Fri,
 22 Nov 2024 04:16:55 -0500
X-MC-Unique: yqNZKyvGM92oYIoNe2PX8A-1
X-Mimecast-MFC-AGG-ID: yqNZKyvGM92oYIoNe2PX8A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23FF01955BF4;
	Fri, 22 Nov 2024 09:16:52 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E86D01955E9E;
	Fri, 22 Nov 2024 09:16:49 +0000 (UTC)
Date: Fri, 22 Nov 2024 17:16:45 +0800
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
Subject: Re: [PATCH v1 03/11] fs/proc/vmcore: disallow vmcore modifications
 after the vmcore was opened
Message-ID: <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-4-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_011658_824480_EA8F1498 
X-CRM114-Status: GOOD (  13.19  )
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

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
......snip...
> @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  		return -EINVAL;
>  	}
>  
> +	/* We'll recheck under lock later. */
> +	if (data_race(vmcore_opened))
> +		return -EBUSY;

As I commented to patch 7, if vmcore is opened and closed after
checking, do we need to give up any chance to add device dumping
as below? 

fd = open(/proc/vmcore);
...do checking;
close(fd);

quit any device dump adding;

run makedumpfile on s390;
  ->fd = open(/proc/vmcore);
    -> try to dump;
  ->close(fd);

> +
>  	if (!data || !strlen(data->dump_name) ||
>  	    !data->vmcoredd_callback || !data->size)
>  		return -EINVAL;
> @@ -1515,12 +1507,16 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	dump->buf = buf;
>  	dump->size = data_size;
>  
> -	/* Add the dump to driver sysfs list */
> +	/* Add the dump to driver sysfs list and update the elfcore hdr */
>  	mutex_lock(&vmcore_mutex);
> -	list_add_tail(&dump->list, &vmcoredd_list);
> -	mutex_unlock(&vmcore_mutex);
> +	if (vmcore_opened) {
> +		ret = -EBUSY;
> +		goto out_err;
> +	}
>  
> +	list_add_tail(&dump->list, &vmcoredd_list);
>  	vmcoredd_update_size(data_size);
> +	mutex_unlock(&vmcore_mutex);
>  	return 0;
>  
>  out_err:
> -- 
> 2.46.1
> 


