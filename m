Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE75C4332F
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LDDzRNGAhRBbfAFL4R1cD2/7h2e8A3m3h9q6eDdOHxk=; b=1bm8WigNobs/GR
	uRyqSu7K69FtMaKNrF57ng1XW7yGlA/iXnT+NPN0sO+tMORWx4jFrvABmJyqE9Ro3YQ1K9qWwAFH/
	n7b0rljDDtKUJ4u5xc2HebLKj5/CJ/iILPX4ftpstkIO2bg0/JLDVHCmbWbGwWMQomsCQwyGWZFKc
	9lsErT1DNzyRYpjrOKx5M0f8XAna8URFgKcOpZf1ZuB+nGClgmAuhduDngedpEc5MOUS12FskzQDc
	eNxpA2BzGqITCvqjnjuORwYPwb3D4I94LM/jNr2qvCxNMgl5uXhG7TgMgyMvz6gygPR1Kb3QvLJrT
	Q8FtP5TZfaqdCb2ORjZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2yHD-00GafK-11;
	Tue, 14 Nov 2023 18:36:43 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2yH9-00Gaeo-1E
	for kexec@lists.infradead.org;
	Tue, 14 Nov 2023 18:36:40 +0000
Received: from [10.137.114.52] (unknown [131.107.159.180])
	by linux.microsoft.com (Postfix) with ESMTPSA id DDE2F20B74C1;
	Tue, 14 Nov 2023 10:36:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDE2F20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1699986997;
	bh=ip5SH1zQ+t2HatDE3wRWZbocUBe8AkIri1k+HYGCJUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nOOO8ywMLG/MkBJKtNIGNNBLu2+deC/41Hr8pT7oH3iuEgMaPpC0ODrhIwmj73U1O
	 rW6MHW1axc7IZssrKgXtR1tEAyFVGbaqoPJqFFlDZmY1WMACPoUPktfmQKtdCy6U6T
	 imiMLsrLn3s+lNqydjAFiDY5h+up7LxDCPX40PLg=
Message-ID: <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
Date: Tue, 14 Nov 2023 10:36:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Stefan Berger <stefanb@linux.ibm.com>,
 Tushar Sugandhi <tusharsu@linux.microsoft.com>,
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
 Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
 Dave Young <dyoung@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org,
 Paul Moore <paul@paul-moore.com>, serge@hallyn.com,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-security-module@vger.kernel.org
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
Content-Language: en-US
From: Sush Shringarputale <sushring@linux.microsoft.com>
In-Reply-To: <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_103639_533885_53E9398D 
X-CRM114-Status: GOOD (  15.36  )
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

CgpPbiAxMS8xMy8yMDIzIDEwOjU5IEFNLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+Cj4KPiBPbiAx
MC8xOS8yMyAxNDo0OSwgVHVzaGFyIFN1Z2FuZGhpIHdyb3RlOgo+PiA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+
PiB8IEludHJvZHVjdGlvbiB8Cj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4+IFRoaXMgZG9jdW1lbnQgcHJv
dmlkZXMgYSBkZXRhaWxlZCBvdmVydmlldyBvZiB0aGUgcHJvcG9zZWQgS2VybmVsCj4+IGZlYXR1
cmUgSU1BIGxvZyBzbmFwc2hvdHRpbmcuwqAgSXQgZGVzY3JpYmVzIHRoZSBtb3RpdmF0aW9uIGJl
aGluZCB0aGUKPj4gcHJvcG9zYWwsIHRoZSBwcm9ibGVtIHRvIGJlIHNvbHZlZCwgYSBkZXRhaWxl
ZCBzb2x1dGlvbiBkZXNpZ24gd2l0aAo+PiBleGFtcGxlcywgYW5kIGRlc2NyaWJlcyB0aGUgY2hh
bmdlcyB0byBiZSBtYWRlIGluIHRoZSBjbGllbnRzL3NlcnZpY2VzCj4+IHdoaWNoIGFyZSBwYXJ0
IG9mIHJlbW90ZS1hdHRlc3RhdGlvbiBzeXN0ZW0uwqAgVGhpcyBpcyB0aGUgMm5kIHZlcnNpb24K
Pj4gb2YgdGhlIHByb3Bvc2FsLsKgIFRoZSBmaXJzdCB2ZXJzaW9uIGlzIHByZXNlbnQgaGVyZVsx
XS4KPj4KPj4gVGFibGUgb2YgQ29udGVudHM6Cj4+IC0tLS0tLS0tLS0tLS0tLS0tLQo+PiBBLiBN
b3RpdmF0aW9uIGFuZCBCYWNrZ3JvdW5kCj4+IEIuIEdvYWxzIGFuZCBOb24tR29hbHMKPj4gwqDC
oMKgwqAgQi4xIEdvYWxzCj4+IMKgwqDCoMKgIEIuMiBOb24tR29hbHMKPj4gQy4gUHJvcG9zZWQg
U29sdXRpb24KPj4gwqDCoMKgwqAgQy4xIFNvbHV0aW9uIFN1bW1hcnkKPj4gwqDCoMKgwqAgQy4y
IEhpZ2gtbGV2ZWwgV29yay1mbG93Cj4+IEQuIERldGFpbGVkIERlc2lnbgo+PiDCoMKgwqDCoCBE
LjEgU25hcHNob3QgQWdncmVnYXRlIEV2ZW50Cj4+IMKgwqDCoMKgIEQuMiBTbmFwc2hvdCBUcmln
Z2VyaW5nIE1lY2hhbmlzbQo+PiDCoMKgwqDCoCBELjMgQ2hvb3NpbmcgQSBQZXJzaXN0ZW50IFN0
b3JhZ2UgTG9jYXRpb24gRm9yIFNuYXBzaG90cwo+PiDCoMKgwqDCoCBELjQgUmVtb3RlLUF0dGVz
dGF0aW9uIENsaWVudC9TZXJ2aWNlLXNpZGUgQ2hhbmdlcwo+PiDCoMKgwqDCoMKgwqDCoMKgIEQu
NC5hIENsaWVudC1zaWRlIENoYW5nZXMKPj4gwqDCoMKgwqDCoMKgwqDCoCBELjQuYiBTZXJ2aWNl
LXNpZGUgQ2hhbmdlcwo+PiBFLiBFeGFtcGxlIFdhbGstdGhyb3VnaAo+PiBGLiBPdGhlciBEZXNp
Z24gQ29uc2lkZXJhdGlvbnMKPj4gRy4gUmVmZXJlbmNlcwo+Pgo+Cj4gVXNlcnNwYWNlIGFwcGxp
Y2F0aW9ucyB3aWxsIGhhdmUgdG8ga25vdwo+IGEpIHdoZXJlIGFyZSB0aGUgc2hhcmQgZmlsZXM/
CldlIGRlc2NyaWJlIHRoZSBmaWxlIHN0b3JhZ2UgbG9jYXRpb24gY2hvaWNlcyBpbiBzZWN0aW9u
IEQuMywgYnV0IHVzZXIKYXBwbGljYXRpb25zIHdpbGwgaGF2ZSB0byBxdWVyeSB0aGUgd2VsbC1r
bm93biBsb2NhdGlvbiBkZXNjcmliZWQgdGhlcmUuCj4gYikgaG93IGRvIEkgcmVhZCB0aGUgc2hh
cmQgZmlsZXMgd2hpbGUgbG9ja2luZyBvdXQgdGhlIHByb2R1Y2VyIG9mIHRoZSAKPiBzaGFyZCBm
aWxlcz8KPgo+IElNTywgdGhpcyB3aWxsIHJlcXVpcmUgYSB3ZWxsIGtub3duIGNvbmZpZyBmaWxl
IGFuZCBhIGxvY2tpbmcgbWV0aG9kIAo+IChmbG9jaykgc28gdGhhdCB1c2VyIHNwYWNlIGFwcGxp
Y2F0aW9ucyBjYW4gd29yayB0b2dldGhlciBpbiB0aGlzIG5ldyAKPiBlbnZpcm9ubWVudC4gVGhl
IGxvY2sgY291bGQgYmUgZGVmaW5lZCBpbiB0aGUgY29uZmlnIGZpbGUgb3IganVzdCBiZSAKPiB0
aGUgY29uZmlnIGZpbGUgaXRzZWxmLgpUaGUgZmxvY2sgaXMgYSBnb29kIGlkZWEgZm9yIGNvLW9y
ZGluYXRpb24gYmV0d2VlbiBVTSBjbGllbnRzLiBXaGlsZQp0aGUgS2VybmVsIGNhbm5vdCBlbmZv
cmNlIGFueSBhY2Nlc3MgaW4gdGhpcyB3YXksIGFueSBVTSBwcm9jZXNzIHRoYXQKaXMgcGxhbm5p
bmcgb24gdHJpZ2dlcmluZyB0aGUgc25hcHNob3QgbWVjaGFuaXNtIHNob3VsZCBmb2xsb3cgdGhh
dApwcm90b2NvbC7CoCBXZSB3aWxsIGVuc3VyZSB3ZSBkb2N1bWVudCB0aGF0IGFzIHRoZSBiZXN0
LXByYWN0aWNlcyBpbgp0aGUgcGF0Y2ggc2VyaWVzLgotIFN1c2gKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
