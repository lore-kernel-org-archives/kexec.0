Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3CACA0FEC
	for <kexec@archiver.kernel.org>; Fri,  1 Sep 2023 21:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d6ma8TmbtoCCwkHL41AAjR4gGUeK+Nl64hJfKk8OT1w=; b=ZqgipO+wl63daz
	L9wed86AAeZrIQXzdq/2WrPnlcWvPPq0GhXnbm0pFbEZRn1W0hiC+AXjNueXVCZj/ldaIHe2yY7tf
	eIfDP5SWj1k7qgTgmDnTQBa+HD5RH4cVjVBosksBrxIEYveFsKVn1bVDHhjxxCPz2FKSI5pXdDTot
	NY3WOPzzok813dZUccQywE8y1JqpAGyuvkPJqQsULLvj236s7Iuw00/soXUrLlJrwkr2IsfEArg7G
	JivXguAKeLBD5u5aigIAfYUJt6LWRjHYlis6a4Dnq/2N/Lx5rZhl1SbBDwy3lTjNsNB0dGWmOQpGf
	gdeS53KOI5ohib9TYnsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qcBZB-000PMw-1w;
	Fri, 01 Sep 2023 21:20:33 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qcBZ7-000PMD-2e
	for kexec@lists.infradead.org;
	Fri, 01 Sep 2023 21:20:32 +0000
Received: from [192.168.86.41] (unknown [50.46.242.41])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E54B212A780;
	Fri,  1 Sep 2023 14:20:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E54B212A780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1693603226;
	bh=it67IfdVDRVdX2moDR85C5xi3JsHlNUpiQ1PvFyXwyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=si6z6nr5hRK+iur7H3WtbmbfLXMYnnXtzVppQ+Hf3C0IlThevpaWcfHSHL/Tlsy6p
	 krlwvMSqsjlLhT9tTCyxtvuNg8VJSPPU/XSRpRbbLkES+L8ZCWuftDMWWN+Vhwfo8F
	 hhLQib+/gMVIhWXU8jArwJoYbG45uy7qrDsORhIc=
Message-ID: <5ce32966-c8c5-adc4-8b9e-f8300b266a61@linux.microsoft.com>
Date: Fri, 1 Sep 2023 14:20:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - network bandwidth
Content-Language: en-US
To: Ken Goldman <kgold@linux.ibm.com>,
 Sush Shringarputale <sushring@linux.microsoft.com>,
 linux-integrity@vger.kernel.org, zohar@linux.ibm.com, peterhuewe@gmx.de,
 jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
 Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
 linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <5c323243-e22e-dd61-f808-2875654936a6@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <5c323243-e22e-dd61-f808-2875654936a6@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_142029_889553_82807ABF 
X-CRM114-Status: GOOD (  10.34  )
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

VGhhbmtzIGEgbG90IEtlbiBmb3IgbG9va2luZyBhdCB0aGUgcHJvcG9zYWwsIGFuZCBzaGFyaW5n
IHlvdXIgdGhvdWdodHMuCgpPbiA4LzMwLzIzIDExOjA2LCBLZW4gR29sZG1hbiB3cm90ZToKPiAK
PiAKPiBPbiA4LzEvMjAyMyAzOjEyIFBNLCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+PiBJ
biBhZGRpdGlvbiwgYSBsYXJnZSBJTUEgbG9nIGNhbiBhZGQgcHJlc3N1cmUgb24gdGhlIG5ldHdv
cmsgYmFuZHdpZHRoIAo+PiB3aGVuCj4+IHRoZSBhdHRlc3RhdGlvbiBjbGllbnQgc2VuZHMgaXQg
dG8gcmVtb3RlLWF0dGVzdGF0aW9uLXNlcnZpY2UuCj4gCj4gSSB3b3VsZCBub3Qgd29ycnkgdG9v
IG11Y2ggYWJvdXQgbmV0d29yayBiYW5kd2lkdGguCk91ciBiYW5kd2lkdGggY29uY2VybnMgYXJl
IGFib3V0IHNjYWxlZCBvdXQgc3lzdGVtLgoKV2hlbiBJTUEgbG9nIHNpemUgaW5jcmVhc2VzIGlu
IHRoZSByYW5nZSBvZiBtZWdhYnl0ZXMsIGFuZCB3aGVuIHRoZQpudW1iZXIgb2YgY2xpZW50IGRl
dmljZXMgaW5jcmVhc2VzLCBpdCBtYWtlcyBhbiBpbXBhY3Qgb24gdGhlIG92ZXJhbGwKbmV0d29y
ayBiYW5kd2lkdGguCgo+IAo+IDEuIEV2ZXJ5IHNvbHV0aW9uIGV2ZW50dWFsbHkgcmVhbGl6ZXMg
dGhhdCBzZW5kaW5nIHRoZSBlbnRpcmUgbG9nIGVhY2ggCj4gdGltZSBodXJ0cyBwZXJmb3JtYW5j
ZS7CoCBUaGUgdmVyaWZpZXIgd2lsbCBhc2sgdGhlIGF0dGVzdG9yLCAiZ2l2ZSBtZSAKPiBldmVy
eXRoaW5nIHNpbmNlIHJlY29yZCBuIiwgYW5kIHRoZSBudW1iZXIgb2YgbmV3IGVudHJpZXMgYXBw
cm9hY2hlcyB6ZXJvLgo+IApDb21wbGV0ZWx5IGFncmVlZC4gSU1BIGxvZyBzbmFwc2hvdHRpbmcg
KHRoaXMgcHJvcG9zZWQgZmVhdHVyZSkgaXMgYQpzb2x1dGlvbiBpbiB0aGF0IGRpcmVjdGlvbi4K
Cj4gMi4gTXkgYmVuY2htYXJrcyBzaG93IHRoYXQKPiAKPiBPbiB0aGUgY2xpZW50LCB0aGUgVFBN
IHF1b3RlIHRpbWUgc3dhbXBzIGV2ZXJ5dGhpbmcgZWxzZS4KPiBPbiB0aGUgc2VydmVyLCB2ZXJp
ZnlpbmcgdGhlIElNQSBlbnRyeSBzaWduYXR1cmVzIHN3YW1wcyBldmVyeXRoaW5nIGVsc2UuCj4g
Cj4gVGhlIG5ldHdvcmsgdHJhbnNmZXIgdGltZSBpcyBuZWdsaWdpYmxlLgpBZ3JlZWQsIGl0IGlz
IHRydWUgaW4gdGhlIGNvbnRleHQgb2YgYW4gaW5kaXZpZHVhbCBjbGllbnQgZGV2aWNlLgoKT3Vy
IG5ldHdvcmsgYmFuZHdpZHRoIGNvbmNlcm5zIGFyZSBmb3IgdGhlIG92ZXJhbGwgdHJhZmZpYyBv
biB0aGUgc2NhbGVkCm91dCBzeXN0ZW0uIEl0IGltcGFjdHMgdGhlIG5ldHdvcmsgYmFuZHdpZHRo
IHdoZW4gdGhlIElNQSBsb2cgaXMgbGFyZ2UKKE1CcykuICBBbmQgdGhlIGlzc3VlIGlzIGNvbXBv
dW5kZWQgd2hlbiB0aGVyZSBhcmUgbGFyZ2UgbnVtYmVyIG9mCmNsaWVudCBkZXZpY2VzLgoKVGhh
bmtzLApUdXNoYXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
