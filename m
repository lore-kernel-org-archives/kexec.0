Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6547CEC875B
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BXuOL0XhhVyrrKgQ/YDtzelMrp/LmF3Mwk7AbVs9wdo=; b=A0Tlo1PD2TfHqU
	wHQcft6ayC0B+1ZBiCqKI9VZVCLT3jwiqjtaeXOP/3u/RbXFVV68hM68vnrGFGa0n+1SA3t4WO7gj
	bohUyRCsc1c42M83nj5dD0LhCF8tF7MHYBnCJ+qFjNV5oUKelGF8pqzaY+ugAY3d4o8J16t6qMh25
	cEi1ixxvmGKdqPfBFkP5qxBLcs7bwWmIXYGrggTcIhifwFIIE+02uPjk8ZTD8SZlEzPF5jhGl/16N
	64YFNo1MGn7fZs0RT2hPpo3QytbFDKC2nPwWBxvvWvdbpn6AJ7QyZj6l8kAN5ck0qDnIk/5AAlrFF
	UP2gbzHgWWSerCJQuiSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeM9f-00CgPm-2w;
	Thu, 07 Sep 2023 21:03:11 +0000
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeM9b-00CgNT-2q
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 21:03:10 +0000
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-592976e5b6dso13659267b3.2
        for <kexec@lists.infradead.org>; Thu, 07 Sep 2023 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694120586; x=1694725386; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRdHQjf/tBzCy2IXz17HvVEnZ9t7E6rFEF3hyTH/5WQ=;
        b=LYQ0Orr2uyGR/o3kpkCjn5qvaOwO6emnb65UNlIEkNqk2B4YgGcHQEe0V9qC8YCO+Z
         UZD0dOnAA1MQGWwP8K64KkOHPT8OSkMQefuqZwC62w7Tgk0uO1Rv8lvP9+jIQ21fHrCq
         uzSYjUPM+JQ1g8So7rb0EHqCJHpw1LXamK0sKwLx8W972qOy8rFZMVde2w9MHpdvKrsn
         Kg4FLXYQmelG9Zp7ktD6+1DD0ux8/SSm/8SQIdUcD5A37zIUz8QE1dEQtAFQW2veOiJq
         8azxKksdPSvmGQXjav6zq/3LAmPwhsqJKlRw7Y90CU1ffdCnZQRIQ2c6UPpirOZnh00t
         f/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694120586; x=1694725386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRdHQjf/tBzCy2IXz17HvVEnZ9t7E6rFEF3hyTH/5WQ=;
        b=XWDTW+OwetXaJ/SjvhKmli45D8U7Dw+NZKOQbuzHCuVnE0vL7bq3scVM88TO8jaDPy
         TE+wbVt+QfoLokDVgvTrnpNNOMO/5urmYAKLHRaPa2WxoJn7ofiNF0x3Tqi/WWNlEp5p
         SRdN4WiJBD678VkUuPHu/0V6rSVapUvSBRpBh5NJZrUMwmMdfNz92A03T6Wl/0VsvAOC
         0eVXrQeDMPeRO4NtznBnYlIvTZempTC2hoFRAPevh2Ukkfz4PyhxSyxQyMjHXMN/4CXz
         FFCgib6vSxyW3mIFb1B4Fp/EWVPCEGYSWDbZq72eRUC0BnSIpoMvUzF4RTuKQyOcHBxI
         iIag==
X-Gm-Message-State: AOJu0YzDd5o0jHK3D/tdX/+5bqKz6SI4YaNYGAeLODA+YjIoTqXSgh//
	oCeJUtAu60mgGSnR6zcD+lo+NklP11Vg6t83uMrE
X-Google-Smtp-Source: AGHT+IFDlkfTBZK0+MbboueHp/g4qH419JvtP06vu4lxBO7TjlbsQsl0/5IZc213XschnCZHZNUEjURU0tqfy5ak1jc=
X-Received: by 2002:a81:6d41:0:b0:595:80be:fc6b with SMTP id
 i62-20020a816d41000000b0059580befc6bmr695657ywc.18.1694120586006; Thu, 07 Sep
 2023 14:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <598fdd62-f4c3-a6dc-ae22-8f5a9e18f570@linux.ibm.com> <c83e13f8-4b7d-9489-37cc-53936b24343c@linux.microsoft.com>
 <0cfdad7c-8cb9-20d3-7986-c1d3d58a33db@linux.ibm.com>
In-Reply-To: <0cfdad7c-8cb9-20d3-7986-c1d3d58a33db@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Sep 2023 17:02:55 -0400
Message-ID: <CAHC9VhRG1SgNz2RFe8gEYxT=5RK6EutFuNt0YRtwA0bp6PsRog@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - aggregate
To: Ken Goldman <kgold@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	zohar@linux.ibm.com, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com, 
	code@tyhicks.com, nramas@linux.microsoft.com, 
	linux-security-module@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_140308_792786_57DB6006 
X-CRM114-Status: GOOD (  30.13  )
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

T24gV2VkLCBTZXAgNiwgMjAyMyBhdCA0OjQ54oCvUE0gS2VuIEdvbGRtYW4gPGtnb2xkQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIDkvMS8yMDIzIDY6MDYgUE0sIFR1c2hhciBTdWdhbmRoaSB3
cm90ZToKPiA+IE9uIDgvMzAvMjMgMTE6MTIsIEtlbiBHb2xkbWFuIHdyb3RlOgo+ID4+IE9uIDgv
MS8yMDIzIDM6MTIgUE0sIFN1c2ggU2hyaW5nYXJwdXRhbGUgd3JvdGU6Cj4gPj4+IC0gQSB1c2Vy
LW1vZGUgcHJvY2VzcyB3aWxsIHRyaWdnZXIgdGhlIHNuYXBzaG90IGJ5IG9wZW5pbmcgYSBmaWxl
IGluCj4gPj4+IFN5c0ZTCj4gPj4+ICAgIHNheSAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvc25h
cHNob3QgKHJlZmVycmVkIHRvIGFzCj4gPj4+IHN5c2tfaW1hX3NuYXBzaG90X2ZpbGUKPiA+Pj4g
ICAgaGVyZSBvbndhcmRzKS4KPiA+Pj4gLSBUaGUgS2VybmVsIHdpbGwgZ2V0IHRoZSBjdXJyZW50
IFRQTSBQQ1IgdmFsdWVzIGFuZCBQQ1IgdXBkYXRlCj4gPj4+IGNvdW50ZXIgWzJdCj4gPj4+ICAg
IGFuZCBzdG9yZSB0aGVtIGFzIHRlbXBsYXRlIGRhdGEgaW4gYSBuZXcgSU1BIGV2ZW50Cj4gPj4+
ICJzbmFwc2hvdF9hZ2dyZWdhdGUiLgo+ID4+Cj4gPj4gSWYgdGhpcyBpcyByZWx5aW5nIG9uIGEg
dXNlci1tb2RlIHByb2Nlc3MsIGlzIHRoZXJlIGEgY29uY2VybiB0aGF0IHRoZQo+ID4+IHByb2Nl
c3MgZG9lc24ndCBydW4uIE1pZ2h0IGl0IGJlIHNhZmVyIHRvIGhhdmUgdGhlIGtlcm5lbCB0cmln
Z2VyIHRoZQo+ID4+IHNuYXBzaG90Lgo+ID4+Cj4gPiBUaGUgVU0gcHJvY2VzcyBoZXJlIHdvdWxk
IGJlIHR5cGljYWxseSBhbiBhdHRlc3RhdGlvbiBjbGllbnQKPiA+IHdoaWNoIHBhc3NlcyBvbiB0
aGUgSU1BIGxvZyB0byB0aGUgcmVtb3RlIHNlcnZpY2UgZm9yIGF0dGVzdGF0aW9uLgo+ID4gSWYg
dGhlIHByb2Nlc3MgZG9lc24ndCBydW4sIHRoZSBjbGllbnQgd2lsbCBvcGVyYXRlIHRoZSBzYW1l
IHdheSBhcyBpdAo+ID4gZG9lcyBjdXJyZW50bHkuCj4KPiBJIHNlZS4KPgo+IDEuIEVuc3VyZSB0
aGF0IHRoZSBhdHRlc3RhdGlvbiBjbGllbnQgc3RvcmVzIHRoZSBzbmFwc2hvdCBpbiBhCj4gd2Vs
bC1rbm93biBhbmQgd2lkZWx5IHJlYWRhYmxlIGxvY2F0aW9uLiAgVGhlcmUgY2FuIGJlIG1vcmUg
dGhhbiBvbmUKPiBhdHRlc3RhdGlvbiBjbGllbnQsIGFuZCBhbGwgbmVlZCBhY2Nlc3MgdG8gdGhl
IHNuYXBzaG90LgoKQSBmZXcgcG9pbnRzOgoKKiBUaGVyZSBpcyBubyByZXF1aXJlbWVudCBmb3Ig
YW4gYWRtaW4gb3Igc29sdXRpb24gcHJvdmlkZXIgdG8gc3VwcG9ydApvciBvdGhlcndpc2UgdXNl
IHRoZSBJTUEgbWVhc3VyZW1lbnQgbG9nIHNuYXBzaG90dGluZyBmdW5jdGlvbmFsaXR5LApldmVu
IGlmIGVuYWJsZWQgaW4gdGhlIGtlcm5lbCBpdCBpcyBvcHQtaW4gYXQgcnVudGltZSAoaS5lLiBz
aW1wbHkKZG9uJ3QgdHJpZ2dlciB0aGUgc25hcHNob3QpLiAgSWYgdGhlIGRlcGxveW1lbnQgaW4g
cXVlc3Rpb24gaXMgdXNpbmcKYW4gYXR0ZXN0YXRpb24gc29sdXRpb24gd2hpY2ggaXMgbm90IGNv
bXBhdGlibGUgd2l0aCB0aGUgc25hcHNob3QKY29uY2VwdCB0aGVuIHRoZXJlIGlzIG5vIG5lZWQg
dG8gcGVyZm9ybSBhIHNuYXBzaG90LCB0aGUgc3lzdGVtIHdpbGwKYmVoYXZlIGp1c3QgYXMgaXQg
d291bGQgdG9kYXk7IG5vdGhpbmcgZ2FpbmVkLCBidXQgbm90aGluZyBsb3N0LgoKKiBPbmUgb2Yg
dGhlIGJlbmVmaXRzIG9mIGluaXRpYXRpbmcgdGhlIHNuYXBzaG90IGluIHVzZXJzcGFjZSBpcyB0
aGF0Cml0IGFmZm9yZHMgc29sdXRpb24gcHJvdmlkZXJzIGEgdHJlbWVuZG91cyBhbW91bnQgb2Yg
ZmxleGliaWxpdHkgd2l0aApyZXNwZWN0IHRvIGhvdyB0byBtYW5hZ2UgdGhlIElNQSBtZWFzdXJl
bWVudCBsb2cuICBOb3Qgb25seSBjYW4KZGlmZmVyZW50LCBhbmQgcG90ZW50aWFsbHkgbW9yZSBj
b21wbGV4LCBsb2dpYyBiZSB1c2VkIHRvIGRldGVybWluZQp0aGUgYXBwcm9wcmlhdGUgdGltZSB0
byB0cmlnZ2VyIHRoZSBzbmFwc2hvdCwgYnV0IHRoZSB0cmltbWVkL29sZCBsb2cKY2FuIGJlIHBy
b2Nlc3NlZCBhbnkgd2F5IHRoZSBhZG1pbiBzZWVzIGZpdDsgd3JpdGluZyBhbmQgc3VwcG9ydGlu
Zwp1c2Vyc3BhY2UgY29kZSBpcyBtYW55IG9yZGVycyBvZiBtYWduaXR1ZGUgZWFzaWVyIHRoYW4g
a2VybmVsIGNvZGUuCgo+IFRoZXJlIGlzIGEgcHJpdmFjeSBjb25jZXJuIGFyb3VuZCBtYWtpbmcg
dGhlIHNuYXBzaG90IHdvcmxkLXJlYWQuCgpTZWUgdGhlIGFib3ZlIHBvaW50cy4gIElmIHNlY3Vy
aXR5IHJlcXVpcmVtZW50cyBjYW4gbm90IGJlIHNhdGlzZmllZApieSBhbnkgb2YgdGhlIHZhcmlv
dXMgc29sdXRpb25zIGRlc2lnbmVkIHRvIHByb3RlY3QgdGhlIGludGVncml0eSBvZgpzeXN0ZW0g
Y29uZmlndXJhdGlvbiBhbmQgbG9nIGRhdGEsIHRoZSBzbmFwc2hvdHRpbmcgZnVuY3Rpb25hbGl0
eSBjYW4KYWx3YXlzIGJlIGJsb2NrZWQgYXQgcnVudGltZSBieSBhbm90aGVyIGNvbGxlY3Rpb24g
b2YgYWNjZXNzIGNvbnRyb2wKc29sdXRpb25zLgoKPiAyLiBJcyB0aGVyZSBhIGNvbmNlcm4gdGhh
dCwgaWYgdGhlIGNsaWVudCBkb2Vzbid0IHJ1biwgaXQgZG9lc24ndCBzb2x2ZQo+IHRoZSBrZXJu
ZWwgbWVtb3J5IGlzc3VlPwoKWWVzLCB0aGUgZGVzaWduIHJlbGllcyBvbiBhIHVzZXJzcGFjZSBw
cm9jZXNzIHRvIGluaXRpYXRlLCBhbmQKY29tcGxldGUgdGhlIHNuYXBzaG90dGluZyBwcm9jZXNz
LiAgVGhlIGdvb2QgbmV3cyBpcyB0aGF0IGlmIHRoZQp1c2Vyc3BhY2UgcHJvY2VzcyBmYWlscyB0
aGUgc3lzdGVtIGlzIG5vIHdvcnNlIG9mZiB0aGFuIGl0IGlzIHRvZGF5LApidXQgbW9kZXJuIGlu
aXQtc3lzdGVtcywgZS5nLiBzeXN0ZW1kLCBzaG91bGQgaGVscCBlbnN1cmUgdGhlCnJlbGlhYmls
aXR5IG9mIHRoZSB1c2Vyc3BhY2Ugc25hcHNob3QgcHJvY2Vzcy9kYWVtb24uCgo+IElzIHRoaXMg
cmVseWluZyBvbiBhIFVNIHByb2Nlc3MgdG8gc29sdmUgYSAga2VybmVsIGlzc3VlPwoKVGhlIHVs
dGltYXRlIHByb2JsZW0gaXMgdGhhdCB3ZSBoYXZlIGFuIHVuYm91bmRlZCBtZW1vcnkgYnVmZmVy
IHRoYXQKd2UgY2FuJ3QgZW5mb3JjZSBsaW1pdHMgb24gaW4gdGhlIHRyYWRpdGlvbmFsIHNlbnNl
LiAgVGhlIGRlc2lnbiBoZXJlCnByb3Bvc2VzIGEgY2hlY2twb2ludCBzeXN0ZW0gd2hpY2ggYWxs
b3dzIHVzIHRvIG1pdGlnYXRlIHRoZQp1bmNvbnRyb2xsZWQgZ3Jvd3RoIG9mIHRoaXMgYnVmZmVy
IHdoaWxlIHByZXNlcnZpbmcgdGhlIGFiaWxpdHkgdG8KcmVtb3RlbHkgYXR0ZXN0IHRoZSBzeXN0
ZW0gKGFsdGhvdWdoIHBlcmhhcHMgd2l0aCBkaWZmZXJlbnQsIG9yCm1vZGlmaWVkIGF0dGVzdGF0
aW9uIHRvb2xzKS4KCkkgaGF2ZSBub3Qgc2VlbiBhbnkgb3RoZXIgb3B0aW9ucyBmb3IgYSB2aWFi
bGUsIGtlcm5lbCBkcml2ZW4gc29sdXRpb24KaW4gYW55IG9mIHRoZSBkaXNjdXNzaW9ucyB0aHVz
IGZhciwgYnV0IGlmIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBJCnRoaW5rIHdlIHdvdWxkIGFs
bCBiZSB2ZXJ5IGludGVyZXN0ZWQgOikgIFRoZSB0bXBmcyBiYXNlZCBzb2x1dGlvbgpkb2Vzbid0
IHNvbHZlIHRoZSBwcm9ibGVtIG9mIHN5c3RlbS13aWRlIG1lbW9yeSBwcmVzc3VyZSBhcyB0bXBm
cyBpcwpzdGlsbCBhIG1lbW9yeS1iYWNrZWQgZmlsZXN5c3RlbS4gIFBhc3NpbmcgYSBmZCB0byB0
aGUga2VybmVsIGlzIHN0aWxsCmEgdXNlcnNwYWNlIGluaXRpYXRlZCBhY3Rpb24sIHdpdGggdGhl
IGFkZGVkIHByb2JsZW0gb2YgcmVxdWlyaW5nIHRoZQprZXJuZWwgZG8gdGhlIEkvTyBpdHNlbGYu
CgotLSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
