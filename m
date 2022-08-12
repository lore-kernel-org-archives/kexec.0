Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEE1C00140
	for <kexec@archiver.kernel.org>; Fri, 12 Aug 2022 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dd1PajheSPQq/IyHLh+Q7Ppv6V7H5TDLm75DrddGV0o=; b=xIe4afhCWEy18X
	y3JPkh+f4xTgB7Io95Ee7Rc+uUlUdlZJH9vKOVJKZhWuX5toDWufnEsFEy8PTD3G6Oo0PL75KzOXN
	QC22Nv5pJEGsPeEfA0odIjDiaOu7cl27BVdQ2eIaCTRG0UgyPq00nIrQ4IOvV4Exelt+8+rKocDA9
	AUVTPJEmBvMr4duw94JynaUs1IKBqdkeUH2KquxYE8UIoUuIGDy+VdyOErx86RIsrmeI32lf6DhWS
	C3nxYuI4g5L57dg4qTeRThWhc73R3F8lFLJj3xcLcG6kLtLQEcB5bT9sFSgMusL2jesrtvsXVxg1r
	lfqXM99ybxis0RQqszWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMYB1-00BJ4G-92; Fri, 12 Aug 2022 17:10:27 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMYAy-00BIwN-0Z
	for kexec@lists.infradead.org; Fri, 12 Aug 2022 17:10:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 458965D92B;
	Fri, 12 Aug 2022 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1660324217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZjtB7m6BM8AVhGJqivBSe/7V5icuzmK/CCVIama6jM=;
	b=a7EnxMAWHDQ7qxPyrbYQ5fcbQMBTp2uWL0w2+8GQKwLJzELA/gM4X8VIWmlQRSkY4OG5Yi
	pqeAMyEiq/tTq4ZJqJ+KxyCh9/+RQI9PCBIw+Aedr6JaGjK5oSMcb5di3bIVAnJJBeBC4a
	ofe/FDsDHQpdjMnJ2qztwgZYre8fYU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1660324217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZjtB7m6BM8AVhGJqivBSe/7V5icuzmK/CCVIama6jM=;
	b=FKbQeBcNh1ssOnHGq/YFnDeFNTrgMI7ojeVuiOdvXg32EfSn8MN3RO8eVvHyVdy3dYSm7u
	lAuDs4f+3HMR4GAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37B0C13AAE;
	Fri, 12 Aug 2022 17:10:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id YMGNDXmJ9mIOCAAAMHmgww
	(envelope-from <bp@suse.de>); Fri, 12 Aug 2022 17:10:17 +0000
Date: Fri, 12 Aug 2022 19:10:11 +0200
From: Borislav Petkov <bp@suse.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
	nasastry@in.ibm.com, mpe@ellerman.id.au,
	Jonathan McDowell <noodles@fb.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v7 3/6] x86/kexec: Carry forward IMA measurement log on
 kexec
Message-ID: <YvaJc7bQjz61Y1jj@zn.tnic>
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
 <20220812164305.2056641-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220812164305.2056641-4-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_101024_457281_85DCD835 
X-CRM114-Status: GOOD (  15.80  )
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

T24gRnJpLCBBdWcgMTIsIDIwMjIgYXQgMTI6NDM6MDJQTSAtMDQwMCwgU3RlZmFuIEJlcmdlciB3
cm90ZToKPiBGcm9tOiBKb25hdGhhbiBNY0Rvd2VsbCA8bm9vZGxlc0BmYi5jb20+Cj4gCj4gT24g
a2V4ZWMgZmlsZSBsb2FkLCB0aGUgSW50ZWdyaXR5IE1lYXN1cmVtZW50IEFyY2hpdGVjdHVyZSAo
SU1BKQo+IHN1YnN5c3RlbSBtYXkgdmVyaWZ5IHRoZSBJTUEgc2lnbmF0dXJlIG9mIHRoZSBrZXJu
ZWwgYW5kIGluaXRyYW1mcywgYW5kCj4gbWVhc3VyZSBpdC4gVGhlIGNvbW1hbmQgbGluZSBwYXJh
bWV0ZXJzIHBhc3NlZCB0byB0aGUga2VybmVsIGluIHRoZQo+IGtleGVjIGNhbGwgbWF5IGFsc28g
YmUgbWVhc3VyZWQgYnkgSU1BLgo+IAo+IEEgcmVtb3RlIGF0dGVzdGF0aW9uIHNlcnZpY2UgY2Fu
IHZlcmlmeSBhIFRQTSBxdW90ZSBiYXNlZCBvbiB0aGUgVFBNCj4gZXZlbnQgbG9nLCB0aGUgSU1B
IG1lYXN1cmVtZW50IGxpc3QgYW5kIHRoZSBUUE0gUENSIGRhdGEuIFRoaXMgY2FuCj4gYmUgYWNo
aWV2ZWQgb25seSBpZiB0aGUgSU1BIG1lYXN1cmVtZW50IGxvZyBpcyBjYXJyaWVkIG92ZXIgZnJv
bSB0aGUKPiBjdXJyZW50IGtlcm5lbCB0byB0aGUgbmV4dCBrZXJuZWwgYWNyb3NzIHRoZSBrZXhl
YyBjYWxsLgo+IAo+IFBvd2VyUEMgYW5kIEFSTTY0IGJvdGggYWNoaWV2ZSB0aGlzIHVzaW5nIGRl
dmljZSB0cmVlIHdpdGggYQo+ICJsaW51eCxpbWEta2V4ZWMtYnVmZmVyIiBub2RlLiB4ODYgcGxh
dGZvcm1zIGdlbmVyYWxseSBkb24ndCBtYWtlIHVzZSBvZgo+IGRldmljZSB0cmVlLCBzbyB1c2Ug
dGhlIHNldHVwX2RhdGEgbWVjaGFuaXNtIHRvIHBhc3MgdGhlIElNQSBidWZmZXIgdG8KPiB0aGUg
bmV3IGtlcm5lbC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBNY0Rvd2VsbCA8bm9vZGxl
c0BmYi5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPgo+
IFJldmlld2VkLWJ5OiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiAjIElNQSBmdW5j
dGlvbiBkZWZpbml0aW9ucwo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvWW1LeXZs
RjNteTF5V1R2S0Bub29kbGVzLWZlZG9yYS1QQzIzWTZFRwoKSXMgdGhlcmUgYW55IHBhcnRpY3Vs
YXIgcmVhc29uIHRvIGtlZXAgc2VuZGluZyBhIHBhdGNoIHdoaWNoIGlzIGFscmVhZHkKdXBzdHJl
YW0/CgotLSAKUmVnYXJkcy9HcnVzcywKICAgIEJvcmlzLgoKU1VTRSBTb2Z0d2FyZSBTb2x1dGlv
bnMgR2VybWFueSBHbWJICkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1jRG9u
YWxkLCBNYXJ0amUgQm91ZGllbiBNb2VybWFuCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
