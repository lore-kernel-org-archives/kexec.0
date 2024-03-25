Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67636C54E64
	for <kexec@archiver.kernel.org>; Mon, 25 Mar 2024 23:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YxfSZ+XmEBDCbcVv5p16ZuaX2uIwCuz2RBtYeS/bHHc=; b=dGq4mSv2XK+omJ
	BVGKNhPkfsijQOfIpBqL5f+WQFlvqIq0h/eSMhCK29+LtoivPcR23oUP2ZtizhLYD/4IBbem0Ytcs
	tg0Yf1R9kccpsK+z1AoA4IlqAs1tavTzTHrxCpWZ2mZkKFk/J6khZzqFT+CDTklvX8c4hJFiy2CWz
	En9nP1pS+D29uaGAXfoOBN8WIJy363Spw/AhaB4tDtFO6zTgCSLZhpvd7P3Zsb9tWjTuXEggO6gmO
	I3V2Er/IGpYfULvCz1YQRIbCCjhzeVBzC4HYQx+nT6SwWO8uutRkkVKHejjGRZkKIPIRAk5kqGYYo
	dsA5gPF0Nec8otC+m4Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rotqq-00000002MoI-0eDM;
	Mon, 25 Mar 2024 23:35:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rotqk-00000002Mn2-2dvz
	for kexec@lists.infradead.org;
	Mon, 25 Mar 2024 23:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711409728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MsXpqf78rAM4i4+ZjUMsQiXhxVgsssODolYLYbs5cZ0=;
	b=UUPQz3KPNWmOk386IwMQoMu4gshxX970pGGMvpOjIYoCRWg+nqfO1ExfQnRt+VII3/R6tF
	OQ82S/zT1N4HCJYgwKgbbm6Wtj3eww3T00WAOEr0ZG9JnEo8N9yJIWkr39+Fv6kWfTFWHF
	VNh+l5oIheg2fEyPZzuNL0r+cDUXCg8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-wka9NgxKOCGU0mZ99BvNrQ-1; Mon,
 25 Mar 2024 19:35:25 -0400
X-MC-Unique: wka9NgxKOCGU0mZ99BvNrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2ABED3C025B8;
	Mon, 25 Mar 2024 23:35:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D96FC3E620;
	Mon, 25 Mar 2024 23:35:22 +0000 (UTC)
Date: Tue, 26 Mar 2024 07:35:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	chenhuacai@loongson.cn, dyoung@redhat.com, jbohac@suse.cz,
	lihuafei1@huawei.com, chenhaixiang3@huawei.com
Subject: Re: [PATCH v2] crash: use macro to add crashk_res into iomem early
 for specific arch
Message-ID: <ZgIKNNZ8hc14FI8a@MiWiFi-R3L-srv>
References: <20240324033513.1027427-1-bhe@redhat.com>
 <ZgDYemRQ2jxjLkq+@MiWiFi-R3L-srv>
 <20240325132909.741ae47a8a05837c175a981e@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240325132909.741ae47a8a05837c175a981e@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_163530_767542_06BC8B1C 
X-CRM114-Status: GOOD (  17.24  )
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

On 03/25/24 at 01:29pm, Andrew Morton wrote:
> On Mon, 25 Mar 2024 09:50:50 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > There are regression reports[1][2] that crashkernel region on x86_64 can't
> > be added into iomem tree sometime. This causes the later failure of kdump
> > loading.
> 
> So I think a cc:stable is needed.

Yeah, I forgot this.

> 
> > This happened after commit 4a693ce65b18 ("kdump: defer the insertion of
> > crashkernel resources") was merged.
> > 
> > Even though, these reported issues are proved to be related to other
> > component, they are just exposed after above commmit applied, I still
> > would like to keep crashk_res and crashk_low_res being added into iomem
> > early as before because the early adding has been always there on x86_64
> > and working very well. For safety of kdump, Let's change it back.
> 
> I'll use 4a693ce65b18 as the Fixes: target, since there is no
> "Exposed-by-non-buggy-patch:" tag.  To tell the -stable tree
> maintainers how far back in history this should be backported.

Thanks a lot.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
