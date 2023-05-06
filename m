Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6AFC77B7C
	for <kexec@archiver.kernel.org>; Sat,  6 May 2023 03:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5rf5syGKdD/u1ttng4YeMOFzzqA3l9akqEJCcd2h2Fg=; b=00JV/pawyerYZ8
	GTt+S+nBW70alSdsXpEBpQNXwE/H+6eE6WT24GwrCcKef0nJOgNxqIvbtPwS7fycvYmaNbQCVniH6
	KrrWHEVt/e27n3LN7nr3a0HlewCdn9L+U3DkQvBPwXUoO4qZGJ5EpkCUf99SniqGMtsGaZCNb0omj
	WtzMrTxAOzh4wYwjoAzhDU+OojyK1YrgRHSEmBu4ERQixwHWsaMwe1IR+nc1kqNHqQl1LPmqqQrky
	O3CUpEypkZJEK70lqqF3/jHGu3Mx8RKYGCpQmli+164PZuI2nXy5r0pE2tuGZGJVpBknLe2K/JePp
	8YaeKiDsrgwvvF96/HMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8LV-00CQFH-2C;
	Sat, 06 May 2023 03:12:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8LT-00CQER-0M
	for kexec@lists.infradead.org;
	Sat, 06 May 2023 03:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683342739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3suRSd3KZ0KYwGkutYe2ERCD4Ik1ZTfbHtjY/Y/oU4=;
	b=iDt6llKiLsfaXI6/axqmBCekCEtRH/eNitfiHenNqqWLPOtOoSMG0S991rHkxmljNaHNFO
	T/XomZk4gZRHnROkw8BNVPDCaDyAnNvbqeKfRfdnoccBxViynWrLFaIhAlMHz1ieqwMHQd
	jvR9Ghp47rnUoaVjKP/EZcgPuH1uRSU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-BaGhF6qTNO-uQduVCtULog-1; Fri, 05 May 2023 23:12:17 -0400
X-MC-Unique: BaGhF6qTNO-uQduVCtULog-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-61b5907e04aso13083756d6.0
        for <kexec@lists.infradead.org>; Fri, 05 May 2023 20:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683342737; x=1685934737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3suRSd3KZ0KYwGkutYe2ERCD4Ik1ZTfbHtjY/Y/oU4=;
        b=AvxxKehF3mgdX3OwcNk93YKrgruyzTiU77OUJgfcoDqB9iSDjprbeoeuYJBDn+kSg8
         aKZ2ttFeIzpbSyUdBq9wLDAJBhomTFwdf5H869EmWxlIlLkYJ+foeYUQhzztb3mq89ip
         sX2MWYq0n9kJ6KHkXryZJi1hClIIeKd7bKu6UU/bAAGMos7ySG+hj0XErNhI6swKee60
         VDBdn9xkHpJdazHtQagB9r7B1cVsRiZfgtyMrSTDIqnZKiMFfX7gVq+1wIFqiBOsrzFL
         8urwyFw1Q0FMutwzk1x0A9zQ9K7JZb8cNfXlNBiI237gihkePZZjVV0wqI32HJZhlipE
         uXUg==
X-Gm-Message-State: AC+VfDwkA+kz3wRrbCuq6OM8S8fpc/vYpzoRVd5wHhgMP9v9Yp4fKV9y
	az3a1MnAhceWoNuDalNvgbTb3HQSIC5DXtJ15JIeqKVBHPSrYzdNIzGvds0+8F5hxqwaS65DcO/
	8n21ei5byunwen9V1BYDmciWmVDss9uWKNxqe
X-Received: by 2002:a05:6214:528b:b0:5ef:50a3:f9ca with SMTP id kj11-20020a056214528b00b005ef50a3f9camr4493515qvb.47.1683342737368;
        Fri, 05 May 2023 20:12:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XAr0ORhwaAfJYJaMJt8qeyA56bF0Jf++pvUxpevtSlOTkxCp2l4e8mMLXr0eeyVBrHjoqWt4Zgw2gK1mxhdw=
X-Received: by 2002:a05:6214:528b:b0:5ef:50a3:f9ca with SMTP id
 kj11-20020a056214528b00b005ef50a3f9camr4493505qvb.47.1683342737101; Fri, 05
 May 2023 20:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230505025438.11943-1-piliu@redhat.com> <cd7dfc7c-9108-f55e-d2e2-2b8b1856ecb2@arm.com>
In-Reply-To: <cd7dfc7c-9108-f55e-d2e2-2b8b1856ecb2@arm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Sat, 6 May 2023 11:12:06 +0800
Message-ID: <CAF+s44RjbROPO5j7jZUp-2s2Sg7VZAUGNg3baRwpPueM87DwxA@mail.gmail.com>
Subject: Re: [PATCH 0/5] arm64: zboot support
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_201227_245649_97CDD147 
X-CRM114-Status: GOOD (  30.19  )
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

T24gU2F0LCBNYXkgNiwgMjAyMyBhdCA2OjM44oCvQU0gSmVyZW15IExpbnRvbiA8amVyZW15Lmxp
bnRvbkBhcm0uY29tPiB3cm90ZToKPgo+IE9uIDUvNC8yMyAyMTo1NCwgUGluZ2ZhbiBMaXUgd3Jv
dGU6Cj4gPiBBcyBtb3JlIGNvbXBsaWNhdGVkIGNhcHN1bGUga2VybmVsIGZvcm1hdCBvY2N1cnMg
bGlrZSB6Ym9vdCwgd2hlcmUgdGhlCj4gPiBjb21wcmVzc2VkIGtlcm5lbCBpcyBzdG9yZWQgYXMg
YSBwYXlsb2FkLiBUaGUgc3RyYWlnaHQgZm9yd2FyZAo+ID4gZGVjb21wcmVzc2lvbiBjYW4gbm90
IG1lZXQgdGhlIGRlbWFuZC4KPiA+Cj4gPiBBcyB0aGUgZmlyc3Qgc3RlcCwgb24gYWFyY2g2NCwg
cmVhZGluZyBpbiB0aGUga2VybmVsIGZpbGUgaW4gYSBwcm9iZQo+ID4gbWV0aG9kIGFuZCBkZWNp
ZGUgaG93IHRvIHVuZm9sZCB0aGUgY29udGVudCBieSB0aGUgbWV0aG9kIGl0c2VsZi4KPiA+Cj4g
PiBUaGUgbmV3IGRlc2lnbmVkIHByb2JlIGludGVyZmFjZSByZXR1cm5zIHR3byBmYWN0b3JzOgo+
ID4gMS4gdGhlIHBhcnNlZCBrZXJuZWxfYnVmIHNob3VsZCBiZSByZXR1cm5lZCBzbyB0aGF0IGl0
IGNhbiBiZSB1c2VkIGJ5Cj4gPiB0aGUgaW1hZ2UgbG9hZCBtZXRob2QgbGF0ZXIuCj4gPiAyLiB0
aGUgZmluYWwgZmQgcGFzc2VkIHRvIHN5c19rZXhlY19maWxlX2xvYWQsIHNpbmNlIGFhcmNoNjQg
a2VybmVsIGNhbgo+ID4gb25seSB3b3JrIHdpdGggSW1hZ2UgZm9ybWF0LCB0aGUgb3V0ZXIgcGF5
bG9hZCBzaG91bGQgYmUgc3RyaXBwZWQgYW5kIGEKPiA+IHRlbXBvcmFyeSBmaWxlIG9mIEltYWdl
IHNob3VsZCBiZSBjcmVhdGVkLgo+ID4KPgo+IFdlbGwgdGhpcyBpcyB1bmZvcnR1bmF0ZS4gSSBw
aW5nZWQgeW91IGEgZmV3IGRheXMgYmFjayBidXQgSSBndWVzcyBpdAo+IG11c3QgaGF2ZSBnb3R0
ZW4gbG9zdCBpbiB0aGUgbm9pc2UuCj4KClNvcnJ5IGZvciB0aGF0LgoKPiBJJ20gb2sgd2l0aCBk
cm9wcGluZyBteSBzZXQsIGJ1dCBJIGRvbid0IHNlZSB5b3VyIDUvNSwgYW5kIGl0IGRvZXNuJ3QK
PiBzaG93IHVwIGluIHRoZSBhcmNoaXZlIGVpdGhlci4gV2hpY2ggcHJlc3VtYWJseSBpcyB0aGUg
Y29yZSBaQk9PVAo+IGZ1bmN0aW9uYWxpdHkuIEZyb20gd2hhdCBJIGNhbiB0ZWxsIHdpdGhvdXQg
dGhhdCwgdGhpcyBzZXQgdGhlbiBpcyBhbGwKPiBqdXN0IGNsZWFudXAuIFNvIGRpZCB5b3UgZG8g
dGhhdCBvbiBwdXJwb3NlLCBpZiBzbyBtYXliZSBpdHMgYmVzdCB0aGVuCj4gdG8ganVzdCByZWJh
c2Ugb24gdG9wIG9mIG15IHNldD8KPgoKSSBmb3Jnb3QgdG8gYWRkIHRoZSBDQyBpbiB0aGF0IHBh
dGNoLCBhbmQgaXQgdHVybnMgb3V0IHRvIGJlIHNlbnQgdG8KbXlzZWxmIG9ubHkuIEkgaGF2ZSBy
ZS1zZW50IGl0LgoKSSBhbSBoYXBweSB0byByZWJhc2Ugb24geW91ciBzZXQgd2l0aCBzb21lIGFk
YXB0YXRpb24gdG8gdGhlIG5ldyBwcm9iZQppbnRlcmZhY2UuCgo+Cj4gR2l2ZW4gSSdtIG5vdCBh
IHJlZ3VsYXIgY29udHJpYnV0b3IgaGVyZSBJJ20gbm90IHN1cmUgbXkgb3BpbmlvbiBtYXR0ZXJz
Cj4gbXVjaCwgYnV0IG9uZSBvZiB0aGUgdGhpbmdzIHRoYXQgYm90aGVyZWQgbWUgd2hlbiBJIHdh
cyB5YWsgc2hhdmluZyBteQo+IHNldCwgd2VyZSB0aGUgI2lmZGVmIGFhcmNoNjQgYml0cyBpbiB0
aGUgY29tbW9uIGNvZGUuIEkgY29uc2lkZXJlZAo+IGF0dGVtcHRpbmcgdG8gcmVtb3ZlIGl0IGJ1
dCB0aGF0IHdhcyBhIGJpdCBtb3JlIGludm9sdmVkIHRoYW4gSSB3YW50ZWQKPiB0byBnZXQuIEJ1
dCwgYXMgQXJkIGNvcnJlY3RseSBwb2ludHMgb3V0LCB0aGUgemJvb3QgaXMgYmVpbmcgdXNlZCBi
eQo+IG1vcmUgdGhhbiBhYXJjaDY0IGF0IHRoaXMgcG9pbnQuIFNvIHRoYXQgaXMgYWxzbyBhIGFy
Z3VtZW50IGZvciBhc3N1cmluZwo+IHdoYXRldmVyIHRoZSBwcm9iZSgpL2V0YyBpbnRlcmZhY2Ug
aXMsIHRoYXQgaXRzIG5vdCAjaWZkZWZlZC4KPgoKWWVzLCBpdCBtYWtlcyBjb2RlIGxvb2sgbm90
IG5lYXQuIEkgaGF2ZSB0cmllZCB0byB0YWNrbGUgaXQgd2l0aCBzZWQsCmJ1dCBmYWlsZWQuIEkg
d2lsbCB0cnkgdG8gYWNoaWV2ZSBpdCB3aXRoIGNvY2NpbmVsbGUuCgpUaGFua3MsCgpQaW5nZmFu
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
