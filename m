Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9D5C3DA4A
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UBsCljVab1BPmvoNWPwKScv3KxusVzTNyxlCSuqCyZY=; b=t8KgMhCs/EuPWa
	YvuNCOkJxC3zldKp+d+bBk3uY58Z5B4fBENjUDstgHxppYFczOvpoMuKsC/aQ6M69SZBfP3u+M61L
	plqyvTO8toz4GUZ/mlFq+8Jdq3SIztqDzXAVcJd1LHNI4qgMOuZtEHsBah2d2NkA/PawDzpJ/p34x
	mmfwFeOZew1KFR0JF52NyfZHCH0Z3PHWojr9fpx+nmEBfgDxlLpT4K95JVUa+X/k7CupziiCuc8Zn
	hZW1/LR5eUVkssI6Ny+USxbus7/2h7+inSXEEzLSeUYSrs7Rqfg6zS4gm5eSctbWSeZ0JiO0JP6Nz
	dppqunailVJOLRF4GuvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh36o-0000000C1R0-0VFP;
	Thu, 22 Aug 2024 08:23:54 +0000
Received: from gardel.0pointer.net ([85.214.157.71])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh36k-0000000C1N1-2tso
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 08:23:52 +0000
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 55409E80263;
	Thu, 22 Aug 2024 10:23:39 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id CBEC216008A; Thu, 22 Aug 2024 10:23:38 +0200 (CEST)
Date: Thu, 22 Aug 2024 10:23:38 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zsb1isJ2cYRp2jpj@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_012350_924926_384EDF27 
X-CRM114-Status: GOOD (  32.12  )
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

T24gRG8sIDIyLjA4LjI0IDEzOjQyLCBQaW5nZmFuIExpdSAocGlsaXVAcmVkaGF0LmNvbSkgd3Jv
dGU6CgogPiBPbiBXZWQsIEF1ZyAyMSwgMjAyNCBhdCAxMDoyN+KAr1BNIExlbm5hcnQgUG9ldHRl
cmluZwo+IDxtenhyZWFyeUAwcG9pbnRlci5kZT4gd3JvdGU6Cj4gPgo+ID4gT24gTW8sIDE5LjA4
LjI0IDIyOjUzLCBQaW5nZmFuIExpdSAocGlsaXVAcmVkaGF0LmNvbSkgd3JvdGU6Cj4gPgo+ID4g
PiAqKiogQmFja2dyb3VuZCAqKioKPiA+ID4KPiA+ID4gQXMgbW9yZSBQRSBmb3JtYXQga2VybmVs
IGltYWdlcyBhcmUgaW50cm9kdWNlZCwgaXQgcG9zdCBjaGFsbGVuZ2UgdG8ga2V4ZWMgdG8KPiA+
ID4gY29wZSB3aXRoIHRoZSBuZXcgZm9ybWF0Lgo+ID4gPgo+ID4gPiBJbiBteSBhdHRlbXB0IHRv
IGFkZCBzdXBwb3J0IGZvciBhcm02NCB6Ym9vdCBpbWFnZSBpbiB0aGUga2VybmVsIFsxXSwKPiA+
ID4gQXJkIHN1Z2dlc3RlZCB1c2luZyBhbiBlbXVsYXRvciB0byB0YWNrbGUgdGhpcyBpc3N1ZS4g
IExhc3QgeWVhciwgd2hlbgo+ID4gPiBKYW4gdHJpZWQgdG8gaW50cm9kdWNlIFVLSSBzdXBwb3J0
IGluIHRoZSBrZXJuZWwgWzJdLCBBcmQgbWVudGlvbmVkIHRoZQo+ID4gPiBlbXVsYXRvciBhcHBy
b2FjaCBhZ2FpbiBbM10KPiA+Cj4gPiBIbW0sIHN5c3RlbWQncyBzeXN0ZW1kLXN0dWIgY29kZSB0
cmllcyB0byBsb2FkIGNlcnRhaW4gInNpZGUtY2FyIgo+ID4gZmlsZXMgcGxhY2VkIG5leHQgdG8g
dGhlIFVLSSwgdmlhIHRoZSBVRUZJIGZpbGUgc3lzdGVtIEFQSXMuIFdoYXQncwo+ID4geW91ciBp
bnRlbnRpb24gd2l0aCB0aGUgVUVGSSBlbXVsYXRvciByZWdhcmRpbmcgdGhhdD8gVGhlIHNpZGVj
YXJzIGFyZQo+ID4gc29tZXdoYXQgaW1wb3J0YW50LCBiZWNhdXNlIHRoYXQncyBob3cgd2UgcGFy
YW1ldGVyaXplIG90aGVyd2lzZQo+ID4gc3RyaWN0bHkgc2VhbGVkLCBpbW11dGFibGUgVUtJcy4K
PiA+Cj4gSUlVQywgeW91IGFyZSByZWZlcnJpbmcgdG8gVUtJIGFkZG9ucy4KClllYWgsIFVLSSBh
ZGRvbnMsIGFzIHdlbGwgYXMgY3JlZGVudGlhbCBmaWxlcywgYW5kIHN5c2V4dC9jb25mZXh0CkRE
SXMuCgpUaGUgYWRkb25zIGFyZSB0aGUgbW9zdCBpbnRlcmVzdGluZyBidHcsIGJlY2F1c2Ugd2Ug
bG9hZCB0aGVtIGludG8KbWVtb3J5IGFzIFBFIGZpbGVzLCBhbmQgYXNrIHRoZSBVRUZJIHRvIGF1
dGhlbnRpY2F0ZSB0aGVtLgoKPiA+IEhlbmNlLCB3aGF0J3MgdGhlIHN0b3J5IHRoZXJlPyBpbXBs
ZW1lbnQgc29tZSBmb3JtIG9mIGZzIGRyaXZlciAoZm9yCj4gPiB3aGF0IGZzIHByZWNpc2VseT8p
IGluIHRoZSBlbXVsYXRvciB0b28/Cj4gPgo+IEFzIGZvciBhZGRvbiwgdGhhdCBpcyBhIG1pc3Np
bmcgcGFydCBpbiB0aGlzIHNlcmllcy4gSSBoYXZlIG92ZXJsb29rZWQKPiB0aGlzIGlzc3VlLiBP
cmlnaW5hbGx5LCBJIHRob3VnaHQgdGhhdCB0aGVyZSB3YXMgbm8gbmVlZCB0byBpbXBsZW1lbnQK
PiBhIGRpc2sgZHJpdmVyIGFuZCB2ZmF0IGZpbGUgc3lzdGVtLCBqdXN0IHByZWxvYWQgdGhlbSBp
bnRvIG1lbW9yeSwgYW5kCj4gZmluYWxseSBwcmVzZW50IHRoZW0gdGhyb3VnaCB0aGUgdWVmaSBB
UEkuIEkgd2lsbCB0YWtlIGEgY2xvc2VyIGxvb2sKPiBhdCBpdCBhbmQgY2hldyBvbiBpdC4KCkl0
IGRvZXNuJ3QgaGF2ZSB0byBiZSBWRkFUIGJ0dy4gSXQganVzdCBoYXMgdG8gYmUgc29tZXRoaW5n
LiBGb3IKZXhhbXBsZSwgaXQgbWlnaHQgc3VmZmljZSB0byB0YWtlIHRoZXNlIGZpbGVzLCBwYWNr
IHRoZW0gdXAgYXMgY3BpbyBvcgpzbyBhbmQgcGFzcyB0aGVtIGFsb25nIHdpdGggdGhlIFVFRkkg
ZXhlY3V0aW9uLiBUaGUgVUVGSSBlbXVsYXRvcgp3b3VsZCB0aGVuIGhhdmUgdG8gZXhwb3NlIHRo
ZW0gYXMgYSBmaWxlIHN5c3RlbSB0aGVuLgoKV2UgYXJlIG5vdCB0YWxraW5nIG9mIGEgYmF6aWxs
aW9uIG9mIGZpbGVzIGhlcmUsIGl0J3MgbW9zdGx5IGEKc21hbGxpc2ggbnVtYmVyIG9mIHNpZGVj
YXIgZmlsZXMgSSdkIGV4cGVjdC4KCj4gPiBBbmQgcmVnYXJkaW5nIHRwbT8gdHBtcyByZXF1aXJl
IGRyaXZlcnMgYW5kIGkgZ3Vlc3MgYXQgdGhlIG1vbWVudCB1ZWZpCj4gPiBlbXVsYXRvciB3b3Vs
ZCBydW4gdGhvc2UgYXJlbid0IGF2YWlsYWJsZSBhbnltb3JlPyBidXQgd2UgcmVhbGx5Cj4gPiBz
aG91bGQgZG8gYSBzZXBhcmF0b3IgbWVhc3VyZW1lbnQgdGhlbi4gKGFsc28gdGhlcmUgbmVlZHMg
dG8gYmUgc29tZQo+ID4gd2F5IHRvIHBhc3Mgb3ZlciBtZWFzdXJlbWVudCBsb2cgb2YgdGhhdCBt
ZWFzdXJlbWVudD8pCj4KPiBJdCBpcyBhIHBpdHkgdGhhdCBpdCBpcyBhIGNvbW1vbiBpc3N1ZSBw
ZXJzaXN0ZW50IHdpdGgga2V4ZWMtcmVib290Cj4ga2VybmVsIG5vd2FkYXlzLgo+IEkgYW0gbm90
IGZhbWlsaWFyIHdpdGggVFBNIGFuZCBoYXZlIG5vIGNsZWFyIGlkZWEgZm9yIHRoZSB0aW1lIGJl
aW5nLgo+IChlbXVsYXRpbmcgUGxhdGZvcm0gQ29uZmlndXJhdGlvbiBSZWdpc3RlcnMgPykuICBC
dXQgc2luY2UgdGhpcwo+IGVtdWxhdG9yIGlzIGhlbGQgaW5zaWRlIGEgbGludXgga2VybmVsIGlt
YWdlLCBhbmQgdGhlIFVLSSdzIHNpZ25hdHVyZQo+IGlzIGNoZWNrZWQgZHVyaW5nIGtleGVjX2Zp
bGVfbG9hZC4gQWxsIG9mIHRoZW0gYXJlIHNhZmUgZnJvbQo+IG1vZGlmaWNhdGlvbiwgdGhpcyBz
ZWN1cml0eSBpcyBub3QgYW4gdXJnZW50IGlzc3VlLgoKSG1tLCBJJ2QgcmVhbGx5IHRoaW5rIGFi
b3V0IHRoaXMgd2l0aCBzb21lIHByaW9yaXR5LiBUaGUgbWVhc3VyZW1lbnQKc3R1ZmYgc2hvdWxk
IG5vdCBiZSBhbiBhZnRlcnRob3VnaHQsIGl0IHR5cGljYWxseSBoYXMgbWFqb3IKaW1wbGljYXRp
b25zIG9uIGhvdyB5b3UgZGVzaWduIHlvdXIgdHJhbnNpdGlvbnMsIGJlY2F1c2UgbWVhc3VyZW1l
bnRzCm9mIHNvbWUgY29tcG9uZW50IGFsd2F5cyBuZWVkIHRvIGhhcHBlbiAqYmVmb3JlKiB5b3Ug
cGFzcyBjb250cm9sIHRvCml0LCBvdGhlcndpc2UgdGhleSBhcmUgcG9pbnRsZXNzLgoKTGVubmFy
dAoKLS0KTGVubmFydCBQb2V0dGVyaW5nLCBCZXJsaW4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
