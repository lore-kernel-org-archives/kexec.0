Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9AAC433EF
	for <kexec@archiver.kernel.org>; Tue, 12 Jul 2022 01:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mfby4Z5Ag2ZUvHmwna03DQdl6U5n9ZjKT75OH6s39LQ=; b=s5CMvj02avYFjr
	e0T5dVhoDer931EFlDRByuiPMxz2qAdtqsDGgyr5AJ0H8PIC/F5+tlJQiGH9AXKgKznp9RBQhLkdN
	jA5LwxaenQ5RDO0K8+qyizXp+XHg7JCM1VGwZB3uw12JrkrqoBfuR7wf6KrC4CV1RXkOve3P0Sf0P
	XTT97HD6GBDEXetFWQTxNSEzVvitI553Zoa/2qmj2oFHoc/5Q5SCzb3NMDlxOHq7awY3yvFebuj27
	TsrHZ8CzTzgF+mMcmqJrWHFBEC6ONCl3mtPs8mQHsYOD7CrC8jMlvb7H4EoAxBZjDZ4G3N7h09f0G
	k26NTf6sfsUdVgRgNaDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB4MM-006JwM-GD; Tue, 12 Jul 2022 01:06:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB4MJ-006Jth-OK
	for kexec@lists.infradead.org; Tue, 12 Jul 2022 01:06:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657587997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huHQ7wQGcrutWiJlcJnxnWvbU6uKiCOCZmwib/4pnSM=;
	b=a9OvBcSyfjKC6rYAHsr0VmOFhrSlU87m4alh7llrv10vKBTTsOJYAUYuqPo5ZPeYe7snU6
	QyLioeGbD/ITqc30+tdfGlsCx2NWJbhxeFhNrMMc8k1W0Tyjk8eqA55a4KNQnba5F/tbHw
	0OUkxN/6+STcto42TLuQHaUsiPcydxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-FZlhS81rNiaxZ4ASu3Y23A-1; Mon, 11 Jul 2022 21:06:34 -0400
X-MC-Unique: FZlhS81rNiaxZ4ASu3Y23A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F3718041BE;
	Tue, 12 Jul 2022 01:06:34 +0000 (UTC)
Received: from localhost (ovpn-12-173.pek2.redhat.com [10.72.12.173])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CCB340D2827;
	Tue, 12 Jul 2022 01:06:32 +0000 (UTC)
Date: Tue, 12 Jul 2022 09:06:30 +0800
From: Baoquan He <bhe@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jianglei Nie <niejianglei2021@163.com>, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <YszJFi+deSIXK3ns@MiWiFi-R3L-srv>
References: <20220711073449.2319585-1-niejianglei2021@163.com>
 <YsvWHwrltqqAb12h@MiWiFi-R3L-srv>
 <YswVHNQX+OGz6IaQ@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YswVHNQX+OGz6IaQ@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_180639_962979_BB2E2D98 
X-CRM114-Status: GOOD (  24.01  )
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

On 07/11/22 at 01:18pm, Matthew Wilcox wrote:
> On Mon, Jul 11, 2022 at 03:49:51PM +0800, Baoquan He wrote:
> > On 07/11/22 at 03:34pm, Jianglei Nie wrote:
> > > elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> > > kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> > > predefined value. If parse_crash_elf_headers() occurs some error and
> > > returns a negetive value, the elfcorehdr_addr should be released with
> > > elfcorehdr_free().
> > > 
> > > We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> > > fails.
> > > 
> > > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > > ---
> > >  fs/proc/vmcore.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > > index 4eaeb645e759..125efe63f281 100644
> > > --- a/fs/proc/vmcore.c
> > > +++ b/fs/proc/vmcore.c
> > > @@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
> > >  	rc = parse_crash_elf_headers();
> > >  	if (rc) {
> > >  		pr_warn("Kdump: vmcore not initialized\n");
> > > -		return rc;
> > > +		goto fail;
> > 
> > Sigh. Why don't you copy my suggested code directly?
> 
> I think at this point, you should just submit your own patch
> and credit this person with Reported-by:

Thanks for telling. I will consider doing this in the future.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
