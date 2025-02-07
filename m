Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55D6C02194
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 03:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bovCnASvGHhB/zWZqXML/1CrlUVnFOGyxkprm/QLHBA=; b=UI9hupXwkkA8PUpTAfN9TCA2wq
	JJei7+UHgsspGHKMa5mNn4gSxas574JEB20sFECQsAgwVfPeH056r5q5adDaIQ6lLT1hlp2zCt8pX
	gY5I4aHWshPXIOZl2hFQi5HNKwcl1/FbrnxwR8LboytfY/+nxZA9rFeXUuTzlyGEztJE1a75Lz2/H
	JurCcGGRD9c5ZEYEo7XJ+CCb+2wnNKRvSiNJJLgRPhRV1n84e9LiSLiD2og3jlqgEu/tz8vFhRTlw
	Ax006prSXdOrFa52dugF56hA88Z3sUxbLNM1GsUl0YRDdyg+xuU2TGpFq79Pe6fFzTinjyYzr+p6g
	IaL7cGqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgEdq-000000089GE-2IBK;
	Fri, 07 Feb 2025 03:02:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgEcU-0000000890d-26jd
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 03:01:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738897288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bovCnASvGHhB/zWZqXML/1CrlUVnFOGyxkprm/QLHBA=;
	b=hGZjPyyON7xRKP7ehp6tAcoLqrbMQOueEomNxe3ipieB9PBsdfeq5l7Ui19RFtfD6S7mWZ
	cFZPFuqj+QbWaX8PF9o7tNvScYpZfqeXnmpqHF6rfIIDpjn/vxkNP1iKbTc+XpCCwWa66y
	Fu06KZ4/V+iTvx5Fx5KSvJo5QA4qtaM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-EAWj6CjfObSvsuBwm3Abqg-1; Thu,
 06 Feb 2025 22:01:24 -0500
X-MC-Unique: EAWj6CjfObSvsuBwm3Abqg-1
X-Mimecast-MFC-AGG-ID: EAWj6CjfObSvsuBwm3Abqg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02B451956086;
	Fri,  7 Feb 2025 03:01:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.206])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C51F71800570;
	Fri,  7 Feb 2025 03:01:19 +0000 (UTC)
Date: Fri, 7 Feb 2025 11:01:15 +0800
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
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v7 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <Z6V3e3yPQyhaRBCN@fedora>
References: <20250116065825.1041558-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116065825.1041558-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_190130_619928_C5DD180D 
X-CRM114-Status: GOOD (  10.35  )
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

Hi Coiby,

On 01/16/25 at 02:58pm, Coiby Xu wrote:
> LUKS is the standard for Linux disk encryption, widely adopted by users,
> and in some cases, such as Confidential VMs, it is a requirement. With 
> kdump enabled, when the first kernel crashes, the system can boot into
> the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore) 
> to a specified target. However, there are two challenges when dumping
> vmcore to a LUKS-encrypted device:

This v7 series looks good to me, other than Randy's concern. Do you plan
to repost to update the document?

Thanks
Baoquan


