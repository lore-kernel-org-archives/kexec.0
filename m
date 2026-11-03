Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21776606A32D
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=z1XV2aFe;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Vd+3z769
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1obNmdeiGvgYu4SrZA7IW2/sLeP9/qhwDqzFhh7JYAU=; b=z1XV2aFe3kxTJf
	PkbNCW9wc41etU/wHgWMsTNeGlgUBZbPH4h4zZAGdCNEnWtBYMIEeTz56x9MKDi1VYTNKyNUjbhho
	YP9QsMAMaqyxHgxxMy42bIAcMDpzDIA2k5B+XSBLoiiNLDtjE5gyx5Q5i1GIfAIcstnuD/kP6t9Po
	aKHx1UBrRduOXg8ko6ANEvukIVzUZR2XAWdYWHFNp+RBOWluhN6tPSVQTvFK1ImT2AnsaDbS+zZi5
	jZ0P5+tMrscM/LArVQlR4HJ2sUGi4OmNSnr8i4mmOI0VpyfOLHpI24nTV8mI7ty7o8RBlAyUflRJd
	oRwCF1UeBfGdmxpq0klw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO4Qf-00000000tCD-2k2H;
	Tue, 03 Nov 2026 02:39:17 +0000
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO4Qb-00000000tBt-1Ypn
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 02:39:15 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1obNmdeiGvgYu4SrZA7IW2/sLeP9/qhwDqzFhh7JYAU=;
	b=Vd+3z769FE2AdKqFFVuIOFI6gUYwT/dCQ9ZA6062sBZuqZKGctrvZW3aefJ7nHvSfYXaYcLxS
	TkC710+MiEdJryQUzEyLuUH6qs/riSOHQKzwbe3plG0hcrYHQj3zkV7aygFUcWkE84Dh7JEljCz
	9Dxow00Cls7ZuHhrX0N7aHU=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jJXp13TtHz1prKx;
	Tue,  3 Nov 2026 10:39:05 +0800 (CST)
Received: from whupemk300004.china.huawei.com (unknown [7.152.185.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 5049B40579;
	Tue,  3 Nov 2026 10:39:09 +0800 (CST)
Received: from [10.67.109.77] (10.67.109.77) by whupemk300004.china.huawei.com
 (7.152.185.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 10:39:08 +0800
Message-ID: <0ea46638-1d62-491c-8364-8a2d16837f88@huawei.com>
Date: Tue, 3 Nov 2026 10:39:07 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] crypto: asymmetric_keys: verify_pefile: fix integer
 underflow in pefile_strip_sig_wrapper
To: Ignat Korchagin <ignat@linux.win>
CC: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Herbert Xu <herbert@gondor.apana.org.au>, <keyrings@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<lujialin4@huawei.com>
References: <20261102074934.2925339-1-gubowen5@huawei.com>
 <CAOs+rJWjCTUwuYQMcBcbiUk8K_NQQtYGVFEBDEMZAKHWCLv98A@mail.gmail.com>
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <CAOs+rJWjCTUwuYQMcBcbiUk8K_NQQtYGVFEBDEMZAKHWCLv98A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk300004.china.huawei.com (7.152.185.168)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_183913_871228_AAB641DB 
X-CRM114-Status: UNSURE (   4.45  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/3/2026 4:49 AM, Ignat Korchagin wrote:
> 
> nit: the subject line looks malformed: weird "-next" suffix pointing
> nowhere. Otherwise:
> 

Thanks for the review! You're right, the "-next" suffix was a mistake. 
Will drop "-next" in the subject.

Best Regards,
Guber


