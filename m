Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A146C61DD3
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aNbCjFVIuJYNB8+haqmfInpJlaQvl8qC6NDl65ZkQyw=; b=RZjqLteVLWpn2B71QEgbIWWWJ0
	jBRKYi1PSdiDT2pjL2jZCeEFoRWSITIs/RVts33QL6j4fwCuITYi26FWB9dBb0n8uOwXD9wxQ+apg
	yPhY62eGzg9E6FyXBzBtrZlvPh64eGdVyyDhdFfn3SJDCoM4bNhlcMKcJ9ToEMONWQXaKpkqXWdB1
	aZcXoH8J2mGrQGU6QuvObgEnU1dCli2B0MmBjd1MUq41LwCfPKPEEGTM9gF5CPAyiN0hpNDWvUVEP
	FfKiFZ/wQZVlcY+wYxwgQpwFnwG53HW0cnggwM1WdC1is/9KI0P9n2O1r0tMN+UfT5mcZJHd7CPTd
	pHSuD6lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x10fA-00000009FdG-3YJk;
	Mon, 31 Aug 2026 11:58:56 +0000
Received: from canpmsgout12.his.huawei.com ([113.46.200.227])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x10f8-00000009Fay-02eL
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 11:58:56 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aNbCjFVIuJYNB8+haqmfInpJlaQvl8qC6NDl65ZkQyw=;
	b=BHjc2uO+C6lYOZPaXhd34wLAcGOm9vn6mA5Kq60tW021U0S2nmIAhenp50eWh6RYp8b6IpuvJ
	kqZAAt7dx6Lx+ReriWigIjmA9doIwpFm+5F8+koxw/XpvXuG0CtRTb5ZpDpnRtwn9Bs/JXkF0LI
	t7VPNXWMN44+jREmH1JvF1c=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hYS0F4SNkznTVd;
	Mon, 31 Aug 2026 19:47:25 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id DED7840563;
	Mon, 31 Aug 2026 19:58:39 +0800 (CST)
Received: from [10.174.186.187] (10.174.186.187) by
 kwepemo200009.china.huawei.com (7.202.195.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 31 Aug 2026 19:58:39 +0800
Message-ID: <b5979755-6089-4e6e-844d-2e6f32f687a6@huawei.com>
Date: Mon, 31 Aug 2026 19:58:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] kho: Convert error handling to immediate return
 pattern
To: Mike Rapoport <rppt@kernel.org>
CC: Alexander Graf <graf@amazon.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <hewenliang4@huawei.com>
References: <00c96a62-f783-497c-a7ac-1de495e4af06@huawei.com>
 <20260824024448.550552-1-longwei27@huawei.com>
 <178817571946.3691424.3757525664520719609.b4-review@b4>
From: "longwei (I)" <longwei27@huawei.com>
In-Reply-To: <178817571946.3691424.3757525664520719609.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.174.186.187]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_045854_512705_1A46A76C 
X-CRM114-Status: GOOD (  11.32  )
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

Hi Mike Rapoport=EF=BC=8C

Thanks for the review.
To be honest, I haven't observed any actual failures in this path in our =
production environment.
This change was identified during our internal team code review=E2=80=94t=
he err |=3D func() pattern looked concerning to us at first glance, so we=
 attempted to clean it up.

However, I agree with your assessment: the caller doesn't care about the =
exact error value, libfdt uses its own error codes, and this is a cold pa=
th where failures are unlikely. The change is indeed unnecessary churn wi=
thout a concrete bug to fix.

I'll drop this patch. Please ignore this submission.

Thanks,
Long Wei

=E5=9C=A8 2026/8/31 19:28, Mike Rapoport =E5=86=99=E9=81=93:
> Hi,
>=20
>=20
>> Replace the chained error accumulation (err |=3D func()) with immediat=
e
>> per-step error checking and early return in kho_out_fdt_setup().
>>
>> Two problems with the current approach:
>> 1. It continues executing FDT operations even after a failure, which
>>    is pointless and potentially unsafe on an invalid FDT context.
>=20
> Did you actually see failures here or was it an LLM suggesting that the=
y
> may happen?
>=20
>> 2. Bitwise OR of multiple negative error codes produces a result that
>>    may not represent any actual error, making debugging misleading.
>>
>> Early return fails fast and preserves the original error code for
>> accurate diagnosis.
>=20
> The caller does not care about the exact error value, so the diagnosis
> statement is moot at best.
> Moreover, libfdt does not return Linux error values.
>=20


