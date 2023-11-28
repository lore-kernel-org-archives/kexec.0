Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8F4C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 02:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NpLcxUt72dhDvDKqDJpSshPk1PGQW/jWE6MPqOJxl7E=; b=0GhDXoPwzWT9MB
	hLzYmZ8n6ckqjqd3BAb8h5EoEU3wCBVEcBCrdZvpOVfEvwcwCJKtcVJ9M4F7lFTLEG6olxzLYNjeP
	cMQoifaZfv1gq22XBsqTzRasg4fW2BRiZhIeBJeZSJLfWWHDTv6HF44H+XsUKGtOv5E7gIAx6nu4m
	iN6e3g5QmvCcuwbx2sR1j9uDD7j9k0KzGdzFdy91aZWpCi4IwAcegB6P1JmZw04po6bZZt64IZ3gx
	lOTdZB4uHj7Z3lYG09xIYK4cvPS9FWF26mza1qycVNmXBqwonlFpRsVVMoV6wxuXA4d7fCeM7N6iA
	sFJkHiYD9TzKg6TiZpGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7nXF-003rE2-0e;
	Tue, 28 Nov 2023 02:09:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7nX8-003rDa-35
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 02:09:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701137344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26ylPeTUKwauoxaVi1z6xco5xaOkWba8wbcA5nPLGlY=;
	b=PxgK5e8p7fjcoHeiNp9/Z45/mdWTB7iglmwHMg179yvVtBT8P7KPyUkrQ1oywZQNwuNbVx
	W9mQbNVhrc8ldngck57JwSp+DhMdmelMw9VBjfwObNETUp3Myli3IrOw82nBmdx6kkSIeG
	toh61BgvNbkMlETPjtCQAitaGMIK1Gc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-e2UQn22RMUWSHmq2EChmgg-1; Mon, 27 Nov 2023 21:07:20 -0500
X-MC-Unique: e2UQn22RMUWSHmq2EChmgg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67a1d6648d9so42082586d6.3
        for <kexec@lists.infradead.org>; Mon, 27 Nov 2023 18:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701137239; x=1701742039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26ylPeTUKwauoxaVi1z6xco5xaOkWba8wbcA5nPLGlY=;
        b=cNdbtYLNHdTKGCwLtTKBnsoIBSW4DCjej5iXseZXkLlROEm/8dw0gQuWW2H7X4rIiW
         JKXzL1BuFWrdA+j8e79mGJqHpQZph+gU3jREw3Ac1ttSrHtS5np67WzFzxq1f0qRMrfw
         QQOG6WsD7yIH7oXzPb2/TNgIBONbN8eRbZMS18E0KxYsagSTb63Zi/LUbrCnkeSRaTsv
         yRZKjIBjMFrK6kvLEWdbNXiJg4RjO+JZN/9hmsArcOQYy7igOsQY8nMBt4txDXNWDxk+
         FK5mJJwrtd6nSL9ALWBt/1qIZFxJjFp/btqQXA+/PxsS1sZ8wOcwUFt1O9/oX4/pZXXP
         wWHg==
X-Gm-Message-State: AOJu0YzrVa8bvqg1iF1akQU27CzzAm/0MRwc0QUjnc0LfyaJRTsE+nKL
	XjQJK4piZx+7oR5bVVZSChLlVBe3DChZ4cJF+m3ejj8rQzWqO0R5IJwEr+hqdQfa0KhHFcg0gcP
	QwoezDQg+2dAsnJBI/xFf4x2W4tbJpJiVttm/
X-Received: by 2002:ad4:4582:0:b0:67a:2c28:ce06 with SMTP id x2-20020ad44582000000b0067a2c28ce06mr8365650qvu.63.1701137239590;
        Mon, 27 Nov 2023 18:07:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTw8IiCvQDQz/rDMw7LbIWJb2p+jcHMtz7+40WBg/SDRsyIbNd4vmRPgJFXJrHQVJWKiRODIA+xEo2TuwpTVs=
X-Received: by 2002:ad4:4582:0:b0:67a:2c28:ce06 with SMTP id
 x2-20020ad44582000000b0067a2c28ce06mr8365639qvu.63.1701137239401; Mon, 27 Nov
 2023 18:07:19 -0800 (PST)
MIME-Version: 1.0
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz> <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
In-Reply-To: <ZWJllXCN0SDIELrX@dwarf.suse.cz>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 28 Nov 2023 10:07:08 +0800
Message-ID: <CAF+s44QDMzSq3ihzRtaP9ZwF-drfAiQq713d9bastsJFiReJ4w@mail.gmail.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To: Jiri Bohac <jbohac@suse.cz>
Cc: Tao Liu <ltao@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.cz
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_180907_089270_0A190E5C 
X-CRM114-Status: GOOD (  22.25  )
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

T24gU3VuLCBOb3YgMjYsIDIwMjMgYXQgNToyNOKAr0FNIEppcmkgQm9oYWMgPGpib2hhY0BzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIFRhbywKPgo+IE9uIFNhdCwgTm92IDI1LCAyMDIzIGF0IDA5OjUx
OjU0QU0gKzA4MDAsIFRhbyBMaXUgd3JvdGU6Cj4gPiBUaGFua3MgZm9yIHRoZSBpZGVhIG9mIHVz
aW5nIENNQSBhcyBwYXJ0IG9mIG1lbW9yeSBmb3IgdGhlIDJuZCBrZXJuZWwuCj4gPiBIb3dldmVy
IEkgaGF2ZSBhIHF1ZXN0aW9uOgo+ID4KPiA+IFdoYXQgaWYgdGhlcmUgaXMgb24tZ29pbmcgRE1B
L1JETUEgYWNjZXNzIG9uIHRoZSBDTUEgcmFuZ2Ugd2hlbiAxc3QKPiA+IGtlcm5lbCBjcmFzaD8g
VGhlcmUgbWlnaHQgYmUgZGF0YSBjb3JydXB0aW9uIHdoZW4gMm5kIGtlcm5lbCBhbmQKPiA+IERN
QS9SRE1BIHdyaXRlIHRvIHRoZSBzYW1lIHBsYWNlLCBob3cgdG8gYWRkcmVzcyBzdWNoIGFuIGlz
c3VlPwo+Cj4gVGhlIGNyYXNoIGtlcm5lbCBDTUEgYXJlYShzKSByZWdpc3RlcmVkIHZpYQo+IGNt
YV9kZWNsYXJlX2NvbnRpZ3VvdXMoKSBhcmUgZGlzdGluY3QgZnJvbSB0aGUKPiBkbWFfY29udGln
dW91c19kZWZhdWx0X2FyZWEgb3IgZGV2aWNlLXNwZWNpZmljIENNQSBhcmVhcyB0aGF0Cj4gZG1h
X2FsbG9jX2NvbnRpZ3VvdXMoKSB3b3VsZCB1c2UgdG8gcmVzZXJ2ZSBtZW1vcnkgZm9yIERNQS4K
Pgo+IEtlcm5lbCBwYWdlcyB3aWxsIG5vdCBiZSBhbGxvY2F0ZWQgZnJvbSB0aGUgY3Jhc2gga2Vy
bmVsIENNQQo+IGFyZWEocyksIGJlY2F1c2UgdGhleSBhcmUgbm90IEdGUF9NT1ZBQkxFLiBUaGUg
Q01BIGFyZWEgd2lsbCBvbmx5Cj4gYmUgdXNlZCBmb3IgdXNlciBwYWdlcy4KPgo+IFVzZXIgcGFn
ZXMgZm9yIFJETUEsIHNob3VsZCBiZSBwaW5uZWQgd2l0aCBGT0xMX0xPTkdURVJNIGFuZCB0aGF0
Cj4gd291bGQgbWlncmF0ZSB0aGVtIGF3YXkgZnJvbSB0aGUgQ01BIGFyZWEuCj4KPiBCdXQgeW91
J3JlIHJpZ2h0IHRoYXQgRE1BIHRvIHVzZXIgcGFnZXMgcGlubmVkIHdpdGhvdXQKPiBGT0xMX0xP
TkdURVJNIHdvdWxkIHN0aWxsIGJlIHBvc3NpYmxlLiBXb3VsZCB0aGlzIGJlIGEgcHJvYmxlbSBp
bgo+IHByYWN0aWNlPyBEbyB5b3Ugc2VlIGFueSB3YXkgYXJvdW5kIGl0Pwo+CgpJIGhhdmUgbm90
IGEgcmVhbCBjYXNlIGluIG1pbmQuIEJ1dCB0aGlzIHByb2JsZW0gaGFzIGtlcHQgdXMgZnJvbQp1
c2luZyB0aGUgQ01BIGFyZWEgaW4ga2R1bXAgZm9yIHllYXJzLiAgTW9zdCBpbXBvcnRhbnRseSwg
dGhpcyBtZXRob2QKd2lsbCBpbnRyb2R1Y2UgYW4gdW5lYXN5IHRyYWNraW5nIGJ1Zy4KCkZvciBh
IHdheSBhcm91bmQsIG1heWJlIHlvdSBjYW4gaW50cm9kdWNlIGEgc3BlY2lmaWMgem9uZSwgYW5k
IGZvciBhbnkKR1VQLCBtaWdyYXRlIHRoZSBwYWdlcyBhd2F5LiBJIGhhdmUgZG91YnRzIGFib3V0
IHdoZXRoZXIgdGhpcyBhcHByb2FjaAppcyB3b3J0aHdoaWxlLCBjb25zaWRlcmluZyB0aGUgdHJh
ZGUtb2ZmIGJldHdlZW4gYmVuZWZpdHMgYW5kCmNvbXBsZXhpdHkuCgpUaGFua3MsCgpQaW5nZmFu
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
