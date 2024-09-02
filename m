Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521BBCD13CF
	for <kexec@archiver.kernel.org>; Mon,  2 Sep 2024 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=33qnRzu0dfOlNM6vS1MQHHJmpOCZK7vT0Jkj4Q0ghVI=; b=k05RlOxXL4K9ll
	vRSf7JiVmJB6RiV1FawEWbEcUzJBTWorKSG8FB2R7cz/aDPeE+SRdliZQagc9mWCuHrK9MKLN+9ov
	T2vjHPRM5zSUfiCevt6hVoV/qZcD7cbEzdfhLHCaqwKrg0ZJdDCzSLhuZR5K6Zp7/DS+lVAC9TYZm
	MU5/O5+FlyiBhH/yBD1oAArJmSYGp1XfmHB3fxPYf1iX3xSFrpfzcCocqrUQPO/pbnyE4eKdMgGH5
	Tmu6AicNaovIDb3E4i2aGI2NYUGvGGu61TyQ726PaffBCxcrwKIU0SG2ZhgnuYYJOSvFpm7d5iOux
	INiZHsMHjwG7NUiRb/4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl8gQ-0000000Ena6-3RPc;
	Mon, 02 Sep 2024 15:09:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl8cR-0000000EmgH-2beH
	for kexec@lists.infradead.org;
	Mon, 02 Sep 2024 15:05:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725289526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziH5RycTQIYEsjONg+GaJvTnZD1q/SgNIqzqcE498lo=;
	b=fX+XsiktcgzIT0g/GKYKFj51Sbw8NnCWMM+XOlu0JpjJ5uhdqonustL0isDxhp1QC7I+jt
	LKRG85pdud8/H/kEPQJbardC5Z443HELy/Ys8XF4ygj9IlJHFK/C78ULkPSKg32z+lr2VR
	e/C5mr4t/PkPiomUGnlLF6BKCYw6RkU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-Vs6lYM-gPG2_SVjYyDdPlw-1; Mon, 02 Sep 2024 11:05:23 -0400
X-MC-Unique: Vs6lYM-gPG2_SVjYyDdPlw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d69603a62aso4736342a91.2
        for <kexec@lists.infradead.org>; Mon, 02 Sep 2024 08:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289522; x=1725894322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziH5RycTQIYEsjONg+GaJvTnZD1q/SgNIqzqcE498lo=;
        b=TtM5+ic7mawnF2yfZTHrnsk8UE9P3bOiDIkJ9rtqLFOYJ9r9QjYVRWUSXsrXUXWBvC
         G/r7310m3eqo2/CtwUJg/2qq0sKhZjLhAIMLtSznM9Svut4G7XY392E4SGYzexi1fBhs
         njT5UM6ZDNkbrUIz4idG7KAWmpBMVLhfhIa2ufVbJ6rDpxeu2ReS1Kah8A13U2K4lqet
         TcLAiZSO1XS37TeTMow4SkDiVIZEQ3Iq+egx81u5rnNmSrU3pihJXjOag9dMEAJUqVwz
         5zmC+NP1MaRbrFr2YELLcIKaGv7z7HUdQUu6/VCmcUGvjpHprhjGxpIajM4Mt6jBE5Gi
         jiUA==
X-Forwarded-Encrypted: i=1; AJvYcCV0gAQp5ReC101o4r5WC8kQ3VMJ/qb8cnVPBvnTBVfbRwzhfnSlm8nTQLmBYrH+WhcawfpZRg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxdlVkv2e2YFTg0oAX5WqZde0pRgAuT9hGyl8by/dX1oph2rZDx
	5Tnyh2NuoDSbfDKiv7ovpPIP6f7hbws9M+PdzCbrzRe4LqzsJZNWMFhHdGgVS8QWylZ4QtdBXUr
	K860kroQ8CVtJi6LLvHClmR+lQu07g9Ag2OTvX/MDEWXq6gl+l2xNQN/0nDfv02US5RxPHmnZkw
	7Snrsg+q9kVy6s3QQt4wBqAIwfgdC9+VS/
X-Received: by 2002:a17:90a:8d07:b0:2d8:27c1:1d4a with SMTP id 98e67ed59e1d1-2d88d6dbadbmr8803282a91.24.1725289522157;
        Mon, 02 Sep 2024 08:05:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0yHTmMgIu13OPCtaJjdH70dJqkGRaPQI7+UUIjnFKNKjMRWxvi7+frXfjTnChdUxzt4MQr6gq2Zp/Dq3TmBk=
X-Received: by 2002:a17:90a:8d07:b0:2d8:27c1:1d4a with SMTP id
 98e67ed59e1d1-2d88d6dbadbmr8803237a91.24.1725289521719; Mon, 02 Sep 2024
 08:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240827203804.4989-1-Ashish.Kalra@amd.com>
In-Reply-To: <20240827203804.4989-1-Ashish.Kalra@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Sep 2024 17:05:08 +0200
Message-ID: <CABgObfZMQ1qcQf-XLZaPGFzmbtoe3gGuMvXF-N0qo_5Z9jf+vg@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Fix host kdump support for SNP
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: seanjc@google.com, dave.hansen@linux.intel.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	thomas.lendacky@amd.com, michael.roth@amd.com, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_080527_783487_52A8A026 
X-CRM114-Status: GOOD (  13.35  )
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

T24gVHVlLCBBdWcgMjcsIDIwMjQgYXQgMTA6NDDigK9QTSBBc2hpc2ggS2FscmEgPEFzaGlzaC5L
YWxyYUBhbWQuY29tPiB3cm90ZToKPiArdm9pZCBzbnBfZGVjb21taXNpb25fYWxsKHZvaWQpCgpT
aG91bGQgYmUgc3BlbGxlZCBzbnBfZGVjb21taXNzaW9uX2FsbCAod2l0aCB0d28gInMiKS4KCj4g
K3N0YXRpYyBERUZJTkVfU1BJTkxPQ0soc25wX2RlY29tbWlzaW9uX2xvY2spOwoKU2FtZSBoZXJl
LgoKPiAgLyoKPiAgICogT25seSBNU1JfVFNDX0FVWCBpcyBzd2l0Y2hlZCB2aWEgdGhlIHVzZXIg
cmV0dXJuIGhvb2suICBFRkVSIGlzIHN3aXRjaGVkIHZpYQo+ICAgKiB0aGUgVk1DQiwgYW5kIHRo
ZSBTWVNDQUxML1NZU0VOVEVSIE1TUnMgYXJlIGhhbmRsZWQgYnkgVk1MT0FEL1ZNU0FWRS4KPiBA
QCAtNTk0LDkgKzU5Nyw5NyBAQCBzdGF0aWMgaW5saW5lIHZvaWQga3ZtX2NwdV9zdm1fZGlzYWJs
ZSh2b2lkKQo+Cj4gIHN0YXRpYyB2b2lkIHN2bV9lbWVyZ2VuY3lfZGlzYWJsZSh2b2lkKQo+ICB7
Cj4gKyAgICAgICBzdGF0aWMgYXRvbWljX3Qgd2FpdGluZ19mb3JfY3B1c19zeW5jaHJvbml6ZWQ7
Cj4gKyAgICAgICBzdGF0aWMgYm9vbCBzeW5jaHJvbml6ZV9jcHVzX2luaXRpYXRlZDsKPiArICAg
ICAgIHN0YXRpYyBib29sIHNucF9kZWNvbW1pc2lvbl9oYW5kbGVkOwoKU2FtZSBoZXJlLCBhbmQg
YmVsb3cgdGhyb3VnaG91dCB0aGUgZnVuY3Rpb24gKGFsc28gU05QX0RFQ09NTUlTU0lPTikuCgpQ
bGVhc2UgY3JlYXRlIGEgbmV3IGZ1bmN0aW9uIHNldl9lbWVyZ2VuY3lfZGlzYWJsZSgpLCB3aXRo
IGEgc3R1YiBpbgpzdm0uaCBpZiBDT05GSUdfS1ZNX0FNRF8KCj4gQEAgLTc0OSw2ICs3NDksNyBA
QCB2b2lkIHNldl9zbnBfaW5pdF9wcm90ZWN0ZWRfZ3Vlc3Rfc3RhdGUoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1KTsKPiAgaW50IHNldl9nbWVtX3ByZXBhcmUoc3RydWN0IGt2bSAqa3ZtLCBrdm1fcGZu
X3QgcGZuLCBnZm5fdCBnZm4sIGludCBtYXhfb3JkZXIpOwo+ICB2b2lkIHNldl9nbWVtX2ludmFs
aWRhdGUoa3ZtX3Bmbl90IHN0YXJ0LCBrdm1fcGZuX3QgZW5kKTsKPiAgaW50IHNldl9wcml2YXRl
X21heF9tYXBwaW5nX2xldmVsKHN0cnVjdCBrdm0gKmt2bSwga3ZtX3Bmbl90IHBmbik7Cj4gK3Zv
aWQgc25wX2RlY29tbWlzaW9uX2FsbCh2b2lkKTsKPiAgI2Vsc2UKPiAgc3RhdGljIGlubGluZSBz
dHJ1Y3QgcGFnZSAqc25wX3NhZmVfYWxsb2NfcGFnZV9ub2RlKGludCBub2RlLCBnZnBfdCBnZnAp
Cj4gIHsKPiBAQCAtNzc5LDcgKzc4MCw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNldl9wcml2YXRl
X21heF9tYXBwaW5nX2xldmVsKHN0cnVjdCBrdm0gKmt2bSwga3ZtX3Bmbl90IHBmbikKPiAgewo+
ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPiAtCj4gK3N0YXRpYyB2b2lkIHNucF9kZWNvbW1pc2lv
bl9hbGwodm9pZCk7CgpUaGlzIHNob3VsZCBiZSBpbmxpbmUgKGFuZCBhZnRlciB0aGUgY2hhbmdl
IGFib3ZlIGl0IHNob3VsZCBiZQpzZXZfZW1lcmdlbmN5X2Rpc2FibGUoKSwgbm90IHNucF9kZWNv
bW1pc3Npb25fYWxsKCksIHRoYXQgaXMgZXhwb3J0ZWQKZnJvbSBzZXYuYykuCgpUaGFua3MsCgpQ
YW9sbwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
