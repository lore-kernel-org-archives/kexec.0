Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C25C41535
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 05:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eIWigW4Uc4Q4ZZMpQzvxUTljcGWEVw1nlmzYteyOhHo=; b=CqxMV6RkgQjTh6
	TBQUXgMl0H+bDqB3R7ibAX8wHVpVQX3x9HGcxjiIbOFwdp4VzyuDdK/WkQztuvINc0xObtRC4vcqs
	BtgfKpJY3CfJy3kUX/3Jw3CSyDPKgFojjUSxMoUQ54o/Vy1omGK2H0fg5PZ+67+k9LXxXCMvKJXVu
	m7njGUYEL5FxEOMtlBv5ip575IrEipz8vejCpnt5nQFwRhhuxMFTzxXWPcflVJOnxDAfkJ7w/c92i
	RccMFwrWRddH6ICex9ifMaOfDEuTkzTNLPk1D/+FsTvgfaaJTlwiNzucV7qb5M4TSwcfQ18f6lOPN
	pUMltNS1ALr7t+cRArjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSgA-00Ctx6-1H;
	Tue, 19 Dec 2023 05:30:06 +0000
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSg7-00Ctwm-1l
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 05:30:05 +0000
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-593ea4c2baaso87381eaf.3
        for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 21:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702963802; x=1703568602; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KSDKlkaKqJ/0klbby4oepQ0g/PTqlT6o7kLyfpy1io=;
        b=h0IfOrOIWXzXJ5a8H/rxqSd9dQXkOlEdnPi2QuMcVUeXCRnwj7tn7qjMKvx4AWAs+D
         q/poMAIoGwE23MNLLU7/AkRJmKh/GFJiho9MZNXExoscRSl9M+IadZfx1p8lT7IupSp+
         9IS571trBkeOWVLPcT/rO3iu4N60k/+JiMNu+KZ4sJAx1QHxeNuTx0uM0cqZrIkZoCXX
         d7LWFGy1CrqtUuUU1bSlUufbaOhF4Gq19V5uXQGnNv3cD41w6PgTMhzwFhlNW6FHDB5+
         S/zdNtwN3ruqoi9es5QXdOd3ee7Z/yFfRciWeGsnIn7Sq8M4IcCpfrqtzFFdQGqFlJbm
         GQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702963802; x=1703568602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KSDKlkaKqJ/0klbby4oepQ0g/PTqlT6o7kLyfpy1io=;
        b=kNO0LOrZ6fYS9lHWUNpWabWz7N58vdgReZiSHaHtKPsxfaIpAYOxHNV/KB95MTucrF
         XoG7Xn8WrPJADALWWyUBkFo2ODNXhtCNEC1vsFJxgQ6YXWU/OARr0GDhXSR0IPZZSVJj
         LUrqcmBAG56voR98gmoC6Sfyb+3bQbt5ZtJJy3NYv6T4n425LmG913ajuOoIproyjx7L
         XtVa+Ixen1RxDM5YWd6k8kT4uGscF2E7/7RlPuc312DPObpjUK8RfC6VgImECxGFhIL/
         opikpHblSWspvtfczs05itpEJhApEt2KVkI46YPZKfg8mB+pYa222fiOB9WNjFjUP8o7
         RstA==
X-Gm-Message-State: AOJu0YzDOzO7uZV+Mp5xMkMJxVY9By/nP8H8TVBxf6mH7scJo7+Qi8br
	yTIuq8V4pt1iZIXRC9Y+ktY=
X-Google-Smtp-Source: AGHT+IGEThJt6CiGC764R0tEHsIGvawOxueOl2KAAAtuymZ2zRABXJEYv1oewzC0AqOEt2NXdSCojQ==
X-Received: by 2002:a05:6358:248b:b0:170:6ed7:3148 with SMTP id m11-20020a056358248b00b001706ed73148mr12035927rwc.22.1702963802200;
        Mon, 18 Dec 2023 21:30:02 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a195100b0028b1fce7c01sm568132pjh.37.2023.12.18.21.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 21:30:01 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: fuqiang.wang@easystack.cn
Cc: bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vgoyal@redhat.com,
	ytcoode@gmail.com
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 13:29:29 +0800
Message-ID: <20231219052955.40414-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c797bdde-b5a5-4b2b-9106-c1386a0e7516@easystack.cn>
References: <c797bdde-b5a5-4b2b-9106-c1386a0e7516@easystack.cn>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_213003_589146_B45EA3C6 
X-CRM114-Status: GOOD (  29.56  )
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

T24gVHVlLCAxOSBEZWMgMjAyMyAxMTo1MDozMiArMDgwMCwgZnVxaWFuZyB3YW5nIDxmdXFpYW5n
LndhbmdAZWFzeXN0YWNrLmNuPiB3cm90ZToKPiDlnKggMjAyMy8xMi8xOSAxMDo0NywgWXVudGFv
IFdhbmcg5YaZ6YGTOgo+IAo+ID4gSGkgZnVxaWFuZywKPiA+Cj4gPiBZZXN0ZXJkYXksIEkgcG9z
dGVkIHR3byBwYXRjaGVzIHRoYXQgaGFwcGVuIHRvIGFkZHJlc3MgdGhlIGJ1Z3MgeW91IGFuIEJh
b3F1YW4KPiA+IGFyZSBjdXJyZW50bHkgZGlzY3Vzc2luZyBoZXJlLCBJIHdhc24ndCBhd2FyZSB0
aGF0IHlvdSBib3RoIHdlcmUgYWxzbyB3b3JraW5nCj4gPiBvbiBmaXhpbmcgdGhlc2UgaXNzdWVz
Lgo+ID4KPiA+IEJhb3F1YW4gc3VnZ2VzdGVkIEkgdGFsayB0byB5b3UgYWJvdXQgaXQuCj4gPgo+
ID4gSWYgeW91J3JlIGludGVyZXN0ZWQsIHlvdSBjYW4gdGFrZSBhIGxvb2sgYXQgbXkgcGF0Y2hl
cyBhbmQgcmV2aWV3IHRoZW0gdG8gc2VlCj4gPiBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4gSWYg
ZXZlcnl0aGluZyBpcyBmaW5lLCBhbmQgaWYgeW91J3JlIHdpbGxpbmcsIHlvdSBjYW4KPiA+IGFs
c28gYWRkIGEgJ1Jldmlld2VkLWJ5JyB0YWcgdGhlcmUuCj4gPgo+ID4gVGhlIGZvbGxvd2luZyBs
aW5rIGlzIGZvciB0aGUgdHdvIHBhdGNoZXMgSSBwb3N0ZWQgeWVzdGVyZGF5Ogo+ID4KPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzEyMTgwODE5MTUuMjQxMjAtMy15dGNvb2Rl
QGdtYWlsLmNvbS90LyN1Cj4gPgo+ID4gU2luY2VyZWx5LAo+ID4gWXVudGFvCj4gCj4gSGkgWXVu
dGFvLAo+IAo+IEknbSBnbGFkIHlvdSd2ZSBhbHNvIG5vdGljZWQgdGhpcyBpc3N1ZS4gQnV0IEkn
bSBzb3JyeSwgSSB3YW50IHRvIHNvbHZlIHRoaXMKPiBwcm9ibGVtIG15c2VsZiBiZWNhdXNlIHRo
aXMgaXMgbXkgZmlyc3QgdGltZSBwb3N0aW5nIGEgcGF0Y2ggaW4gdGhlIGNvbW11bml0eSwKPiBh
bmQgSSBjaGVyaXNoIHRoaXMgb3Bwb3J0dW5pdHkgdmVyeSBtdWNoLgoKSSBjYW4gdHJ1bHkgdW5k
ZXJzdGFuZCB5b3VyIGZlZWxpbmdzIGJlY2F1c2UgSSBzdGlsbCByZW1lbWJlciBob3cgdGhyaWxs
ZWQgSQp3YXMgd2hlbiBteSBmaXJzdCBwYXRjaCBnb3QgbWVyZ2VkLiBTbyBrZWVwIGl0IHVwIQoK
PiAKPiBJIGhhdmUgY2FyZWZ1bGx5IHJldmlld2VkIHlvdXIgcGF0Y2guIFRoZXJlIGlzIHNvbWUg
Y2hhbmdlcyB3aGVyZSBteSB2aWV3cyBkaWZmZXIKPiBmcm9tIHlvdXJzOgo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYyBiL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCj4gaW5k
ZXggYzkyZDg4NjgwZGJmLi4zYmU0NmY0YjQ0MWUgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYva2Vy
bmVsL2NyYXNoLmMKPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYwo+IEBAIC0yODIsMTAg
KzI4Miw2IEBAIGludCBjcmFzaF9zZXR1cF9tZW1tYXBfZW50cmllcyhzdHJ1Y3Qga2ltYWdlICpp
bWFnZSwgc3RydWN0IGJvb3RfcGFyYW1zICpwYXJhbXMpCj4gICAgICAgc3RydWN0IGNyYXNoX21l
bW1hcF9kYXRhIGNtZDsKPiAgICAgICBzdHJ1Y3QgY3Jhc2hfbWVtICpjbWVtOwo+IAo+IC0gICAg
Y21lbSA9IHZ6YWxsb2Moc3RydWN0X3NpemUoY21lbSwgcmFuZ2VzLCAxKSk7Cj4gLSAgICBpZiAo
IWNtZW0pCj4gLSAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4gLQo+ICAgICAgIG1lbXNldCgmY21k
LCAwLCBzaXplb2Yoc3RydWN0IGNyYXNoX21lbW1hcF9kYXRhKSk7Cj4gICAgICAgY21kLnBhcmFt
cyA9IHBhcmFtczsKPiAKPiBAQCAtMzIxLDYgKzMxNywxMSBAQCBpbnQgY3Jhc2hfc2V0dXBfbWVt
bWFwX2VudHJpZXMoc3RydWN0IGtpbWFnZSAqaW1hZ2UsIHN0cnVjdCBib290X3BhcmFtcyAqcGFy
YW1zKQo+ICAgICAgIH0KPiAKPiAgICAgICAvKiBFeGNsdWRlIHNvbWUgcmFuZ2VzIGZyb20gY3Jh
c2hrX3JlcyBhbmQgYWRkIHJlc3QgdG8gbWVtbWFwICovCj4gKyAgICBjbWVtID0gdnphbGxvYyhz
dHJ1Y3Rfc2l6ZShjbWVtLCByYW5nZXMsIDEpKTsKPiArICAgIGlmICghY21lbSkKPiArICAgICAg
ICByZXR1cm4gLUVOT01FTTsKPiArICAgIGNtZW0tPm1heF9ucl9yYW5nZXMgPSAxOwo+ICsKPiAg
ICAgICByZXQgPSBtZW1tYXBfZXhjbHVkZV9yYW5nZXMoaW1hZ2UsIGNtZW0sIGNyYXNoa19yZXMu
c3RhcnQsIGNyYXNoa19yZXMuZW5kKTsKPiAgICAgICBpZiAocmV0KQo+ICAgICAgICAgICBnb3Rv
IG91dDsKPiAKPiAxLiBJIGRvbid0IGZlZWwgdmVyeSBnb29kIHRoYXQgeW91IGhhdmUgbW92ZWQg
dnphbGxvYygpIHRvIGluIGZyb250IG9mCj4gbWVtbWFwX2V4Y2x1ZGVfcmFuZ2VzLiBCZWNhdXNl
IGlmIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWxzLCB0aGVyZSBpcyBubyBuZWVkIHRvCj4gZG8gYW55
dGhpbmcgZWxzZSBhZnRlcndhcmRzLgoKSSBtb3ZlZCBpdCBoZXJlIGJlY2F1c2Ugb25seSBtZW1t
YXBfZXhjbHVkZV9yYW5nZXMoKSBhbmQgdGhlIGNvZGUgYmVsb3cgaXQgdXNlIGNtZW0uCgpJIHRo
aW5rIGl0IGlzIGEgZ29vZCBwcmFjdGljZSB0byBwdXQgcmVsYXRlZCBjb2RlIHRvZ2V0aGVyLCB3
aGljaCBhbHNvIGltcHJvdmVzCmNvZGUgcmVhZGFiaWxpdHkuCgo+IAo+IDIuIFRoZSBjbWVtLT5t
YXhfbnJfcmFuZ2VzIHNob3VsZCBiZSBzZXQgdG8gMi4gQmVjYXVzZSBpbgo+IG1lbW1hcF9leGNs
dWRlX3JhbmdlcywgYSBjbWVtLT5yYW5nZXNbXSB3aWxsIGJlIGZpbGxlZCBpbiBhbmQgaWYgYSBz
cGxpdCBvY2N1cnMKPiBsYXRlciwgYW5vdGhlciBvbmUgd2lsbCBiZSBhZGRlZC4KCldpdGggdGhl
IGN1cnJlbnQgY29kZSwgaW1hZ2UtPmVsZl9sb2FkX2FkZHIgc2hvdWxkIGJlIGVxdWFsIHRvIGNy
YXNoa19yZXMuc3RhcnQsCnNvIHNwbGl0IHdpbGwgbm90IG9jY3VyIGluIGNyYXNoX2V4Y2x1ZGVf
bWVtX3JhbmdlKCkuIFRoZXJlZm9yZSwgc2V0dGluZwpjbWVtLT5tYXhfbnJfcmFuZ2VzIHRvIDEg
aXMgc2FmZS4KCj4gCj4gVGhhbmtzCj4gZnVxaWFuZwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
