Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE03EC27C4F
	for <kexec@archiver.kernel.org>; Wed, 26 Jun 2024 06:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ou224pCnhBeLH7YHe7Iy4PT1X0wm3MJaMYPyqXsMSRo=; b=aZTadVXuIYEGIL
	smDha6BFB3IUoemSrSUtajXdxDettMml8LPMY1HrBFcvxLbkvBDsRiGaiMVTFbluGKf1SxovKIa7w
	pxxX9Ks/wrGXqUaO5gd/551rlfGbAkDADzVEJfq+M0npI/wZ2+Rsnp6DB/ZNDs6lUiFwvKo1yuwBY
	QXgR8ne2D4FGatAgzeX8cqn39nO22kmxv6xh3AK5kNulsSBnF689xH9HqrzJS5O8MHWvgylvMWqTa
	ytXkvuOIkNdq8VJ8dxkXxAD5o6rXZr8ziSC1uLVU/jVzosJMvmK9oX0anZIfJqTlr2MIev/K6rqb3
	AYxOzaLI4vQN5+H6u3iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMMYi-00000005eza-3L7e;
	Wed, 26 Jun 2024 06:55:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMMYf-00000005eyY-2WfC
	for kexec@lists.infradead.org;
	Wed, 26 Jun 2024 06:55:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719384907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=994fzQ/F1dpy9uMm2QXJtHskyOYh9UYvqN0maQSazFU=;
	b=ZRqY7NNRzAeRMcttXcFs2eQt0Po/CCujqsxl/64/NA5jKOhxXDokmrUdkW3NfauPzU7OIg
	1x4Knn6zcF3fUe8huOjLSanoATVXKF4qVD0Jfup+BBg7EQPqIZlmaus171QAa+RZ7MT7FX
	5Gx0ZEb3R7Awf4iMiAlZDG/Gv9DkEn4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-Pln5fua_PtKCLYbvkAPHYQ-1; Wed,
 26 Jun 2024 02:55:03 -0400
X-MC-Unique: Pln5fua_PtKCLYbvkAPHYQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E2A719560B4;
	Wed, 26 Jun 2024 06:55:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58E703000225;
	Wed, 26 Jun 2024 06:54:59 +0000 (UTC)
Date: Wed, 26 Jun 2024 14:54:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
	Coiby Xu <coxu@redhat.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] kexec_load: Use new kexec flag for hotplug support
Message-ID: <Znu7P+SoF02EuSdJ@MiWiFi-R3L-srv>
References: <20240613190738.1852258-1-sourabhjain@linux.ibm.com>
 <74f5ee40-c2c8-4daa-8457-b6be0deffaa5@linux.ibm.com>
 <ZnuQDHkGmGcfXX9Z@MiWiFi-R3L-srv>
 <4a618f31-97dc-455b-a457-fb365825920e@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <4a618f31-97dc-455b-a457-fb365825920e@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_235509_819685_BBA2E6CC 
X-CRM114-Status: GOOD (  12.36  )
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

On 06/26/24 at 10:49am, Sourabh Jain wrote:
> Hello Baoquan,
> 
> On 26/06/24 09:20, Baoquan He wrote:
> > On 06/25/24 at 01:51pm, Sourabh Jain wrote:
> > > Any review/comments on this patch series.
> > I try to have a look, while there's conflict when applying to the latest
> > kexec-tools.
> 
> This patch series apply cleanly on master branch of below repos.
> 
> https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/
> https://github.com/horms/kexec-tools
> 
> May I know which upstream repo and branch you are applying this patch
> series?

Oh, sorry. I have left local patch related to hotplug from much ealier
discussion, I thought it's a rebasing conflict.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
