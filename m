Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D4606A320
	for <kexec@archiver.kernel.org>; Sat, 21 Nov 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yF8kdgs6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsesueW3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uv2c0lmJklPq1Wc0gXDH9rjg1R31DFHF/GMaY9whSXQ=; b=yF8kdgs6wE7zaaM8p3t5KioSfm
	gmUYiHQPXjgJtwfZDPEy5gDUf1f5jdhBaYLCarozfV3/gaIUQRrVXTv4ifq6e0HFuKvFVTbGde96k
	CgTHIgRrMBEvwWmgnXOs4Jo30P7pbUpj0BKxJtFr2GKbhe24dRN5Vd3EezMqwYabf7zV5f7KMzKVj
	ex3HEB0Fk95ssYSx4zoHjZmb3Elb29Zbc3JHX7sp8vLY2ZYaqv5eLylF1+ioU96fhG59VIve+mrCk
	43yZSkoPrABDO1BcLXZcar60O1YU09LrslAHEx3BJE/+iGRntbfzXt0WrXRRG4zffD/7FcXsvyN56
	pyVGlJxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUoFU-0000000HWAN-0Ein;
	Sat, 21 Nov 2026 16:47:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUoFT-0000000HWAC-0z0w
	for kexec@lists.infradead.org;
	Sat, 21 Nov 2026 16:47:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9AA2643CD3;
	Sat, 21 Nov 2026 16:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A24B1F000C6;
	Sat, 21 Nov 2026 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795279654;
	bh=uv2c0lmJklPq1Wc0gXDH9rjg1R31DFHF/GMaY9whSXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lsesueW3X1qKAOO9pJace8UpjWKc8hbm4SWMQrfV52DwwGpG902h4g8DTk5xllO3Y
	 tyUkdjKYxtT22Uq5A6QlNrME7wjNJkavBDFv+hVbJ528vXuZJibT5JtgfZ0wIPBrMN
	 qFAck48uwIsRNPEihgz3t5AWpTzJicoYr6zaNu7reCGEsb61bOvJdqy4VIuf6udnLZ
	 iNfGCAPsoy1aTlCnElBRtK9oZoB497sONSMmOC5MwSYoOF8kjxxPUZxGI4e4i/b5LA
	 utYCz2e7rP1FPUeYpOIIirglT5J8sfDzXsJg0dM0cmBAtbA93Okvesc4S/aQsfPhhK
	 TiitL4aI0mbzg==
Message-ID: <sashiko-outbox-227172@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH printk v4 0/8] Introduce policies for unsafe flushing
To: "John Ogness" <john.ogness@linutronix.de>, "Petr Mladek" <pmladek@suse.com>
Cc: "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Breno Leitao" <leitao@debian.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Rio <rioo.tsukatsukii@gmail.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Bradley
 Morgan" <brads@mainlining.org>, "Pnina Feder" <pnina.feder@mobileye.com>, "Alessandro
 Carminati" <acarmina@redhat.com>, "Gal Pressman" <gal@nvidia.com>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>, "Oleg
 Nesterov" <oleg@redhat.com>, "Bradley Morgan" <include@grrlz.net>, "Alex
 Elder" <elder@riscstar.com>, =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQp?= <blbllhy@gmail.com>, "Petr
 Pavlu" <petr.pavlu@suse.com>, kexec@lists.infradead.org, "Gustavo Luiz
 Duarte" <gustavold@gmail.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
In-Reply-To: <20261121163557.963029-1-john.ogness@linutronix.de>
References: <20261121163557.963029-1-john.ogness@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 16:47:32 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Sashiko has reviewed this 8-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121163557.9630=
29-1-john.ogness@linutronix.de

