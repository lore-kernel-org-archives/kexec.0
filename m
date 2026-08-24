Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F87EC5DF9D
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 06:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02mzIcyNFWU0Hsiw7mRli2vS+eyyUPUCGoO00qWXUWo=; b=AT1Sne9ONKkZsbuAtn412t4uck
	oZFfQf6SkUDZLPtcYHk1OitDoMzkniYkdaNwPLXjPDRdwMRZNQmLak7Kl67xr3Qv2MXc0jIZUYfgi
	b1IXydBk74BWn8FWcA8LZsnnh9QUHEO3HmZySYOXZQK960U4WSntqE2YLiqpsTb5yxHiUNBuyJQ/M
	r1NKmQxhkrhN7hYTLRlFrGUqSkqRtacE0jxN2bYYhfg7SaqyvnmY1gsDV1mzfrGCG9W3WmuxgWJCo
	T0FjpD+XG2gZWQ6Ync4L710vnrtxj4F4G+pcbGVc+nbZc3+SoEhLAJkMudTGpdxLVW7xDA89yVfgN
	CrcloNYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyOGJ-0000000G0Dr-2IYh;
	Mon, 24 Aug 2026 06:34:27 +0000
Received: from canpmsgout08.his.huawei.com ([113.46.200.223])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyOGD-0000000G0Bz-36TK
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 06:34:25 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=02mzIcyNFWU0Hsiw7mRli2vS+eyyUPUCGoO00qWXUWo=;
	b=LZ0/DHz7xa2j9yzxzP1e3NfauLKAuLx2idpzSrpgnag56gGrgINKWhZ5xmCv+x5EgwYQbEbcn
	OPHb3y05XB3hOr05ODst+wZM3wMO4PNeQ65AS9uXZa0Ga1PbZKsoKLaiOlSMqN6vqfTMHwHJ+dB
	5R6rc11v2EFhJLIcNt7Os8A=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hT17j3SsfzmVXX;
	Mon, 24 Aug 2026 14:23:29 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id E9D1C402AB;
	Mon, 24 Aug 2026 14:34:13 +0800 (CST)
Received: from [10.174.186.187] (10.174.186.187) by
 kwepemo200009.china.huawei.com (7.202.195.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 14:34:13 +0800
Message-ID: <e1c2d008-9490-4b68-924f-dcc45a84f369@huawei.com>
Date: Mon, 24 Aug 2026 14:34:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] kho: Convert error handling to immediate return
 pattern
To: Matthew Wilcox <willy@infradead.org>
CC: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <hewenliang4@huawei.com>
References: <00c96a62-f783-497c-a7ac-1de495e4af06@huawei.com>
 <20260824024448.550552-1-longwei27@huawei.com>
 <aouyWs39qxGI7CP0@casper.infradead.org>
From: "longwei (I)" <longwei27@huawei.com>
In-Reply-To: <aouyWs39qxGI7CP0@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.174.186.187]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_233421_970817_956D4356 
X-CRM114-Status: UNSURE (   8.27  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Matthew,

Thanks for the review.

I chose the explicit `if (err) return err` pattern for clarity and
"fail fast" behavior. However, I'm happy to adopt the chained pattern
if the maintainer prefers it.

Thanks,
Long Wei

=E5=9C=A8 2026/8/24 10:54, Matthew Wilcox =E5=86=99=E9=81=93:
> On Mon, Aug 24, 2026 at 10:44:48AM +0800, LongWei27 wrote:
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -1438,20 +1438,34 @@ static __init int kho_out_fdt_setup(void)
>>  	int err;
>> =20
>>  	err =3D fdt_create(root, PAGE_SIZE);
>> -	err |=3D fdt_finish_reservemap(root);
>> -	err |=3D fdt_begin_node(root, "");
>> -	err |=3D fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE)=
;
>> +	if (err)
>> +		return err;
>> +	err =3D fdt_finish_reservemap(root);
>> +	if (err)
>> +		return err;
>> +	err =3D fdt_begin_node(root, "");
>> +	if (err)
>> +		return err;
>> +	err =3D fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);=

>> +	if (err)
>> +		return err;
>=20
> Less verbose:
>=20
>  	err =3D fdt_create(root, PAGE_SIZE);
> -	err |=3D fdt_finish_reservemap(root);
> -	err |=3D fdt_begin_node(root, "");
> -	err |=3D fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);=

> +	if (!err)
> +		err =3D fdt_finish_reservemap(root);
> +	if (!err)
> +		err =3D fdt_begin_node(root, "");
> +	if (!err)
> +		err =3D fdt_property_string(root, "compatible",
> +				KHO_FDT_COMPATIBLE);
>=20
> up to the maintainer which one they prefer ...


