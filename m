Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5269BC04A94
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ozwIw8DkKONtpkbu1rV0WvzN/h7z22CDsQj/C7D83FM=; b=LyM68UXe8v+8on
	P8YMGoBAJagT9p0Fx65aQbX97dW/eKepvts3CerhHtjmAml6kutMBaMAnieXm6fEuC7jWayXNgE8t
	Eb3n0QQcNYakjWUp8J+uSZYVr3tp/YakBU83aBl8JPNHvLzNcBs5MTVunNCU6mBTf+vdA79K3cyXo
	BBF5Q93uk9SfLHMFPYr4tULbs+5fOvBFuRUGvlP06VK5137T+rxHnj2KpBVd6mEm6ybOpZvyJ15SS
	TztTXazTlFUNWFaBiG4Y8MpP20NAbz9SmMvHfy8TdJ3EC7Ohfbbt4NsJsyaFDMHtMxSd/Bu2CKlZL
	ZYj80Nmg/8kfOT43/ECA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRTxs-00749n-1d;
	Thu, 03 Aug 2023 08:45:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRTxp-00748c-1S
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 08:45:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691052342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WTtwxEW9Hl3Gp8FLgTwQrit/9PDxNQU5Gp9J/hakRU=;
	b=Y+fslikFbKoLfOi76DMFrhvF7HaoROKeDEokTC1kz+mv8+Tn/f0sH0aniQ5XOGxQ2HmNZ4
	qK1ZyfdCLTeVzNNWhdX7wcI/0icXDs1/jSR2vwftOzBf82z1hPlmErwHFYE25JZOTgsgw2
	DMgoZCKm4Noq7a2x+vKTWwEH0KRODyw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-zx63jmx_Pny5s3jdaqgBpg-1; Thu, 03 Aug 2023 04:45:41 -0400
X-MC-Unique: zx63jmx_Pny5s3jdaqgBpg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-52227ea05a9so503234a12.1
        for <kexec@lists.infradead.org>; Thu, 03 Aug 2023 01:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052340; x=1691657140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WTtwxEW9Hl3Gp8FLgTwQrit/9PDxNQU5Gp9J/hakRU=;
        b=GaJ60lFOPgKpdF+/3BPWeY8E8JskpoFZjGZggS2TqIOmKdQ0mPFo1vDAXHOrMq4ter
         P/Cq/3g3wtHDv+Nv4Q1vYZ4DDNZZ5Z7L+YB2smf0KAeXOnh+LgNSQGib/8vLIj5J7QuF
         nWNuVBoiRh8I7Im8oissI49EH5R9f+eEmyloEo5bIkFWtMCQrnRxOu9iUyeLiSbJ5GcR
         7oj0FTVu5pAulDPpc8OalqtH9B3N6DRwbdBHBtqcVgzkC8ACP3xqtaTcJa6I+v/kqtmT
         fG/JylItDmdAsNkjVBfOkxRp+Uu6jxxz8Zrm46HhOmwbfBKX+col1t/AikQ8KBr/+wc3
         ae9A==
X-Gm-Message-State: ABy/qLYDCqg76R2xQ/A3a0RKPl6bcVkoeBSMEmhULCrV179nK6aZlGpp
	YkB2yE+7lTcaxcwISpn08EjuPz+6OT7MPUOOt/V1BixqZaCkwelcEkAP37sdpqESW6eZg6bfdHi
	IocbzSFGMTs3qWbxPCEYNXU8xWhRc1nNVTtW+VlJMrRFhkUQ=
X-Received: by 2002:a05:6402:8cc:b0:522:b86f:a22b with SMTP id d12-20020a05640208cc00b00522b86fa22bmr8253565edz.1.1691052340458;
        Thu, 03 Aug 2023 01:45:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHAjcAMDE6gra8l5ZZAW/6UOYK05QYubSQG3i/aSNHLiaaL17sRRjdSBS7YI4g4TJWlArNp+MzSk5AU/TLJRmI=
X-Received: by 2002:a05:6402:8cc:b0:522:b86f:a22b with SMTP id
 d12-20020a05640208cc00b00522b86fa22bmr8253549edz.1.1691052340222; Thu, 03 Aug
 2023 01:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230803023257.9260-1-ltao@redhat.com>
In-Reply-To: <20230803023257.9260-1-ltao@redhat.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 3 Aug 2023 16:45:04 +0800
Message-ID: <CAO7dBbV=D3N31L-VPS=2Vtreqc-4drKYHT1xWrKphT3J_G5Ndw@mail.gmail.com>
Subject: Re: [RFC][PATCH] iwlwifi: Add pci .shutdown() hook for iwlwifi driver
To: gregory.greenman@intel.com, kvalo@kernel.org, johannes.berg@intel.com, 
	mukesh.sisodiya@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_014545_582340_778BB6A1 
X-CRM114-Status: GOOD (  26.91  )
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

QWRkIGtleGVjIHRvIHRoZSBDQyBsaXN0IHNvIGtleGVjIHBlb3BsZSBjYW4ga25vdyB0aGlzLgoK
T24gVGh1LCBBdWcgMywgMjAyMyBhdCAxMDo1NeKAr0FNIFRhbyBMaXUgPGx0YW9AcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPiBQcmV2aW91c2x5IG5vIC5zaHV0ZG93bigpIGhvb2sgaXMgaW1wbGVtZW50
ZWQgZm9yIGl3bHdpZmkgZHJpdmVyLCBhCj4gRVRJTUVET1VUIGVycm9yIHdpbGwgb2NjdXIgZHVy
aW5nIHRoZSBrZXhlYyBrZXJuZWwgYm9vdHVwLiBBcyBhCj4gY29uc2VxdWVuY2UsIHdpZmkgaXMg
dW51c2FibGUgYWZ0ZXIga2V4ZWMgaW50byB0aGUgbmV3IGtlcm5lbC4KPgo+IFRoaXMgaXNzdWUg
aXMgb2JzZXJ2ZWQgYW5kIHBhdGNoIHRlc3RlZCBvbiB0aGUgZm9sbG93aW5nIHdpcmVsZXNzIGNh
cmRzOgo+Cj4gMSkgTmV0d29yayBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBDb21ldCBM
YWtlIFBDSC1MUCBDTlZpIFdpRmksCj4gICAgU3Vic3lzdGVtOiBJbnRlbCBDb3Jwb3JhdGlvbiBX
aS1GaSA2IEFYMjAxIDE2ME1Iego+IDIpIE5ldHdvcmsgY29udHJvbGxlcjogSW50ZWwgQ29ycG9y
YXRpb24gV2lyZWxlc3MtQUMgOTI2MCwKPiAgICBTdWJzeXN0ZW06IEludGVsIENvcnBvcmF0aW9u
IERldmljZSBlMDE0Cj4KPiBTaWduZWQtb2ZmLWJ5OiBUYW8gTGl1IDxsdGFvQHJlZGhhdC5jb20+
Cj4gLS0tCj4KPiBIaSBmb2xrcywKPgo+IFRoaXMgaXMgYSBSRkMgcGF0Y2ggYW5kIEknbSBub3Qg
c3VyZSBhYm91dCB0aGUgY29ycmVjdG5lc3Mgb2YgdGhlIGNvZGUsCj4gZXNwZWNpYWxseSBhYm91
dCB0aGUgcGNpX2NsZWFyX21hc3RlcigpIHBhcnQuIFdoYXQgSSB3YW50IGlzIHRvIHN0b3AgYW55
Cj4gb25nb2luZyBETUEgYWNjZXNzLCBpbiBjYXNlIGlmIHRoZSBtZW1vcnkgb3ZlcndyaXR0aW5n
IGR1cmluZyBrZXhlYwo+IGtlcm5lbCBib290dXAuIEJ1dCB0aGVyZSBpcyBhbHJlYWR5IHBjaV9j
bGVhcl9tYXN0ZXIocGNpX2RldikgaW4KPiBkcml2ZXJzL3BjaS9wY2ktZHJpdmVyLmM6cGNpX2Rl
dmljZV9zaHV0ZG93bigpLCBzbyBJJ20gbm90IHN1cmUgaWYgaXQgaXMKPiBzdGlsbCBuZWVkZWQg
aW4gdGhlIGRyaXZlciBzaWRlLiBBbmQgSSBvbmx5IHRlc3RlZCB0aGUgcGF0Y2ggYWdhaW5zdCB0
aGUKPiBhYm92ZSAyIHdpcmVsZXNzIGNhcmRzIGFuZCB3b3JrZWQgT0ssIG5vdCBzdXJlIGlmIGl0
IGNhbiB3b3JrIGZvciBvdGhlcnMuCj4gUGxlYXNlIHJldmlldyB0aGUgcGF0Y2gsIHRoYW5rcyBp
biBhZHZhbmNlIQo+Cj4gVGhhbmtzLAo+IFRhbyBMaXUKPgo+IC0tLQo+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMgfCAxMyArKysrKysrKysrKysrCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jCj4gaW5kZXggNzNjMWZiM2MwYzVlLi4yNGM0YzJk
ZDdjYjAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9w
Y2llL2Rydi5jCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2ll
L2Rydi5jCj4gQEAgLTE1MTMsNiArMTUxMywxOCBAQCBzdGF0aWMgdm9pZCBpd2xfcGNpX3JlbW92
ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKPiAgICAgICAgIGl3bF90cmFuc19wY2llX2ZyZWUodHJh
bnMpOwo+ICB9Cj4KPiArc3RhdGljIHZvaWQgaXdsX3BjaV9zaHV0ZG93bihzdHJ1Y3QgcGNpX2Rl
diAqcGRldikKPiArewo+ICsgICAgICAgc3RydWN0IGl3bF90cmFucyAqdHJhbnMgPSBwY2lfZ2V0
X2RydmRhdGEocGRldik7Cj4gKwo+ICsgICAgICAgaWYgKCF0cmFucykKPiArICAgICAgICAgICAg
ICAgcmV0dXJuOwo+ICsKPiArICAgICAgIGl3bF9kcnZfc3RvcCh0cmFucy0+ZHJ2KTsKPiArCj4g
KyAgICAgICBwY2lfY2xlYXJfbWFzdGVyKHBkZXYpOwo+ICt9Cj4gKwo+ICAjaWZkZWYgQ09ORklH
X1BNX1NMRUVQCj4KPiAgc3RhdGljIGludCBpd2xfcGNpX3N1c3BlbmQoc3RydWN0IGRldmljZSAq
ZGV2aWNlKQo+IEBAIC0xNTgzLDYgKzE1OTUsNyBAQCBzdGF0aWMgc3RydWN0IHBjaV9kcml2ZXIg
aXdsX3BjaV9kcml2ZXIgPSB7Cj4gICAgICAgICAuaWRfdGFibGUgPSBpd2xfaHdfY2FyZF9pZHMs
Cj4gICAgICAgICAucHJvYmUgPSBpd2xfcGNpX3Byb2JlLAo+ICAgICAgICAgLnJlbW92ZSA9IGl3
bF9wY2lfcmVtb3ZlLAo+ICsgICAgICAgLnNodXRkb3duID0gaXdsX3BjaV9zaHV0ZG93biwKPiAg
ICAgICAgIC5kcml2ZXIucG0gPSBJV0xfUE1fT1BTLAo+ICB9Owo+Cj4gLS0KPiAyLjQwLjEKPgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
