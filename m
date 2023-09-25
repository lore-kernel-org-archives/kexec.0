Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70BACE7A94
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wt/oWpKIN4dWJm8FXnk9NSs1rMIqPS2Z6diMMtBU+xw=; b=GRO9e0o4Hv3yXj
	styC7jIIwenABcDyzUqoGNX8gG276tIfUwQG2wA5Y8rOS5B6sZZvmyYmSiaFL/axwMknNygG8tAf9
	0Zpaaohg0yjz6HanWnEPpfcP6R2alAde/XS6cbcpmERoKXyq9z07/71LLoH1TOUSteG0PbZv9c1os
	1mN7eRlr3KhgWssPog+CI2VOf6+GqPDkf2+Vtt24H7gdbxn0+rKeM1iK3veHltbaiXn1kUEXqCWCN
	uyKEOlMi6Jm94yDduO0Nl+PS8mE+Q2QVtfg68H4jQXtJFZxL50gEtOYk6hUXyIA2f3leTO7ysqV2X
	YyVHDuYfUzz5G0xLYnCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkmhW-00ERoS-2x;
	Mon, 25 Sep 2023 14:36:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkmhT-00ERnt-1r
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 14:36:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695652597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tsz7HOe9ogY6gp1h+q1EOev48I4dzKMW2GN4NhayDsI=;
	b=Ssy6Tz1vygERv/TcPajUhJ1I1fme47YP5/H0IBC/LgdKiXkdoMkNaaeevMt75E2ePjZYcU
	XvYfwZ8xvYnw9DCU01cxAmalK3dou6jSfLzr7J9nEQoQeICXpOlRHH2QOQNAkhu7klZTIx
	5FYjmSEleGVe3pkdqI1BYbULDYGvoCM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-suMnaxO6PKiXCvJ3TLd1aA-1; Mon, 25 Sep 2023 10:36:33 -0400
X-MC-Unique: suMnaxO6PKiXCvJ3TLd1aA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC2271E441D3;
	Mon, 25 Sep 2023 14:36:32 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91A54C15BB8;
	Mon, 25 Sep 2023 14:36:30 +0000 (UTC)
Date: Mon, 25 Sep 2023 16:36:28 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Ard Biesheuvel <ardb@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 tglx@linutronix.de, dhowells@redhat.com, vgoyal@redhat.com,
 keyrings@vger.kernel.org, akpm@linux-foundation.org, Baoquan He
 <bhe@redhat.com>, bhelgaas@google.com, Luca Boccassi <bluca@debian.org>,
 lennart@poettering.net, "Liu, Pingfan" <piliu@redhat.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <20230925163628.2c39a98e@rotkaeppchen>
In-Reply-To: <ZQtr8Y_isZP4nG96@desktop>
References: <20230911052535.335770-1-kernel@jfarr.cc>
	<20230913160045.40d377f9@rotkaeppchen>
	<63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
	<CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
	<CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com>
	<CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
	<ZQtr8Y_isZP4nG96@desktop>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_073639_699726_3DEFFE3A 
X-CRM114-Status: GOOD (  10.30  )
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

Hi Jan,

On Thu, 21 Sep 2023 00:02:25 +0200
Jan Hendrik Farr <kernel@jfarr.cc> wrote:

[...]

> > Maybe we should do a BoF at LPC to discuss this further?  
> 
> I definetly won't be at LPC, is it possible to join virtually?

Yes, LPC will be hybrid again this year. Virtual access costs $50
although you can apply for an 50% discount when you are a
non-professional.

https://lpc.events/event/17/page/212-attend

Thanks
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
