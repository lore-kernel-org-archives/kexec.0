Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FA3ECE564
	for <kexec@archiver.kernel.org>; Tue, 10 Sep 2024 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=F1sFyYIb4jIt+jxw+wAA2yYrog1MyrzgNXmxhjpJOEY=; b=VlsEvW2Lq0br5UMmVsjo2CTBt5
	hHeM+8tfAdQB/i8xpnQB/RutfIcXU2vqjO1GNyChQYN/WnguB/7HCv0dQLkoldlAp7JWUR8otZvXu
	E00jspUfi2Krlu+X0RIKZYF6famuMdwrf56iQWzQKZz0X6x9zveiDj7AMdnsDexp0xJr766xdSFvd
	8cvUWHAhGZiKA/7I9+UBJtUdxua1uCCcqVSY2Os16xahdIqVL6Fh8Lb3Lm9vfhbyMVsxbraPvWEeq
	2apnph93Qu4s88/kYSHdNkMbjIKo9ex/uTyBUgZuh/Dvn5fsp2uBOFkyyB/lJcdV7ITi15fu//ODn
	4pQBLIRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so1pO-00000005rkt-1lQk;
	Tue, 10 Sep 2024 14:26:46 +0000
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so1pK-00000005rhg-3y7O
	for kexec@lists.infradead.org;
	Tue, 10 Sep 2024 14:26:44 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:35602)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so1p3-00FrpQ-8z; Tue, 10 Sep 2024 08:26:25 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:55678 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so1p2-009HMx-7D; Tue, 10 Sep 2024 08:26:24 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Breno Leitao <leitao@debian.org>
Cc: ardb@kernel.org,  linux-efi@vger.kernel.org,  kexec@lists.infradead.org,
  bhe@redhat.com,  vgoyal@redhat.com,  devel@edk2.groups.io,
  rppt@kernel.org,  usamaarif642@gmail.com,  gourry@gourry.net,
  rmikey@meta.com
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
Date: Tue, 10 Sep 2024 09:26:00 -0500
In-Reply-To: <20240910-juicy-festive-sambar-9ad23a@devvm32600> (Breno Leitao's
	message of "Tue, 10 Sep 2024 06:58:44 -0700")
Message-ID: <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1so1p2-009HMx-7D;;;mid=<87ed5rd1qf.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19dkBTjOgMEh0RF9HPfgeclbCjl4TDYDm8=
Subject: Re: EFI table being corrupted during Kexec
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: rmikey@meta.com, gourry@gourry.net, usamaarif642@gmail.com, rppt@kernel.org, devel@edk2.groups.io, vgoyal@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, linux-efi@vger.kernel.org, ardb@kernel.org, leitao@debian.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_072643_007784_A692D365 
X-CRM114-Status: GOOD (  29.00  )
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

QnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4gd3JpdGVzOgoKPiBXZSd2ZSBzZWVuIGEg
cHJvYmxlbSBpbiB1cHN0cmVhbSBrZXJuZWwga2V4ZWMsIHdoZXJlIGEgRUZJIFRQTSBsb2cgZXZl
bnQgdGFibGUKPiBpcyBiZWluZyBvdmVyd3JpdHRlbi4gIFRoaXMgcHJvYmxlbSBoYXBwZW4gb24g
cmVhbCBtYWNoaW5lLCBhcyB3ZWxsIGFzIGluIGEKPiByZWNlbnQgRURLMiBxZW11IFZNLgo+Cj4g
RGlnZ2luZyBkZWVwLCB0aGUgdGFibGUgaXMgYmVpbmcgb3ZlcndyaXR0ZW4gZHVyaW5nIGtleGVj
LCBtb3JlIHByZWNpc2VseSB3aGVuCj4gcmVsb2NhdGluZyBrZXJuZWwgKHJlbG9jYXRlX2tlcm5l
bCgpIGZ1bmN0aW9uKS4KPgo+IEkndmUgYWxzbyBmb3VuZCB0aGF0IHRoZSB0YWJsZSBpcyBiZWlu
ZyBwcm9wZXJseSByZXNlcnZlZCB1c2luZwo+IG1lbWJsb2NrX3Jlc2VydmUoKSBlYXJseSBpbiB0
aGUgYm9vdCwgYW5kIHRoYXQgcmFuZ2UgZ2V0cyBvdmVyd3JpdHRlbiBsYXRlciBpbgo+IGJ5IHJl
bG9jYXRlX2tlcm5lbCgpLiBJbiBvdGhlciB3b3Jkcywga2V4ZWMgaXMgb3ZlcndyaXRpbmcgYSBt
ZW1vcnkgdGhhdCB3YXMKPiBwcmV2aW91c2x5IHJlc2VydmVkIChhcyBtZW1ibG9ja19yZXNlcnZl
KCkpLgo+Cj4gVXNhbWEgZm91bmQgdGhhdCBrZXhlYyBvbmx5IGhvbm91cnMgbWVtb3J5IHJlc2Vy
dmF0aW9ucyBmcm9tIC9zeXMvZmlybXdhcmUvbWVtbWFwCj4gd2hpY2ggY29tZXMgZnJvbSBlODIw
X3RhYmxlX2Zpcm13YXJlIHRhYmxlLgo+Cj4gTG9va2luZyBhdCB0aGUgVFBNIHNwZWMsIEkgZm91
bmQgdGhlIGZvbGxvd2luZyBwYXJ0Ogo+Cj4gCUlmIHRoZSBBQ1BJIFRQTTIgdGFibGUgY29udGFp
bnMgdGhlIGFkZHJlc3MgYW5kIHNpemUgb2YgdGhlIFBsYXRmb3JtIEZpcm13YXJlIFRDRyBsb2cs
Cj4gCWZpcm13YXJlIOKAnHBpbnPigJ0gdGhlIG1lbW9yeSBhc3NvY2lhdGVkIHdpdGggdGhlIFBs
YXRmb3JtIEZpcm13YXJlIFRDRyBsb2csIGFuZCByZXBvcnRzCj4gCXRoaXMgbWVtb3J5IGFzIOKA
nFJlc2VydmVk4oCdIG1lbW9yeSB2aWEgdGhlIElOVCAxNWgvRTgyMCBpbnRlcmZhY2UuCj4KPgo+
IEZyb206IGh0dHBzOi8vdHJ1c3RlZGNvbXB1dGluZ2dyb3VwLm9yZy93cC1jb250ZW50L3VwbG9h
ZHMvUEMtQ2xpZW50UGxhdGZvcm1fUHJvZmlsZV9mb3JfVFBNXzJwMF9TeXN0ZW1zX3Y0OV8xNjEx
MTRfcHVibGljLXJldmlldy5wZGYKPgo+IEkgYW0gd29uZGVyaW5nIGlmIHRoYXQgbWVtb3J5IHJl
Z2lvbi9yYW5nZSBzaG91bGQgYmUgcGFydCBvZiBlODIwIHRhYmxlIHRoYXQgaXMKPiBwYXNzZWQg
YnkgRUZJIGZpcm13YXJlIHRvIGtlcm5lbCwgYW5kIGlmIGl0IGlzIG5vdCBwYXNzZWQgKGFzIGl0
IGlzIG5vdCBiZWluZwo+IHBhc3NlZCB0b2RheSksIHRoZW4gdGhlIGtlcm5lbCBkb2Vzbid0IG5l
ZWQgdG8gcmVzcGVjdCBpdCwgYW5kIGl0IGlzIGZyZWUgdG8KPiBvdmVyd3JpdGUgKGFzIGl0IGRv
ZXMgdG9kYXkpLiBJbiBvdGhlciB3b3JkcywgdGhpcyBpcyBhIGZpcm13YXJlIGJ1ZyBhbmQgbm90
IGEKPiBrZXJuZWwgYnVnLgo+Cj4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8KCkkgYWdyZWUgdGhh
dCB0aGlzIGFwcGVhcnMgdG8gYmUgYSBmaXJtd2FyZSBidWcuICBUaGlzIG1lbW9yeSBpcyByZXNl
cnZlZAppbiBvbmUgbG9jYXRpb24gYW5kIG5vdCBpbiBhbm90aGVyIGxvY2F0aW9uLgoKVGhhdCBz
YWlkIHRoYXQgZG9lc24ndCBtZWFuIHdlIGNhbid0IGRlYWwgd2l0aCBpdCBpbiB0aGUga2VybmVs
LgphY3BpX3RhYmxlX3VwZ3JhZGUgc2VlbXMgdG8gaGF2ZSBoaXQgYSBzaW1pbGFyIGlzc3VlIGlz
c3VlIGFuZCBjYWxscwphcmNoX3Jlc2VydmVfbWVtX2FyZWEgdG8gcmVzZXJ2ZSB0aGUgYXJlYSBp
biB0aGUgZTgyMHRhYmxlcy4KCgpUaGUgbGFzdCB0aW1lIEkgbG9va2VkIHRoZSBlODIwIHRhYmxl
cyAoaW4gdGhlIGtlcm5lbCkgYXJlIHVzZWQgdG8gc3RvcmUKdGhlIGVmaSBtZW1vcnkgbWFwIHdo
ZW4gYXZhaWxhYmxlIGFuZCBvbmx5IHVzZSB0aGUgdHJ1ZSBlODIwIGRhdGEgb24Kb2xkZXIgc3lz
dGVtcy4KCldoaWNoIGlzIGEgbG9uZyB3YXkgb2Ygc2F5IHRoYXQgdGhlIGU4MjAgdGFibGUgaW4g
dGhlIGtlcm5lbCBsYXN0IEkKbG9va2VkIHdhcyB0aGUgbWFzdGVyIHRhYmxlLCBvZiBob3cgdGhl
IGZpcm13YXJlIHZpZXdzIHRoZSBtZW1vcnkuCgoKQXMgSSByZWNhbGwgdGhlIG1lbWJsb2NrIGFs
bG9jYXRvciBpcyB0aGUgYm9vdHN0cmFwIG1lbW9yeSBhbGxvY2F0b3IKdXNlZCB3aGVuIGJyaW5n
aW5nIHVwIHRoZSBrZXJuZWwuICBTbyBJIGRvbid0IHNlZSByZXNlcnZpbmcgc29tZXRoaW5nCmlu
IHRoZSBtZW1ibG9jayBhbGxvY2F0b3IgYXMgYmVpbmcgYXV0aG9yaXRhdGl2ZSBhcyB0byBob3cg
dGhlIGZpcm13YXJlCmhhcyBzZXR1cCBtZW1vcnkuCgoKCkkgd291bGQgc3VnZ2VzdCB3cml0aW5n
IGEgcGF0Y2ggdG8gdXBkYXRlIHdoYXRldmVyIGlzIGNhbGxpbmcKbWVtYmxvY2tfcmVzZXJ2ZSB0
byBhbHNvLCBvciBwZXJoYXBzIGluIHByZWZlcmVuY2UgdG8gdXBkYXRlIHRoZSBlODIwCm1hcC4g
IElmIHRoZSBjb2RlIGlzIG5vdCB4ODYgc3BlY2lmaWMgSSB3b3VsZCBzdWdnZXN0IHVzaW5nIEFD
UEkncwphcmNoX3Jlc2VydmVfbWVtX2FyZWEgY2FsbC4KCgpJZiB5b3UgaGF2ZSBhIGdvb2QgcGF0
aCB0byB5b3VyIHRoZSBmb2xrcyB3aG8gd3JpdGUgZm9yIHRoZSBjb21wdXRlcnMKd2hlcmUgdGhp
cyBoYXBwZW5zIGl0IHNlZW1zIGVudGlyZWx5IHJlYXNvbmFibGUgdG8gcmVwb3J0IHRoaXMgYXMg
YSBidWcKdG8gdGhlbSBhcyB3ZWxsLgoKRXJpYwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
