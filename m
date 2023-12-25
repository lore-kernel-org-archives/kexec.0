Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D17BC3DA6E
	for <kexec@archiver.kernel.org>; Mon, 25 Dec 2023 23:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ee8oXnFgzclWm1BvOtC6oqEuuf0T/q5pE6MGVYARb7I=; b=aN7Y7BfQQ3WOeR
	NsSwv3KWbEn6O+oBjWYV5PbFp4VQWXlnx5rvBPldjA2YzMaCykVwSnAruhYMB4Cl+XS1n7Ca1qJ/V
	jz0GSDKo8s9EuoqfKXs1/mS/cYjssaRCYLC0quJWqq7gA4TqMZXEhIttRRbzA3MJxZ4AMqh+y6qAD
	GVJOBMR60XlvXERZ6IIgt5xOQjprygDgOukyesQF9ZzEuhQ6xcNhoKZLjpPP3AHH+LzbjDQ40BaWr
	LtPL42dzZr8AE9ytCNFGl/vfIA0KmtsyG9D5pWr6UUEh5Pgc2e0PURnTvkI6kWPMCLjtme4uYqZdB
	fOsaFgLayeG1z99icqSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHuQV-00BNq7-0X;
	Mon, 25 Dec 2023 23:32:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHuQR-00BNpi-1x
	for kexec@lists.infradead.org;
	Mon, 25 Dec 2023 23:32:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703547116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSlPAyAZzv+QVMkLmtnw21kPDx01ngb4jPGaj9Nd6Dk=;
	b=cu2DyaeJ5BNca6CG8XbZeaXYTMCraM4JoiUpPgzx8HzgQp8GZjoFTfHgt12232PnRL6aO3
	t3V81zjZxzMdh1stfq24evv5xK+jRdzfTKYOxauWeNPo13h0F5OIL3YGAOpk/rtYFHhMjQ
	HE007AF/jvtR+dklGJ9xzpszq2WM63Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-Kp_o3q8TMuunmh3-dbEeKw-1; Mon,
 25 Dec 2023 18:31:54 -0500
X-MC-Unique: Kp_o3q8TMuunmh3-dbEeKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E07831C172C1;
	Mon, 25 Dec 2023 23:31:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1691C060AF;
	Mon, 25 Dec 2023 23:31:52 +0000 (UTC)
Date: Tue, 26 Dec 2023 07:31:49 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>, akpm@linux-foundation.org
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <ZYoQ5ej3uDKt5rmw@MiWiFi-R3L-srv>
References: <20231222121855.148215-1-fuqiang.wang@easystack.cn>
 <ZYWPHSmwK8iG6xUr@MiWiFi-R3L-srv>
 <ZYe3iN816iiKDwIu@MiWiFi-R3L-srv>
 <a65e7a06-bc91-4c82-9a65-6066f9f64409@easystack.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a65e7a06-bc91-4c82-9a65-6066f9f64409@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_153159_713563_DF212A06 
X-CRM114-Status: GOOD (  15.98  )
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

T24gMTIvMjUvMjMgYXQgMDk6NDRwbSwgZnVxaWFuZyB3YW5nIHdyb3RlOgo+IOWcqCAyMDIzLzEy
LzI0IDEyOjQ2LCBCYW9xdWFuIEhlIOWGmemBkzoKPiAKPiA+IFJldGhpbmsgYWJvdXQgdGhpcywg
c2VlbXMgYWJvdmUgY29kZSBjb21tZW50IGlzIGZpbmUgdG8gYmUga2VwdCwgYW5kIHRoZQo+ID4g
c2FtZSBmZWVsaW5nIGFib3V0IHRoZSBlbGZoZWFkZXIgcmVnaW9uIHNwbGl0IGZyb20gY3Jhc2hr
X3Jlcy4gU28sIG90aGVyCj4gPiB0aGFuIHRoZSBwYXRjaCBsb2cgY29uY2VybnMsIHRoaXMgcGF0
Y2ggbG9va3MgZ29vZCB0byBtZS4gTGV0J3Mgc2VlIGlmCj4gPiBvdGhlciBwZW9wbGUgaGFzIGNv
bmNlcm4gYWJvdXQgdGhlIG5ld2x5IGFkZGVkIGNvbW1lbnRzLgo+ID4gCj4gCj4gSGkgQmFvcXVh
bgo+IAo+IFRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgc3VnZ2VzdGlvbnMgaW4gdGhlIHBh
dGNoIGxvZyBhbmQgY29kZSBjb21tZW50cy4gSQo+IGhhdmUgbGVhcm5lZCBhIGxvdCBhbmQgSSB3
aWxsIGdyYWR1YWxseSBpbXByb3ZlLgo+IAo+IEkgZm91bmQgdGhlIGZvbGxvd2luZyBwYXRjaCBp
biBsaW51eC1uZXh0Ogo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0Lz9pZD02NjZlZjEzZjI4NzBjNDNiYThh
NDAyZWM4YTNjZWRmNmViNmM2ZjVhCj4gCj4gSSdtIHNvcnJ5LCBJdCdzIG15IG1pc3Rha2UuIERv
IHlvdSB0aGluayBpdCBpcyBzdGlsbCBuZWNlc3NhcnkgdG8gbWVyZ2UgdGhpcwo+IHBhdGNoIGJh
c2VkIG9uIHRoYXQgPwoKVGhhdCBwYXRjaCBuZWVkIGJlIHdpdGhkcmV3IGJlY2F1c2UgdGhhdCBp
cyBub3QgZXhwZWN0ZWQgYWNjb3JkaW5nIHRvCm91ciBkaXNjdXNzaW9uLgoKSGkgQW5kcmV3LAoK
Q291bGQgeW91IHdpdGhkcmF3IHRoZSBwYXRjaCBmdXFpYW5nIG1lbnRpb25lZD8KCng4Ni9jcmFz
aDogZml4IHBvdGVudGlhbCBjbWVtLT5yYW5nZXMgYXJyYXkgb3ZlcmZsb3cKaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC9j
b21taXQvP2lkPTY2NmVmMTNmMjg3MGM0M2JhOGE0MDJlYzhhM2NlZGY2ZWI2YzZmNWEKClRoYW5r
cwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
