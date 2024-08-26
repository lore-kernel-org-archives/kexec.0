Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7474C5320E
	for <kexec@archiver.kernel.org>; Mon, 26 Aug 2024 02:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mj4WmgQf4ArOggBhYioGndwe/NX4rZLhOOuAkk/raRE=; b=VcEz9elzHwNrJX
	M3so/liOpnkT9nawk0iGhAOBnN17KC0iY1cTkgtfQQOGETu3HRGtsCFWXmlUvER9FHRgz6qfByndO
	mNGc42nExrqbDaD+NPxzfIJMMRyPBslTzzxgFVrGEFqqHUTqyXjwRpfxHwL7F2BwCP7CBM6gwnQ5D
	JMFhSbr+/mYQy19beDdC61lRdEnMyAaxm/z9G1SUvisaYBMjFeMx8hZg5816dI00MZPmilLG8w2x2
	Xdd2fV7SGAjgQ/xFrZmeLyP51vf89sE+gWefmZXJjwiyY9FJUSahaQyraMHg629IV92ACmzmBZltJ
	EBxIqFGevl5FaeudXk8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siP4W-00000005UyJ-2tVW;
	Mon, 26 Aug 2024 02:03:08 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siP4S-00000005Uxf-0b7I
	for kexec@lists.infradead.org;
	Mon, 26 Aug 2024 02:03:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724637782;
	bh=dZljPhuAr0mbkeN13uZvN48XWKzlLsshYIWJUncVcO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VHGPtgj3ZZH12Ev7NLX3TF4pSlkYdY9+3Nos8qj7Ugrk3Qd7UBTWOtWCw67MgXYWv
	 Qf2bSQC2kE+6RnAmHrsiymxESd/vrerKgDKnxQbFnzMGj9QoZhKM4BG813fBkW7/oy
	 z6/RR90YfTlKCPEcpUglj1BtK76nlsKyI9rwR+9dNJFdSKB9WERcPawXYYaYWesu3G
	 qO2lMQfKPcsW0jJphnqBQ0sQ9kXdFOOxx2o6xJ+jdhIoe3PL2bPg8u7lSQ8ia2DLv4
	 1IKHQh9Xc0kwVaDtqJFt7AUOf/uVLWHWmUo277slyXLTsvcl221QRZpYtO03eTe8IU
	 rQ67+TcLWw9cw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WsYq848z1z4wbR;
	Mon, 26 Aug 2024 12:02:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Dave Vasilevsky
 <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Reimar
 =?utf-8?Q?D=C3=B6ffinger?=
 <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
In-Reply-To: <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
Date: Mon, 26 Aug 2024 12:02:59 +1000
Message-ID: <87frqsghws.fsf@mail.lhotse>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_190304_527928_70C776A5 
X-CRM114-Status: GOOD (  23.05  )
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

R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JpdGVzOgo+IEhpIERh
dmUsCj4KPiBPbiBGcmksIEF1ZyAyMywgMjAyNCBhdCAyOjU04oCvUE0gRGF2ZSBWYXNpbGV2c2t5
IDxkYXZlQHZhc2lsZXZza3kuY2E+IHdyb3RlOgo+PiBGaXhlcyBib290IGZhaWx1cmVzIG9uIDYu
OSBvbiBQUENfQk9PSzNTXzMyIG1hY2hpbmVzIHVzaW5nCj4+IE9wZW4gRmlybXdhcmUuIE9uIHRo
ZXNlIG1hY2hpbmVzLCB0aGUga2VybmVsIHJlZnVzZXMgdG8gYm9vdAo+PiBmcm9tIG5vbi16ZXJv
IFBIWVNJQ0FMX1NUQVJULCB3aGljaCBvY2N1cnMgd2hlbiBDUkFTSF9EVU1QIGlzIG9uLgo+Pgo+
PiBTaW5jZSBtb3N0IFBQQ19CT09LM1NfMzIgbWFjaGluZXMgYm9vdCB2aWEgT3BlbiBGaXJtd2Fy
ZSwgaXQgc2hvdWxkCj4+IGRlZmF1bHQgdG8gb2ZmIGZvciB0aGVtLiBVc2VycyBib290aW5nIHZp
YSBzb21lIG90aGVyIG1lY2hhbmlzbQo+PiBjYW4gc3RpbGwgdHVybiBpdCBvbiBleHBsaWNpdGx5
Lgo+Pgo+PiBBbHNvIGRlZmF1bHRzIHRvIENSQVNIX0RVTVA9biBvbiBzaC4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogRGF2ZSBWYXNpbGV2c2t5IDxkYXZlQHZhc2lsZXZza3kuY2E+Cj4+IFJlcG9ydGVk
LWJ5OiBSZWltYXIgRMO2ZmZpbmdlciA8UmVpbWFyLkRvZWZmaW5nZXJAZ214LmRlPgo+PiBDbG9z
ZXM6IGh0dHBzOi8vbGlzdHMuZGViaWFuLm9yZy9kZWJpYW4tcG93ZXJwYy8yMDI0LzA3L21zZzAw
MDAxLmh0bWwKPj4gRml4ZXM6IDc1YmMyNTVhNzQ0NCAoImNyYXNoOiBjbGVhbiB1cCBrZHVtcCBy
ZWxhdGVkIGNvbmZpZyBpdGVtcyIpCj4KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghCj4KPj4gLS0t
IGEva2VybmVsL0tjb25maWcua2V4ZWMKPj4gKysrIGIva2VybmVsL0tjb25maWcua2V4ZWMKPj4g
QEAgLTk3LDcgKzk3LDcgQEAgY29uZmlnIEtFWEVDX0pVTVAKPj4KPj4gIGNvbmZpZyBDUkFTSF9E
VU1QCj4+ICAgICAgICAgYm9vbCAia2VybmVsIGNyYXNoIGR1bXBzIgo+PiAtICAgICAgIGRlZmF1
bHQgeQo+PiArICAgICAgIGRlZmF1bHQgQVJDSF9ERUZBVUxUX0NSQVNIX0RVTVAKPj4gICAgICAg
ICBkZXBlbmRzIG9uIEFSQ0hfU1VQUE9SVFNfQ1JBU0hfRFVNUAo+PiAgICAgICAgIGRlcGVuZHMg
b24gS0VYRUNfQ09SRQo+PiAgICAgICAgIHNlbGVjdCBWTUNPUkVfSU5GTwo+Cj4gSU1ITyBDUkFT
SF9EVU1QIHNob3VsZCBqdXN0IGRlZmF1bHQgdG8gbiwgbGlrZSBtb3N0IGtlcm5lbCBvcHRpb25z
LCBhcwo+IGl0IGVuYWJsZXMgbm9uLXRyaXZpYWwgZXh0cmEgZnVuY3Rpb25hbGl0eTogdGhlIGtl
cm5lbCBzb3VyY2UgdHJlZSBoYXMKPiBtb3JlIHRoYW4gMTAwIGxvY2F0aW9ucyB0aGF0IGNoZWNr
IGlmIENPTkZJR19DUkFTSF9EVU1QIGlzIGVuYWJsZWQuCj4KPiBMZXR0aW5nIGl0IGRlZmF1bHQg
dG8gZW5hYmxlZCBhbHNvIGNvbmZsaWN0cyB3aXRoIHRoZSBzcGlyaXQgb2YgdGhlCj4gaGVscCB0
ZXh0IGZvciB0aGUgc3ltYm9sOgo+Cj4gICAgICAgICAgIEdlbmVyYXRlIGNyYXNoIGR1bXAgYWZ0
ZXIgYmVpbmcgc3RhcnRlZCBieSBrZXhlYy4KPiAgICAgICAgICAgVGhpcyBzaG91bGQgYmUgbm9y
bWFsbHkgb25seSBzZXQgaW4gc3BlY2lhbCBjcmFzaCBkdW1wIGtlcm5lbHMKPiAgICAgICAgICAg
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl4KPiAgICAgICAgICAgd2hpY2ggYXJlIGxvYWRlZCBpbiB0aGUgbWFpbiBrZXJuZWwgd2l0
aCBrZXhlYy10b29scyBpbnRvCj4gICAgICAgICAgIGEgc3BlY2lhbGx5IHJlc2VydmVkIHJlZ2lv
biBhbmQgdGhlbiBsYXRlciBleGVjdXRlZCBhZnRlcgo+ICAgICAgICAgICBhIGNyYXNoIGJ5IGtk
dW1wL2tleGVjLiBUaGUgY3Jhc2ggZHVtcCBrZXJuZWwgbXVzdCBiZSBjb21waWxlZAo+ICAgICAg
ICAgICB0byBhIG1lbW9yeSBhZGRyZXNzIG5vdCB1c2VkIGJ5IHRoZSBtYWluIGtlcm5lbCBvciBC
SU9TIHVzaW5nCj4gICAgICAgICAgIFBIWVNJQ0FMX1NUQVJULCBvciBpdCBtdXN0IGJlIGJ1aWx0
IGFzIGEgcmVsb2NhdGFibGUgaW1hZ2UKPiAgICAgICAgICAgKENPTkZJR19SRUxPQ0FUQUJMRT15
KS4KPiAgICAgICAgICAgRm9yIG1vcmUgZGV0YWlscyBzZWUgRG9jdW1lbnRhdGlvbi9hZG1pbi1n
dWlkZS9rZHVtcC9rZHVtcC5yc3QKPgo+ICAgICAgICAgICBGb3IgczM5MCwgdGhpcyBvcHRpb24g
YWxzbyBlbmFibGVzIHpmY3BkdW1wLgo+ICAgICAgICAgICBTZWUgYWxzbyA8ZmlsZTpEb2N1bWVu
dGF0aW9uL2FyY2gvczM5MC96ZmNwZHVtcC5yc3Q+Cj4KPiBXaGF0IGlzIHNvIHNwZWNpYWwgYWJv
dXQgQ1JBU0hfRFVNUCwgdGhhdCBpdCBzaG91bGQgYmUgZW5hYmxlZCBieQo+IGRlZmF1bHQ/CiAK
VGhlIHJlYWxpdHkgaXMgdGhhdCBlc3NlbnRpYWxseSBhbGwgZGlzdHJvcyBlbmFibGUgaXQuIEJl
Y2F1c2UgdGhleQpkb24ndCB3YW50IHRvIG1hbmFnZSBzZXBhcmF0ZSBrZXJuZWwgLyBjcmFzaC1r
ZXJuZWwgcGFja2FnZXMuCgpTbyBJTUhPIGhhdmluZyBpdCBlbmFibGVkIGJ5IGRlZmF1bHQgaW4g
dXBzdHJlYW0gZG9lcyBtYWtlIHNlbnNlLApiZWNhdXNlIGl0IG1vcmUgY2xvc2VseSBtYXRjaGVz
IHdoYXQgZGlzdHJvcy91c2VycyBhY3R1YWxseSBydW4uCgpjaGVlcnMKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
