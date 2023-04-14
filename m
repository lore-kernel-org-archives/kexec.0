Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBA3C77B6F
	for <kexec@archiver.kernel.org>; Fri, 14 Apr 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X3ZCRI6C5q576JosDUIpM3rlRcbIT9Auf9DpzX5DZBE=; b=KxjD+upEOx+79S
	obu9h54bzqCUxlh+V015bhJ2N5hcHyOUHV2TJyLTcCUxv1wyPuH6OgiQfZvMbAdXzia1d/TDNmOmn
	Gmjj24hl/P8zK2c69L3QStlg0Ot3D/oU1CodiaChp3rJpA64EgedmVq8OoJ+3VqsF5BYfLDsvO5pr
	Wt3ZgzIgP7P8SvVe/k5IALFZCj7MgQUNbj7pUOfuB28xIeCwGACcpWJmDYzi5b2UrxQUQ8kJpim7S
	8J06pLFHZ06vZZisFLWu+JmvpiWvw7EtXNb2TmNPIp7iTs+M0ka7lrn81fbxrrb2OjuztNllmO9S8
	ruPXpM9EXVfMAS+MJ0yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnG4N-008uuY-0a;
	Fri, 14 Apr 2023 09:50:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnG4I-008usq-2a
	for kexec@lists.infradead.org;
	Fri, 14 Apr 2023 09:50:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681465807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyikU5M9d76wbxiGEiGM6t7sb6u7giUEixuT9mv0t1Y=;
	b=JMn/U+0r8SIJLM7TFaVBtFUo+ya1hpVxotVVXo2wVr3oPAJT9JuWp+4kZea2XXNpDOVM6G
	7cvSZqHSchSs+uTaOaBGx0N+RCCTEIWQElm1hrm+zDJdybah9HgWEc5AkMk6zRZ9fwB2js
	PuDX4LuDPuHmbk07cUowXMN5CnpV3K8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-XS39Y3QeNJW4OlVc1qG7KQ-1; Fri, 14 Apr 2023 05:50:02 -0400
X-MC-Unique: XS39Y3QeNJW4OlVc1qG7KQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 810C6185A7A8;
	Fri, 14 Apr 2023 09:50:01 +0000 (UTC)
Received: from localhost (ovpn-12-58.pek2.redhat.com [10.72.12.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AF76A2027043;
	Fri, 14 Apr 2023 09:50:00 +0000 (UTC)
Date: Fri, 14 Apr 2023 17:49:56 +0800
From: Baoquan He <bhe@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZDkhxGzMOvmrt1PI@MiWiFi-R3L-srv>
References: <20230407022419.19412-1-bhe@redhat.com>
 <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
 <ZDabRr/yyakrrDDO@arm.com>
 <ZDezLrWSg7qd5K08@MiWiFi-R3L-srv>
 <ZDgSCfLMtL9heS8J@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZDgSCfLMtL9heS8J@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_025010_945223_735A50E3 
X-CRM114-Status: GOOD (  15.75  )
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

On 04/13/23 at 03:30pm, Catalin Marinas wrote:
> On Thu, Apr 13, 2023 at 03:45:50PM +0800, Baoquan He wrote:
> > I am OK with this version, or the version with min(SZ_4G,
> > arm64_dma_phys_limit), or v4. Please help point out if I got your idea
> > correctly. Thanks a lot.
> 
> I think we should stick to this patch. The disabling of the ZONE_DMA(32)
> is fairly specialised and you are right that we should not introduce an
> artificial 4GB crashkernel boundary on such systems. The slight
> confusion may be that ,high triggers a search above 4GB where there's
> not such boundary but this would match the documentation anyway.

OK, sounds good to me. Thanks a lot for all those careful reviewing and
helpful suggestions.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
