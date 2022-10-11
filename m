Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCACAC433FE
	for <kexec@archiver.kernel.org>; Tue, 11 Oct 2022 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:From:MIME-Version:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JYjGZIZx9U6skyVBabuOf6rxqkh3FQEJkSbSKdmHUmU=; b=vu7i+4HwJuboOf
	OQhTt1S+BQ2R4xbV1U4PFmqLER6u4VXLqygAAakOdb4CiMb10P7xDkL1Pyv0GZ51hRxRGuzfkXOzi
	8jB1FEe/vb8BoM2+wzLaqttCzBCDi7cQD1Cjq17mMjzd5L2K6bh3OO7XSn/eQwOf/LE3P7KftETI+
	OPHVlyiO8ECrdW4BXm6kGGIHZYpewjI9WCvKKUl70b2zLUXqgS9qstEwigW0xCe334oRz689DfYG+
	8cCTrNToTTANApGp8OUldBZDGk/omhWobvhNgIUr4PCAHEypNEUQWylWJTSbzVLZ0mHMbQ0cg1ziw
	0wq90GEzF2YdNNFGhmIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiJgM-005PVN-7Z; Tue, 11 Oct 2022 18:08:46 +0000
Received: from 176-133-184-57.abo.bbox.fr ([176.133.184.57] helo=mail.azurya.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiJgE-005PU3-TP
	for kexec@lists.infradead.org; Tue, 11 Oct 2022 18:08:41 +0000
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by mail.azurya.net (Postfix) with ESMTPA id 08B75B46F54
	for <kexec@lists.infradead.org>; Tue, 11 Oct 2022 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=azurya.net; s=dkim;
	t=1665511362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YTl7t1Bsl+CAy/kZiBcrRTIhFfdllLEMU4rQ2wJ2cNs=;
	b=Yr6ABVWBy9kCff+dv+hVu6JjQqA0MHvQfggQqQ3IA0mfyg3fu03mNl635CFZHCD36a844S
	yLbX0h3O+tqgdrhMsgC+UEpDYJ3hkspmphM7KbkGLIh1Tvv2lJouSVKtFdhIDxNVGPSg08
	cjtpFAoxWfkNrYApR2tcKxdL6lSOG6A=
Message-ID: <255eefa5-053b-4152-7b4e-21d707f16468@azurya.net>
Date: Tue, 11 Oct 2022 20:02:41 +0200
MIME-Version: 1.0
From: Azurya Development <dev@azurya.net>
Subject: Multiboot2 xen 4.14.5 kernel
To: kexec@lists.infradead.org
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=azurya.net;
	s=dkim; t=1665511362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YTl7t1Bsl+CAy/kZiBcrRTIhFfdllLEMU4rQ2wJ2cNs=;
	b=E7tB/9/+qm2c0ETx25MZZrWAorPzADnAW/SkPMcBB8cHlNp0QyWynDN/lAVapdPSwApJc7
	0NNh9+4vG/YICsbV4/0H6oWt6c/qDt58G8VmLVo94YTW5QsWPQt/hqf4IWCDCRARozZLID
	GMAOQmXcx8IAhVoHx60NmXGIMNEXfgA=
ARC-Seal: i=1; s=dkim; d=azurya.net; t=1665511362; a=rsa-sha256; cv=none;
	b=Trk8nm0MWa7sVKwKtVb1swVHG07N1QY0tQ4xNIDBKZz9PZdXu/8N0rOKf3S+iiIgfTQGaK
	7oFRhjeePVr2NDIkFaI35nmFSXRpjDFcEyCCtVINwzZnvOfAxZgMBzbL+ZwDiJ8Pk5+jIy
	39ipZlYQzXY/MKV7PfUWtwbP8yk1Wcs=
ARC-Authentication-Results: i=1;
	mail.azurya.net;
	auth=pass smtp.auth=dev@azurya.net smtp.mailfrom=dev@azurya.net
Authentication-Results: mail.azurya.net;
	auth=pass smtp.auth=dev@azurya.net smtp.mailfrom=dev@azurya.net
X-Spamd-Bar: /
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_110839_087853_08428486 
X-CRM114-Status: UNSURE (   9.00  )
X-CRM114-Notice: Please train this message.
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

SGksCgpJJ20gdHJ5aW5nIHRvIGtleGVjIGZyb20gYSBMaW51eCBrZXJuZWwgdG8gYSBYZW4gc3Vw
cG9ydGluZyBtdWx0aWJvb3QyLiAKTXkgR1JVQjIgY29uZmlnIG1hbmFnZXMgdG8gbGF1bmNoIFhl
biB3aXRob3V0IGFueSBpc3N1ZXMsIGJ1dCBJIGhhdmVuJ3QgCmJlZW4gYWJsZSB0byByZXByb2R1
Y2UgYSBzaW1pbGFyIHNldHVwIHVzaW5nIHRoZSBsYXRlc3Qga2V4ZWMgYmluYXJ5LgoKSGVyZSdz
IHRoZSByZWxldmFudCAod29ya2luZykgZ3J1Yi5jZmcgc2VjdGlvbjoKCiA+IGVjaG/CoMKgIMKg
J0xvYWRpbmcgWGVuIDQuMTQuNSAuLi4nCiA+wqDCoMKgwqAgaWYgWyAiJGdydWJfcGxhdGZvcm0i
ID0gInBjIiAtbyAiJGdydWJfcGxhdGZvcm0iID0gIiIgXTsgdGhlbgogPsKgwqDCoMKgIMKgIMKg
IHhlbl9ybV9vcHRzPQogPsKgwqDCoMKgIGVsc2UKID7CoMKgwqDCoMKgwqDCoMKgIHhlbl9ybV9v
cHRzPSJuby1yZWFsLW1vZGUgZWRkPW9mZiIKID7CoMKgwqDCoCBmaQogPiBtdWx0aWJvb3QywqDC
oCDCoC94ZW4tNC4xNC41Lmd6IHBsYWNlaG9sZGVywqAgY29uc29sZT1ub25lIApkb20wX21lbT1t
aW46MTAyNE0gZG9tMF9tZW09bWF4OjQwOTZNIHVjb2RlPXNjYW4gc210PW9mZiAKZ250dGFiX21h
eF9mcmFtZXM9MjA0OCBnbnR0YWJfbWF4X21hcHRyYWNrX2ZyYW1lcz00MDk2ICR7eGVuX3JtX29w
dHN9CiA+IGVjaG/CoMKgIMKgJ0xvYWRpbmcgTGludXggNS4xNS42NC0xLmZjMzIucXViZXMueDg2
XzY0IC4uLicKID4gbW9kdWxlMsKgwqAgwqAvdm1saW51ei01LjE1LjY0LTEuZmMzMi5xdWJlcy54
ODZfNjQgcGxhY2Vob2xkZXIgCnJvb3Q9L2Rldi9tYXBwZXIvcXViZXNfZG9tMC1yb290IHJvIApy
ZC5sdWtzLnV1aWQ9bHVrcy00MjcyZTJlYi0yZjZmLTQ1MzItYTgwMS1jZmIzMDI5YjEwODAgCnJk
Lmx2bS5sdj1xdWJlc19kb20wL3Jvb3QgcmQubHZtLmx2PXF1YmVzX2RvbTAvc3dhcCAKcGx5bW91
dGguaWdub3JlLXNlcmlhbC1jb25zb2xlcyByZC5kcml2ZXIucHJlPWJ0cmZzIHJoZ2IgcXVpZXQK
ID4gZWNob8KgwqAgwqAnTG9hZGluZyBpbml0aWFsIHJhbWRpc2sgLi4uJwogPiBtb2R1bGUywqDC
oCDCoC0tbm91bnppcCAvaW5pdHJhbWZzLTUuMTUuNjQtMS5mYzMyLnF1YmVzLng4Nl82NC5pbWcK
CkFuZCBoZXJlIGlzIG15IHVuc3VjY2Vzc2Z1bCBhdHRlbXB0IGF0IHJlcHJvZHVjaW5nIHRoaXMg
YmVoYXZpb3IgKGZyb20gYSAKTGludXggTGl2ZVVTQik6CgogPiBta2RpciAvbW50L2Jvb3QgJiYg
bW91bnQgL2Rldi9zZGEyIC9tbnQvYm9vdCAmJiBtb3VudCAvZGV2L3NkYTEgCi9tbnQvYm9vdC9l
ZmkKID4ga2V4ZWMgXAogPsKgIMKgwqAgLWwgL21udC9ib290L3hlbi00LjE0LjUuZ3ogXAogPsKg
IMKgwqAgLXQgbXVsdGlib290Mi14ODYgXAogPsKgIMKgwqAgLS1jb21tYW5kLWxpbmU9ImNvbnNv
bGU9dmdhIGRvbTBfbWVtPW1pbjoxMDI0TSBkb20wX21lbT1tYXg6NDA5Nk0gCnVjb2RlPXNjYW4g
c210PW9mZiBnbnR0YWJfbWF4X2ZyYW1lcz0yMDQ4IGdudHRhYl9tYXhfbWFwdHJhY2tfZnJhbWVz
PTQwOTYiIFwKID7CoCDCoMKgIC0tbW9kdWxlPSIvbW50L2Jvb3Qvdm1saW51ei01LjE1LjY0LTEu
ZmMzMi5xdWJlcy54ODZfNjQgCnJvb3Q9L2Rldi9tYXBwZXIvcXViZXNfZG9tMC1yb290IHJvIApy
ZC5sdWtzLnV1aWQ9bHVrcy00MjcyZTJlYi0yZjZmLTQ1MzItYTgwMS1jZmIzMDI5YjEwODAgCnJk
Lmx2bS5sdj1xdWJlc19kb20wL3Jvb3QgcmQubHZtLmx2PXF1YmVzX2RvbTAvc3dhcCAKcGx5bW91
dGguaWdub3JlLXNlcmlhbC1jb25zb2xlcyByZC5kcml2ZXIucHJlPWJ0cmZzIHJoZ2IiIFwKID4g
LS1tb2R1bGU9Ii9tbnQvYm9vdC9pbml0cmFtZnMtNS4xNS42NC0xLmZjMzIucXViZXMueDg2XzY0
LmltZyIKID4ga2V4ZWMgLWUKCkFmdGVyIHRoZSBrZXhlYyAtZSBjb21tYW5kLCB0aGUgc3lzdGVt
IHN5c3RlbWF0aWNhbGx5IHJlYm9vdHMgaW5zdGVhZCBvZiAKbG9hZGluZyBYZW4sIHdpdGggbm8g
aW5mb3JtYXRpb24gYWJvdXQgd2h5LgoKU29tZSB0aGluZ3MgSSB0cmllZDoKCiogUmVtb3Zpbmcg
LS1ub3VuemlwIGZyb20gZ3J1Yi5jZmcgaGFzIG5vIGVmZmVjdCBhbmQgWGVuIHN0aWxsIGJvb3Rz
LgoqIFJlbW92aW5nICJxdWlldCIgZnJvbSB0aGUgZG9tMCBMaW51eCdzIGNvbW1hbmQgbGluZS4g
U3RpbGwgbm8gb3V0cHV0LgoqIGtleGVjJ2luZyBkaXJlY3RseSBpbnRvIGRvbTAgTGludXgga2Vy
bmVsLiBUaGlzIHdvcmtzLCBidXQgaXQgaXMgbm90CndoYXQgSSB3YW50LgoqIEFkZGluZyAibm8t
cmVhbC1tb2RlIiBhbmQgIm5vLXJlYWwtbW9kZSBlZGQ9b2ZmIiB0byBYZW4ncwpjb21tYW5kLWxp
bmUuIE5vIGx1Y2suCiogQWRkaW5nICJub3JlYm9vdCIgdG8gWGVuJ3MgY29tbWFuZC1saW5lLiBX
aXRoIEdSVUIyIGFuZCBhIGZvcmNlZApjcmFzaCAoZS5nLiBieSBvbWl0dGluZyB0aGUgbW9kdWxl
MiBpbnN0cnVjdGlvbnMpLCBYZW4gaGFuZ3MgYXMKZXhwZWN0ZWQuIFdpdGgga2V4ZWMgdGhlIHN5
c3RlbSByZWJvb3RzIG5vbmV0aGVsZXNzLCB3aXRoIG5vCmluZm9ybWF0aW9uLgoqIEkgYWxzbyBz
dHVtYmxlZCB1cG9uIFt0aGlzCmFydGljbGVdKGh0dHBzOi8veGVuYml0cy54ZW5wcm9qZWN0Lm9y
Zy9kb2NzLzQuMTQtdGVzdGluZy9taXNjL2tleGVjX2FuZF9rZHVtcC50eHQpCmJ1dCB0aGUgYC0t
dm1tYCBvcHRpb24gaXMgSUEtNjQgc3BlY2lmaWMsIHdoaWxlIEknbSBvbiB4ODZfNjQuCgpJJ20g
cnVubmluZyBvdXQgb2YgaWRlYXMgaG93IHRvIGZpeCB0aGlzLCBpcyB0aGVyZSBzb21ldGhpbmcg
SSBhbSAKdW5hd2FyZSB3aXRoIHJlZ2FyZCB0byBib290aW5nIGEgbXVsdGlib290MiBzeXN0ZW0/
IE9yIFhlbiBpbiAKcGFydGljdWxhcj8gSG93IHRvIHJlcHJvZHVjZSBHUlVCMidzIHNldHVwIHVz
aW5nIGtleGVjPwoKUmVnYXJkcywKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
