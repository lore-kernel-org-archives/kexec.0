Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336F9CDB483
	for <kexec@archiver.kernel.org>; Wed, 18 Oct 2023 08:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UAvBOnLL6l4fzj10KhRR7xzMY2OuJNWezISyI2yL75k=; b=1nxW/79EPPBq8z
	jKuLble4Dw1JLCIsHEJLm3+Er+dhpeKeBeFzyCvlBPx0CT+P5Z4SMjWd+dtuzgwClc2oH42CtwnhE
	obAq8drKCfo3txu1mQfQYiQr8B7sI1YSLTbLynHFQ6okCj9HPekaM7I8QQLjFTM3yqTpOGdmAs5yo
	/o6iU/YDeMDXdY2S7n0a0B7WkOQGr2Ndee+VE7x10wISifUMjciGjkPMMDn3XwEL5rGX/+yWKFIaU
	E1WGOkaw04mqKFCBA/TmkSTXIy74FKRXcW5sKdyCZPrbccphfqpfZcmYZoW4DT9xw9eCsMF3DLEm3
	dYowjo+ZzObovV0tS/Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt1o8-00E85c-2G;
	Wed, 18 Oct 2023 08:21:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt1o5-00E84h-2D
	for kexec@lists.infradead.org;
	Wed, 18 Oct 2023 08:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697617291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxyLuX2sVSgocSVP1OJP8CY85CjyrBJH2u1BiNoMcK0=;
	b=K+uCRtmGQL13t+g+i8iXne45SmcOKlNRrq/H7hF5kAvtqNhLoGpZUSxVIqVVEKmxUcfg7f
	8VAsG4/A2zdb0rxff7mpxAWop2e/m2HKIzd0dB5G4+I3xLnBrw98nqru4NMPC8WlsecgIC
	SGNDnnnJ7injIqqIfEoixHHM7noqtKU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-yRth3YKxMt60zaRk0BjZSA-1; Wed, 18 Oct 2023 04:21:20 -0400
X-MC-Unique: yRth3YKxMt60zaRk0BjZSA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63d0c38e986so64845876d6.1
        for <kexec@lists.infradead.org>; Wed, 18 Oct 2023 01:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697617280; x=1698222080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxyLuX2sVSgocSVP1OJP8CY85CjyrBJH2u1BiNoMcK0=;
        b=R1Ko2gyvsSJB28cII/eiXfKYE0gaAUeGOM193ZJDT7DidNkXX4lZbceyzC8mqp/XPl
         m+MBV19+Gmxl0AhZHj1B0Zu91v6xPEEpqG38oahZHApkFLlzGx3hE1U5BDrtBEKUnd8s
         uIjJQWiQn8+Kgi+6jI0AnkNJhN8BNTXA+iPDdlWJgjdD4RJvrf9QRzW/+q9VkGSPvABC
         OdL/CRVEgS2AiZzbRlT0fzFdJuirzvyZSEtHRXmxKsX8NKNzfIutw8YaDixglfBljjyM
         yP6GOy5dqoUopKn5tfsMSuYoKNwxV+4Qp5+93/Z/Fc207cYa3PogR81U+YV/PFiGUSpq
         jDBA==
X-Gm-Message-State: AOJu0YxPeaf0JP9dPONhDYukYDGnDKW1JCPjqTsEY1LA0gu6txZaeQ/8
	gwdu94oHyhaWHOULTMomFzrGRC0+nZB/NH7/sDWKTcvmfEJjHpNgqLPwlVvTYve538A4VVS9H4w
	TsS8U26TfF1QzKqteJvutX7qXtEBD2G0CgDj/
X-Received: by 2002:a05:6214:b6a:b0:65d:afc:3a52 with SMTP id ey10-20020a0562140b6a00b0065d0afc3a52mr5765333qvb.49.1697617280029;
        Wed, 18 Oct 2023 01:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHEzDiqR89ZioUu+FBLZxahmm1G/0JaYQSHoQo8mqvVERP6h3/yg3Ccnp1+KCRgp7ZOTHk4yr+FE4y1NMHClA=
X-Received: by 2002:a05:6214:b6a:b0:65d:afc:3a52 with SMTP id
 ey10-20020a0562140b6a00b0065d0afc3a52mr5765320qvb.49.1697617279800; Wed, 18
 Oct 2023 01:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231017022806.4523-1-piliu@redhat.com> <20231017022806.4523-3-piliu@redhat.com>
 <064ae2ee-ad15-c0ab-f78b-7b3e7dc6612d@linux.ibm.com>
In-Reply-To: <064ae2ee-ad15-c0ab-f78b-7b3e7dc6612d@linux.ibm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 18 Oct 2023 16:21:08 +0800
Message-ID: <CAF+s44S33-x=bjZsLc=Ke+J6UFPq6DMxPA1Vaohc6_qLoEw9iw@mail.gmail.com>
Subject: Re: [PATCHv9 2/2] powerpc/setup: Loosen the mapping between cpu
 logical id and its seq in dt
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>, 
	Ming Lei <ming.lei@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Wen Xiong <wenxiong@us.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_012133_815158_25EAF5EB 
X-CRM114-Status: GOOD (  20.06  )
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

T24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgNjozOeKAr1BNIEhhcmkgQmF0aGluaSA8aGJhdGhpbmlA
bGludXguaWJtLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gMTcvMTAvMjMgNzo1OCBhbSwgUGluZ2Zh
biBMaXUgd3JvdGU6Cj4gPiAqKiogSWRlYSAqKioKPiA+IEZvciBrZXhlYyAtcCwgdGhlIGJvb3Qg
Y3B1IGNhbiBiZSBub3QgdGhlIGNwdTAsIHRoaXMgY2F1c2VzIHRoZSBwcm9ibGVtCj4gPiBvZiBh
bGxvY2F0aW5nIG1lbW9yeSBmb3IgcGFjYV9wdHJzW10uIEhvd2V2ZXIsIGluIHRoZW9yeSwgdGhl
cmUgaXMgbm8KPiA+IHJlcXVpcmVtZW50IHRvIGFzc2lnbiBjcHUncyBsb2dpY2FsIGlkIGFzIGl0
cyBwcmVzZW50IHNlcXVlbmNlIGluIHRoZQo+ID4gZGV2aWNlIHRyZWUuIEJ1dCB0aGVyZSBpcyBz
b21ldGhpbmcgbGlrZSBjcHVfZmlyc3RfdGhyZWFkX3NpYmxpbmcoKSwKPiA+IHdoaWNoIG1ha2Vz
IGFzc3VtcHRpb24gb24gdGhlIG1hcHBpbmcgaW5zaWRlIGEgY29yZS4gSGVuY2UgcGFydGlhbGx5
Cj4gPiBsb29zZW5pbmcgdGhlIG1hcHBpbmcsIGkuZS4gdW5iaW5kIHRoZSBtYXBwaW5nIG9mIGNv
cmUgd2hpbGUga2VlcCB0aGUKPiA+IG1hcHBpbmcgaW5zaWRlIGEgY29yZS4KPiA+Cj4gPiAqKiog
SW1wbGVtZW50ICoqKgo+ID4gQXQgdGhpcyBlYXJseSBzdGFnZSwgdGhlcmUgYXJlIHBsZW50eSBv
ZiBtZW1vcnkgdG8gdXRpbGl6ZS4gSGVuY2UsIHRoaXMKPiA+IHBhdGNoIGFsbG9jYXRlcyBpbnRl
cmltIG1lbW9yeSB0byBsaW5rIHRoZSBjcHUgaW5mbyBvbiBhIGxpc3QsIHRoZW4KPiA+IHJlb3Jk
ZXIgY3B1cyBieSBjaGFuZ2luZyB0aGUgbGlzdCBoZWFkLiBBcyBhIHJlc3VsdCwgdGhlcmUgaXMg
YSByb3RhdGUKPiA+IHNoaWZ0IGJldHdlZW4gdGhlIHNlcXVlbmNlIG51bWJlciBpbiBkdCBhbmQg
dGhlIGNwdSBsb2dpY2FsIG51bWJlci4KPiA+Cj4gPiAqKiogUmVzdWx0ICoqKgo+ID4gQWZ0ZXIg
dGhpcyBwYXRjaCwgYSBib290LWNwdSdzIGxvZ2ljYWwgaWQgd2lsbCBhbHdheXMgYmUgbWFwcGVk
IGludG8gdGhlCj4gPiByYW5nZSBbMCx0aHJlYWRzX3Blcl9jb3JlKS4KPiA+Cj4gPiBCZXNpZGVz
IHRoaXMsIGF0IHRoaXMgcGhhc2UsIGFsbCB0aHJlYWRzIGluIHRoZSBib290IGNvcmUgYXJlIGZv
cmNlZCB0bwo+ID4gYmUgb25saW5lZC4gVGhpcyByZXN0cmljdGlvbiB3aWxsIGJlIGxpZnRlZCBp
biBhIGxhdGVyIHBhdGNoIHdpdGgKPiA+IGV4dHJhIGVmZm9ydC4KPiA+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBQaW5nZmFuIExpdSA8cGlsaXVAcmVkaGF0LmNvbT4KPiA+IENjOiBNaWNoYWVsIEVsbGVy
bWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+Cj4gPiBDYzogTmljaG9sYXMgUGlnZ2luIDxucGlnZ2lu
QGdtYWlsLmNvbT4KPiA+IENjOiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNz
Z3JvdXAuZXU+Cj4gPiBDYzogTWFoZXNoIFNhbGdhb25rYXIgPG1haGVzaEBsaW51eC5pYm0uY29t
Pgo+ID4gQ2M6IFdlbiBYaW9uZyA8d2VueGlvbmdAdXMuaWJtLmNvbT4KPiA+IENjOiBCYW9xdWFu
IEhlIDxiaGVAcmVkaGF0LmNvbT4KPiA+IENjOiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNv
bT4KPiA+IENjOiBTb3VyYWJoIEphaW4gPHNvdXJhYmhqYWluQGxpbnV4LmlibS5jb20+Cj4gPiBD
YzogSGFyaSBCYXRoaW5pIDxoYmF0aGluaUBsaW51eC5pYm0uY29tPgo+ID4gQ2M6IGtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKPiA+IFRvOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwo+
Cj4gVGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMsIFBpbmdmYW4uCj4gTG9va3MgZ29vZCB0byBt
ZS4KPgo+IEFja2VkLWJ5OiBIYXJpIEJhdGhpbmkgPGhiYXRoaW5pQGxpbnV4LmlibS5jb20+Cj4K
ClRoYW5rIHlvdSBmb3Iga2luZGx5IHJldmlld2luZy4gSSBob3BlIHRoYXQgYWZ0ZXIgYWxsIHRo
ZXNlIHllYXJzLCB3ZQpoYXZlIGFjY29tcGxpc2hlZCB0aGUgb2JqZWN0aXZlLgoKQmVzdCBSZWdh
cmRzLAoKUGluZ2ZhbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
