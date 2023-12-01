Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F92C4167B
	for <kexec@archiver.kernel.org>; Fri,  1 Dec 2023 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o52l2cU9NX7htf+/vi46Vrlw9b2mjAT7M6ZywKTTvuo=; b=wdrOWM6BTyvpxK
	gRfn8M8qPSfABmiiLxshN+Gq176ITRx+jJgYE75QbT3RhxX3FWsJ0S4WWnm0h96ONWRsuXF5ZAUBm
	yEw1jnuxIvk/sK/pYqrb5QfE7xp81MoDq3/PDMOaANULCibXLLwbnELVyIynN0aFn1RDvu5IUYBO7
	CCafbLwZaKsM6SMIQmrIGRPZ5lhc5xDOZ+NvI5j4DBRm96fyq+kxvBGKkImSUaDQmhhLpPDeTcDCP
	k4+9iyGanjcgno9gpTX+PNF0EFRlsAsATyY0EhOhZC/IeIStiMB0uF49jZF2vO90EgHGW2Y6urtnb
	XwlM7CiElTTqWieTpq/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r91oV-00DOzg-0w;
	Fri, 01 Dec 2023 11:36:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r91oR-00DOvm-27
	for kexec@lists.infradead.org;
	Fri, 01 Dec 2023 11:36:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701430561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H76S5nJm1jWqRaGejCWH6ccm2LOJtZaVxPslQ1jiKOQ=;
	b=G9XmzAJ3o4X+uXYnwIz8AxpejTp5q+kjD1MmOuCGnUIVOuSml0kAYjns89p/l5h4AMhlQR
	Vyt2m5Vl0J7h4JhLbcQlNWp6tw9PTh8W+e4qTZExCRLJEr8KFvvokgEM+eEXe4rdN706xC
	07dXNhQzzJ9gtLczaHdtAwNl0/HUu+4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-B9N1asX_MoOt3O0iCcnc5Q-1; Fri, 01 Dec 2023 06:34:09 -0500
X-MC-Unique: B9N1asX_MoOt3O0iCcnc5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5FEF811E7D;
	Fri,  1 Dec 2023 11:34:08 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.211])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 93FF32166B26;
	Fri,  1 Dec 2023 11:34:07 +0000 (UTC)
Date: Fri, 1 Dec 2023 12:34:04 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, mhocko@suse.cz
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <20231201123404.49a46a64@rotkaeppchen>
In-Reply-To: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_033603_854041_C0F236DE 
X-CRM114-Status: GOOD (  20.66  )
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

Hi Jiri,

I'd really love to see something like this to work. Although I also
share the concerns about shitty device drivers corrupting the CMA.
Please see my other mail for that.

Anyway, one more comment below.

On Fri, 24 Nov 2023 20:54:36 +0100
Jiri Bohac <jbohac@suse.cz> wrote:

[...]
 
> Now, specifying
> 	crashkernel=100M craskhernel=1G,cma
> on the command line will make a standard crashkernel reservation
> of 100M, where kexec will load the kernel and initrd.
> 
> An additional 1G will be reserved from CMA, still usable by the
> production system. The crash kernel will have 1.1G memory
> available. The 100M can be reliably predicted based on the size
> of the kernel and initrd.

I doubt that the fixed part can be predicted "reliably". For sure it
will be more reliable than today but IMHO we will still be stuck with
some guessing. Otherwise it would mean that you already know during
boot which initrd the user space will be loading later on. Which IMHO is
impossible as the initrd can always be rebuild with a larger size.
Furthermore, I'd be careful when you are dealing with compressed kernel
images. As I'm not sure how the different decompressor phases would
handle scenarios where the (fixed) crashkernel memory is large enough
to hold the compressed kernel (+initrd) but not the decompressed one.

One more thing, I'm not sure I like that you need to reserve two
separate memory regions. Personally I would prefer it if you could
reserve one large region for the crashkernel but allow parts of it to
be reused via CMA. Otherwise I'm afraid there will be people who only
have one ,cma entry on the command line and cannot figure out why they
cannot load the crash kernel.

Thanks
Philipp
 
> When no crashkernel=size,cma is specified, everything works as
> before.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
