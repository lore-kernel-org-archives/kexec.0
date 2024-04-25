Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C88DC10F15
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 03:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UleZR1Bzsnq35tYaYe5uJ4/asbOUxf/e4HRRPzzK6L0=; b=Pt9egZ7oV6Udlq
	TvZNgt/1z7D2jpFHR1W9rhMIANBBD/xkJb0DfrIOr1RlR49Id4wYoBphHsJV+HzbjiR69tK22TXiG
	ApQne9P4vkQNZsGEF0pUH+uebLwgx2RBPs8LhmYaWvpC9kn4SbrSshCyemciiISUGcw0Qjf83BmGz
	LTlwix8hduOWkga8YS5/UI4Qc8GP6EkbnVscDa557cY0jQnok45mKZRlDPzO6FFt4t7b02Gb45oxq
	PtsIoc2duqmxfmsNSaNwGY6OvBgwadx9gIISL9CgL4LG7Q3nSLjFBK565O4aM/eOZeGbL5unC2A1I
	av8sRuRJM28laYWN9LWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzpmB-00000006ohU-05ep;
	Thu, 25 Apr 2024 03:27:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzpm7-00000006ofn-3CFw
	for kexec@lists.infradead.org;
	Thu, 25 Apr 2024 03:27:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714015672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWSmUlxpy5chU36ujG9zh3zLE+Cbg/C6ozI8EtQmNdo=;
	b=IijrQ9dsaR6c1A1BK5gV/sJx2dTQ1yqW5om9GSI4QNPk+dwKRpIs9LT8tXMzytye18CI8U
	n9n0ahC64usTgrfxz7YQ2KbhkI8KOZ5kM1BfjGlgNxBfmt40shL4SP/reJ/AK2WjfQ88+N
	bR0yUBxp40tfU5eTyy1fxKl8CrMClm4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-shIIEUKON-e67xNi9iiDgg-1; Wed, 24 Apr 2024 23:27:41 -0400
X-MC-Unique: shIIEUKON-e67xNi9iiDgg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a55c019c6d5so24758366b.3
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 20:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015660; x=1714620460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWSmUlxpy5chU36ujG9zh3zLE+Cbg/C6ozI8EtQmNdo=;
        b=O40J4pCcUydU4uK98jwdRy63W+mVP07dLkaeYzejTVY7EkMWOsr7jesBhWsIvgg/4Z
         ik0VpP3oHr9KO/FX+OIupD+r5f5YcY//rvK9ZavXio6dMXKwCD+/TmeDhc6GToG7HWto
         1ul0K+Tm3FHVVYk1jdGNu/5c1xr5DDqOHwL5lQcDE2pSJfVtOiZOS2WCuPo8a4V88EY0
         ts37NnqDiIKjkFJ7L1ZPzRIHzIzw7tpC5o1hFdhb2YeZjDm2tBDtLsWA6cN376/h2MHb
         YQtThzrcPlKInDVQ3olbKFOvyoVoyz1A6U5lNqle06dWRSbGBf8QOKP+XqYpmffKMtEl
         FlQA==
X-Forwarded-Encrypted: i=1; AJvYcCUd5Mmx10eLmTNTRnuGNpyRzbD2PxxI5ZEbj8yIhk2y73zFxHsf9SqSktrfjAcTe/dNKlk7z4Ntk+P1CrkjD/prU1CCFB61cD5d
X-Gm-Message-State: AOJu0Yzxy3fZ6tKK3lzlqyXyiqCmdDXvBX9kZh7dGp81m/rh3vytjXx2
	p3XpOw1Qw6WKt+ly+vu1TfMg6/B1EY/tgrIcisINpXWXqGiG62PVfuuwg+p7PoxuK4CcsEuuP3N
	sUveV/poWkXxcehx9hhUS7fOH/2n5Cl1ys18WL0qS7cToiOvbRsWTXh5tCXSEpGTnueWoNcyziY
	WYGbs2NDkMcvN2W52VNR8zOBhs5SyTxU9d
X-Received: by 2002:a17:906:480d:b0:a51:d204:d69e with SMTP id w13-20020a170906480d00b00a51d204d69emr2791130ejq.7.1714015660132;
        Wed, 24 Apr 2024 20:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPtP2jLSqClgtPj4M56kdlZeBO+5l40Gy1g8sabQb/6hAodyZM3zbt7TnPaVinyQrLiG6LY+/bY5NEzTPbikE=
X-Received: by 2002:a17:906:480d:b0:a51:d204:d69e with SMTP id
 w13-20020a170906480d00b00a51d204d69emr2791116ejq.7.1714015659871; Wed, 24 Apr
 2024 20:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev> <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com> <20240326153223.GF8419@ziepe.ca>
 <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com> <20240403154414.GD1363414@ziepe.ca>
In-Reply-To: <20240403154414.GD1363414@ziepe.ca>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 25 Apr 2024 11:27:03 +0800
Message-ID: <CAO7dBbX0ZBwSzvi=ftNHe73hPP6Ji2WWTsKKYmD2tZENMjH_bw@mail.gmail.com>
Subject: Re: Implementing .shutdown method for efa module
To: Jason Gunthorpe <jgg@ziepe.ca>, "Margolin, Michael" <mrgolin@amazon.com>
Cc: Gal Pressman <gal.pressman@linux.dev>, sleybo@amazon.com, leon@kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_202755_898069_2D0E25B0 
X-CRM114-Status: GOOD (  11.00  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGkgSmFzb24gJiBNaWNoYWVsLAoKS2luZGx5IHBpbmcuLi4gQW55IHByb2dyZXNzIGZvciB0aGUg
ZWZhIC5zaHV0ZG93biBpbXBsZW1lbnRpbmc/IFRoYW5rcwppbiBhZHZhbmNlIQoKVGhhbmtzLApU
YW8gTGl1CgoKT24gV2VkLCBBcHIgMywgMjAyNCBhdCAxMTo0NOKAr1BNIEphc29uIEd1bnRob3Jw
ZSA8amdnQHppZXBlLmNhPiB3cm90ZToKPgo+IE9uIE1vbiwgQXByIDAxLCAyMDI0IGF0IDA0OjIz
OjMyUE0gKzAzMDAsIE1hcmdvbGluLCBNaWNoYWVsIHdyb3RlOgo+ID4gSmFzb24KPiA+Cj4gPiBU
aGFua3MgZm9yIHlvdXIgcmVzcG9uc2UsIGVmYV9yZW1vdmUoKSBpcyBwZXJmb3JtaW5nIHJlc2V0
IHRvIHRoZSBkZXZpY2UKPiA+IHdoaWNoIHNob3VsZCBzdG9wIGFsbCBETUEgZnJvbSB0aGUgZGV2
aWNlLgo+ID4KPiA+IEV4Y2VwdCBza2lwcGluZyBjbGVhbnVwcyB0aGF0IGFyZSB1bm5lY2Vzc2Fy
eSBmb3Igc2h1dGRvd24gZmxvdyBhcmUgdGhlcmUKPiA+IGFueSBvdGhlciByZWFzb25zIHRvIHBy
ZWZlciBhIHNlcGFyYXRlIGZ1bmN0aW9uIGZvciBzaHV0ZG93bj8KPgo+IFllcyB5b3Ugc2hvdWxk
IHNraXAgImNsZWFudXBzIiBsaWtlIHJlbW92aW5nIHRoZSBJQiBkZXZpY2UgYW5kCj4gb3RoZXJ3
aXNlIGFzIHRoZXJlIGlzIGEgcmlzayBvZiBzeXN0ZW0gaGFuZy9kZWFkbG9jayBpbiBhIHNodXRk
b3duCj4gaGFuZGxlciBjb250ZXh0Lgo+Cj4gSmFzb24KPgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
