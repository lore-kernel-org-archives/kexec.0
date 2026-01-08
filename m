Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B8CD14899
	for <kexec@archiver.kernel.org>; Thu,  8 Jan 2026 03:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TqkA5ZayFeDWxiqiqN+hD7LCP7d5sRCdB4Jg02yJh4U=; b=B2zcCgAyGnDdqAszIdZh3dk9bf
	9m7Rh5RplmWJ6sawHmf6ya6vdRbbIFIDo2CTzpVQDa7HeW2Wxl6xR6Rph8PWrWNx9JwH7iySahd8Z
	YpXn3lDFT4LhURj28UogppGhHJt8YAVqhRAF7VTA5cZxFCenZEd3qrMdD5DK0CntuSJogbKfGnoL1
	18xn6TiRJKzzLn2eZDmWt/S0Mqjfi+JOA7de1hbyixQgwNnbechaOrx2P3wRJttXP/5abcsYnjI8d
	bTWFzUWjw/c7/TlOmuvO/Zojq74gFtjm6KN1YH+1YcemVeKsQpwRvO9tMPADreSMbwxLUJGtLmVDA
	xDIYpWwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdgSU-0000000Frrl-1xb9;
	Thu, 08 Jan 2026 03:13:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdgSQ-0000000FrrM-2ImF
	for kexec@lists.infradead.org;
	Thu, 08 Jan 2026 03:13:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767841983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqkA5ZayFeDWxiqiqN+hD7LCP7d5sRCdB4Jg02yJh4U=;
	b=XZ3QQmadLtUt6NbvXBZDMzckqk69QDfTW2HHeu24Dd3NfhAXS4wRCvt1hHg1/UDaVnaDFW
	EdiMjKuK+XAlAjsPq6iJVcnt3GCxA9GrXvCSxSQ0dESQqemQB9zY/iKNPEptnx6LsBBAzV
	fMrTQnXXkyvWcHcsaWKgvW8g7AacMwI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-4mEiVWWRMB-s2KIbFUWGeQ-1; Wed,
 07 Jan 2026 22:13:00 -0500
X-MC-Unique: 4mEiVWWRMB-s2KIbFUWGeQ-1
X-Mimecast-MFC-AGG-ID: 4mEiVWWRMB-s2KIbFUWGeQ_1767841979
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1A5F195608E;
	Thu,  8 Jan 2026 03:12:58 +0000 (UTC)
Received: from localhost (unknown [10.72.112.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A20B319560A2;
	Thu,  8 Jan 2026 03:12:56 +0000 (UTC)
Date: Thu, 8 Jan 2026 11:12:46 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
To: David Binderman <dcb314@hotmail.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-6.19-rc4/kernel/kexec_core.c:425: Possible loss of data ?
Message-ID: <aV8grrXoMlkJZ0fY@MiWiFi-R3L-srv>
References: <VI1PR02MB395224C3D5F37DEDA794AED09C84A@VI1PR02MB3952.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR02MB395224C3D5F37DEDA794AED09C84A@VI1PR02MB3952.eurprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_191306_665196_3141EE29 
X-CRM114-Status: GOOD (  14.63  )
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

On 01/07/26 at 02:32pm, David Binderman wrote:
> Hello there,
> 
> Static analyser cppcheck says:
> 
> linux-6.19-rc4/kernel/kexec_core.c:425:7: style: int result is assigned to long variable. If the variable is long to avoid loss of information, then you have loss of information. [truncLongCastAssignment]
> 
> Source code is
> 
>     size = (1 << order) << PAGE_SHIFT;
> 
> I have no idea how large order gets, but if it gets over about
> 30 or so, then IMHO there will be a loss of bits.

We may not need to worry about it. In all places where
kimage_alloc_control_pages is called, the order is 0 or
get_order(KEXEC_CONTROL_PAGE_SIZE) on mips which is 2. 

arch/mips/include/asm/kexec.h:#define KEXEC_CONTROL_PAGE_SIZE (4096 + 3*4096)

[~]$ git grep kimage_alloc_control_pages
arch/arm64/kernel/machine_kexec.c:      struct page *page = kimage_alloc_control_pages(kimage, 0);
arch/x86/kernel/machine_kexec_64.c:     page = kimage_alloc_control_pages(image, 0);
include/linux/kexec.h:extern struct page *kimage_alloc_control_pages(struct kimage *image,
kernel/crash_core.c:    vmcoreinfo_page = kimage_alloc_control_pages(image, 0);
kernel/kexec.c: image->control_code_page = kimage_alloc_control_pages(image,
kernel/kexec.c:         image->swap_page = kimage_alloc_control_pages(image, 0);
kernel/kexec_core.c:struct page *kimage_alloc_control_pages(struct kimage *image,
kernel/kexec_file.c:    image->control_code_page = kimage_alloc_control_pages(image,
kernel/kexec_file.c:            image->swap_page = kimage_alloc_control_pages(image, 0);

> 
> Perhaps some sanity check on the value of order would
> be a good idea ? Either that or
> 
>     size = (1UL << order) << PAGE_SHIFT;
> 
> might be better code.

That is fine if people is worried, a patch is welcome.


