Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B4FEE01EE
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 11:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=prMUGwad8RZyGc/Y7R6gtCb+h0z21+DtGypOFfZjzKk=; b=D5hGMh/rW3zfeo
	dWybcfqycnCbUVL9Achw1hZ5OaEsGeIC3Gd+gsgEMG07QErutXZSfpogbLUhy70OarW4zu8f+UUyS
	K9r7EcTWoc+1KMb9Z9rfVdaw+rXmAYj2HqBf+9AcifGTzxutwFgK+8IgK/cSsTRueNZcdYzhhdEAI
	nikIzf5rum/tmmMTUp1n6bD5ZlifLDPvdJaSYa8foswat5qh7C2ig1+QIx0hxp/mXoHBzcd5yAUdk
	iRkMULBO4BBogQV4YL8SNf2amnHwmdwXnWJbf5QMFgJoq52yilNxBfOh5MYEYDMatt9mWauRa0KdD
	iXp+exwOY8HDx0txWAFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soLGM-00000009F1p-2FCV;
	Wed, 11 Sep 2024 11:11:54 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soL3B-00000009CRp-0PDT
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 10:58:18 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a8d56155f51so218541066b.2
        for <kexec@lists.infradead.org>; Wed, 11 Sep 2024 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726052295; x=1726657095; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfRXO8aG7CV7xVz5FI9ItiLuIzkInF12v0gTlp+dl+o=;
        b=aaFnO7ntypx8ieXuYpuIEDIZdkonyOt01ufSty++VrGBVR+RaU3Osliajk+Qu2MZQh
         30k2oPMUDN/ZDr25JwBVxnZijHGQjWCUDwfiO3mWns8iXqdv+FJ6iyGvcLOqpcL3A3T1
         rz9UUPmeT6ZURVlK/FVxHnHu/8DoyooB+2HlbnZUA2lOpN8Yx8eqckqqB6HD6Px/oQpj
         NBUz2POSbksdvHw8ZxEdWPBeJkDbTx+sCx7DNjUdwS8WIpAzZ6SPkpacZFGCYdxJkeYB
         z3RL+U/lgp9CUsORZhiSFfdIkZD8xoacpo97kB1Ty8hi6DoYUg5Q1xvy5w0jPiI6Q02j
         b3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726052295; x=1726657095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfRXO8aG7CV7xVz5FI9ItiLuIzkInF12v0gTlp+dl+o=;
        b=Ygrxx7HnLJev2n/NgH80/LEP4BXirD4APaBtg1CeRXTBgDfAImHGi0jqGUCl6BXtgl
         uzOYQxfCE4w/XIOeydNm9GnzKbsZKE/nsHFq9b/aAoP4j70I7GzExEOGq1/s0aAzh8SB
         lzGfXjrz31Y3ZIqk3n33di5n4DBCQj6gfv7atMXw0GF61cflATk2xeM5AMitex3yrfGj
         Lkvvtm3qs/pT27a+xrVjswyTLsZ187gMZlNN4BYBaSC8B0oHyDGq7iuHszSSJQBWJfR4
         YRW6IWJjr2WsqDCJ8N/EGzuWzdsibdAVVcaidgg7AQ2zm4cIsanTpaQ9hj7On1sLsXLd
         ogyQ==
X-Gm-Message-State: AOJu0YxOshbGu1C/a+eELLxwLoKWl+AfamxhISKKfbL1jD9dS5MILd88
	EBo90upZtHA9o2L/nwrhc2+qvFtMPGxXoZ6x1G1XpzwB7djEdbsp
X-Google-Smtp-Source: AGHT+IGLMNPOA93gjLZo+ChcKvIbXVcmDwqywv3Wgapd4ujtL40XzixDcfbg0lCaaCCVF5rVri6aHQ==
X-Received: by 2002:a17:907:3d87:b0:a8d:60e2:396b with SMTP id a640c23a62f3a-a9004a98eebmr227622866b.65.1726052294334;
        Wed, 11 Sep 2024 03:58:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:aa41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5491asm596445066b.198.2024.09.11.03.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 03:58:14 -0700 (PDT)
Message-ID: <8d3ec802-4f7e-42be-b757-bc103d039f0b@gmail.com>
Date: Wed, 11 Sep 2024 11:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EFI table being corrupted during Kexec
To: ardb@kernel.org, linux-efi@vger.kernel.org
Cc: kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com,
 devel@edk2.groups.io, rppt@kernel.org, gourry@gourry.net, rmikey@meta.com,
 afish@apple.com, kraxel@redhat.com, "Eric W. Biederman"
 <ebiederm@xmission.com>, Breno Leitao <leitao@debian.org>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_035817_162895_34E28E96 
X-CRM114-Status: GOOD (  32.14  )
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

CgpPbiAxMC8wOS8yMDI0IDE1OjI2LCBFcmljIFcuIEJpZWRlcm1hbiB3cm90ZToKPiBCcmVubyBM
ZWl0YW8gPGxlaXRhb0BkZWJpYW4ub3JnPiB3cml0ZXM6Cj4gCj4+IFdlJ3ZlIHNlZW4gYSBwcm9i
bGVtIGluIHVwc3RyZWFtIGtlcm5lbCBrZXhlYywgd2hlcmUgYSBFRkkgVFBNIGxvZyBldmVudCB0
YWJsZQo+PiBpcyBiZWluZyBvdmVyd3JpdHRlbi4gIFRoaXMgcHJvYmxlbSBoYXBwZW4gb24gcmVh
bCBtYWNoaW5lLCBhcyB3ZWxsIGFzIGluIGEKPj4gcmVjZW50IEVESzIgcWVtdSBWTS4KPj4KPj4g
RGlnZ2luZyBkZWVwLCB0aGUgdGFibGUgaXMgYmVpbmcgb3ZlcndyaXR0ZW4gZHVyaW5nIGtleGVj
LCBtb3JlIHByZWNpc2VseSB3aGVuCj4+IHJlbG9jYXRpbmcga2VybmVsIChyZWxvY2F0ZV9rZXJu
ZWwoKSBmdW5jdGlvbikuCj4+Cj4+IEkndmUgYWxzbyBmb3VuZCB0aGF0IHRoZSB0YWJsZSBpcyBi
ZWluZyBwcm9wZXJseSByZXNlcnZlZCB1c2luZwo+PiBtZW1ibG9ja19yZXNlcnZlKCkgZWFybHkg
aW4gdGhlIGJvb3QsIGFuZCB0aGF0IHJhbmdlIGdldHMgb3ZlcndyaXR0ZW4gbGF0ZXIgaW4KPj4g
YnkgcmVsb2NhdGVfa2VybmVsKCkuIEluIG90aGVyIHdvcmRzLCBrZXhlYyBpcyBvdmVyd3JpdGlu
ZyBhIG1lbW9yeSB0aGF0IHdhcwo+PiBwcmV2aW91c2x5IHJlc2VydmVkIChhcyBtZW1ibG9ja19y
ZXNlcnZlKCkpLgo+Pgo+PiBVc2FtYSBmb3VuZCB0aGF0IGtleGVjIG9ubHkgaG9ub3VycyBtZW1v
cnkgcmVzZXJ2YXRpb25zIGZyb20gL3N5cy9maXJtd2FyZS9tZW1tYXAKPj4gd2hpY2ggY29tZXMg
ZnJvbSBlODIwX3RhYmxlX2Zpcm13YXJlIHRhYmxlLgo+Pgo+PiBMb29raW5nIGF0IHRoZSBUUE0g
c3BlYywgSSBmb3VuZCB0aGUgZm9sbG93aW5nIHBhcnQ6Cj4+Cj4+IAlJZiB0aGUgQUNQSSBUUE0y
IHRhYmxlIGNvbnRhaW5zIHRoZSBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBQbGF0Zm9ybSBGaXJt
d2FyZSBUQ0cgbG9nLAo+PiAJZmlybXdhcmUg4oCccGluc+KAnSB0aGUgbWVtb3J5IGFzc29jaWF0
ZWQgd2l0aCB0aGUgUGxhdGZvcm0gRmlybXdhcmUgVENHIGxvZywgYW5kIHJlcG9ydHMKPj4gCXRo
aXMgbWVtb3J5IGFzIOKAnFJlc2VydmVk4oCdIG1lbW9yeSB2aWEgdGhlIElOVCAxNWgvRTgyMCBp
bnRlcmZhY2UuCj4+Cj4+Cj4+IEZyb206IGh0dHBzOi8vdHJ1c3RlZGNvbXB1dGluZ2dyb3VwLm9y
Zy93cC1jb250ZW50L3VwbG9hZHMvUEMtQ2xpZW50UGxhdGZvcm1fUHJvZmlsZV9mb3JfVFBNXzJw
MF9TeXN0ZW1zX3Y0OV8xNjExMTRfcHVibGljLXJldmlldy5wZGYKPj4KPj4gSSBhbSB3b25kZXJp
bmcgaWYgdGhhdCBtZW1vcnkgcmVnaW9uL3JhbmdlIHNob3VsZCBiZSBwYXJ0IG9mIGU4MjAgdGFi
bGUgdGhhdCBpcwo+PiBwYXNzZWQgYnkgRUZJIGZpcm13YXJlIHRvIGtlcm5lbCwgYW5kIGlmIGl0
IGlzIG5vdCBwYXNzZWQgKGFzIGl0IGlzIG5vdCBiZWluZwo+PiBwYXNzZWQgdG9kYXkpLCB0aGVu
IHRoZSBrZXJuZWwgZG9lc24ndCBuZWVkIHRvIHJlc3BlY3QgaXQsIGFuZCBpdCBpcyBmcmVlIHRv
Cj4+IG92ZXJ3cml0ZSAoYXMgaXQgZG9lcyB0b2RheSkuIEluIG90aGVyIHdvcmRzLCB0aGlzIGlz
IGEgZmlybXdhcmUgYnVnIGFuZCBub3QgYQo+PiBrZXJuZWwgYnVnLgo+Pgo+PiBBbSBJIG1pc3Np
bmcgc29tZXRoaW5nPwo+IAo+IEkgYWdyZWUgdGhhdCB0aGlzIGFwcGVhcnMgdG8gYmUgYSBmaXJt
d2FyZSBidWcuICBUaGlzIG1lbW9yeSBpcyByZXNlcnZlZAo+IGluIG9uZSBsb2NhdGlvbiBhbmQg
bm90IGluIGFub3RoZXIgbG9jYXRpb24uCj4gCj4gVGhhdCBzYWlkIHRoYXQgZG9lc24ndCBtZWFu
IHdlIGNhbid0IGRlYWwgd2l0aCBpdCBpbiB0aGUga2VybmVsLgo+IGFjcGlfdGFibGVfdXBncmFk
ZSBzZWVtcyB0byBoYXZlIGhpdCBhIHNpbWlsYXIgaXNzdWUgaXNzdWUgYW5kIGNhbGxzCj4gYXJj
aF9yZXNlcnZlX21lbV9hcmVhIHRvIHJlc2VydmUgdGhlIGFyZWEgaW4gdGhlIGU4MjB0YWJsZXMu
Cj4gCj4gCj4gVGhlIGxhc3QgdGltZSBJIGxvb2tlZCB0aGUgZTgyMCB0YWJsZXMgKGluIHRoZSBr
ZXJuZWwpIGFyZSB1c2VkIHRvIHN0b3JlCj4gdGhlIGVmaSBtZW1vcnkgbWFwIHdoZW4gYXZhaWxh
YmxlIGFuZCBvbmx5IHVzZSB0aGUgdHJ1ZSBlODIwIGRhdGEgb24KPiBvbGRlciBzeXN0ZW1zLgo+
IAo+IFdoaWNoIGlzIGEgbG9uZyB3YXkgb2Ygc2F5IHRoYXQgdGhlIGU4MjAgdGFibGUgaW4gdGhl
IGtlcm5lbCBsYXN0IEkKPiBsb29rZWQgd2FzIHRoZSBtYXN0ZXIgdGFibGUsIG9mIGhvdyB0aGUg
ZmlybXdhcmUgdmlld3MgdGhlIG1lbW9yeS4KPiAKPiAKPiBBcyBJIHJlY2FsbCB0aGUgbWVtYmxv
Y2sgYWxsb2NhdG9yIGlzIHRoZSBib290c3RyYXAgbWVtb3J5IGFsbG9jYXRvcgo+IHVzZWQgd2hl
biBicmluZ2luZyB1cCB0aGUga2VybmVsLiAgU28gSSBkb24ndCBzZWUgcmVzZXJ2aW5nIHNvbWV0
aGluZwo+IGluIHRoZSBtZW1ibG9jayBhbGxvY2F0b3IgYXMgYmVpbmcgYXV0aG9yaXRhdGl2ZSBh
cyB0byBob3cgdGhlIGZpcm13YXJlCj4gaGFzIHNldHVwIG1lbW9yeS4KPiAKPiAKPiAKPiBJIHdv
dWxkIHN1Z2dlc3Qgd3JpdGluZyBhIHBhdGNoIHRvIHVwZGF0ZSB3aGF0ZXZlciBpcyBjYWxsaW5n
Cj4gbWVtYmxvY2tfcmVzZXJ2ZSB0byBhbHNvLCBvciBwZXJoYXBzIGluIHByZWZlcmVuY2UgdG8g
dXBkYXRlIHRoZSBlODIwCj4gbWFwLiAgSWYgdGhlIGNvZGUgaXMgbm90IHg4NiBzcGVjaWZpYyBJ
IHdvdWxkIHN1Z2dlc3QgdXNpbmcgQUNQSSdzCj4gYXJjaF9yZXNlcnZlX21lbV9hcmVhIGNhbGwu
Cj4gCgpUaGFua3MsIEkgaGF2ZSBzZW50IGEgcG90ZW50aWFsIGZpeCBmb3IgdGhpcyBhdCAKaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwOTExMTA0MTA5LjE4MzE1MDEtMS11c2FtYWFy
aWY2NDJAZ21haWwuY29tLwoKV2UgY2FuIHNlZSB0aGlzIGlzc3VlIGluIGtlcm5lbHMgZ29pbmcg
YWxsIHRoZSB3YXkgYmFjayB0byA1LjEyLiBVcCB1bnRpbCBub3cgaXQgb25seSBjb3JydXB0ZWQK
dGhlIHRwbV9sb2cgdmVyc2lvbiwgc28gaXQgd2Fzbid0IHJlYWxseSBhbiBpc3N1ZS4gQWZ0ZXIg
dXBncmFkaW5nIHByb2R1Y3Rpb24gdG8gNi45LCB0aGUgdHBtX2xvZwpzaXplIGhhcyBzdGFydGVk
IHRvIGdldCBjb3JydXB0ZWQgYXMgd2VsbC4gV2hlbiBzaXplIHdhcyBjb3JydXB0ZWQgdG8gYSBu
ZWdhdGl2ZSB2YWx1ZSwgdGhlCm1lbWJsb2NrX3Jlc2VydmUgaW4gZWZpX3RwbV9ldmVudGxvZ19p
bml0IGlzIHJlc2VydmluZyB0aGUgZW50aXJlIG1lbW9yeSBhdmFpbGFibGUsIGFuZCB0aGUgc3lz
dGVtCk9PTXMgYXQgYm9vdCB0aW1lLCB3aGljaCBpcyBjYXVzaW5nIGEgc2VyaW91cyBpc3N1ZS4g
SXQgd291bGQgYmUgZ29vZCB0byBrbm93IGlmIHRoZSBhYm92ZSBwYXRjaCBpcwphbiBhY2NlcHRh
YmxlIGZpeC4KClRoYW5rcyEKVXNhbWEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
