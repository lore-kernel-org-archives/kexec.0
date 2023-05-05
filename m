Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85CCC77B7F
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LAWSYnpP/DHztoTSJacnojzVjxOV2iVBp3B3Q0lCp3w=; b=ifrHi4YyM3EwZk
	QUANAhe4nrqCwQxjxupl9kBqn+NA8cdNdEr0MkuNTeZigf35hJ5OPqIJVdRtPUx8xKAOZ1/cvZOgj
	kwyHPt4gJ3lVb3LOAhP0WCjJt1gTNm5ajkr4ZJb4IFke9GNZmXjHW8E/jwNKYP/lrYw6oQ9r2rjch
	EkCw0cwFpCxyT13F788KK/qSWmwRFmCFq1D2P5ns//PyNu/RF8dzkUYYlKABnIJoyL49FLkwfdrbL
	B2TLuJ5wWf5J3bkHSOHZcQwWwQ0k2fWbspomfW16rOCta8lbYdYRgBWW6uD8kyR/yRkjLBdBnTtHM
	hIHTOaCFGtOtNh269ahQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puxZU-00BDs5-06;
	Fri, 05 May 2023 15:42:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puxZQ-00BDrD-2y
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 15:42:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 425AA63EF7;
	Fri,  5 May 2023 15:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51864C433A7;
	Fri,  5 May 2023 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683301327;
	bh=e7UBW6nu7Bv5KqpVh+Ou6qfxjxE/anFMzqSwqXY5S4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5PLHwrZFiYGpdj6RY0mjLbKf7LGO4IJNdoelkqeLCsZwJ9AQl6Zn5fBcJvz6z7/J
	 lPnMUdtIvxiS8zIP+hxR0E6WSTxYdZ+0LUcmum8d51PpeQmLuDCpcIGKTbROr8r/pq
	 SoOT1/xOFJJN249UvpXLkZ7SrG0GAjV3/sbBa2YpsM5njF29rKT1vLtxut/GUxs/DB
	 T+Td1guK97PVlpI961ygi7b/wqGiwtRRtgEPLfMnSQ0OxJGqLNF8ruduqMdUkjonAo
	 A0Ng3lSYUr+lLy5cPdhTG089cGO+Neb6Afivn6c9rQ5D/ORfBV7bKpOjqkEIWvhbxC
	 VHCVkeTX5e+xg==
Date: Fri, 5 May 2023 17:42:04 +0200
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org,
	jeremy.linton@arm.com
Subject: Re: [PATCH 3/5] arm64: change the prototype of image probe function
Message-ID: <ZFUjzEwHZ6o+C9NO@kernel.org>
References: <20230505025438.11943-1-piliu@redhat.com>
 <20230505025438.11943-4-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230505025438.11943-4-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_084209_021963_036B271A 
X-CRM114-Status: GOOD (  17.60  )
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

T24gRnJpLCBNYXkgMDUsIDIwMjMgYXQgMTA6NTQ6MzVBTSArMDgwMCwgUGluZ2ZhbiBMaXUgd3Jv
dGU6Cj4gQ2hhbmdpbmcgdGhlIGFhcmNoNjQgcHJvYmUncyBwcm90b3R5cGUgIGZyb20KPiAJdHlw
ZWRlZiBpbnQgKHByb2JlX3QpKGNvbnN0IGNoYXIgKmtlcm5lbF9idWYsIG9mZl90IGtlcm5lbF9z
aXplKTsKPiB0bwo+IAl0eXBlZGVmIGludCAocHJvYmVfdCkoY29uc3QgY2hhciAqa2VybmVsX2J1
Ziwgb2ZmX3Qga2VybmVsX3NpemUsIHN0cnVjdCBrZXhlY19pbmZvICppbmZvKTsKPiAKPiBMYXRl
ciwgaW5mbyBjYW4gYmUgdXNlZCB0byByZXR1cm4gYm90aCB0aGUgZmlsZSBkZXNjcmlwdG9yIGFu
ZCBwYXJzZWQga2VybmVsCj4gYnVmZmVyLiBUaGUgZmQgaXMgcGFzc2VkIHRvIHN5c19rZXhlY19m
aWxlX2xvYWQsIGFuZCB0aGUgcGFyc2VkIGtlcm5lbAo+IGJ1ZmZlciBpcyB1c2VkIGJ5IGltYWdl
J3MgbG9hZCBmdW5jdGlvbi4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQaW5nZmFuIExpdSA8cGlsaXVA
cmVkaGF0LmNvbT4KCkhpIFBpbmdmYW4sCgpJIGFtIHNlZWluZyBhIGJ1aWxkIGZhaWx1cmUgb24g
QVJNICgzMmJpdCkuCgogIDEzOCB8IGludCB6SW1hZ2VfYXJtX3Byb2JlKGNvbnN0IGNoYXIgKlVO
VVNFRChidWYpLCBvZmZfdCBVTlVTRUQobGVuKSkKICAgICAgfCAgICAgXn5+fn5+fn5+fn5+fn5+
fgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vLi4va2V4ZWMvYXJjaC9hcm0va2V4ZWMtekltYWdl
LWFybS5jOjIxOgouLi8uLi9rZXhlYy9hcmNoL2FybS9rZXhlYy1hcm0uaDoxMjo1OiBub3RlOiBw
cmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJh6SW1hZ2VfYXJtX3Byb2Jl4oCZIHdhcyBoZXJlCiAg
IDEyIHwgaW50IHpJbWFnZV9hcm1fcHJvYmUoY29uc3QgY2hhciAqYnVmLCBvZmZfdCBsZW4sIHN0
cnVjdCBrZXhlY19pbmZvICppbmZvKTsKICAgICAgfCAgICAgXn5+fn5+fn5+fn5+fn5+fgptYWtl
WzFdOiAqKiogW01ha2VmaWxlOjEyNDoga2V4ZWMvYXJjaC9hcm0va2V4ZWMtekltYWdlLWFybS5v
XSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1h
a2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICcvaG9tZS9ydW5uZXIvd29yay9rZXhlYy10b29scy9r
ZXhlYy10b29scy9rZXhlYy10b29scy0yLjAuMjYuZ2l0L19idWlsZC9zdWInCm1ha2U6ICoqKiBb
TWFrZWZpbGU6Mjc2OiBkaXN0Y2hlY2tdIEVycm9yIDIKRXJyb3I6IFByb2Nlc3MgY29tcGxldGVk
IHdpdGggZXhpdCBjb2RlIDIuCgpMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vaG9ybXMva2V4ZWMt
dG9vbHMvYWN0aW9ucy9ydW5zLzQ4OTUxMjQ3MTkvam9icy84NzQwMjcyMTAzCgouLi4KCj4gZGlm
ZiAtLWdpdCBhL2tleGVjL2tleGVjLmggYi9rZXhlYy9rZXhlYy5oCj4gaW5kZXggMGQ4MjBhZC4u
NmU4NDMwZSAxMDA2NDQKPiAtLS0gYS9rZXhlYy9rZXhlYy5oCj4gKysrIGIva2V4ZWMva2V4ZWMu
aAo+IEBAIC0xOTEsNyArMTkxLDEzIEBAIHVuc2lnbmVkIGxvbmcgbG9jYXRlX2hvbGUoc3RydWN0
IGtleGVjX2luZm8gKmluZm8sCj4gIAl1bnNpZ25lZCBsb25nIGhvbGVfbWluLCB1bnNpZ25lZCBs
b25nIGhvbGVfbWF4LAo+ICAJaW50IGhvbGVfZW5kKTsKPiAgCj4gKyNpZm5kZWYgX19hYXJjaDY0
X18KPiAgdHlwZWRlZiBpbnQgKHByb2JlX3QpKGNvbnN0IGNoYXIgKmtlcm5lbF9idWYsIG9mZl90
IGtlcm5lbF9zaXplKTsKPiArI2Vsc2UKPiArdHlwZWRlZiBpbnQgKHByb2JlX3QpKGNvbnN0IGNo
YXIgKmtlcm5fZm5hbWUsIG9mZl90IGtlcm5lbF9zaXplLAo+ICsJc3RydWN0IGtleGVjX2luZm8g
KmluZm8pOwo+ICsjZW5kaWYKPiArCgpUaGlzIHNlZW1zIGtpbmQgb2YgdW5mb3J0dW5hdGUuCkNv
dWxkIHdlIHVwZGF0ZSB0aGUgcHJvdG90eXBlIGZvciBhbGwgYXJjaGl0ZWN0dXJlcz8KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
