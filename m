Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BB3C3DA6E
	for <kexec@archiver.kernel.org>; Mon, 25 Dec 2023 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X5Bhplb4wJUK+VH6HSWGtWQuO/2EAqBjlIahW579hMo=; b=BQ+J+WfzjPbAMN
	0SBZdbHhNhV+yG9+hUIXcmjVeOt4ABNieE3n8oSX/8YyITbbBGWnCx8+vWUWdMuB4TBgSpXgfrf2H
	qhcppSTsDyWO1qT/rMTJgfWrBrmYQDQjmv2nHAqfquAdGz0lh0Y5sFSZqvjv6ZWOGsJsi7+JBkTt6
	e1N2dLmW48RTA5O6mEhI4Tx77aGCcQOjpKXK0bom6E1FX+5wuVQgo8T/hMD97iNI/xqWIRBbQxi0N
	oHkQ32fJ0alFtrfsbO7pjXbH3yMZcsttuFveiNd9Ml4E+FY4FRP16rtcWs7jCfMk+H122gGhwvMpU
	Yx77YKUVcGTeerFcWROA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHlFs-00Awnl-2J;
	Mon, 25 Dec 2023 13:44:28 +0000
Received: from mail-m25473.xmail.ntesmail.com ([103.129.254.73])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHlFo-00AwnH-2G
	for kexec@lists.infradead.org;
	Mon, 25 Dec 2023 13:44:27 +0000
Received: from [10.9.0.134] (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id EB78C4C0290;
	Mon, 25 Dec 2023 21:44:02 +0800 (CST)
Message-ID: <a65e7a06-bc91-4c82-9a65-6066f9f64409@easystack.cn>
Date: Mon, 25 Dec 2023 21:44:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/kexec: fix potential cmem->ranges out of bounds
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231222121855.148215-1-fuqiang.wang@easystack.cn>
 <ZYWPHSmwK8iG6xUr@MiWiFi-R3L-srv> <ZYe3iN816iiKDwIu@MiWiFi-R3L-srv>
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <ZYe3iN816iiKDwIu@MiWiFi-R3L-srv>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEpMVk5KTxlLTExNGR5KGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8ca137e1fd022ekunmeb78c4c0290
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6Nzo5STc#Fy4DGT0SIzgR
	Gh0aCxBVSlVKTEtITkpKQ09ITE1PVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFJS0xCNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_054424_970467_80D0EFB1 
X-CRM114-Status: UNSURE (   8.76  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

5ZyoIDIwMjMvMTIvMjQgMTI6NDYsIEJhb3F1YW4gSGUg5YaZ6YGTOgoKPiBSZXRoaW5rIGFib3V0
IHRoaXMsIHNlZW1zIGFib3ZlIGNvZGUgY29tbWVudCBpcyBmaW5lIHRvIGJlIGtlcHQsIGFuZCB0
aGUKPiBzYW1lIGZlZWxpbmcgYWJvdXQgdGhlIGVsZmhlYWRlciByZWdpb24gc3BsaXQgZnJvbSBj
cmFzaGtfcmVzLiBTbywgb3RoZXIKPiB0aGFuIHRoZSBwYXRjaCBsb2cgY29uY2VybnMsIHRoaXMg
cGF0Y2ggbG9va3MgZ29vZCB0byBtZS4gTGV0J3Mgc2VlIGlmCj4gb3RoZXIgcGVvcGxlIGhhcyBj
b25jZXJuIGFib3V0IHRoZSBuZXdseSBhZGRlZCBjb21tZW50cy4KPgoKSGkgQmFvcXVhbgoKVGhh
bmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBzdWdnZXN0aW9ucyBpbiB0aGUgcGF0Y2ggbG9nIGFu
ZCBjb2RlIGNvbW1lbnRzLiBJCmhhdmUgbGVhcm5lZCBhIGxvdCBhbmQgSSB3aWxsIGdyYWR1YWxs
eSBpbXByb3ZlLgoKSSBmb3VuZCB0aGUgZm9sbG93aW5nIHBhdGNoIGluIGxpbnV4LW5leHQ6Cmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgt
bmV4dC5naXQvY29tbWl0Lz9pZD02NjZlZjEzZjI4NzBjNDNiYThhNDAyZWM4YTNjZWRmNmViNmM2
ZjVhCgpJJ20gc29ycnksIEl0J3MgbXkgbWlzdGFrZS4gRG8geW91IHRoaW5rIGl0IGlzIHN0aWxs
IG5lY2Vzc2FyeSB0byBtZXJnZSB0aGlzCnBhdGNoIGJhc2VkIG9uIHRoYXQgPwoKVGhhbmtzIGEg
bG90IGFnYWluCmZ1cWlhbmcKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
