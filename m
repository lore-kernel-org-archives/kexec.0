Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B9EC3DA60
	for <kexec@archiver.kernel.org>; Thu, 18 Jul 2024 00:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RSm2gcZCxrk2XL/ZY5ZebtHEhKwI4vO/gaBSwODGSgo=; b=mCzLz/Ob1cqVvi
	29rhYKbRWn6hLR159hpoCkTuxYyurCvWxrlzfcX0yfDcLYhEMDjtJM97N6LCFUd3R+LAeIZGd/hOR
	+pu4PpHdNEojxg20Z7Qt8XNefznRcXut6vnlzFHHtiVfI9JC7/Yr2x2/fnaU7nZd9EtGYZpbbl65E
	7D8xk/lfoYY7wZAxnbJYxdPmyYbNJ8ui71UALESKXo9jHXqji8baGIN8cn/mEnOKLhE70sXptEtOd
	IrY0DtW3wwKvxhYe3zjHBTMzf0yWvEqMM3l0Idwc2FaXd96JVursXuWF1GUZrt3kNXIA4ZbAl1mKH
	/09fo+XQtWQhyIB4h9/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUFDZ-0000000FHq2-1Tqc;
	Thu, 18 Jul 2024 00:41:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUFDW-0000000FHpI-3aIH
	for kexec@lists.infradead.org;
	Thu, 18 Jul 2024 00:41:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721263312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdT1Q8DUAxZNiL7SNTBgQkDNeP4OE0UKnHCkmEwALTQ=;
	b=WfLpzEpx52tu/LblZjV9unx4DiLsbZGYLQDdc+VdEfvwLMkw9uNhFhuYIzkL2UT61IGq2v
	RyxPXphlCBp7t1ibIVapcKtdTDayxQYgjgXwQnzni/vMSEkuIO71Kt65ossPjq8E62Ajed
	u+BTDVYkH4s7Mqb5rcS2gfGVt3p6H4A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-1K_buE-fOEKq7ZT6Gsqghw-1; Wed,
 17 Jul 2024 20:41:49 -0400
X-MC-Unique: 1K_buE-fOEKq7ZT6Gsqghw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEAA91955F43;
	Thu, 18 Jul 2024 00:41:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF99319560B2;
	Thu, 18 Jul 2024 00:41:43 +0000 (UTC)
Date: Thu, 18 Jul 2024 08:41:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crash: fix x86_32 memory reserve dead loop retry
 bug at "high"
Message-ID: <Zphkw7sSmdIXzicY@MiWiFi-R3L-srv>
References: <20240717070904.2671147-1-ruanjinjie@huawei.com>
 <ZpfJYcjZ0QmFUpPf@MiWiFi-R3L-srv>
 <20240717124916.0535d675cadf2feeee9752fe@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240717124916.0535d675cadf2feeee9752fe@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_174154_986331_9EE01685 
X-CRM114-Status: UNSURE (   6.84  )
X-CRM114-Notice: Please train this message.
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

On 07/17/24 at 12:49pm, Andrew Morton wrote:
> On Wed, 17 Jul 2024 21:38:41 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > 1) revert commit 8f9dade5906a in Andrew's tree;

Thanks, Andrew.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
