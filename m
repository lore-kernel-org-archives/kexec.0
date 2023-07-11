Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4D1C001DD
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 03:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mPdorwzhnMrBCGn+vH0bh8e2mkepNUIzvdtuutf9Ua8=; b=QDLX4BepiLc06A
	bVrn5PhIfB2mgx7EEQYqq7EblOTerjjQq+ep9ZgKCw3kR8nZyI+YD6rVBozKTquPEr2UxDU9/fK/n
	2z2ohaOz58PbJCH3zFLuuO5kNH3FyYN20Ytt6Rt1CvK2xBwWrpWJKd4dvBG+7THkQ/giLjkk+WdtB
	EUpAVSkj8wP7+xRjurjYptvfeH5SFrfWKjFKUHEhw5Ffheg2K7Joj51cVs05NznsW5tEe6KwIkPhd
	vETLA3TGUWDKea2eOpYA8Q9c42eO9aAB7NB/YqCPbRXPO5uPc83tm7xTYi0KWd0++MlOQ2v8zABQC
	JFcjbX/PAfF3r9ne8RHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4TO-00DXo7-2b;
	Tue, 11 Jul 2023 03:55:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4TL-00DXll-0E
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 03:55:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689047728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I51Q3nKKNCTWEmMYUHL5yUr4E1b6ZzzA1zlm0zArZHo=;
	b=e4PmIOL1gy8UHIdAbgiTUTJKgPJ52ZqbbsIsmcDPhHCCaKTBPBArSDpIvjnw9GpI7NUcDo
	FJg5Cd1v3uOT9OiLWfl/SWDVZK8XxpipmwPIx/CgzSw9/trApP2kZEI8wkRZAxi4udnuwG
	7XyF573aGl7U0ZbUaO791+EM3mp4gD4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-fKpwi9lMMZaMUFS06JhTyA-1; Mon, 10 Jul 2023 23:55:27 -0400
X-MC-Unique: fKpwi9lMMZaMUFS06JhTyA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e3871cf9so42380816d6.1
        for <kexec@lists.infradead.org>; Mon, 10 Jul 2023 20:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047726; x=1691639726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I51Q3nKKNCTWEmMYUHL5yUr4E1b6ZzzA1zlm0zArZHo=;
        b=hDhQGuOucG3n2PFW3/ax4of+GsEK+VJt8MXY2rIkKU9h/d/UEEBHUPwO7eYqFs5edL
         vGnWiJmSiQDCyEMes2Zpo4cgw43mJItW8fJze42q418jvSLuFOB3kg+v+ewy+xle1Imj
         Dl5D5GmY4Kp7jZsVasFQwODC+HRDe2n/ZpVlQpLjQbn0Q1mStcUf5zJjkcIcbP7ZH+Py
         uzd8uhHnpje3upcQYbgDTvXnX8FHLMC2dSeada9pjeIXZXxHl0h6sRMKRYO3KSa1pjc/
         Rsz6nhFE9I3D1dUf/kjaRF9wz6P6KtklDFm/9WQbeP8SOwCbVo9EQa9nWTH4R8R4hnt2
         aiUQ==
X-Gm-Message-State: ABy/qLbbrjyLs1mkXLC3XgHwdo8aN+zU++5JTM9P6QLPpBS2zMXu3fuW
	AgKIoK03R+u2qZOQgqSHaCZVIe7q9B+eNP1BO+RsJXo+KcdVZetHqNBCddZTt2bF2UoC3JNlFv4
	2Y0UdTqBYeTF2K3N3f+luRZN0HcaJP+xgmsAGjdywYsBZ5ZAN2xMj
X-Received: by 2002:a0c:8d45:0:b0:62f:ec76:f5b7 with SMTP id s5-20020a0c8d45000000b0062fec76f5b7mr11891460qvb.55.1689047726713;
        Mon, 10 Jul 2023 20:55:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTZhew2EUuIm724AKpM7YWVbIe48FZcuO2pasYKl7L1r04MF0dNfYfUrZnlan7BYQ6w00L0ejYouJH3uMuKwg=
X-Received: by 2002:a0c:8d45:0:b0:62f:ec76:f5b7 with SMTP id
 s5-20020a0c8d45000000b0062fec76f5b7mr11891446qvb.55.1689047726501; Mon, 10
 Jul 2023 20:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230708020259.1343736-1-ming.lei@redhat.com> <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de> <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 11 Jul 2023 11:55:15 +0800
Message-ID: <CAF+s44RuqswbosY9kMDx35crviQnxOeuvgNsuE75Bb0Y2Jg2uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, 
	Thomas Gleixner <tglx@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_205531_235923_2450415B 
X-CRM114-Status: GOOD (  20.61  )
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

T24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgNToxNuKAr1BNIE1pbmcgTGVpIDxtaW5nLmxlaUByZWRo
YXQuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgSnVsIDEwLCAyMDIzIGF0IDA4OjQxOjA5QU0gKzAy
MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+ID4gT24gU2F0LCBKdWwgMDgsIDIwMjMgYXQg
MTA6MDI6NTlBTSArMDgwMCwgTWluZyBMZWkgd3JvdGU6Cj4gPiA+IFRha2UgYmxrLW1xJ3Mga25v
d2xlZGdlIGludG8gYWNjb3VudCBmb3IgY2FsY3VsYXRpbmcgaW8gcXVldWVzLgo+ID4gPgo+ID4g
PiBGaXggd3JvbmcgcXVldWUgbWFwcGluZyBpbiBjYXNlIG9mIGtkdW1wIGtlcm5lbC4KPiA+ID4K
PiA+ID4gT24gYXJtIGFuZCBwcGM2NCwgJ21heGNwdXM9MScgaXMgcGFzc2VkIHRvIGtkdW1wIGNv
bW1hbmQgbGluZSwgc2VlCj4gPiA+IGBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tkdW1wL2tk
dW1wLnJzdGAsIHNvIG51bV9wb3NzaWJsZV9jcHVzKCkKPiA+ID4gc3RpbGwgcmV0dXJucyBhbGwg
Q1BVcy4KPiA+Cj4gPiBUaGF0J3Mgc2ltcGx5IGJyb2tlbi4gIFBsZWFzZSBmaXggdGhlIGFyY2gg
Y29kZSB0byBtYWtlIHN1cmUKPiA+IGl0IGRvZXMgbm90IHJldHVybiBhIGJvZ3VzIG51bV9wb3Nz
aWJsZV9jcHVzIHZhbHVlIGZvciB0aGVzZQo+CgpJbiBmYWN0LCBudW1fcG9zc2libGVfY3B1cyBp
cyBub3QgYnJva2VuLgoKUXVvdGUgZnJvbSBhZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50
eHQKICAgICAgIG1heGNwdXM9ICAgICAgICBbU01QXSBNYXhpbXVtIG51bWJlciBvZiBwcm9jZXNz
b3JzIHRoYXQgYW4gU01QIGtlcm5lbAogICAgICAgICAgICAgICAgICAgICAgIHdpbGwgYnJpbmcg
dXAgZHVyaW5nIGJvb3R1cC4gIG1heGNwdXM9biA6IG4gPj0gMCBsaW1pdHMKICAgICAgICAgICAg
ICAgICAgICAgICB0aGUga2VybmVsIHRvIGJyaW5nIHVwICduJyBwcm9jZXNzb3JzLiBTdXJlbHkg
YWZ0ZXIKICAgICAgICAgICAgICAgICAgICAgICBib290dXAgeW91IGNhbiBicmluZyB1cCB0aGUg
b3RoZXIgcGx1Z2dlZCBjcHUKYnkgZXhlY3V0aW5nCiAgICAgICAgICAgICAgICAgICAgICAgImVj
aG8gMSA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdVgvb25saW5lIi4KU28gbWF4Y3B1cwog
ICAgICAgICAgICAgICAgICAgICAgIG9ubHkgdGFrZXMgZWZmZWN0IGR1cmluZyBzeXN0ZW0gYm9v
dHVwLgogICAgICAgICAgICAgICAgICAgICAgIFdoaWxlIG49MCBpcyBhIHNwZWNpYWwgY2FzZSwg
aXQgaXMgZXF1aXZhbGVudCB0byAibm9zbXAiLAogICAgICAgICAgICAgICAgICAgICAgIHdoaWNo
IGFsc28gZGlzYWJsZXMgdGhlIElPIEFQSUMuCgpIZXJlLCBhcyBpdCBleHBsYWluZWQsIG1heGNw
dXMgb25seSBhZmZlY3RzIHRoZSBib290dXAsIGxhdGVyLCBleHRyYQpjcHVzIGNhbiBiZSBvbmxp
bmUuCgo+IFRoYXQgaXMgZG9jdW1lbnRlZCBpbiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tk
dW1wL2tkdW1wLnJzdC4KPgo+IE9uIGFybSBhbmQgcHBjNjQsICdtYXhjcHVzPTEnIGlzIHBhc3Nl
ZCBmb3Iga2R1bXAga2VybmVsLCBhbmQgIm1heGNwdT0xIgoKT24gYWFyY2g2NCBhbmQgeDg2LCBu
cl9jcHVzPTEgaXMgdXNlZCwgd2hpbGUgb24gcHBjNjQsIGR1ZSB0byB0aGUKaW1wbGVtZW50YXRp
b24sIG5yX2NwdXM9MSBjYW4gbm90IGJlIHN1cHBvcnRlZC4KCgpUaGFua3MsCgpQaW5nZmFuCgo+
IHNpbXBseSBrZWVwIG9uZSBvZiBDUFUgY29yZXMgYXMgb25saW5lLCBhbmQgb3RoZXJzIGFzIG9m
ZmxpbmUuCj4KPiBTbyBDYyBvdXIgYXJjaChhcm0gJiBwcGM2NCkgJiBrZHVtcCBndXlzIHdydC4g
cGFzc2luZyAnbWF4Y3B1cz0xJyBmb3IKPiBrZHVtcCBrZXJuZWwuCj4KPiA+IHNldHVwcywgb3Ro
ZXJ3aXNlIHlvdSdsbCBoYXZlIHRvIHBhcGVyIG92ZXIgaXQgaW4gYWxsIGtpbmQgb2YKPiA+IGRy
aXZlcnMuCj4KPiBUaGUgaXNzdWUgaXMgb25seSB0cmlnZ2VyZWQgZm9yIGRyaXZlcnMgd2hpY2gg
dXNlIG1hbmFnZWQgaXJxICYKPiBtdWx0aXBsZSBodyBxdWV1ZXMuCj4KPgo+IFRoYW5rcywKPiBN
aW5nCj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4ga2V4ZWMgbWFpbGluZyBsaXN0Cj4ga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMKPgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
