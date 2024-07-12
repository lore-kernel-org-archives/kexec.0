Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F40BC2BD09
	for <kexec@archiver.kernel.org>; Fri, 12 Jul 2024 06:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Hw+DdEbpk7xrweG5ZrGHCf6VqSEH2pAO4jlHE0vRA0=; b=BaAN3fseCSgNeA
	1gswLmVe36rIEzOzU4d33PvVu4HJ86NT+FSiqxa/TZelXqRuGpGIPVM6Y8ts4mXoaY9bYOcoBjA0a
	yUsEJaVwg52+7pAtfNol6B3B2EQOsOElZsSnoKo+E9QfReVVLt4Psxy9uUrkrA+OUcSrxCVKiQdRm
	xZnw8ColMBRKowCmca6X4L50uNOPA+afFsbXuAzr/zG7HH3TMCH25aMNQWs14c9KrpE67rACh9Aro
	lahIJaG7RWtwl6Y+SSIPK177EjkbkDPczkw1r2V2BRI61lt6qmziadrw6lkrHxg9s7nZBMqvkTRJr
	M7OLx7O+fWAgK/gjIN8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSA53-0000000GfPU-3PJ6;
	Fri, 12 Jul 2024 06:48:33 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSA50-0000000GfOx-0D4s
	for kexec@lists.infradead.org;
	Fri, 12 Jul 2024 06:48:31 +0000
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso2367328e87.2
        for <kexec@lists.infradead.org>; Thu, 11 Jul 2024 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720766908; x=1721371708; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMV/z33NFOqMzM8JfcQjaOoMBKUPMqBIE+lUrEw52mE=;
        b=OSb3BN+lLZ4mtqjujT16Xhk033dEsSwVJ0ygDDaV+DGC2dy40WNvz9gBDQg3OJa2O/
         c4QqW/YexGN0WfKtEpTxPWaODSzGnTfAfMeVP/hlrmdHbvdX2m7H4i3acZEpacrXtsHN
         c9ei3vpub6OkBlUx6uK+aNpPRJkBd9mltJRSPLq612z7PvPw6/mDVFlcQTgXkLtWlnew
         emRUMaUKCb/y8RM80RcbhXRz3z5lOF9RXkGIIsmKgd8GNezUoibpKbHmZM1dhuX9w69C
         trfGWKrwmoWpy0QXg3fAttgAGwTnF7gNE6zmjQ+6HRhypzxh5Q1OIAkEn1zgzng6P2Wt
         VHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720766908; x=1721371708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMV/z33NFOqMzM8JfcQjaOoMBKUPMqBIE+lUrEw52mE=;
        b=JMVggAHTnVU0TxrpIs+FR42hnPY0Qp7jrbicZtCJ3drP2JHd5ZthwmQPz4nfYTPLPz
         rUufH9mAt+TRRRGNaIhpCKyQFzfD09QrHQKzkrvK6raPPxUJvpA8fxwCCp3xo2cytarp
         olvF0Wz3ftF+PogtuDdakotyuVYBpwAKpf33XupDA28qfwT8lJxB4LZ08jaZJQ2VMWrD
         1ehdB8y1t2iMnM9QRMNQ+bJPu4l4ytqNhwtukzkyBd/geGDbQSbzfBGAGqIWrGCPNiSL
         LStaVgcWdOurYMRxZeZZX6AweypkQssnhT9BKULGUjzJ7jmbPamFM6OxwRetFQyf/D7A
         PhqA==
X-Forwarded-Encrypted: i=1; AJvYcCVCjm+GmkpfZs3S7YS9QsxmXpYm3EmqlBEJ6ElukwuihPJ7KQ5M4xEE3wOMD4Zq9NeNFaJZQCR6RXTTeR/5weh91go2+kk28NZg
X-Gm-Message-State: AOJu0YxEj1yEufDJNwGWUw0qwpoQ3YVG/0lpKLTUZ28RWY1lF3mE7Oiw
	D6yN6bJlonk1enDqQ2nX26+ChYhEAnsHntGUvZ1hqw5WZmq4ODm2sykxFWWVkSg=
X-Google-Smtp-Source: AGHT+IHTtmtrVLLE7aDfY6kkhvZrmZsV2MnTKBQLikl9TyOMWMFZLyZQL7bTaCQtck/kvBawPV6jfQ==
X-Received: by 2002:a05:6512:3499:b0:52e:936e:a237 with SMTP id 2adb3069b0e04-52eb999b382mr6496264e87.16.1720766908188;
        Thu, 11 Jul 2024 23:48:28 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a872002sm314623966b.211.2024.07.11.23.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 23:48:27 -0700 (PDT)
From: Petr Tesarik <petr.tesarik@suse.com>
X-Google-Original-From: Petr Tesarik <ptesarik@suse.com>
Date: Fri, 12 Jul 2024 08:48:26 +0200
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Petr Tesarik
 <petr@tesarici.cz>
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
Message-ID: <20240712084826.3128cba2@mordecai.tesarici.cz>
In-Reply-To: <06c0d61f-8dcb-46f6-8710-db1c6163907b@linux.ibm.com>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
	<59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
	<20240712082124.272e079f@meshulam.tesarici.cz>
	<06c0d61f-8dcb-46f6-8710-db1c6163907b@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_234830_111131_7971EC19 
X-CRM114-Status: GOOD (  19.91  )
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

T24gRnJpLCAxMiBKdWwgMjAyNCAxMjowMToyOSArMDUzMApTb3VyYWJoIEphaW4gPHNvdXJhYmhq
YWluQGxpbnV4LmlibS5jb20+IHdyb3RlOgoKPiBIZWxsbyBQZXRyLAo+IAo+IE9uIDEyLzA3LzI0
IDExOjUxLCBQZXRyIFRlc2HFmcOtayB3cm90ZToKPiA+IE9uIEZyaSwgMTIgSnVsIDIwMjQgMTA6
MDA6MDkgKzA1MzAKPiA+IFNvdXJhYmggSmFpbiA8c291cmFiaGphaW5AbGludXguaWJtLmNvbT4g
d3JvdGU6Cj4gPiAgCj4gPj4gSGVsbG8gUGV0ciwKPiA+Pgo+ID4+IEp1c3Qgd2FudCB0byBtZW50
aW9uZWQgZmV3IHBvaW50cyBhYm91dCB0aGUgY29tbWl0IG1lc3NhZ2UuIE5vIHN0cm9uZwo+ID4+
IG9waW5pb24gb24gY2hhbmdpbmcgdGhlIGNvbW1pdCBtZXNzYWdlLgo+ID4+Cj4gPj4gT24gMTEv
MDcvMjQgMTY6MDQsIFBldHIgVGVzYXJpayB3cm90ZTogIAo+ID4+PiBGcm9tOiBQZXRyIFRlc2Fy
aWsgPHB0ZXNhcmlrQHN1c2UuY29tPgo+ID4+Pgo+ID4+PiBUaGVyZSBpcyBubyByZWFzb24gdG8g
cmVzdHJpY3QgYWNjZXNzIHRvIHRoaXMgYXR0cmlidXRlLCBhcyBpdCBtZXJlbHkKPiA+Pj4gcmVw
b3J0cyB3aGV0aGVyIGNyYXNoIGVsZmNvcmVoZHIgaXMgYXV0b21hdGljYWxseSB1cGRhdGVkIG9u
IENQVSBob3QKPiA+Pj4gcGx1Zy91bnBsdWcgYW5kL29yIG9ubGluZS9vZmZsaW5lIGV2ZW50cy4g
IAo+ID4+IE5vdywgaXQgaXMgbm90IGp1c3QgZWxmY29yZWhkcjsgdGhlcmUgY291bGQgYmUgbXVs
dGlwbGUga2V4ZWMgc2VnbWVudHMKPiA+PiBiYXNlZCBvbiB0aGUgYXJjaGl0ZWN0dXJlJ3MgbmVl
ZHMuCj4gPj4gRm9yIGV4YW1wbGUsIG9uIFBvd2VyUEMsIGl0IGlzIGVsZmNvcmVoZHIgYW5kIEZE
VC4gIAo+ID4gUmlnaHQuIEkgYW0gZXZlbiB3b3JraW5nIHdpdGggYSBQb3dlclZNIExQQVIgb24g
YW4gTDkyMiBzeXN0ZW0gbm93LiA7LSkKPiA+Cj4gPiBPVE9IIEkgd2FzIGp1c3QgdG9vIGxhenkg
dG8gaW52ZW50IG15IG93biBkZXNjcmlwdGlvbiwgc28gSSB0b29rIGl0Cj4gPiBmcm9tIERvY3Vt
ZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZGV2aWNlcy1zeXN0ZW0tY3B1LiBUaGF0IG9uZQo+
ID4gY291bGQgYmUgaW1wcm92ZWQuIEFuZCBhIGNvdXBsZSBvZiBvdGhlciBwbGFjZXMuLi4gRXhw
ZWN0IGEgcGF0Y2guICAKPiBUaGFua3MgZm9yIHBvaW50IGl0IG91dCwgSSB3aWxsIHNlbmQgYSBw
YXRjaCB0byBmaXggdGhlIEFCSSBkb2N1bWVudCBmb3IgCj4gY3Jhc2hfaG90cGx1ZyBhbmQgb3Ro
ZXIgcGxhY2VzIGluIHRoZSBrZXJuZWwuIFRoYW5rcywKCk9oLCBJIHdhcyBwbGFubmluZyB0byBk
byB0aGF0LCBidXQgaWYgeW91IHdhbnQgdG8gc2VuZCBhIHBhdGNoCnlvdXJzZWxmLCBJIHdvbid0
IGR1cGxpY2F0ZSBlZmZvcnRzLiBUaGVyZSBhcmUgb3RoZXIgY2xlYW51cHMgb24gbXkKVE9ETyBs
aXN0LgoKUGV0ciBUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
