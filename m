Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11FDC4167B
	for <kexec@archiver.kernel.org>; Mon, 11 Dec 2023 05:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RvnetEiivImII1XMpRpI90cHi70YceZp/M/av9XwXd4=; b=auDQAynC7a8Zqq
	0o5ih8cWlVAJzvVZKAxcoxzqeWtmjmN0LroPuUDfarWoeji+ipF18lpsIlFRtXoHyOZkswOBIm4MX
	zFUr9Xq2Sc+aaiYxzZmGYGui8NkDuSmJ1AgKJJ6mTWUQOJQsbQQRWlXL1eHPXVBnOuZVOu/sofzLX
	yc3YMlIFSerHyN+xCvkizdTnGt1BpiPDbb2zOZuKJO7ta7wK0emQj6UXBdWfgc/nBILQ4KD1QJ9E3
	MOZtPa5O4LuVk+3pEyDm5d9ohsVKjvRN+fdz+GzQa7jMpoMr8jPKTNB/TR4p5b1MV/u0ZRY4uWRBa
	tYlRjq4KhkDSw2BLMuRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCZEe-0046c2-06;
	Mon, 11 Dec 2023 05:53:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCZEa-0046b0-1s
	for kexec@lists.infradead.org;
	Mon, 11 Dec 2023 05:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702274017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQMg/oQLQ+AfY0dgegoDtJ1iAm0snwYJkd6yvNpoSzg=;
	b=Z1PvKxbFCdY6Yw4WgQQwdcya6lQ76n4PGTLTIAHPmtksu0ZBdzlL8MY6xMt6Et0jtYIF+Z
	nAbN7OjmdPAOXCFl0xDnFJUHJvnsR3I+A0XdpDKXK80VgCefXVGHz1drRMqIex6F7kYTXD
	IEBAXw7dAcziqrAB5URIF+QyFcjlLPg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-1DnNItMvMzGKeaaYkGtXLA-1; Mon, 11 Dec 2023 00:53:26 -0500
X-MC-Unique: 1DnNItMvMzGKeaaYkGtXLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65501185A78B;
	Mon, 11 Dec 2023 05:53:16 +0000 (UTC)
Received: from localhost (unknown [10.72.112.218])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AD063C27;
	Mon, 11 Dec 2023 05:53:15 +0000 (UTC)
Date: Mon, 11 Dec 2023 13:53:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yuntao Wang <ytcoode@gmail.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] crash_core: Fix the check for whether crashkernel is
 from high memory
Message-ID: <ZXajyFKrSp5oRKwf@MiWiFi-R3L-srv>
References: <20231209141438.77233-1-ytcoode@gmail.com>
 <20231209143418.92f02de6b6c6db2b7b3b1815@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231209143418.92f02de6b6c6db2b7b3b1815@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231210_215340_743019_5D47C0E9 
X-CRM114-Status: GOOD (  14.39  )
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

On 12/09/23 at 02:34pm, Andrew Morton wrote:
> On Sat,  9 Dec 2023 22:14:38 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > If crash_base is equal to CRASH_ADDR_LOW_MAX, it also indicates that
> > the crashkernel memory is allocated from high memory. However, the
> > current check only considers the case where crash_base is greater than
> > CRASH_ADDR_LOW_MAX. Fix it.
> > 
> > This patch also includes some minor cleanups.
> 
> Can we please include a description of the runtime effects of this
> change?  ie, what happens now and under what circumstances, and how
> does the fix alter these things?

This is a good catch. Guess it's observed from code exploring.

The runtime effects is that crashkernel high memory is successfully
reserved, whereas the crashkernel low memory is bypassed in this
case, then kdump kernel bootup will fail because of no low memory
under 4G.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
