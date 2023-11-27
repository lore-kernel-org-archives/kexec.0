Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4EFC4167B
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 23:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tlma9/4MB7u5+tP+e0esn167IHe4FI98CaOaQy8IIAo=; b=flgzlrb2sbb7Tg
	EFNqaH46xgA/MK3hh5PwKdCXa/N0IyaPGyU46ug8T7S+xhCoef/lrZwb1HvUxJlJLglB6tA4ziPYU
	u49+A+zfl/tSwFjAHI6JA6teJtx6a+T1GAevuEjiNYq63nNopH1G8rycdUDPhlCBdQTrjDwGZz7Ys
	mo6XoOqpNkSuIjroCV/B1sWXA2D4inOyKK3ms4TtIQExdXc+A5OwAUXQ656UPSipK3S4On1XowFaJ
	c+cFlTxKod23yqt3VApVzQPB321uqShkNhmX2B3yCzDBSJuSFdI9WdoP+srg+JlpTxd/1RGputu0o
	Nk7j41IX8i/YyXytmKfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7kwC-003eew-1O;
	Mon, 27 Nov 2023 23:22:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7kw9-003eeU-30
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 23:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701127363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogPEqxULtysiUtZcGeDA7xzlCpM7O4utKcE8RQktsgA=;
	b=T+0WBSFZLso6OvVys6YDOvnwkKyHDicSBmxz/Hf3xCpDN9IjOBNy64PtWBGmE+J9mr1VZy
	zLZfcgjGk+ZJYvpcv3d3v62/xYkA7Nuey4DmRXE6AfWLyLwoY2+nSW4pezSYmn+kB+uZRw
	cYqxnV3e28x3+QLo86d2VMnVltLZUo8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-s5bHiCjRMXuy4ZD201jdOA-1; Mon, 27 Nov 2023 18:22:41 -0500
X-MC-Unique: s5bHiCjRMXuy4ZD201jdOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FB9D85A58A;
	Mon, 27 Nov 2023 23:22:41 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FE1A1C060B0;
	Mon, 27 Nov 2023 23:22:40 +0000 (UTC)
Date: Tue, 28 Nov 2023 07:22:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: add kexec_file flag to support debug printing
Message-ID: <ZWUkvbXHhU4Ij1JW@MiWiFi-R3L-srv>
References: <20231114152030.240945-1-bhe@redhat.com>
 <20231127133218.GA3354982@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231127133218.GA3354982@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_152246_064466_90E4FAF6 
X-CRM114-Status: GOOD (  14.24  )
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

On 11/27/23 at 01:32pm, Simon Horman wrote:
> On Tue, Nov 14, 2023 at 11:20:30PM +0800, Baoquan He wrote:
> > This add KEXEC_FILE_DEBUG to kexec_file_flags so that it can be passed
> > to kernel when '-d' is added with kexec_file_load interface. With that
> > flag enabled, kernel can enable the debugging message printing.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> Thanks,
> 
> this looks fine to me.
> But perhaps the corresponding Kernel patch should land first?
> Let me know what you think.

Yes, agree. I will ping you once kernel patches are taken. Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
