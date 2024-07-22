Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AFAC3DA59
	for <kexec@archiver.kernel.org>; Mon, 22 Jul 2024 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eGtasZHpVCtNwYyXffn1eT0C1efmnjuGl9feRBvaWnk=; b=PuAx/0dXG2Y2YE
	UjvJYb0+4mvKRoio6YyWl3INYWWp4xLO5fJMvBC02b5/WqjA2pwLaONatLyPt/tCnovXZv4ymnsmT
	F2tor55dEHIuF6E1ZLXzjBMAPiFlRs8zMlpCQYt10fcJAPXs1FiTPJopTQZC6GYlGH0fmjEkApHjO
	ERHT+EKkJLtrrsgbhe/4Q28a4RGEHjjs+90lAzxx3cSh6pKhBlN+YLusWa27E/VFRaLLUVTI6DclQ
	g8FcMDeO7HrvBMnGwNpiFS5rH9dIeFCh0F+/G1cskmXCiv0vuASNsfHP47RnpJZml8NMzw1z36LkT
	4Qb4it1JC845oAfAUJ6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVqJf-00000009GBm-3yO8;
	Mon, 22 Jul 2024 10:30:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVqJd-00000009GBL-0K2P
	for kexec@lists.infradead.org;
	Mon, 22 Jul 2024 10:30:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721644248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=920T09UfGz6bsniIm1Cf50ju0AGe0vceUzq5dRrbSaw=;
	b=PdKJyWoAf0pGdne+1CKL6NyMuuoKey5RnNqRHnKgI2jF/DuIFJHkOaTakgneEj2NHJp/T5
	X3uplXMIjICJZljvK4RhAk3Qa+sKzRnLIGsnLrB4vQ0rLeS7u4AqUl3kGBYl4tlM9qwVXh
	NqUw8mxye1Fx2yPs8ut1Qw0+/9YYeZ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-QsRzAvh_OJS8UbRmtQQzbQ-1; Mon,
 22 Jul 2024 06:30:44 -0400
X-MC-Unique: QsRzAvh_OJS8UbRmtQQzbQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8476A1955F65;
	Mon, 22 Jul 2024 10:30:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 112031955F40;
	Mon, 22 Jul 2024 10:30:41 +0000 (UTC)
Date: Mon, 22 Jul 2024 18:30:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] kexec: Use atomic_try_cmpxchg_acquire() in
 kexec_trylock()
Message-ID: <Zp40zOw+E1Na/Lly@MiWiFi-R3L-srv>
References: <20240719103937.53742-1-ubizjak@gmail.com>
 <Zp3NXf9UBCtFKBsa@MiWiFi-R3L-srv>
 <CAFULd4Y8vhcTWG-eNMSLEJHR_1=LuQzKj7q4JX8Kv7auJKAYDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFULd4Y8vhcTWG-eNMSLEJHR_1=LuQzKj7q4JX8Kv7auJKAYDQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_033049_207243_68EB80B0 
X-CRM114-Status: GOOD (  15.10  )
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

T24gMDcvMjIvMjQgYXQgMTA6NTNhbSwgVXJvcyBCaXpqYWsgd3JvdGU6Cj4gT24gTW9uLCBKdWwg
MjIsIDIwMjQgYXQgNTowOeKAr0FNIEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPiB3cm90ZToK
PiA+Cj4gPiBPbiAwNy8xOS8yNCBhdCAxMjozOHBtLCBVcm9zIEJpemphayB3cm90ZToKPiA+ID4g
VXNlIGF0b21pY190cnlfY21weGNoZ19hY3F1aXJlKCpwdHIsICZvbGQsIG5ldykgaW5zdGVhZCBv
Zgo+ID4gPiBhdG9taWNfY21weGNoZ19hY3F1aXJlKCpwdHIsIG9sZCwgbmV3KSA9PSBvbGQgaW4g
a2V4ZWNfdHJ5bG9jaygpLgo+ID4gPiB4ODYgQ01QWENIRyBpbnN0cnVjdGlvbiByZXR1cm5zIHN1
Y2Nlc3MgaW4gWkYgZmxhZywgc28KPiA+ID4gdGhpcyBjaGFuZ2Ugc2F2ZXMgYSBjb21wYXJlIGFm
dGVyIGNtcHhjaGcuCj4gPgo+ID4gU2VlbXMgaXQgY2FuIHNpbXBsaWZ5IGNvZGUgZXZlbiB0aG91
Z2ggb24gbm9uLXg4NiBhcmNoLCBzaG91bGQgd2UKPiA+IHJlcGxhY2UgYXRvbWljX3RyeV9jbXB4
Y2hnX2FjcXVpcmUoKSB3aXRoIGF0b21pY190cnlfY21weGNoZ19hY3F1aXJlKCkKPiA+IGluIGFs
bCBzaW1pbGFyIHBsYWNlcz8KPiAKPiBZZXMsIHRoZSBjaGFuZ2UgaXMgYmVuZWZpY2lhbCBhbHNv
IGZvciBub24teDg2IGFyY2hpdGVjdHVyZXMsIHBsZWFzZQo+IHNlZSBhbmFseXNpcyBhdCB0aHJl
YWQgWzFdLiBJJ3ZlIGJlZW4gbG9va2luZyB0aHJvdWdoIHRoZSBrZXJuZWwKPiBzb3VyY2VzIGZv
ciB0aGVzZSBwbGFjZXMgZm9yIHF1aXRlIHNvbWUgdGltZSwgYW5kIEkgYmVsaWV2ZSBJIGhhdmUK
PiBjaGFuZ2VkIG1vc3Qgb2YgdGhlIHBsYWNlcy4gVGhlIGNoYW5nZSBpcyByZWxhdGl2ZWx5IHN0
cmFpZ2h0Zm9yd2FyZCwKPiBhbmQgaW1tZWRpYXRlbHkgcmVzdWx0cyBpbiBhIGJldHRlciBjb2Rl
Lgo+IAo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzg3MXF3Z21xd3MuZnNmQG1w
ZS5lbGxlcm1hbi5pZC5hdS8KCkdvb2QgdG8ga25vdywgdGhhbmtzIGZvciB0ZWxsaW5nLgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
