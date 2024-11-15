Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ED5D6A225
	for <kexec@archiver.kernel.org>; Fri, 15 Nov 2024 01:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=auIunFr57gOFN1FNFHA32Az1353D4ZZkXxzIl3P/F3I=; b=z+V7V7V3KEM/f/aDPB3lJCP6pX
	+CqiCyRY4gIHjcZOaTaheAX5wgg7/IpLKadTtgwNzdu3eU8R+brS7jL3xydPXvnlJYQP8JueHlsMI
	hJT11qtueLVpALUKFWGNZJeBbq2jM6SEpi9i3wu200WM5+BlAqQl+rmM45E4jIQOU2XO3jt72ZdbM
	muss+r0IwMCyxn9Y3VpKIUyjfy3TeN4e3bl247IF0myBanYvLh1981s19bhV6aCnlk8bffiuEqcc2
	lURbi/5c2ZifzYXxfUd1a7fqVMdn336Vwe0gHzgoKQAUaMaF4yCXMSYuD/OF0d/YJrbCNDuvd7xgs
	iEAxMsNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBl3o-00000001Im6-3Kt8;
	Fri, 15 Nov 2024 01:23:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBl3l-00000001Il6-0md7
	for kexec@lists.infradead.org;
	Fri, 15 Nov 2024 01:23:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731633818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auIunFr57gOFN1FNFHA32Az1353D4ZZkXxzIl3P/F3I=;
	b=CImER+3lbQfmzYqcdd+OLZru2oldshHQc1rG+xuHQZi7nkH/bomJqmplCS5T3STImy/DNk
	qdXcrqU8mHhZfAhS12Qt9VwnPYlpoYdk5rb/jSJDEvneP7J2/yGIcyQ2X+ygG2yhZLpoyl
	uGVsQNGQgHhzvzZZmvEiix+TZB9uySc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-jer0dGJqMXqiUqm9a4LeyA-1; Thu,
 14 Nov 2024 20:23:35 -0500
X-MC-Unique: jer0dGJqMXqiUqm9a4LeyA-1
X-Mimecast-MFC-AGG-ID: jer0dGJqMXqiUqm9a4LeyA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC0321955D62;
	Fri, 15 Nov 2024 01:23:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BC931955F43;
	Fri, 15 Nov 2024 01:23:31 +0000 (UTC)
Date: Fri, 15 Nov 2024 09:23:27 +0800
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: x86@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
	bp@alien8.de
Subject: Re: [PATCH 0/3] x86/ioremap: clean up the mess in xxx_is_setup_data
Message-ID: <Zzaij4fbgBdMYqdi@MiWiFi-R3L-srv>
References: <20241115012131.509226-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115012131.509226-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_172341_336418_D64A5959 
X-CRM114-Status: GOOD (  12.70  )
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

Also CC kexec list.

On 11/15/24 at 09:21am, Baoquan He wrote:
> Functions memremap_is_setup_data() and early_memremap_is_setup_data()
> share completely the same process and handling, except of the
> different memremap/unmap invocations. The code can be extracted and put
> into a helper function __memremap_is_setup_data().
> 
> And parameter 'size' is unused in implementation of memremap_is_efi_data(),
> memremap_is_setup_data and early_memremap_is_setup_data().
> 
> This patchset is made to clean them up. It sits on top of tip/x86/urgent
> commit 8d9ffb2fe65a ("x86/mm: Fix a kdump kernel failure on SME system
> when CONFIG_IMA_KEXEC=y")
> 
> Baoquan He (3):
>   x86/ioremap: introduce helper to check if physical address is in
>     setup_data
>   x86/ioremap: use helper to implement xxx_is_setup_data()
>   x86/mm: clean up unused parameters of functions
> 
>  arch/x86/mm/ioremap.c | 117 +++++++++++++++---------------------------
>  1 file changed, 41 insertions(+), 76 deletions(-)
> 
> -- 
> 2.41.0
> 


