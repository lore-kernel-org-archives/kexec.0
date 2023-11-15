Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC20FC4332F
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 00:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7KupGR95nMzj5EgUvWMGe1WdYxeNCfXxv8nezTxjTEg=; b=GEToBwpV5/H942
	roWZmV4UIE4Mc8I5fFor/r3x9BVWGn+jc00yhFr1bR4vuYGjn5GaAbiT7Tx0OOsIYaZ+HgvAQimjn
	YAsRm7rR7315DKRBxBNIbAmWmg72laHbx39bi6uI8ccLJB0KzAqg93tawD5qwwI+NFfUUK0yLc2Q1
	c9oO1jFOMwd5GeVDgpXDQun1613/MMChuQ6d/2XUlJ0q8LRpDiCX5ynsTDBeOuKcFtYI2zWm/xOmq
	AgxuuC95lT3Of6tRM8xL7y8vKg8Q9AiHaMtlOO6qqrx8bp7yKCphZLmmi1cjZZb+eXWow+vLcdgoX
	lkgMgJkfeeGjAZlBRWlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r33xx-00H2XK-0i;
	Wed, 15 Nov 2023 00:41:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r33xu-00H2VM-1B
	for kexec@lists.infradead.org;
	Wed, 15 Nov 2023 00:41:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700008860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=STT+ATW57rth6ZYo472RqzwfiLTSlBKOqun91LfAKSQ=;
	b=Meu3KzsBWv4UAB5vFCvO5/XTIFW+WL+gEqRRZAeNP/Ty9eZkHC9ev1ZvCsLu0j5EH1nIyb
	hUGAyUmsNh/6MqCbg9q4NpLUhIGnna6t+XELC/RIpZSc0ra/EuD1zGpwKR9G5gUrXxqovE
	z/CkrJSCBpA9lLVoJBR6AyCfpsirxWM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-77tfofzDNhCK4KwggBC1CQ-1; Tue, 14 Nov 2023 19:40:55 -0500
X-MC-Unique: 77tfofzDNhCK4KwggBC1CQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04645185A780;
	Wed, 15 Nov 2023 00:40:55 +0000 (UTC)
Received: from localhost (unknown [10.72.112.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D0446112130B;
	Wed, 15 Nov 2023 00:40:53 +0000 (UTC)
Date: Wed, 15 Nov 2023 08:40:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	ebiederm@xmission.com, takahiro.akashi@linaro.org
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-ID: <ZVQTkqSa4FA6b6iH@MiWiFi-R3L-srv>
References: <20231114091658.228030-1-bhe@redhat.com>
 <20231114091658.228030-2-bhe@redhat.com>
 <20231114151745.e77ed504b3fce325f54ec08e@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231114151745.e77ed504b3fce325f54ec08e@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_164110_499261_BC4095FB 
X-CRM114-Status: GOOD (  22.05  )
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

On 11/14/23 at 03:17pm, Andrew Morton wrote:
> On Tue, 14 Nov 2023 17:16:57 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > This function, being a variant of walk_system_ram_res() introduced in
> > commit 8c86e70acead ("resource: provide new functions to walk through
> > resources"), walks through a list of all the resources of System RAM
> > in reversed order, i.e., from higher to lower.
> > 
> > It will be used in kexec_file code to load kernel, initrd etc when
> > preparing kexec reboot.
> >
> > ...
> >
> > +/*
> > + * This function, being a variant of walk_system_ram_res(), calls the @func
> > + * callback against all memory ranges of type System RAM which are marked as
> > + * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
> > + * higher to lower.
> > + */
> > +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> > +				int (*func)(struct resource *, void *))
> > +{
> > +	struct resource res, *rams;
> > +	int rams_size = 16, i;
> > +	unsigned long flags;
> > +	int ret = -1;
> > +
> > +	/* create a list */
> > +	rams = kvcalloc(rams_size, sizeof(struct resource), GFP_KERNEL);
> > +	if (!rams)
> > +		return ret;
> > +
> > +	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > +	i = 0;
> > +	while ((start < end) &&
> > +		(!find_next_iomem_res(start, end, flags, IORES_DESC_NONE, &res))) {
> > +		if (i >= rams_size) {
> > +			/* re-alloc */
> > +			struct resource *rams_new;
> > +			int rams_new_size;
> > +
> > +			rams_new_size = rams_size + 16;
> > +			rams_new = kvcalloc(rams_new_size, sizeof(struct resource),
> > +					    GFP_KERNEL);
> 
> kvrealloc()?

Exactly. Will udpate. Thanks for the great suggestion.

> 
> > +			if (!rams_new)
> > +				goto out;
> > +
> > +			memcpy(rams_new, rams,
> > +					sizeof(struct resource) * rams_size);
> > +			kvfree(rams);
> > +			rams = rams_new;
> > +			rams_size = rams_new_size;
> > +		}
> > +
> > +		rams[i].start = res.start;
> > +		rams[i++].end = res.end;
> > +
> > +		start = res.end + 1;
> > +	}
> > +
> > +	/* go reverse */
> > +	for (i--; i >= 0; i--) {
> > +		ret = (*func)(&rams[i], arg);
> > +		if (ret)
> > +			break;
> > +	}
> > +
> > +out:
> > +	kvfree(rams);
> > +	return ret;
> > +}
> > +
> >  /*
> >   * This function calls the @func callback against all memory ranges, which
> >   * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
> > -- 
> > 2.41.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
