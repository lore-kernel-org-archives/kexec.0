Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CEDC001DC
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Z+cokC0De4jb3FLF9Um9UwG1ShdAQlHwAmC0v6dczs=; b=gTaQRnGTq1G1k/
	cdTLt7zMnMk4oUNTGEQrkxVJoN7MYaze7YwxXPXmHPQJ7Jjjcu/4Q4nBScHVuU32QYM+lAFn2aQZO
	nBLffFpYoCCRvpaph7Mrlt6Nk646k6tVorEVb9xJ5Ejcu2QYIfHo8XiE9/pQmElsVQCFmTbZuKgxd
	Jlnh0eid8NIsNEcfJAxxpRYHnfmFoB28lO8PgwMeoGf5F6ONdKbdgvlO3YWsfAlNSV31TO1zs2Ivj
	3gL+wzytRJ4CxiACiuhgn4tmKTK9QoagZXWWXMZsLMBQu+KCv+YWZ8hwSREXlOUkg61R4wLsradqx
	cvDkLlCRYSR9xSNn+Ddg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOa5l-009bpn-2H;
	Wed, 26 Jul 2023 08:41:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOa5h-009bpC-2h
	for kexec@lists.infradead.org;
	Wed, 26 Jul 2023 08:41:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690360912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d/oTrLa3wfV0i253XfKhTyT1CTpeukEXI1z5KYmU9f8=;
	b=B1DA7dpdEoOIoctpb1fAQhCeZL6P+ShUh7mbvZRWJHxQPmEq9u4S+z1XgXZXqN/PQdchkJ
	9GNOp5cRA0rzA/L8voWg8sMvZaxBMoXt1MCEjenxkp9YefQE0kRGDoCZO7+mQuy5/CkUIb
	ZMWk/omkmsmEfRHvlNmnmJC1wiAT/yo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-dBAKzojIPFCmGPV9s8Djaw-1; Wed, 26 Jul 2023 04:41:48 -0400
X-MC-Unique: dBAKzojIPFCmGPV9s8Djaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C29781010427;
	Wed, 26 Jul 2023 08:41:47 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D339B4094DC0;
	Wed, 26 Jul 2023 08:41:46 +0000 (UTC)
Date: Wed, 26 Jul 2023 16:41:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Matthew Wilcox <willy@infradead.org>, Vivek Goyal <vgoyal@redhat.com>,
	akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix signedness bug in read_from_oldmem()
Message-ID: <ZMDcR6wKn3Dz6NJy@MiWiFi-R3L-srv>
References: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
 <ZMC1jU7ywPGt1QmO@MiWiFi-R3L-srv>
 <c770613e-1f11-4bff-bc5f-9bc6f07a4da5@kadam.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c770613e-1f11-4bff-bc5f-9bc6f07a4da5@kadam.mountain>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_014153_945875_8E3BDD67 
X-CRM114-Status: GOOD (  12.43  )
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

On 07/26/23 at 09:03am, Dan Carpenter wrote:
> On Wed, Jul 26, 2023 at 01:56:29PM +0800, Baoquan He wrote:
> > 
> > Thanks for this fix. Just curious, this is found out by code exploring,
> > or any breaking?
> 
> It's from static analysis, looking at when error codes are type promoted
> to unsigned.  I pushed the Smatch check for this yesterday.

I see, thanks for telling.

> 
> https://github.com/error27/smatch/commit/a2e6ca07e2ef83a72c9ffa3508af1398a6ecc7ed
> 
> regards,
> dan carpenter
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
