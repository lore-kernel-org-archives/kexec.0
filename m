Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2355C77B7C
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 03:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bbwbYL8GHca12q/HJgn9ZtNoW+CFXpXP7Ea51XDJAus=; b=KG5B+iXMTj2EQz
	pcl7Mx2pQWeg4ufy/QKe4QzgHj0q5117BhwEqfmeYrp0mFUmNsASdRKm/mU8FCijJHffd5OTgiFyj
	uhh8mS2rw1//zU3D0lhE3/bQL5THXBFC9AIumo96s6fhsyxzlRt2IPKckd1QnXF2MOT3RQi1Y3HQh
	q+ElxansHmytvAAkPRGR9sNDX5FUIBCd8rAZXYK3FlYdpKlo5aZ8b+23ga+z8S2Q4bdxukdHYwJii
	zFGdEbArnQVhj4Oqp45UxPpGo7/BprJSkwigm0vV3eVCeT+SJPAv8TkcsCiE3DwhovBpHRLY/uZk9
	ckdck02MRSMg/NwngObg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pulqX-009byM-1b;
	Fri, 05 May 2023 03:11:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pulqV-009bxc-09
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 03:11:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683256258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SadsbPWluF/7sfEghUdAi4nwYp5hcp1KPzyGxW0JCMc=;
	b=eWLT1R6V9R0+N6CxDGNsayTXvMDUVqByoKaxbKgk/TPaxwCEYekCCB2XUThSs6saevS9Mz
	ktjpS/wuRE7iSkSSz7B6pDNICZ3m94j9elSxLRiYgGmOlVDK41gsb1+2i+/fuUy+gDKg63
	vUWtv6VdlLvGRkqmDQgiYi3G0aFLdl4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-7QoybDbsOTiM5clP54sjlA-1; Thu, 04 May 2023 23:10:57 -0400
X-MC-Unique: 7QoybDbsOTiM5clP54sjlA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5ef626ad00fso17704916d6.3
        for <kexec@lists.infradead.org>; Thu, 04 May 2023 20:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683256256; x=1685848256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SadsbPWluF/7sfEghUdAi4nwYp5hcp1KPzyGxW0JCMc=;
        b=aPRmYih+g5hRBznex2/GjjTQLJ5oV+OouwVDtKfMZNpecjzpbt8FJeTfSEQX7udpce
         GhuIFMRFxtohNN74040VEdBhO0ZPtbkT+CYBVUTcLW1kFA20cgQkB7eroMs6GxQmrXLa
         k7HUQdQC5QTzcKgUToVAI0AmNZ16ZTtwPY9WzWBSZbAdQOtL+Bt8NauHNPnjAjZJuYet
         IS1lz/PxKmJreAygiaVDFkkK3kCzTBelt25HsZ7nNF6DaHjyBLt711htPlZDrp5JUSm+
         6gsAURclX8gahY/QlIWw+M+wuTuCU0wOpINRF9slUl8fkrIwob1m/zInKAro8N24FBl+
         uv4Q==
X-Gm-Message-State: AC+VfDxg65+jl68MxQPDPO5TQjcOmLSQe8HOEYfL6uDzV6D8P5qOEJ6z
	bI0TCdYUt8dk8eDjZLPV/ibObOHS9qVzIg08PHVdyxbAKG3+wtmzhMVPFoPPONYC3D5NXZ634jx
	MVZPXI80w70xfYiDTaF0bocUyqtOB2aNMXyjLMUoL5r2O
X-Received: by 2002:a05:6214:300c:b0:616:58f1:283e with SMTP id ke12-20020a056214300c00b0061658f1283emr219659qvb.10.1683256256425;
        Thu, 04 May 2023 20:10:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5SWCp6TuEPR39x7iYHp66Y+A6RDHqFwuouiMK1bpKbeQXhgfsxi4YnuqMdde2d6n1x+qZiDKJzH4CzBzBL3+U=
X-Received: by 2002:a05:6214:300c:b0:616:58f1:283e with SMTP id
 ke12-20020a056214300c00b0061658f1283emr219650qvb.10.1683256256198; Thu, 04
 May 2023 20:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230504164147.1166614-1-jeremy.linton@arm.com> <20230504164147.1166614-5-jeremy.linton@arm.com>
In-Reply-To: <20230504164147.1166614-5-jeremy.linton@arm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 5 May 2023 11:10:45 +0800
Message-ID: <CAF+s44R3z66-ZO=8tYYS4Z5yWPhfkk0ZW+5TqhvkqU_vn5A_OA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: Fix some issues with zImage _probe()
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, bhsharma@redhat.com, 
	ardb@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_201059_157900_B5D5390D 
X-CRM114-Status: GOOD (  16.47  )
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

T24gRnJpLCBNYXkgNSwgMjAyMyBhdCAxMjo0NOKAr0FNIEplcmVteSBMaW50b24gPGplcmVteS5s
aW50b25AYXJtLmNvbT4gd3JvdGU6Cj4KPiBDdXJyZW50IGNvbXBpbGVycyBub3RlIHRoYXQgZm5h
bWUgd2lsbCBiZSBudWxsIHdoaWxlCj4gYXR0ZW1wdGluZyB0byBwcmludCBmYWlsdXJlcyBmcm9t
IHN0cmR1cCgpLgo+Cj4gRnVydGhlciBmaXggYSBtZW1vcnkgbGVhayBjYXVzZWQgYnkga2VybmVs
X3VuY29tcHJlc3NlZF9idWYKPiBuZXZlciBiZWluZyB1c2VkL2ZyZWVkIGJlZm9yZSB0aGUgYWxs
b2NhdGVkIGJsb2NrIGlzIHJlcGxhY2VkCj4gYnkgdGhlIG9uZSByZXR1cm5lZCBieSBzbHVycF9k
ZWNvbXByZXNzX2ZpbGUoKS4KPgo+IFNpZ25lZC1vZmYtYnk6IEplcmVteSBMaW50b24gPGplcmVt
eS5saW50b25AYXJtLmNvbT4KPiAtLS0KPiAga2V4ZWMvYXJjaC9hcm02NC9rZXhlYy16SW1hZ2Ut
YXJtNjQuYyB8IDEzICstLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9rZXhlYy9hcmNoL2FybTY0L2tl
eGVjLXpJbWFnZS1hcm02NC5jIGIva2V4ZWMvYXJjaC9hcm02NC9rZXhlYy16SW1hZ2UtYXJtNjQu
Ywo+IGluZGV4IDZlZTgyZmYuLjNlYjFhZDggMTAwNjQ0Cj4gLS0tIGEva2V4ZWMvYXJjaC9hcm02
NC9rZXhlYy16SW1hZ2UtYXJtNjQuYwo+ICsrKyBiL2tleGVjL2FyY2gvYXJtNjQva2V4ZWMteklt
YWdlLWFybTY0LmMKPiBAQCAtNTUsOCArNTUsNyBAQCBpbnQgekltYWdlX2FybTY0X3Byb2JlKGNv
bnN0IGNoYXIgKmtlcm5lbF9idWYsIG9mZl90IGtlcm5lbF9zaXplKQo+ICAgICAgICAgfQo+Cj4g
ICAgICAgICBpZiAoIShmbmFtZSA9IHN0cmR1cChGSUxFTkFNRV9JTUFHRSkpKSB7Cj4gLSAgICAg
ICAgICAgICAgIGRiZ3ByaW50ZigiJXM6IENhbid0IGR1cGxpY2F0ZSBzdHJpbmdzICVzXG4iLCBf
X2Z1bmNfXywKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZuYW1lKTsKPiArICAg
ICAgICAgICAgICAgZGJncHJpbnRmKCIlczogQ2FuJ3QgZHVwbGljYXRlIHN0cmluZ3NcbiIsIF9f
ZnVuY19fKTsKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC0xOwo+ICAgICAgICAgfQo+Cj4gQEAg
LTY3LDE1ICs2Niw2IEBAIGludCB6SW1hZ2VfYXJtNjRfcHJvYmUoY29uc3QgY2hhciAqa2VybmVs
X2J1Ziwgb2ZmX3Qga2VybmVsX3NpemUpCj4gICAgICAgICAgICAgICAgIGdvdG8gZmFpbF9ta3N0
ZW1wOwo+ICAgICAgICAgfQo+Cj4gLSAgICAgICBrZXJuZWxfdW5jb21wcmVzc2VkX2J1ZiA9Cj4g
LSAgICAgICAgICAgICAgIChjaGFyICopIGNhbGxvYyhrZXJuZWxfc2l6ZSwgc2l6ZW9mKG9mZl90
KSk7Cj4gLSAgICAgICBpZiAoIWtlcm5lbF91bmNvbXByZXNzZWRfYnVmKSB7Cj4gLSAgICAgICAg
ICAgICAgIGRiZ3ByaW50ZigiJXM6IENhbid0IGNhbGxvYyAlbGQgYnl0ZXNcbiIsCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywga2VybmVsX3NpemUpOwo+IC0gICAg
ICAgICAgICAgICByZXQ9IC1FTk9NRU07Cj4gLSAgICAgICAgICAgICAgIGdvdG8gZmFpbF9jYWxs
b2M7Cj4gLSAgICAgICB9Cj4gLQo+ICAgICAgICAgLyogc2x1cnAgaW4gdGhlIGlucHV0IGtlcm5l
bCAqLwo+ICAgICAgICAgZGJncHJpbnRmKCIlczogIiwgX19mdW5jX18pOwo+ICAgICAgICAga2Vy
bmVsX3VuY29tcHJlc3NlZF9idWYgPSBzbHVycF9kZWNvbXByZXNzX2ZpbGUoa2VybmVsX2J1ZiwK
PiBAQCAtMTI4LDcgKzExOCw2IEBAIGludCB6SW1hZ2VfYXJtNjRfcHJvYmUoY29uc3QgY2hhciAq
a2VybmVsX2J1Ziwgb2ZmX3Qga2VybmVsX3NpemUpCj4gIGZhaWxfYmFkX2hlYWRlcjoKPiAgICAg
ICAgIGZyZWUoa2VybmVsX3VuY29tcHJlc3NlZF9idWYpOwo+Cj4gLWZhaWxfY2FsbG9jOgo+ICAg
ICAgICAgaWYgKGZkID49IDApCj4gICAgICAgICAgICAgICAgIGNsb3NlKGZkKTsKPgo+IC0tCj4g
Mi40MC4wCj4KUmV2aWV3ZWQtYnk6IFBpbmdmYW4gTGl1IDxwaWxpdUByZWRoYXQuY29tPgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
