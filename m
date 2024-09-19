Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1326CDD552
	for <kexec@archiver.kernel.org>; Thu, 19 Sep 2024 03:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EhR0328eqsbwYh6VEDkVgyyVRtC0BehewndCyBN0N04=; b=z0cDnHqGgTUYrj
	nUO4qnQEYtJxfu0Or+6cJ+FNPOfx9WQItHlf522uNswyrc9+lpX6rNj0hKG1n2gMKuBmeSachadqG
	0ou8yuzUniXBhTlzQhtuHr+85lUJhiCju0t0V+sIQQA6LxyxmigLbdlWBP/vaDvtu1wuAUqTcssa0
	7hp+YUfEBbKfbzHdQkAq+bamibHCc3xQUTqq2Cn0q4z5Lisx3btCEu3OqialxLdIVQiVrHnOxQ0jG
	wISbsSIjQysQP1KnVdmPfbfRCO2DYtzOXoSYp7EqKUASdi+2wkfdsMMjxPD+7ZHcOZw8zKnHoh5ET
	5rnV1KHaFWXIOucOt/qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sr7mZ-00000009MDF-078D;
	Thu, 19 Sep 2024 03:24:39 +0000
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sr7mU-00000009MBm-38Ms
	for kexec@lists.infradead.org;
	Thu, 19 Sep 2024 03:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726716265;
	bh=fZa83PjDF+loDF68mkxwlic+EMe/zFZXGtZzppvd0EI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kKrfwXQzYOVoLALAu4QL5cpeNLZ3QlBIP45hb3cw/4FvpWKiSfhgBqI9/imj0M0Hf
	 FcOhPgV7nLSzZozANLb+DWAG9iM+k7ioTpcaQK+Z/3dTu81vHqFjyQU4yBDtvMFr2T
	 vgAmi/i58LOQYT3ZCnzPkz+6KQPEwUlJBThCDLC1UDMLdR9fJmJayb6xiZjOp+/kTc
	 uSEJYWpnekmA0Y1inNEkjpEqoQabVADoCxvH3tbI5jTye0aknSrsJMoWCWl3DRbPgw
	 Z/PqCvPn1RU8HxzF+hG9DBu3xMzrAMEhf9/Xa+ut3OyOw8urSdGB6Ave3V6vLKrRLe
	 aveMIY2NWz7Aw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X8LTz0kTlz4xWZ;
	Thu, 19 Sep 2024 13:24:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Vasilevsky <dave@vasilevsky.ca>, glaubitz@physik.fu-berlin.de,
 bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 ebiederm@xmission.com
Cc: Dave Vasilevsky <dave@vasilevsky.ca>, Reimar =?utf-8?Q?D=C3=B6ffinger?=
 <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH v2] crash, powerpc: Default to CRASH_DUMP=n on
 PPC_BOOK3S_32
In-Reply-To: <20240917163720.1644584-1-dave@vasilevsky.ca>
References: <20240917163720.1644584-1-dave@vasilevsky.ca>
Date: Thu, 19 Sep 2024 13:24:22 +1000
Message-ID: <87ttecpbq1.fsf@mail.lhotse>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_202434_950600_8092B4E1 
X-CRM114-Status: GOOD (  12.24  )
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

RGF2ZSBWYXNpbGV2c2t5IDxkYXZlQHZhc2lsZXZza3kuY2E+IHdyaXRlczoKPiBGaXhlcyBib290
IGZhaWx1cmVzIG9uIDYuOSBvbiBQUENfQk9PSzNTXzMyIG1hY2hpbmVzIHVzaW5nCj4gT3BlbiBG
aXJtd2FyZS4gT24gdGhlc2UgbWFjaGluZXMsIHRoZSBrZXJuZWwgcmVmdXNlcyB0byBib290Cj4g
ZnJvbSBub24temVybyBQSFlTSUNBTF9TVEFSVCwgd2hpY2ggb2NjdXJzIHdoZW4gQ1JBU0hfRFVN
UCBpcyBvbi4KPgo+IFNpbmNlIG1vc3QgUFBDX0JPT0szU18zMiBtYWNoaW5lcyBib290IHZpYSBP
cGVuIEZpcm13YXJlLCBpdCBzaG91bGQKPiBkZWZhdWx0IHRvIG9mZiBmb3IgdGhlbS4gVXNlcnMg
Ym9vdGluZyB2aWEgc29tZSBvdGhlciBtZWNoYW5pc20KPiBjYW4gc3RpbGwgdHVybiBpdCBvbiBl
eHBsaWNpdGx5Lgo+Cj4gRG9lcyBub3QgY2hhbmdlIHRoZSBkZWZhdWx0IG9uIGFueSBvdGhlciBh
cmNoaXRlY3R1cmVzIGZvciB0aGUKPiB0aW1lIGJlaW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTogRGF2
ZSBWYXNpbGV2c2t5IDxkYXZlQHZhc2lsZXZza3kuY2E+Cj4gUmVwb3J0ZWQtYnk6IFJlaW1hciBE
w7ZmZmluZ2VyIDxSZWltYXIuRG9lZmZpbmdlckBnbXguZGU+Cj4gQ2xvc2VzOiBodHRwczovL2xp
c3RzLmRlYmlhbi5vcmcvZGViaWFuLXBvd2VycGMvMjAyNC8wNy9tc2cwMDAwMS5odG1sCj4gRml4
ZXM6IDc1YmMyNTVhNzQ0NCAoImNyYXNoOiBjbGVhbiB1cCBrZHVtcCByZWxhdGVkIGNvbmZpZyBp
dGVtcyIpCj4gLS0tCj4gIGFyY2gvYXJtL0tjb25maWcgICAgICAgfCAzICsrKwo+ICBhcmNoL2Fy
bTY0L0tjb25maWcgICAgIHwgMyArKysKPiAgYXJjaC9sb29uZ2FyY2gvS2NvbmZpZyB8IDMgKysr
Cj4gIGFyY2gvbWlwcy9LY29uZmlnICAgICAgfCAzICsrKwo+ICBhcmNoL3Bvd2VycGMvS2NvbmZp
ZyAgIHwgNCArKysrCj4gIGFyY2gvcmlzY3YvS2NvbmZpZyAgICAgfCAzICsrKwo+ICBhcmNoL3Mz
OTAvS2NvbmZpZyAgICAgIHwgMyArKysKPiAgYXJjaC9zaC9LY29uZmlnICAgICAgICB8IDMgKysr
Cj4gIGFyY2gveDg2L0tjb25maWcgICAgICAgfCAzICsrKwo+ICBrZXJuZWwvS2NvbmZpZy5rZXhl
YyAgIHwgMiArLQo+ICAxMCBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpBY2tlZC1ieTogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1PiAo
cG93ZXJwYykKCmNoZWVycwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
