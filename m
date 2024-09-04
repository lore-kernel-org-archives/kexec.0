Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDC0CD37B6
	for <kexec@archiver.kernel.org>; Wed,  4 Sep 2024 22:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QVOrV6MZxiOCZTMS0kxsLReHcgn33GpIhfSbwlGJOOc=; b=kQhRmTmuE5Lr3kC+jW+UKoxrua
	jxvCKDuRNsw4cAEyOHE6iCXa9NWkypRrGhAcxze7T4S7bZRpbhHsWtrNuEGOdSHekfCeaFeF2JCSz
	AT7Xm9zUa2Z/7JnPruWsSNn8mIJaJsVXVh0ygxDv/7MbisPHbFar5bUJ0P8QlhOwaH3e/O+OzZvaO
	Q7CiaEqwTax2RJbarox/wXG10F8lE2Kg7d1/ZmsJD7Ny6l7EnUOVnvEUKqfuTVp2DWnurZawXvBEN
	tbCtG40tQ5NjL9Li3W2sxVx0WiSlyRY39R/7JoybFwbO1JA4ejXZgwzFMbQiJTfX4oMGaymF6gUCT
	vhJ7qXQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slyP4-00000006E2T-31v6;
	Wed, 04 Sep 2024 22:23:06 +0000
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slyP0-00000006E01-3TKM
	for kexec@lists.infradead.org;
	Wed, 04 Sep 2024 22:23:04 +0000
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-6d52d811d1aso31247527b3.1
        for <kexec@lists.infradead.org>; Wed, 04 Sep 2024 15:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725488581; x=1726093381; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IcbwmmlOLf0klhujBPied779n3Fl3qlNEilivTVgvc=;
        b=SsLfVJJLN5Vqzi9iSSYd85eeZe0EgcszOwoUGqXICe/9Us+qdrYIJKn487sl4NT9FU
         7HObdPvbdzGCYwLcHrPF/8C/b+OoYgYgRX9BsrPVpRwRVoDtyPAn92gdFtRjcH3D8kun
         eeya6d949dsfeCmu5WlUjN0ZZoSkphGQC4F+Yc2OpJCt2OpK3L53JrYMJTk4+jPhl3cR
         y15ONIyDJnswmdDeN2FpxDbzijliLact4VQt1Xi3gOJrvM/GhWBP0E3/N6qSGRvDk8nX
         yIdWjfKWaokvgu5vcuj+4wl77C1Prq2c79fkUZCR3UtYLR00Xp9nX9jzPwI9PtHPjijP
         xg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725488581; x=1726093381;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4IcbwmmlOLf0klhujBPied779n3Fl3qlNEilivTVgvc=;
        b=Km7YBsdv5NxBCrb2W2ttlQx7XiBsy41O3STJ6ghsJ2rZvfEtFDBsp/6fkFNEy9MxYz
         atmY2WC/ic5eOwKh3nu3LVE2lCGdr2WPWXBO78QazRJFj/fcthOpvJG0XsptSjGVwson
         KZXXv6+ErM+BcSdjuz5bA1hZ8IdZ37tj/ymTEghs1tGnK/7DBgJ7ohCPqvkfqQRCbIH5
         XUx/KrQIkDJ3OHj+zHm1gkJXoozAO6Je66y1ddKTJJ8UijHeZWw4O89JF71QZdthMaTp
         O3Pvzvs/Nn2f1/latp5t9abaf1gix+6cWw9tmq1oP5eyclGe/BF7yOES7P/XDhofRoo8
         Iwwg==
X-Forwarded-Encrypted: i=1; AJvYcCVDFp9meICOToOTxmBZ9U2E76m1oMZHQzW+m+D+0YRdJRGuahxknQNFqXtrNwEsPo4EIUGY3g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxkiQZMJURG1IVJlS3PCvrOQPBEA6Q0+f87zP3bQTs1PX3FwyLd
	erNonXV6GMWs+awKO5FBIxWFXQGIFNklStXHgUwSILOEHUpHMoortkPkDOeBmA24+yMaQgZZXV1
	g6A==
X-Google-Smtp-Source: AGHT+IGYeTai88fqs4PTMdPKSg8MaUYgkkisjxloKq27r7jXpBOr3zwINpKcQRS2VjU6U9JC53KdXYeYceY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2009:b0:6be:523:af53 with SMTP id
 00721157ae682-6db26026aaamr1583987b3.3.1725488581437; Wed, 04 Sep 2024
 15:23:01 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:23:00 -0700
In-Reply-To: <c24deb49-4369-4dcf-bb71-3160f2466ac3@amd.com>
Mime-Version: 1.0
References: <20240903191033.28365-1-Ashish.Kalra@amd.com> <ZtdpDwT8S_llR9Zn@google.com>
 <fbde9567-d235-459b-a80b-b2dbaf9d1acb@amd.com> <25ca73c9-e4ba-4a95-82c8-0d6cf8d0ff78@redhat.com>
 <14b0bc83-f645-408f-b8af-13f49fe6155d@amd.com> <20240904195408.wfaukcphpw5iwjcg@amd.com>
 <c24deb49-4369-4dcf-bb71-3160f2466ac3@amd.com>
Message-ID: <ZtjdxNTBJymcx2Lq@google.com>
Subject: Re: [PATCH v2] x86/sev: Fix host kdump support for SNP
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <ashish.kalra@amd.com>
Cc: Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, x86@kernel.org, hpa@zytor.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thomas.lendacky@amd.com, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_152302_898410_E903DA43 
X-CRM114-Status: GOOD (  25.53  )
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

T24gV2VkLCBTZXAgMDQsIDIwMjQsIEFzaGlzaCBLYWxyYSB3cm90ZToKPiBPbiA5LzQvMjAyNCAy
OjU0IFBNLCBNaWNoYWVsIFJvdGggd3JvdGU6Cj4gPiAgIC0gU2VhbiBpbnF1aXJlZCBhYm91dCBt
YWtpbmcgdGhlIHRhcmdldCBrZHVtcCBrZXJuZWwgbW9yZSBhZ25vc3RpYyB0bwo+ID4gICAgIHdo
ZXRoZXIgb3Igbm90IFNOUF9TSFVURE9XTiB3YXMgZG9uZSBwcm9wZXJseSwgc2luY2UgdGhhdCBt
aWdodAo+ID4gICAgIGFsbG93IGZvciBjYXB0dXJpbmcgc3RhdGUgZXZlbiBmb3IgZWRnZSBjYXNl
cyB3aGVyZSB3ZSBjYW4ndCBnbwo+ID4gICAgIHRocm91Z2ggdGhlIG5vcm1hbCBjbGVhbnVwIHBh
dGguIEkgbWVudGlvbmVkIHdlJ2QgdHJpZWQgdGhpcyB0byBzb21lCj4gPiAgICAgZGVncmVlIGJ1
dCBoaXQgaXNzdWVzIHdpdGggdGhlIElPTU1VLCBhbmQgd2hlbiB3b3JraW5nIGFyb3VuZCB0aGF0
Cj4gPiAgICAgdGhlcmUgd2FzIGFub3RoZXIgaXNzdWUgYnV0IEkgZG9uJ3QgcXVpdGUgcmVjYWxs
IHRoZSBzcGVjaWZpY3MuCj4gPiAgICAgQ2FuIHlvdSBwb3N0IGEgcXVpY2sgcmVjYXAgb2Ygd2hh
dCB0aGUgaXNzdWVzIGFyZSB3aXRoIHRoYXQgYXBwcm9hY2gKPiA+ICAgICBzbyB3ZSBjYW4gZGV0
ZXJtaW5lIHdoZXRoZXIgb3Igbm90IHRoaXMgaXMgc3RpbGwgYW4gb3B0aW9uPwo+IAo+IFllcywg
aSBiZWxpZXZlIHdpdGhvdXQgU05QX1NIVVRET1dOLCBlYXJseV9lbmFibGVfaW9tbXVzKCkgY29u
ZmlndXJlIHRoZQo+IElPTU1VcyBpbnRvIGFuIElSUSByZW1hcHBpbmcgY29uZmlndXJhdGlvbiBj
YXVzaW5nIHRoZSBjcmFzaCBpbgo+IGlvX2FwaWMuYzo6Y2hlY2tfdGltZXIoKS4KPiAKPiBJdCBs
b29rcyBsaWtlIGluIHRoaXMgY2FzZSwgd2UgZW5hYmxlIElSUSByZW1hcHBpbmcgY29uZmlndXJh
dGlvbiAqZWFybGllcioKPiB0aGFuIHdoZW4gaXQgbmVlZHMgdG8gYmUgZW5hYmxlZCBhbmQgd2hp
Y2ggY2F1c2VzIHRoZSBwYW5pYyBhcyBpbmRpY2F0ZWQ6Cj4gCj4gRU1FUkdFTkNZIFvCoMKgwqAg
MS4zNzY3MDFdIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiB0aW1lciBkb2Vzbid0IHdvcmsK
PiB0aHJvdWdoIEludGVycnVwdC1yZW1hcHBlZCBJTy1BUElDCgpJIGFzc3VtZSB0aGUgcHJvYmxl
bSBpcyB0aGF0IElPTU1VIHNldHVwIGZhaWxzIGluIHRoZSBrZHVtcCBrZXJuZWwsIG5vdCB0aGF0
IGl0CmRvZXMgdGhlIHNldHVwIGVhcmxpZXIuICBUaGF0J3MgdGhhdCBwYXJ0IEkgd2FudCB0byB1
bmRlcnN0YW5kLgoKQmFzZWQgb24gdGhlIFNOUCBBQkk6CgogIFRoZSBmaXJtd2FyZSBpbml0aWFs
aXplcyB0aGUgSU9NTVUgdG8gcGVyZm9ybSBSTVAgZW5mb3JjZW1lbnQuIFRoZSBmaXJtd2FyZSBh
bHNvCiAgdHJhbnNpdGlvbnMgdGhlIGV2ZW50IGxvZywgUFBSIGxvZywgYW5kIGNvbXBsZXRpb24g
d2FpdCBidWZmZXJzIG9mIHRoZSBJT01NVSB0bwogIGFuIFJNUCBwYWdlIHN0YXRlIHRoYXQgaXMg
cmVhZCBvbmx5IHRvIHRoZSBoeXBlcnZpc29yIGFuZCBjYW5ub3QgYmUgYXNzaWduZWQgdG8KICBn
dWVzdHMuCgphbmQgY29tbWl0IGYzNjZhOGRhYzFiOCAoImlvbW11L2FtZDogQ2xlYW4gdXAgUk1Q
IGVudHJpZXMgZm9yIElPTU1VIHBhZ2VzIGR1cmluZwpTTlAgc2h1dGRvd24iKSwgbXkgdW5kZXJz
dGFuZGluZyBpcyB0aGF0IHRoZSBwYWdlcyB1c2VkIGZvciB0aGUgSU9NTVUgbG9ncyBhcmUKZm9y
Y2VkIHRvIHJlYWQtb25seSBmb3IgdGhlIElPTU1VLCBhbmQgc28gYXR0ZW1wdGluZyB0byBhY2Nl
c3MgdGhvc2UgcGFnZXMgaW4gdGhlCmtkdW1wIGtlcm5lbCB3aWxsIHJlc3VsdCBpbiBhbiBSTVAg
I1BGLgoKVGhhdCdzIHF1aXRlIHVuZm9ydHVuYXRlLCBhcyBpdCBtZWFucyBteSBpZGVhIG9mIGVh
dGluZyBSTVAgI1BGcyBkb2Vzbid0IHJlYWxseQp3b3JrLCBiZWNhdXNlIHRoYXQgaWRlYSBpcyBi
YXNlZCBvbiB0aGUgYXNzdW1wdGlvbiB0aGF0IG9ubHkgZ3Vlc3QgcHJpdmF0ZSBtZW1vcnkKd291
bGQgZ2VuZXJhdGUgdW5leHBlY3RlZCBSTVAgI1BGcyAgOi0oCgo+IE5leHQsIHdlIHRyaWVkIHdp
dGggYW1kX2lvbW11PW9mZiwgd2l0aCB0aGF0IHdlIGRvbid0IGdldCB0aGUgaXJxIHJlbWFwcGlu
Zwo+IHBhbmljIGR1cmluZyBjcmFzaGtlcm5lbCBib290LCBidXQgYm9vdCBzdGlsbCBoYW5ncyBi
ZWZvcmUgc3RhcnRpbmcga2R1bXAKPiB0b29scy4KPiAKPiBTbyBldmVudHVhbGx5IHdlIGRpc2Nv
dmVyZWQgdGhhdCBpcnFyZW1hcHBpbmcgaXMgcmVxdWlyZWQgZm9yIHgyYXBpYyBhbmQgd2l0aAo+
IGFtZF9pb21tdT1vZmYgd2UgZG9uJ3QgZW5hYmxlIGlycXJlbWFwcGluZyBhdCBhbGwuCgpZZWFo
LCB0aGF0IG1ha2VzIHNlbnNlLCBhcyBkb2VzIGZhaWxpbmcgdG8gYm9vdCBpZiB0aGUgc3lzdGVt
IGlzbid0IGNvbmZpZ3VyZWQKcHJvcGVybHksIGkuZS4gY2FuJ3Qgc2VuZCBpbnRlcnJ1cHRzIHRv
IGFsbCBDUFVzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
