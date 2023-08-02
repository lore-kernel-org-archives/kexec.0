Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4134AC001DF
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 21:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aYQQqV8FSRlv0wHXhxHiSMwZFtASvWCWgR+gpsByvLU=; b=HwQwf+u1WtAkQR
	NjtryTTFvlU4U5i/lTj28VrcZvbHQcFBKr+rDtoWeHGmzLnByNzIiP/5mO2ZknvMxCJIeq5X4a2CD
	IZ1+nBlkWGcwju1/K2X3PMyxMiKA3KslSdob1+sIC4Sq8b30uyUiyEEjQC/5kjh8YxPLUUMkruze9
	JgQiauzlOaHg8+3u+jcvqsL4EvXMQZusu5a6fPCrGgVU6VBrMWdvUIDs0CqHIdlyzY6kZZms6Hncj
	ujBnr9lQpQpkj4a3OEFLX+SasS/0lBY9MCodyLZvKp9oPeE9OhKX7+DfXe0YCmao0FO6HNc8qj++K
	6+ujq/WBT84E5tStnhOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRJ1l-005thz-2N;
	Wed, 02 Aug 2023 21:05:05 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRJ1i-005th2-1W
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 21:05:04 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 515BD238C43B;
	Wed,  2 Aug 2023 14:04:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 515BD238C43B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691010298;
	bh=lDhGmfOqOASIVIWXuGXoYoWxEku+AuKF6Qlgy+mAwtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bU9/BT1+pCU9BG6swaQw91EZJeOBr4XQsaCuEhORCtzAm2tWmwVLxpCePkXMCd94r
	 ya5C3hChz2Ax3H8zeh1WuxjCSNA5sZGGxq4QSHQx0obmVtsfTt7XU5BRjfi1m2kJXr
	 OcsZhZ4RdSCjMMlbTWveU7naD+yvYEYmmiEDLvlQ=
Message-ID: <dd126081-3216-c15e-124e-ef137b376cdb@linux.microsoft.com>
Date: Wed, 2 Aug 2023 14:04:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, zohar@linux.ibm.com, noodles@fb.com,
 bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
 vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de, jgg@ziepe.ca,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_140502_580251_84DE5324 
X-CRM114-Status: GOOD (  24.14  )
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

Ck9uIDgvMS8yMyAyMDo1OCwgSmFya2tvIFNha2tpbmVuIHdyb3RlOgo+IE9uIFdlZCBBdWcgMiwg
MjAyMyBhdCAxMjowMSBBTSBFRVNULCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4+IFRoYW5rcyBm
b3IgdGhlIHJlc3BvbnNlIEphcmtrby4KPj4KPj4gT24gOC8xLzIzIDEyOjAyLCBKYXJra28gU2Fr
a2luZW4gd3JvdGU6Cj4+PiBUaGUgc2hvcnQgc3VtbWFyeSBpcyBjcnlwdGljIHRvIHNheSB0aGUg
bGVhc3QuCj4+IERvIHlvdSBtZWFuIHRoZSBwYXRjaCBzdWJqZWN0IGxpbmUsIG9yIHRoZSBkZXNj
cmlwdGlvbiBiZWxvdz8KPiBJdCBpcyBpbiB0aGUgcHJvY2VzcyBkb2N1bWVudGF0aW9uOgo+Cj4g
aHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92Ni4zL3Byb2Nlc3Mvc3VibWl0dGluZy1w
YXRjaGVzLmh0bWwjdGhlLWNhbm9uaWNhbC1wYXRjaC1mb3JtYXQKU291bmRzIGdvb2QuwqAgSSB3
aWxsIGNsZWFudXAgYm90aCB0aGUgc3VtbWFyeSBwaHJhc2UgYW5kIHRoZSBwYXRjaCAKZGVzY3Jp
cHRpb24uCj4+PiAidXBkYXRlIGNvdW50ZXIiIGRvZXMgbm90IG1hcCBpdCB0byBoYXZlIGFueXRo
aW5nIHRvIGRvIHdpdGggUENScy4KPj4gQWdyZWVkLsKgIEkgbm90aWNlZCB0aGF0IHdoZW4gSSB3
YXMgdGVzdGluZyB0aGUgcGF0Y2hlcy4KPj4gVGhlIHVwZGF0ZSBjb3VudGVyIGlzIHNhbWUgZm9y
IGFsbCBQQ1JzLsKgIEl0IHdhcyBhbHNvIHRoZSBzYW1lIGZvcgo+PiB0aGUgdHdvIGhhc2ggYWxn
bydzIEkgdGVzdGVkIGl0IGZvciAoU0hBMSBhbmQgU0hBMjU2KS4gQnV0IHRoZSBzcGVjCj4+IGRl
c2NyaXB0aW9uIGFuZCBLZXJuZWwgaW1wbGVtZW50YXRpb24gcmVxdWlyZXMgdG8gcGFzcyB0aGUK
Pj4gcGNyX2lkeCBhbmQgaGFzaCBhbGdvIHRvIFBDUl9SZWFkIGNvbW1hbmQgdG8gZ2V0IHRoZSB1
cGRhdGUgY291bnRlci4KPiBJIHdhcyByZWZlcnJpbmcgdG8gdGhlIGZhY3QgdGhhdCBUUE0yX1BD
Ul9SZWFkIGRvZXMgbm90IGhhdmUgYSBmaWVsZAo+IGNhbGxlZCAidXBkYXRlIGNvdW50ZXIiIGlu
IGl0cyByZXNwb25zZSBidXQgaXQgaGFzIGEgZmllbGQgY2FsbGVkCj4gInBjclVwZGF0ZUNvdW50
ZXIiLiBQbGVhc2UgcmVmZXIgdG8gdGhpZ3MgdGhhdCBhY3R1YWxseSBleGlzdC4KPgo+IEluIHRo
ZSBsb25nIGRlc2NyaXB0aW9uIHlvdSBhcmUgaW4gc29tZSBvY2Nhc2lvbnMgcmVmZXJyaW5nIHRv
IHRoZSBzYW1lCj4gb2JqZWN0IGFzOgo+Cj4gMS4gInVwZGF0ZSBjb3VudGVyIgo+IDIuICJwY3JV
cGRhdGVDb3VudGVyIgo+IDMuICJQY3JVcGRhdGVDb3VudGVyIgo+Cj4gVGhpcyBpcyBhbWJpZ3Vv
dXMgYW5kIHdyb25nLgpUaGFua3MuIEkgd2lsbCBjb25zaXN0ZW50bHkgdXNlIHBjclVwZGF0ZUNv
dW50ZXIgZ29pbmcgZm9yd2FyZC4KPiA+RnJvbSBsb25nIGRlc2NyaXB0aW9uIEkgc2VlIHplcm8g
bW90aXZhdGlvbiB0byBhY2sgdGhpcyBjaGFuZ2UsIGV4Y2VwdAo+IHNvbWUgaGVyZXNheSBhYm91
dCBJTUEgcmVxdWlyaW5nIGl0LiBXaHkgZG9lcyBJTUEgbmVlZCB1cGRhdGVfY250IGFuZAo+IHdo
eSB0aGlzIGlzIG5vdCBkb2N1bWVudGVkIHRvIHRoZSBsb25nIGRlc2NyaXB0aW9uPwpTaW5jZSBw
YXRjaCAyIG9mIHRoaXMgc2VyaWVzIGV4cG9zZXMgdGhlIGZ1bmN0aW9uYWxpdHkgdG8gSU1BLApp
dCBpcyBkZXNjcmliZWQgaW4gdGhlIGxvbmcgZGVzY3JpcHRpb24gb2YgcGF0Y2ggMi4KCkJ1dCBJ
IGNhbiBhZGQgdGhlIGRlc2NyaXB0aW9uIGhlcmUgYXMgd2VsbCBmb3IgY29tcGxldGVuZXNzLgo+
PiBCdXQgSSBjYW4gdXBkYXRlIHRwbTJfcGNyX3JlYWQoKSBpZiB5b3UgYXJlIG9rIHdpdGggaXQu
Cj4+IFBsZWFzZSBsZXQgbWUga25vdy4KPiBZb3UgY2FuIGFkZCAidTMyICp1cGRhdGVfY250Ii4K
U291bmRzIGdvb2QuwqAgV2lsbCBkby4KCkJ0dywgdGhlIGZ1bmN0aW9uIHRwbTJfcGNyX3JlYWQg
aXMgbm90IGV4cG9zZWQgZGlyZWN0bHkgdG8gdGhlIG90aGVyCnN1YnN5c3RlbXMgKGxpa2UgSU1B
KS7CoCBJdCBpcyBleHBvc2VkIHZpYSB0cG1fcGNyX3JlYWQuCgpEbyB5b3Ugd2FudCB0byBleHBv
c2UgdHBtMl9wY3JfcmVhZCBkaXJlY3RseSwKb3IgZG8geW91IHdhbnQgbWUgdG8gdXBkYXRlIHRo
ZSBmdW5jdGlvbiBzaWduYXR1cmUgb2YgdHBtX3Bjcl9yZWFkIGFzIHdlbGw/CgpVcGRhdGluZyB0
aGUgZnVuY3Rpb24gc2lnbmF0dXJlIG9mIHRwbV9wY3JfcmVhZCBhcyB3ZWxsIC0KdG8gcmV0dXJu
ICJ1MzIgKnVwZGF0ZV9jbnQiIHNlZW1zIGxpa2UgdGhlIHJpZ2h0IGFwcHJvYWNoLgpJbiB0aGF0
IGNhc2UsIEkgY2FuIHNldCAqdXBkYXRlX2NudCB0byBzYXkgMCBvciAtMSBmb3IgVFBNMQooYmVj
YXVzZSBwY3JVcGRhdGVDb3VudGVyIGlzIG5vdCBhdmFpbGFibGUgZm9yIFRQTTEpLgoKUGxlYXNl
IGxldCBtZSBrbm93IHdoYXQgZG8geW91IHRoaW5rLgoKSSB3aWxsIG1ha2UgdGhlIGNoYW5nZXMg
YWNjb3JkaW5nbHkuCgpJIHdpbGwgYWxzbyB3YWl0IGZvciBJTUEvS2V4ZWMgbWFpbnRhaW5lcnMg
dG8gdGFrZSBhIGxvb2sgYXQgdGhlIApyZW1haW5pbmcgcGF0Y2hlcwppbiB0aGlzIHNlcmllcywg
aW5jb3Jwb3JhdGUgdGhlaXIgZmVlZGJhY2ssIGFuZCBzZW5kIHRoZSBWMiBvZiB0aGlzIHNlcmll
cy4KClRoYW5rcyBhZ2FpbiBmb3IgeW91ciBmZWVkYmFjay4gUmVhbGx5IGFwcHJlY2lhdGUgaXQu
Cgp+VHVzaGFyCj4KPiBCUiwgSmFya2tvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
