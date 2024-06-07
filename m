Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD6AC27C55
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qt79vRMWCR3hku28jsIkH93Iyil7IuomiUO50+a57A8=; b=QGGG/bSbifuTqh
	RkSEY2Z2fS37/qK3v1J/j1hNdAnoda9nfnzNmGw6DT99E5ceHIKC+Ersdqczw1r2QQHRJls7qQ/9x
	HQTRK53frft/ZohdJLiRYIKNNVa2e7/+CauFQhruIm9CU5tyDU6ylcMYLOv3jNl1TQRfNifyO7mFX
	xHjikWb563bHu2IPxTEoZ5aE3f7RjXLzXE4jPITuwnVSVQogQa6rWPMdxfVdvZ8+QwSZw8X/wLczF
	BfVlTbBbSR8WQCqLmflmE7P0uRSQUYY2SSQ+Uw0LywAe6BwKxgsv0jR7Q8fRRTSVphTmj2M7wOkxJ
	JbrqFCJteMF2mi4tWuEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFWEv-0000000DP4F-0mG0;
	Fri, 07 Jun 2024 09:50:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFWEt-0000000DP3D-0qvz
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 09:50:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717753825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgUcKDXwW/3wItiPJn/Z+o3EMy54AtmFeCxWRvfH4ZE=;
	b=LaGOKOS4VHIVzPdW/1Z8N2lFPiJGPxRwcttCjrcd4QgOvZD22uK1lfQOUFb7aRUW8sS377
	lzNTPvTLc/kWHWnOe4zDJPCK63IcPGz10ukK/qsqckjW+NnXPLO8bto+EMFogSBfNtz+RJ
	EAwr7fde+2GzAoCcS0c4Df2qwuiy7jk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-XIAT92ayN7-n_AW4BioL7w-1; Fri, 07 Jun 2024 05:50:21 -0400
X-MC-Unique: XIAT92ayN7-n_AW4BioL7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A10685A5B5;
	Fri,  7 Jun 2024 09:50:20 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 65F2140C6EB7;
	Fri,  7 Jun 2024 09:50:18 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:50:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Message-ID: <ZmLX15YJIhUG/XP3@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-6-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-6-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_025027_332892_8FD08DDB 
X-CRM114-Status: UNSURE (   7.42  )
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

On 05/23/24 at 01:04pm, Coiby Xu wrote:
......
> +ssize_t __weak dm_crypt_keys_read(char *buf, size_t count, u64 *ppos)
> +{
> +	struct kvec kvec = { .iov_base = buf, .iov_len = count };
> +	struct iov_iter iter;
> +
> +	iov_iter_kvec(&iter, READ, &kvec, 1, count);
> +	return read_from_oldmem(&iter, count, ppos, false);
Do we need create a x86 specific version to cope with the confidential
computing thing, e.g sme/tdx?

> +}
> +


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
