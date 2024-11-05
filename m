Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3B0D35E4B
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 20:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b/JSQTrSzb37U789dHamrbQMfVynUvv7YkFMZVXU5Gc=; b=0qxlG3dFtkXpsD
	rkUaZNaVQ49R5a75wA106KMqLwr69DJcuZSO0ADPlX2LWp1TbuFmjLJlp1kH/qyoWu0L8gQYvFFJK
	bnHkrvCEDD/u92OrP+81xAj5gv1CC5TMGouelG9OV+sJTdEB7z8+cMd802xTYasmjDayHFkqBpqEw
	zJ6K5a4oiC7mBNeAF3ilp5HtDfwp1WuDP1rTIgXi3C9/qCA1X0t8OlwP5zD1xl7BcCzDIMMR0qb7k
	YE0e/uIRQqy0XYUnJ/+sLeDd+nfX7kIlQk2zEvlalCpzlxFAAeu5mAngUnwdjJCJp3vgYvExChqzN
	bp1oBuyFpcXjBiJ+aMDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8QWs-00000000mh7-23zy;
	Tue, 05 Nov 2024 20:51:58 +0000
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8QWp-00000000mgV-2Bpo
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 20:51:56 +0000
Received: from [IPv6:::1] ([172.56.208.84])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5Kp2Qo377876
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 12:51:03 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5Kp2Qo377876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730839864;
	bh=ixwACA4CP2QvZwHQk7BOsKWdozEfHRYZScctyBHfj+o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XDaSO/HMBm3U0TE4NJUZ+zaGhgQv1Xs/9PLIwBjmwCp1S6gVvBUwpUV3P3YoGFSUq
	 ViiWkLb0+lTwuLP4joqmsc6SGTIMziFl6TC1YOvGhK4IoMB7Qpne06EO8X8gcm0U9v
	 Ryo0OZrb+qKBimxiXsLdS67QWOWFU5dLBRBzgIMJuFdnWnfNgUU4+0eu7LPYU4l598
	 i8LDKl7ZlP4i/Uf6qlYxH6tdSG22Qf3Hjah2MUHjvfLHGCZ7+8ZujqhIfwaa8NmhKC
	 fbCX9vCROqU5qtqE2sLFxAtGAoEBDgNLhnSPxuhi7h/4WD+2SOk4flyXJcdJHJF2Bz
	 9dJB51Q3HVDfw==
Date: Tue, 05 Nov 2024 12:50:56 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Woodhouse, David" <dwmw@amazon.co.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
CC: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kai.huang@intel.com" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_6/7=5D_x86/kexec=3A_Debuggi?=
 =?US-ASCII?Q?ng_support=3A_Dump_registers_on_exception?=
User-Agent: K-9 Mail for Android
In-Reply-To: <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
References: <20241103054019.3795299-1-dwmw2@infradead.org> <20241103054019.3795299-7-dwmw2@infradead.org> <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
Message-ID: <66DC35BB-A9E5-45E4-AAAD-051C22943F51@zytor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_125155_595540_5432BE2C 
X-CRM114-Status: GOOD (  10.65  )
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

T24gTm92ZW1iZXIgNSwgMjAyNCAxMjozODoxMCBQTSBQU1QsICJXb29kaG91c2UsIERhdmlkIiA8
ZHdtd0BhbWF6b24uY28udWs+IHdyb3RlOgo+T24gU3VuLCAyMDI0LTExLTAzIGF0IDA1OjM1ICsw
MDAwLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6Cj4+IAo+PiArCj4+ICsvKiBQcmludCB0aGUgYnl0
ZSBpbiAlYmwsIGNsb2JiZXIgJXJheCAqLwo+PiArU1lNX0NPREVfU1RBUlRfTE9DQUxfTk9BTElH
Tihwcl9ieXRlKQo+PiArwqDCoMKgwqDCoMKgwqBtb3ZiwqDCoMKgwqAlYmwsICVhbAo+PiArwqDC
oMKgwqDCoMKgwqBub3AKPj4gK8KgwqDCoMKgwqDCoMKgYW5kYsKgwqDCoMKgJDB4MGYsICVhbAo+
PiArwqDCoMKgwqDCoMKgwqBhZGRiwqDCoMKgwqAkMHgzMCwgJWFsCj4+ICvCoMKgwqDCoMKgwqDC
oGNtcGLCoMKgwqDCoCQweDNhLCAlYWwKPj4gK8KgwqDCoMKgwqDCoMKgamLCoMKgwqDCoMKgwqAx
Zgo+PiArwqDCoMKgwqDCoMKgwqBhZGRiwqDCoMKgwqAkKCdhJyAtICcwJyAtIDEwKSwgJWFsCj4+
ICsxOsKgwqDCoMKgwqBwcl9jaGFyCj4+ICvCoMKgwqDCoMKgwqDCoEFOTk9UQVRFX1VOUkVUX1NB
RkUKPj4gK8KgwqDCoMKgwqDCoMKgcmV0Cj4+ICtTWU1fQ09ERV9FTkQocHJfYnl0ZSkKPj4gKwo+
Cj5PYnZpb3VzbHkgdGhhdCBmdW5jdGlvbiBuYW1lIChhbmQgY29tbWVudCkgYXJlIHdyb25nOyBm
aXhlZCBpbiBteSB0cmVlLgo+YXQKPmh0dHBzOi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvZHdt
dzIvbGludXguZ2l0L3Nob3J0bG9nL3JlZnMvaGVhZHMva2V4ZWMtZGVidWcKPgo+VGhpcyBmdW5j
dGlvbiAoYW5kIGFsc28gcHJfcXdvcmQpIGFyZSBhbHNvIHdoYXQgb2JqdG9vbCBpcyBjb21wbGFp
bmluZwo+YWJvdXQ6Cj4KPnZtbGludXgubzogd2FybmluZzogb2JqdG9vbDogcmVsb2NhdGVfcmFu
Z2UrMHgyZjY6IHVucmVhY2hhYmxlIGluc3RydWN0aW9uCj52bWxpbnV4Lm86IHdhcm5pbmc6IG9i
anRvb2w6IHJlbG9jYXRlX3JhbmdlKzB4MzA1OiB1bnJlYWNoYWJsZSBpbnN0cnVjdGlvbgo+Cj5J
IGRvbid0IHF1aXRlIHNlZSB3aHksIGJlY2F1c2UgcHJfcXdvcmQoKSBxdWl0ZSBibGF0YW50bHkg
Y2FsbHMKPnByX255YmxsZSgpLCBhcyBpdCdzIG5vdyBuYW1lZC4gQW5kIGV4Y19oYW5kbGVyKCkg
cmVwZWF0ZWRseSBjYWxscwo+cHJfcXdvcmQoKS4KPgo+QnV0IG1vc3Qgb2YgdGhlIG9ianRvb2wg
YW5ub3RhdGlvbnMgSSd2ZSBhZGRlZCBoZXJlIHdlcmUganVzdCB0byBtYWtlCj5pdCBzaHV0IHVw
IGFuZCBidWlsZCwgd2l0aG91dCBtdWNoIHRob3VnaC4gUGV0ZXIsIEpvc2gsIGFueSBjaGFuY2Ug
eW91Cj5jYW4gaGVscCBtZSBmaXggaXQgdXAgcGxlYXNlPwo+Cj5JdCB3b3VsZCBhbHNvIGJlIHJl
YWxseSB1c2VmdWwgaWYgb2JqdG9vbCB3b3VsZCBsZXQgbWUgaGF2ZSBkYXRhIGluc2lkZQo+YSAi
Y29kZSIgc2VnbWVudCwgd2l0aG91dCBjb21wbGFpbmluZyB0aGF0IGl0IGNhbid0IGRlY29kZSBp
dCBhcwo+aW5zdHJ1Y3Rpb25zIOKAlCBhbmQgd2l0aG91dCBhbHNvIGZhaWxpbmcgdG8gZGVjb2Rl
IHRoZSBmaXJzdCBpbnN0cnVjdGlvbgo+b2YgdGhlICpzdWJzZXF1ZW50KiBmdW5jdGlvbi4gSSd2
ZSBwdXQgdGhlIEdEVCBhdCB0aGUgZW5kIHRvIHdvcmsKPmFyb3VuZCB0aGF0LCBidXQgaXQncyBh
IGJpdCBuYXN0eS4KCmNvZGUgaW4gdGhlIGRhdGEgKnNlY3Rpb24qIG9yICpzZWdtZW50Kj8gRWl0
aGVyIGlzIG5hc3R5LCB0aG91Z2guIFRoYXQncyB3aGF0IC5yb2RhdGEgaXMgZm9yLgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
