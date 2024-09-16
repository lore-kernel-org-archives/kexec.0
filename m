Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCD6C3ABB2
	for <kexec@archiver.kernel.org>; Mon, 16 Sep 2024 20:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yT4eRcEy+w+NqXu7mkKB8XYeijvYUwlc7BC9UrH9I7Q=; b=Siv0Bsvv1k304PD9GoonSjIqSL
	Ux7ibXD9EKREu5fO5wZ9ekTcPQwusew8CUc50B2HTKum1W8UFoVyJBpwl0HOKBK3nJ53zKAx04J70
	2Ag+bwjDLpRSmaLp7d01sWnacpQ7x9Ih0d9osYilPEBzDQSt6pxCl0fDlnQM5GyDqP6eD4xNhH0Kg
	iyEaddoprb8qgXNKSyTjsgMzkllr24Z4Voe9lOK0xw8vbjlDI7pLkHeg+T9nWrYDdjDwLuBjGHjWx
	vnym9XTD0fHORoeMnNJfYNgKt5hrBeEEEsJgG2KJPZoidLs9OMOGayU9+7EaK42akqyayN25Axl1t
	3mq+ELvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqIEL-00000004qA5-0yNX;
	Mon, 16 Sep 2024 20:21:53 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqIEI-00000004q3a-1Sfy
	for kexec@lists.infradead.org;
	Mon, 16 Sep 2024 20:21:51 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:42630)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sqIDz-001tnV-Dg; Mon, 16 Sep 2024 14:21:31 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:37670 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sqIDx-005wGA-MA; Mon, 16 Sep 2024 14:21:30 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Breno Leitao <leitao@debian.org>,  Ard Biesheuvel <ardb@kernel.org>,
  Usama Arif <usamaarif642@gmail.com>,  linux-efi@vger.kernel.org,
  kexec@lists.infradead.org,  bhe@redhat.com,  vgoyal@redhat.com,
  tglx@linutronix.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  linux-kernel@vger.kernel.org,  rmikey@meta.com,  gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
	<CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
	<2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
	<CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
	<20240912-wealthy-gabby-tamarin-aaba3c@leitao>
	<d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
	<20240913-careful-maroon-crab-8a0541@leitao>
	<5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
Date: Mon, 16 Sep 2024 15:20:58 -0500
In-Reply-To: <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
	(James Bottomley's message of "Fri, 13 Sep 2024 08:07:18 -0400")
Message-ID: <87o74n5p05.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1sqIDx-005wGA-MA;;;mid=<87o74n5p05.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18ZE5XOodQ0y66kw/dUg5oYa8/l9iiyLZM=
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: gourry@gourry.net, rmikey@meta.com, linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de, vgoyal@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, linux-efi@vger.kernel.org, usamaarif642@gmail.com, ardb@kernel.org, leitao@debian.org, James.Bottomley@HansenPartnership.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_132150_394150_F82B93F5 
X-CRM114-Status: GOOD (  36.34  )
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

SmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPiB3
cml0ZXM6Cgo+IE9uIEZyaSwgMjAyNC0wOS0xMyBhdCAwNDo1NyAtMDcwMCwgQnJlbm8gTGVpdGFv
IHdyb3RlOgo+PiBIZWxsbyBKYW1lcywKPj4gCj4+IE9uIFRodSwgU2VwIDEyLCAyMDI0IGF0IDEy
OjIyOjAxUE0gLTA0MDAsIEphbWVzIEJvdHRvbWxleSB3cm90ZToKPj4gPiBPbiBUaHUsIDIwMjQt
MDktMTIgYXQgMDY6MDMgLTA3MDAsIEJyZW5vIExlaXRhbyB3cm90ZToKPj4gPiA+IEhlbGxvIEFy
ZCwKPj4gPiA+IAo+PiA+ID4gT24gVGh1LCBTZXAgMTIsIDIwMjQgYXQgMTI6NTE6NTdQTSArMDIw
MCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4+ID4gPiA+IEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGNv
dWxkIGJlIGFuIEVGSSBidWcsIGdpdmVuIHRoYXQgaXQgZG9lcwo+PiA+ID4gPiBub3QgZGVhbCB3
aXRoIEU4MjAgdGFibGVzIGF0IGFsbC4KPj4gPiA+IAo+PiA+ID4gSSB3YW50IHRvIGJhY2sgdXAg
YSBsaXR0bGUgYml0IGFuZCBtYWtlIHN1cmUgSSBhbSBmb2xsb3dpbmcgdGhlCj4+ID4gPiBkaXNj
dXNzaW9uLgo+PiA+ID4gCj4+ID4gPiBGcm9tIHdoYXQgSSB1bmRlcnN0YW5kIGZyb20gcHJldmlv
dXMgZGlzY3Vzc2lvbiwgd2UgaGF2ZSBhbiBFRkkKPj4gPiA+IGJ1ZyBhcyB0aGUgcm9vdCBjYXVz
ZSBvZiB0aGlzIGlzc3VlLgo+PiA+ID4gCj4+ID4gPiBUaGlzIGhhcHBlbnMgYmVjYXVzZSB0aGUg
RUZJIGRvZXMgTk9UIG1hcmsgdGhlIEVGSSBUUE0gZXZlbnQgbG9nCj4+ID4gPiBtZW1vcnkgcmVn
aW9uIGFzIHJlc2VydmVkIChFRklfUkVTRVJWRURfVFlQRSkuIE5vdCBoYXZpbmcgYW4KPj4gPiA+
IGVudHJ5IGZvciB0aGUgZXZlbnQgdGFibGUgbWVtb3J5IGluIEVGSSBtZW1vcnkgbWFwcGVkLCB0
aGVuCj4+ID4gPiBsaWJzdHViIHdpbGwgaWdub3JlIGl0IGNvbXBsZXRlbHkgKHRoZSBUUE0gZXZl
bnQgbG9nIG1lbW9yeQo+PiA+ID4gcmFuZ2UpIGFuZCBub3QgcG9wdWxhdGUgZTgyMCB0YWJsZSB3
aXRoIGl0Lgo+PiA+IAo+PiA+IFdhaXQsIHRoYXQncyBub3QgY29ycmVjdC7CoCBUaGUgVFBNIGxv
ZyBpcyBpbiBtZW1vcnkgdGhhdCBkb2Vzbid0Cj4+ID4gc3Vydml2ZSBFeGl0Qm9vdFNlcnZpY2Vz
IChieSBkZXNpZ24gaW4gY2FzZSB0aGUgT1MgZG9lc24ndCBjYXJlCj4+ID4gYWJvdXQgaXQpLsKg
IFNvIHRoZSBFRkkgc3R1YiBhY3R1YWxseSBjb3BpZXMgaXQgb3ZlciB0byBhIG5ldwo+PiA+IGNv
bmZpZ3VyYXRpb24gdGFibGUgdGhhdCBpcyBpbiByZXNlcnZlZCBtZW1vcnkgYmVmb3JlIGl0IGNh
bGxzCj4+ID4gRXhpdEJvb3RTZXJ2aWNlcy4gIFRoaXMgbmV3IGNvcHkgc2hvdWxkIGJlIGluIGtl
cm5lbCByZXNlcnZlZAo+PiA+IG1lbW9yeSByZWdhcmRsZXNzIG9mIGl0cyBlODIwIG1hcCBzdGF0
dXMuCj4+IAo+PiBGaXJzdCBvZiBhbGwsIHRoYW5rcyBmb3IgY2xhcmlmeWluZyBzb21lIHBvaW50
cyBoZXJlLgo+PiAKPj4gSG93IHNob3VsZCB0aGUgVFBNIGxvZyB0YWJsZSBiZSBwYXNzZWQgdG8g
dGhlIG5leHQga2VybmVsIHdoZW4KPj4ga2V4ZWNpbmcoKSBzaW5jZSBpdCBkaWRuJ3Qgc3VyaXZl
IEV4aXRCb290U2VydmljZXM/Cj4KPiBJJ3ZlIG5vIGlkZWEuICBJJ20gYXNzdW1pbmcgeW91IGRv
bid0IGVsYWJvcmF0ZWx5IHJlY29uc3RydWN0IHRoZSBFRkkKPiBib290IHNlcnZpY2VzLCBzbyB5
b3UgY2FuJ3QgZW50ZXIgdGhlIEVGSSBib290IHN0dWIgYmVmb3JlCj4gRXhpdEJvb3RTZXJ2aWNl
cyBpcyBjYWxsZWQ/ICBTbyBJJ2QgZ3Vlc3MgeW91IHdhbnQgdG8gcHJlc2VydmUgdGhlIEVGSQo+
IHRhYmxlIHRoYXQgY29waWVkIHRoZSBUUE0gZGF0YSBpbiB0byBrZXJuZWwgbWVtb3J5LgoKVGhp
cyBsZWF2ZXMgdHdvIHByYWN0aWNhbCBxdWVzdGlvbnMgaWYgSSBoYXZlIGJlZW4gZm9sbG93aW5n
IGV2ZXJ5dGhpbmcKY29ycmVjdGx5LgoKMSkgSG93IHRvIGdldCBrZXhlYyB0byBhdm9pZCBwaWNr
aW5nIHRoYXQgbWVtb3J5IGZvciB0aGUgbmV3IGtlcm5lbCB0bwogICBydW4gaW4gYmVmb3JlIGl0
IGluaXRpYWxpemVzIGl0c2VsZi4gKEFLQSB0aGUgZ2V0dGluZyBzdG9tcGVkIGJ5CiAgIHJlbG9j
YXRlIGtlcm5lbCBwcm9ibGVtKS4KCjIpIEhvdyB0byBwb2ludCB0aGUgbmV3IGtlcm5lbCB0byBw
cmVzZXJ2ZWQgdHBtX2xvZy4KCgpUaGlzIHJlY29tbWVuZGF0aW9uIGlzIGZyb20gbWVtb3J5IHNv
IGl0IG1heSBiZSBhIGJpdCBvZmYgYnV0CnRoZSBnZW5lcmFsIHN0cnVjdHVyZSBzaG91bGQgd29y
ay4gIFRoZSBpZGVhIGlzIGFzIGZvbGxvd3MuCgotIFBhc3MgdGhlIGluZm9ybWF0aW9uIGJldHdl
ZW4ga2VybmVscy4KCiAgSXQgaXMgcHJvYmFibHkgc2ltcGxlc3QgZm9yIHRoZSBrZXJuZWwgdG8g
aGF2ZSBhIGNvbW1hbmQgbGluZSBvcHRpb24KICB0aGF0IHRlbGxzIHRoZSBrZXJuZWwgdGhlIGFk
ZHJlc3MgYW5kIHNpemUgb2YgdGhlIHRwbV9sb2cuCgogIFdlIGhhdmUgYSBjb3VwbGUgb2YgbWVj
aGFuaXNtcyBoZXJlLiAgQXNzdW1pbmcgeW91IGFyZSBsb2FkaW5nIGEKICBiekltYWdlIHdpdGgg
a2V4ZWNfZmlsZV9sb2FkIHlvdSBzaG91bGQgYmUgYWJsZSB0byBoYXZlIHRoZSBpbiBrZXJuZWwK
ICBsb2FkZXIgdG8gYWRkIHRob3NlIGFyZ3VtZW50cyB0byB0aGUga2VybmVsIGNvbW1hbmQgbGlu
ZS4KCi0gRW5zdXJlIHRoYXQgd2hlbiB0aGUgbG9hZGVyIGlzIGZpbmRpbmcgYW4gYWRkcmVzcyB0
byBsb2FkIHRoZSBuZXcKICBrZXJuZWwgaXQgdHJlYXRzIHRoZSBhZGRyZXNzIG9mIHRoZSB0cG1f
bG9nIGFzIHVuYXZhaWxhYmxlLgoKRG9lcyB0aGF0IHNvdW5kIGxpa2UgYSBkb2FibGUgcGxhbj8K
CkVyaWMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
