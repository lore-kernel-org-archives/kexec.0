Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D666CFD36B
	for <kexec@archiver.kernel.org>; Fri, 11 Oct 2024 12:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zt1zSump33EPxYTwXWMogSEJh1tjXlBEB1vdY7vAGJ4=; b=u/uljotS9armnT
	v7ta0y7F9kKI3MYEWmzZbMCCkfJETQgksN2WWEGvlHt+8e0+zfSo/YJpA8VS2sJhJEar7L3DnGwAv
	pLR/tUXKVDlDQqwte8DHN+RlXPmKwn4SlXSZaVWE8fy+plxRWpmnb4cF/wXDUJJ9CX/AZVco9UfH1
	OJURf7UuU4VEVUpepQrK1lqTvV3vyzKnh2FGe3Xgy0xNie5AgYD+YT+l8fu0NT/e0nljz5DC2BK5c
	0x3CIT/74pdAxbOSMcEmyZWrFxQtRe7JKp7Es/tyNgZOXBAuTtgT9aMjSPLEks3mwVKDxiGshCiMg
	NWMiAcCGXBoKE557jQWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szEZQ-0000000GGNA-1zLv;
	Fri, 11 Oct 2024 12:16:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szDbF-0000000G7UC-00qi
	for kexec@lists.infradead.org;
	Fri, 11 Oct 2024 11:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728645262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJJtEL6w+7VUR/VsKtaAgJCMix0WY7OT5w6s7RnNNO8=;
	b=fajL6im6rFWYTrVpSmtIfo0NI3KbBPpT1fz9oLa4rtofi2XYSRZA/nIL61OSuVLksYq141
	i6m+nyqmQC9AdlJ1AWGN/hEaOGxPhISFCjdtc4yRD7Zj4CS8wOLP4DHJpPQBEsLd3ILWAE
	Qg9BNERpX5wm7eYCVFo/iCL9UgB4H4Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-MGETEfIwNg6q7xDP-P54sg-1; Fri, 11 Oct 2024 07:14:19 -0400
X-MC-Unique: MGETEfIwNg6q7xDP-P54sg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe4dbeddaso35575356d6.3
        for <kexec@lists.infradead.org>; Fri, 11 Oct 2024 04:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728645259; x=1729250059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJJtEL6w+7VUR/VsKtaAgJCMix0WY7OT5w6s7RnNNO8=;
        b=pmvhVnvPjSKlbkthORYzXhv+ta2k5Yla6z8SyqHSXE4weh1nm+msYO++A1fo8l/VOS
         aOB/x3yxc6pk0bhz7eJY3rAoO3c8GA16wpSa8VOCTyDn8qS9GVw+chN1JZ1gs9uoA0Lr
         7lAoncf6byGbTgh+9Xsl1fGt5j9qge79+Rl25hlG0ByXSPxyxXZiPnmHbPbJQqkKufAk
         DCn88rXVRf4pV3jfmIRywoshST5l1mgn1NC145+aGguc+cb26YPcvf3gAtL4JhHvs0AO
         o0XqkjJ5OwLwKivXSnd7R/WU1JOX+E+0R8FAhHzGnAVwhDNPFNbn3leazXusTl6F3YIP
         4QYw==
X-Forwarded-Encrypted: i=1; AJvYcCVzeUZ4NhuTbjGvaxkV0RS+PqW14MsBht+GSR6IKXQYN2cvZwLbnAoIS+HB8L4VPNVnNaKx8A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7J2mM7FmUjJ/VojnYX3Rjge5GXs7bucqNpQKb64RHphbjmdQ0
	frTM0JFu/M5ppLiQmPmAib9vcCf9TRitmj3r1EPGfdTQTuJOYVvNr/pUbZbUOfWvvheB99xlbS4
	jI012P3I9WFhHcdP/YHniJAgosElNc1NxfrCP8ab3J2h6M/1kt8JfjFZLztzopmX0EZDXGbDnEw
	ZwteXjinXVHCcURIVT/cwgmMHJYVsnrnr0
X-Received: by 2002:a05:6214:5882:b0:6c4:6217:da9c with SMTP id 6a1803df08f44-6cbf004a571mr31936856d6.17.1728645259055;
        Fri, 11 Oct 2024 04:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX2sHsoz5TyjkZzuVrEcFWeFp2arw73z4CIk77l+R3+MUCt+i7/MetD8XW1bUIt5ArPEcSZqsc1VoKLCUzecA=
X-Received: by 2002:a05:6214:5882:b0:6c4:6217:da9c with SMTP id
 6a1803df08f44-6cbf004a571mr31936756d6.17.1728645258754; Fri, 11 Oct 2024
 04:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241008115408.21944-1-piliu@redhat.com> <20241008115408.21944-3-piliu@redhat.com>
 <20241011084406.GB66815@kernel.org>
In-Reply-To: <20241011084406.GB66815@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 11 Oct 2024 19:14:07 +0800
Message-ID: <CAF+s44QMLaQLmm6cst+o2Ssgi2v-SBXcw3hE1kKTFnL7DmoLFg@mail.gmail.com>
Subject: Re: [PATCH 2/3] kexec: Introduce UKI image parser
To: Simon Horman <horms@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Philipp Rudo <prudo@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_041425_134829_7026193B 
X-CRM114-Status: GOOD (  22.54  )
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

T24gRnJpLCBPY3QgMTEsIDIwMjQgYXQgNDo0NOKAr1BNIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBUdWUsIE9jdCAwOCwgMjAyNCBhdCAwNzo1NDowMlBNICsw
ODAwLCBQaW5nZmFuIExpdSB3cm90ZToKPiA+IEEgVUtJIGltYWdlIGlzIGEgUEUgZmlsZSB0aGF0
IGNvbnNpc3RzIG9mIHNldmVyYWwgc2VjdGlvbnMsIHR5cGljYWxseQo+ID4gaW5jbHVkaW5nOiAu
dGV4dCwgLmRhdGEsIC5saW51eCwgLmluaXRyZCwgLmNtZGxpbmUsIGFuZCBvdGhlcnMuCj4gPgo+
ID4gVGhlIGtlcm5lbCBpbWFnZSBpcyBzdG9yZWQgaW4gdGhlIC5saW51eCBzZWN0aW9uLCB3aGlj
aCBpcyBvbmUgb2YgdGhlCj4gPiBmb3JtYXRzIGN1cnJlbnRseSByZWNvZ25pemVkIGJ5IGtleGVj
LXRvb2xzLiBUaGVyZWZvcmUsIHRoZSBVS0kgcGFyc2VyCj4gPiBjYW4gYmUgdXNlZCB0byBzdHJp
cCBhd2F5IHRoZSBVS0kgbGF5ZXIsIGFsbG93aW5nIHRoZSBvdGhlciBwYXJzZXIgdG8KPiA+IHBy
b2Nlc3MgdGhlIGtlcm5lbCBpbWFnZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nZmFuIExp
dSA8cGlsaXVAcmVkaGF0LmNvbT4KPiA+IENjOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5v
cmc+Cj4gPiBDYzogRXJpYyBCaWVkZXJtYW4gPGViaWVkZXJtQHhtaXNzaW9uLmNvbT4KPiA+IENj
OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4KPiA+IENjOiBEYXZlIFlvdW5nIDxkeW91bmdA
cmVkaGF0LmNvbT4KPiA+IENjOiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCj4gPiAtLS0KPiA+
ICBpbmNsdWRlL3BlLmggICAgICB8IDEwNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKPiA+ICBrZXhlYy9NYWtlZmlsZSAgICB8ICAgMSArCj4gPiAga2V4ZWMva2V4ZWMt
dWtpLmMgfCAxMjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kwo+ID4gIGtleGVjL2tleGVjLmggICAgIHwgICA0ICsrCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAy
MzEgaW5zZXJ0aW9ucygrKQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3BlLmgKPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQga2V4ZWMva2V4ZWMtdWtpLmMKPgo+IEhpIFBpbmdmYW4gTGl1
LAo+Cj4gSSB0aGluayB5b3UgbmVlZCB0byBzcXVhc2ggdGhlIGZvbGxvd2luZyBpbnRvIHRoaXMg
cGF0Y2gKPiBzbyB0aGF0IHBlLmggaXMgaW5jbHVkZWQgaW4gZGlzdHJpYnV0aW9uIHRhcmJhbGxz
Lgo+Cj4gWW91IHNob3VsZCBiZSBhYmxlIHRvIHNlZSB0aGUgcHJvYmxlbSBieSBydW5uaW5nOiBt
YWtlIGRpc3RjaGVjay4KPgoKT2gsIHRoYW5rcy4gSSB3aWxsIGZpeCBpdCBpbiBWMiBhbmQgIHJl
bWVtYmVyIHRvIGRvIHN1Y2ggdGVzdHMgaW4gZnV0dXJlLgoKQmVzdCByZWdhcmRzLAoKUGluZ2Zh
bgoKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9NYWtlZmlsZSBiL2luY2x1ZGUvTWFrZWZpbGUKPiBp
bmRleCBjZDg4YTI2YjE0NzYuLjZhM2U4NTQxYzM2ZCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL01h
a2VmaWxlCj4gKysrIGIvaW5jbHVkZS9NYWtlZmlsZQo+IEBAIC04LDYgKzgsNyBAQCBkaXN0ICs9
IGluY2x1ZGUvTWFrZWZpbGUgICAgICAgICAgICAgICAgXAo+ICAgICAgICAgaW5jbHVkZS94ODYv
bWJfaGVhZGVyLmggICAgICAgICBcCj4gICAgICAgICBpbmNsdWRlL3g4Ni9tdWx0aWJvb3QyLmgg
ICAgICAgIFwKPiAgICAgICAgIGluY2x1ZGUvZWxmLmggICAgICAgICAgICAgICAgICAgXAo+ICsg
ICAgICAgaW5jbHVkZS9wZS5oICAgICAgICAgICAgICAgICAgICBcCj4gICAgICAgICBpbmNsdWRl
L2ltYWdlLmggICAgICAgICAgICAgICAgIFwKPiAgICAgICAgIGluY2x1ZGUvdW51c2VkLmggICAg
ICAgICAgICAgICAgXAo+ICAgICAgICAgaW5jbHVkZS9ib290L2xpbnV4Ymlvc190YWJsZXMuaCBc
Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
