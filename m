Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598D9C001DF
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/0a2OSWFsnA+/jHmD4pRNbNszKsYFH/dvuyNESyqZvM=; b=Pb6XN9yNOh7QEL
	9fRZKOI7UxJ95Wp/tncXs8jUR/q1iXvTk+TrLAWvxLrMxyYg2dR002Z8kyT4zeieRPb8rxE62pawo
	Iga01dUcbGUKVzJ24yBvtsOL6tYNpCBEYNarJMdgNfLhfiPIwrkH0Ru01mSTvcwMdfnJA/qRTTwSV
	JvJuSplvns07PP4Poabo+JK1JBJMbtr51+NQnWPQZef4Swaze9Uh4kGCULEou0iONBhVws0Ze5nmA
	KCC4DoXha78JKJC3Qj6bTan/yGlV8SW6D+7MJ//50zCtWG1i6jbwyWF7o+6NMfTLE6lStTdAMjEpq
	obZ1fDQ2gxiwbh3UlU2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRAmQ-004sXR-2o;
	Wed, 02 Aug 2023 12:16:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRAmN-004sWs-04
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 12:16:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BE77A61934;
	Wed,  2 Aug 2023 12:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C59EC433C8;
	Wed,  2 Aug 2023 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690978597;
	bh=mJfqVZK+jvN4uGhoEgDCkbf492zRjfUslV9sKG0GxUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFSueOEaiSo6UJZSPmZCcHj9ZGGOGIBQS8dMOPobzkdSeL0unXqItOzWoArh8M48/
	 eGSaTM2+psUfWmVf8Tv1Fwm9Y0NEvHY7M6wpxMMw60u8Arxzlmy8eq5GgcQ9xzgem7
	 hCF4DqJig00/kg/bGT5zG53zD0m/7zqJno2o5/ZWiPFLTpF8ECJJaPw2HsrHV3pwhO
	 DZ7QVgNy7zTSVuOTKPs9eXA2ONfP7gW822UwqtHcT4TlwmUbZxwfMIuUcQez7bz1Zb
	 LZYs91cP/E9/ZEkN9yYS6FrXpD4LARsUC92bUk3H2LRD5VG97CtL/QUIsUOalz4zga
	 t8ffekgWvSogQ==
Date: Wed, 2 Aug 2023 14:16:33 +0200
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>,
	horms@verge.net.au, ardb@kernel.org
Subject: Re: [PATCHv6 3/5] kexec/zboot: Add arch independent zboot support
Message-ID: <ZMpJIZ18ynQLln8W@kernel.org>
References: <20230724022142.6425-1-piliu@redhat.com>
 <20230724022142.6425-4-piliu@redhat.com>
 <ZMitmSZPqnH+/70s@kernel.org>
 <CAF+s44QBMgsT7Q2ro9obVvHYCrKYTQoeCnOVOMzhfexQS+_6Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF+s44QBMgsT7Q2ro9obVvHYCrKYTQoeCnOVOMzhfexQS+_6Sw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_051639_159328_04E38871 
X-CRM114-Status: GOOD (  28.88  )
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

T24gV2VkLCBBdWcgMDIsIDIwMjMgYXQgMDU6NTM6NTlQTSArMDgwMCwgUGluZ2ZhbiBMaXUgd3Jv
dGU6Cj4gSGkgU2ltb24sCj4gCj4gVGhhbmtzIGZvciB0aGUgdHJ5LiBQbGVhc2Ugc2VlIHRoZSBj
b21tZW50IGJlbG93Lgo+IAo+IE9uIFR1ZSwgQXVnIDEsIDIwMjMgYXQgMzowMOKAr1BNIFNpbW9u
IEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCBKdWwgMjQs
IDIwMjMgYXQgMTA6MjE6NDBBTSArMDgwMCwgUGluZ2ZhbiBMaXUgd3JvdGU6Cj4gPiA+IEZyb206
IEplcmVteSBMaW50b24gPGplcmVteS5saW50b25AYXJtLmNvbT4KPiA+ID4KPiA+ID4gVGhlIGxp
bnV4IGtlcm5lbCBDT05GSUdfWkJPT1Qgb3B0aW9uIGNyZWF0ZXMKPiA+ID4gc2VsZiBkZWNvbXBy
ZXNzaW5nIFBFIGtlcm5lbCBpbWFnZXMuIFNvIHRoaXMgbWVhbnMKPiA+ID4gdGhhdCBrZXhlYyBz
aG91bGQgaGF2ZSBhIGdlbmVyaWMgdW5kZXJzdGFuZGluZyBvZgo+ID4gPiB0aGUgZm9ybWF0IHdo
aWNoIG1heSBiZSB1c2VkIGJ5IG11bHRpcGxlIGFyY2hlcy4KPiA+ID4KPiA+ID4gU28gbGV0cyBh
ZGQgYW4gYXJjaCBpbmRlcGVuZGVudCB2YWxpZGF0aW9uCj4gPiA+IGFuZCBkZWNvbXByZXNzaW9u
IHJvdXRpbmUuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEplcmVteSBMaW50b24gPGplcmVt
eS5saW50b25AYXJtLmNvbT4KPiA+ID4gW01vZGlmaWVkIGJ5IFBpbmdmYW4gdG8gZXhwb3J0IGtl
cm5lbCBmZF0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUGluZ2ZhbiBMaXUgPHBpbGl1QHJlZGhhdC5j
b20+Cj4gPgo+ID4gSGkgUGluZ2ZhbiwKPiA+Cj4gPiB1bmZvcnR1bmF0ZWx5IHRoaXMgY2F1c2Vz
IGEgYnVpbGQgZmFpbHVyZSBvbiBocHBhLgo+ID4KPiA+IC4uLy4uL2tleGVjL2tleGVjLXBlLXpi
b290LmM6MzE6MTA6IGZhdGFsIGVycm9yOiBrZXhlYy1wZS16Ym9vdC5oOiBObyBzdWNoIGZpbGUg
b3IgZGlyZWN0b3J5Cj4gPiAgICAzMSB8ICNpbmNsdWRlIDxrZXhlYy1wZS16Ym9vdC5oPgo+ID4g
ICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4KPiA+Cj4gPiBMaW5rOiBodHRwczov
L2dpdGh1Yi5jb20vaG9ybXMva2V4ZWMtdG9vbHMvYWN0aW9ucy9ydW5zLzU3MjM1ODA1MjMvam9i
LzE1NTA4NDI1NzkwCj4gPgo+IAo+IEl0IGlzIG5vdCByZWxhdGVkIHRvIGNyb3NzLWNvbXBpbGlu
Zy4gQWN0dWFsbHksIEkgaGF2ZSB0cmllZCB0bwo+IHNpbXBsaWZ5IHRoZSB0ZXN0IG1hdHJpeCwg
d2hpY2ggbGltaXRzIHRoZSBjb21waWxhdGlvbiBvbmx5IG9uIHg4Nl82NC4KPiBBbmQgSSBnb3Qg
dGhlIHNpbWlsYXIgZXJyb3IgWzFdCj4gCj4gVGhlIHdvcmtmbG93IGNvbnRyb2wgZmlsZSBpcyBb
Ml0sIHdoaWNoIGNsaXBzIG91dCBhbGwgYXJjaGVzIGV4Y2VwdAo+IHg4Nl82NC4gIEJ1dCBJIGNh
biBzdWNjZXNzZnVsbHkgYnVpbGQgaXQgb24gdGhlIEZlZG9yYSBzeXN0ZW0gd2l0aCB0aGUKPiBm
b2xsb3dpbmcgYmFzaCBzY3JpcHQsIHdoaWNoIGlzIGJhc2VkIG9uIHRoZSBnaXRodWIncyBidWls
ZCBsb2cuICBTbwo+IG1heWJlIGl0IGlzIGEgYnVnIHdpdGggdGhlIGNvbXBpbGluZyB0b29scz8K
PiAKPiBrZXhlY190b29sc19kaXI9Ii4vIgo+IAo+IG1rZGlyICRrZXhlY190b29sc19kaXIvX2J1
aWxkIFwKPiAgICAgICAgICAka2V4ZWNfdG9vbHNfZGlyL19idWlsZC9zdWIgXAo+ICAgICAgICAg
ICRrZXhlY190b29sc19kaXIvX2luc3QgXAo+ICAgICAgICAgICRrZXhlY190b29sc19kaXIvX2Rl
c3QKPiBjaG1vZCBhLXcgJGtleGVjX3Rvb2xzX2Rpcgo+IHRlc3QgLWQgJGtleGVjX3Rvb2xzX2Rp
ci9fYnVpbGQKPiBJTlNUQUxMX0JBU0U9JChjZCAka2V4ZWNfdG9vbHNfZGlyL19pbnN0ICYmIHB3
ZCB8IHNlZCAtZQo+ICdzLF5bXjpcXC9dOltcXC9dLC8sJykgJiZcCj4gICAgICAgICBERVNURElS
PSIka2V4ZWNfdG9vbHNfZGlyL19kZXN0IiAmJiBcCj4gICAgICAgICBjZCAka2V4ZWNfdG9vbHNf
ZGlyL19idWlsZC9zdWIgJiYgXAo+ICAgICAgICAgICAgICAgICAuLi8uLi9jb25maWd1cmUgXAo+
ICAgICAgICAgICAgICAgICAgXAo+ICAgICAgICAgICAgICAgICAtLXNyY2Rpcj0uLi8uLiAtLXBy
ZWZpeD0iJElOU1RBTExfQkFTRSIgJiYgXAo+ICAgICAgICAgbWFrZSAgLWo4Cj4gCj4gCj4gWzFd
OiBodHRwczovL2dpdGh1Yi5jb20vcGZsaXUva2V4ZWMtdG9vbHMvYWN0aW9ucy9ydW5zLzU3Mzcy
NTQxMDkvam9iLzE1NTQ4NTIwODYzCj4gWzJdOiBodHRwczovL2dpdGh1Yi5jb20vcGZsaXUva2V4
ZWMtdG9vbHMvYmxvYi96Ym9vdFY2Ly5naXRodWIvd29ya2Zsb3dzL21haW4ueW1sCgpUaGFua3Ms
CgpJIGd1ZXNzIHRoYXQga2V4ZWMtcGUtemJvb3QuaCBpcyBtaXNzaW5nIGluIHRoZSBidWlsZCBl
bnZpcm9ubWVudCBmb3IgdGhlCkdpdEh1YiBhY3Rpb25zLCBidXQgcHJlc2VudCBpbiB5b3VyIEZl
ZG9yYSBlbnZpcm9ubWVudC4KCkNvdWxkIHlvdSB0YWtlIGEgbG9vayBhbmQgc2VlIHdoZXJlIHlv
dXIgY29weSBvZiBrZXhlYy1wZS16Ym9vdC5oCmNhbWUgZnJvbT8KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
