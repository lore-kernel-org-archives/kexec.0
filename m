Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6873BEE021C
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 08:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LCUQgDcJORLcbnuxxh8Th5e9HlfmA/bpkGwxaP7LxCE=; b=yHxSZW5zkXRACZ
	aRUSxMpFUWTYzCQkIWMGzutmmOi9cqK5Z51RwalT1zGhBezinrWCuSo2fpdeQhjVLaRxXtLipiIvE
	B4b4WifM24b8XAIJOHTyzE/VPhYsr/WN9IgBB3yjgdZEwuWWs4D8CEvr6lKPPHKSYueO15B8pojte
	/6wYnVC3c0AtGrMFIARvtC1XFPntFQ6T9/jEFpvJJ6baIv/km38U6Epm6VnabxjpXCJNovv6WXIh2
	UnjAkqHtsQrkgAsWTsgSI+AQ/KxpnIaDoaBVKCAAFm3YQ/6nfCeiZDeRkDioILtw/gPgcqmWZHnNc
	N2IdzXaF5coXgxAAce1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soJ1s-00000008kqB-3i6A;
	Wed, 11 Sep 2024 08:48:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIzR-00000008k4J-1g4F
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 08:46:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726044375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq8JaCWyziRBjtKqtbfl0xssh8Fkw9br1JpvTEvClbc=;
	b=RxriWNS34oVm5goNyDWPYC6JOfFF6a8RfPHN8IXDhPSiy0cv2Ss/F1XoC7yawa1rJBBxG2
	0rvUCrgxTgk9RYr8gRWSorVgfFw3Uv6EOfP92B+g2YFcoWg7UMrvZZdb9wer2hc6lAzYEU
	q9lZiqePUoWHSemZUu/1uH3z+T3cxZQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-ohkZIDUfPKurTa_aKaUB3w-1; Wed,
 11 Sep 2024 04:44:39 -0400
X-MC-Unique: ohkZIDUfPKurTa_aKaUB3w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C94331956077;
	Wed, 11 Sep 2024 08:44:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.146])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 292773000235;
	Wed, 11 Sep 2024 08:44:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 02D531800635; Wed, 11 Sep 2024 10:44:34 +0200 (CEST)
Date: Wed, 11 Sep 2024 10:44:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: devel@edk2.groups.io, afish@apple.com
Cc: leitao@debian.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com, 
	rppt@kernel.org, usamaarif642@gmail.com, gourry@gourry.net, rmikey@meta.com
Subject: Re: [edk2-devel] EFI table being corrupted during Kexec
Message-ID: <5ey4rmwtcnoukoh57o7ysgolyyzjcwnc3x6ao2zzu3l32xee43@o62hzctqe36q>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <BABE4F07-DF49-48C5-BAB7-B5986C035C8E@apple.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BABE4F07-DF49-48C5-BAB7-B5986C035C8E@apple.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_014617_583682_8DA1C861 
X-CRM114-Status: GOOD (  17.38  )
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

T24gVHVlLCBTZXAgMTAsIDIwMjQgYXQgMDg6NDQ6NDBBTSBHTVQsIEFuZHJldyBGaXNoIHZpYSBn
cm91cHMuaW8gd3JvdGU6Cj4gCj4gCj4gPiBPbiBTZXAgMTAsIDIwMjQsIGF0IDY6NTjigK9BTSwg
QnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4gd3JvdGU6Cj4gPiAKPiA+IAo+ID4gV2Un
dmUgc2VlbiBhIHByb2JsZW0gaW4gdXBzdHJlYW0ga2VybmVsIGtleGVjLCB3aGVyZSBhIEVGSSBU
UE0gbG9nIGV2ZW50IHRhYmxlCj4gPiBpcyBiZWluZyBvdmVyd3JpdHRlbi4gIFRoaXMgcHJvYmxl
bSBoYXBwZW4gb24gcmVhbCBtYWNoaW5lLCBhcyB3ZWxsIGFzIGluIGEKPiA+IHJlY2VudCBFREsy
IHFlbXUgVk0uCj4gPiAKPiA+IERpZ2dpbmcgZGVlcCwgdGhlIHRhYmxlIGlzIGJlaW5nIG92ZXJ3
cml0dGVuIGR1cmluZyBrZXhlYywgbW9yZSBwcmVjaXNlbHkgd2hlbgo+ID4gcmVsb2NhdGluZyBr
ZXJuZWwgKHJlbG9jYXRlX2tlcm5lbCgpIGZ1bmN0aW9uKS4KPiA+IAo+ID4gSSd2ZSBhbHNvIGZv
dW5kIHRoYXQgdGhlIHRhYmxlIGlzIGJlaW5nIHByb3Blcmx5IHJlc2VydmVkIHVzaW5nCj4gPiBt
ZW1ibG9ja19yZXNlcnZlKCkgZWFybHkgaW4gdGhlIGJvb3QsIGFuZCB0aGF0IHJhbmdlIGdldHMg
b3ZlcndyaXR0ZW4gbGF0ZXIgaW4KPiA+IGJ5IHJlbG9jYXRlX2tlcm5lbCgpLiBJbiBvdGhlciB3
b3Jkcywga2V4ZWMgaXMgb3ZlcndyaXRpbmcgYSBtZW1vcnkgdGhhdCB3YXMKPiA+IHByZXZpb3Vz
bHkgcmVzZXJ2ZWQgKGFzIG1lbWJsb2NrX3Jlc2VydmUoKSkuCj4gPiAKPiA+IFVzYW1hIGZvdW5k
IHRoYXQga2V4ZWMgb25seSBob25vdXJzIG1lbW9yeSByZXNlcnZhdGlvbnMgZnJvbSAvc3lzL2Zp
cm13YXJlL21lbW1hcAo+ID4gd2hpY2ggY29tZXMgZnJvbSBlODIwX3RhYmxlX2Zpcm13YXJlIHRh
YmxlLgo+IAo+IFRoZSBFODIwIHRhYmxlIGlzIG5vdCBwYXJ0IG9mIHRoZSBVRUZJIHN0YW5kYXJk
IGFuZCBpdCBpcyBwcm9kdWNlZCBieQo+IGEgbGlicmFyeSBpbiB0aGUgT3ZtZlBrZyBmb3Ig4oCc
c3BlY2lhbCBjYXNlc+KAnSBzbyBJIGd1ZXNzIHRoYXQgbGliIGNvdWxkCj4gaGF2ZSBhIGJ1Zz8K
ClRoaXMgInNwZWNpYWwgY2FzZSIgaXMgZGlyZWN0IGtlcm5lbCBib290ICgncWVtdSAta2VybmVs
IHZtbGludXgnKSBhbmQKbG9hZGluZyB0aGUgbGludXgga2VybmVsIGFzIEVGSSBiaW5hcnkgZmFp
bGVkLiAgVGhhdCBzaG91bGQgb25seSBoYXBwZW4Kd2l0aCBsaW51eCBrZXJuZWxzIHNvIG9sZCB0
aGF0IHRoZXkgZG8gbm90IGhhdmUgdGhlIGVmaSBzdHViLgoKQWxzbyBub3RlICJwcm9ibGVtIGhh
cHBlbiBvbiByZWFsIG1hY2hpbmUiIGFib3ZlLCBzbyBpdCBjbGVhcmx5IGlzIG5vdApzb21ldGhp
bmcgT1ZNRi1zcGVjaWZpYy4KCnRha2UgY2FyZSwKICBHZXJkCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
