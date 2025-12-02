Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36372CFD2F6
	for <kexec@archiver.kernel.org>; Tue,  2 Dec 2025 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JsdSONDsYowfbOUGFHoi6ZdWvnnwkrdvfymRkfV+MPY=; b=UvRa/IiqLAqnnxMw/oyc/+LlN7
	EhV9hoi/F4JQt9AXv8xUQ457F31+019SC9AKSFQAIIycMcMvnvBPNugy9k6IbFnwtv38jwRE+ChS+
	lZSGJz6ejuQSmS8ro2CtYHhE/YpPIHTPCKZfJs/PnW5vnPX/7qm3mL7bnFdJqIA5DTdW5WdrJtcl4
	Y74dFvKvu4+KIoWQ+Wo4sHm/r8nRVi8zGOz1Itz3DjWYW9QqCKfcHkIb3xXbUzpv3psA974EQHk0n
	m5ORT/ICX3alawqaGPmkDSR03dpg/vb0yN/BK5naC+Qf1MYfs1aV7aWcY592vtLjGIsF7smc25fU9
	2INnmvvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQQCM-00000005Q8e-1hLH;
	Tue, 02 Dec 2025 13:13:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQQCK-00000005Q7o-1YFz
	for kexec@lists.infradead.org;
	Tue, 02 Dec 2025 13:13:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764681218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JsdSONDsYowfbOUGFHoi6ZdWvnnwkrdvfymRkfV+MPY=;
	b=E6NDEt/WlW4I5DzIA9C7v91IPKDFnfslqKZ+W+MQUjYNIt2/eoEUq58UGlo0duB0j7+osv
	hShmDHbSauZpvVkVmskmQ+zxhRkLfImWcDLsI6q2ue0ReV1IzV+6BisXBMRGfy2n6yFO90
	1Tnr92dJ1Sy6IvhouEAzw7swbMDT7wc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-q8bW6AE0Mo2R_347Dw_DuA-1; Tue,
 02 Dec 2025 08:13:35 -0500
X-MC-Unique: q8bW6AE0Mo2R_347Dw_DuA-1
X-Mimecast-MFC-AGG-ID: q8bW6AE0Mo2R_347Dw_DuA_1764681211
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61C7C1977016;
	Tue,  2 Dec 2025 13:13:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C472918009A9;
	Tue,  2 Dec 2025 13:13:20 +0000 (UTC)
Date: Tue, 2 Dec 2025 21:13:14 +0800
From: Baoquan He <bhe@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, andreyknvl@gmail.com,
	glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	elver@google.com, sj@kernel.org, lorenzo.stoakes@oracle.com,
	snovitoll@gmail.com, christophe.leroy@csgroup.eu,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v4 11/12] arch/um: don't initialize kasan if it's disabled
Message-ID: <aS7l6gfOWvVpFWy9@MiWiFi-R3L-srv>
References: <20251128033320.1349620-1-bhe@redhat.com>
 <20251128033320.1349620-12-bhe@redhat.com>
 <86d982368a85ab9dde17e52b45e77f5f76efea08.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d982368a85ab9dde17e52b45e77f5f76efea08.camel@sipsolutions.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_051340_469893_7B7AE76A 
X-CRM114-Status: GOOD (  14.28  )
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

On 12/01/25 at 11:56am, Johannes Berg wrote:
> On Fri, 2025-11-28 at 11:33 +0800, Baoquan He wrote:
> > And also do the kasan_arg_disabled chekcing before kasan_flag_enabled
>                                      ^^^^^^^^
> 
> typo

Thanks, will fix.

> 
> > enabling to make sure kernel parameter kasan=on|off has been parsed.
> 
> But I'm not sure how to understand that sentence.
> 
> And I have no idea what to do with this patch, with it being random CC
> of the middle of the series.

Sorry for the inconvenience. I am worried several rounds of posting
could bomb receivers's mail box, so only add arch's mailing list to 
CC in each arch's relevant patch. The whole patchset can be found at
below link. And the whole patchset are sent to linux-mm, lkml and kexec
mailing lists if subscribed any of them.

[PATCH v4 00/12] mm/kasan: make kasan=on|off work for all three modes
https://lore.kernel.org/all/20251128033320.1349620-1-bhe@redhat.com/T/#u

Thanks
Baoquan


