Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2DFC52D7C
	for <kexec@archiver.kernel.org>; Wed, 21 Aug 2024 07:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tX79Mbdw6LXAb+6zvDf1xCtDpLU5DgJs2sZNY4MFGHQ=; b=GPGThk3gMbHHPN
	jd2eCLCbH+EQOi5vkH0p87E7t6dSbBVP4goTSa9URoHV35OdLDyycrPrc3umfMezwh1JINH+iaaIc
	C7YnWuSlr9S2nZ5lfaRbmtPIix32QXclQYOEvpqUKuWB2j3CEEHwFUVZMRYTANWFBdcNi2X46ylws
	LBI9qRVlgYMHEob2E166Sg2yXcN80xpAa84+clChv0QceGDLpBjY5JBlZjsycFpaaSTynrrqrejzV
	tU90m0VNbDcaxmmt09O0iurZegsdFyR+65Z2IrkkEF354ieWDxcfQzUuo1/GghzEcVMZi3FIOHg80
	9nTHe3B64n4hWRCYkKKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgfus-00000007wQh-2IuQ;
	Wed, 21 Aug 2024 07:38:02 +0000
Received: from mail.envisioncraftsman.com ([162.19.67.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgfuo-00000007wPX-0dfo
	for kexec@lists.infradead.org;
	Wed, 21 Aug 2024 07:38:00 +0000
Received: by mail.envisioncraftsman.com (Postfix, from userid 1002)
	id 0C513241F3; Wed, 21 Aug 2024 09:36:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=envisioncraftsman.com; s=mail; t=1724225833;
	bh=uGTmdNfeKWYppKfROrYtp0X+RK7/pRJQsBUrarqToyk=;
	h=Date:From:To:Subject:From;
	b=Bnl6iKH2qntkl92JL4oG5kYdI4OQ+D9eGj5jGqNFcln3lPpGRFQp+HZwPjDmrxbiP
	 DaE5vmKLzjhIfytW0BHb1du2bAXp6xHqg/Tt8x+3WyBC+fRcdBX4nbn8u9/kcUfV1v
	 uPX/UDitCnGkLHOK1760/p32IjvsYizK0ORmPUkZjIEr6kbYlktmckwwOZXmlMqkTk
	 Jc97piAuTwwoe1FkOY02OhOtdmrd/C3y6GmrhLl/NEJTMEYc3dlTciwpaL8hAyrFCg
	 57bZrhUuip8bsZK+OJ+pAQhZsWZhgQWXTjlldBJaAj6igVlYkiEEU9WRpYJ1Xcn9Vu
	 1wAzl3HipAkBg==
Received: by mail.envisioncraftsman.com for <kexec@lists.infradead.org>; Wed, 21 Aug 2024 07:35:59 GMT
Message-ID: <20240821084500-0.1.4j.va9m.0.5b7aifmnz0@envisioncraftsman.com>
Date: Wed, 21 Aug 2024 07:35:59 GMT
From: =?UTF-8?Q?"Jan_Pol=C3=A1=C5=A1ek"?= <jan.polasek@envisioncraftsman.com>
To: <kexec@lists.infradead.org>
Subject: Quick Question About Collaboration
X-Mailer: mail.envisioncraftsman.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_003758_660146_3C0CFAED 
X-CRM114-Status: UNSURE (   2.38  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGVsbG8hCgpJIGFtIHZlcnkgaW1wcmVzc2VkIHdpdGggdGhlIHByb2R1Y3RzIGFuZCBzZXJ2aWNl
cyB5b3Ugb2ZmZXIuCgpJIHRob3VnaHQgd2UgY291bGQgaGVscCB5b3UgcmVhY2ggYSBsYXJnZXIg
YXVkaWVuY2Ugd2l0aCB5b3VyIG9mZmVyaW5ncy4gV291bGQgeW91IGJlIGludGVyZXN0ZWQgaW4g
Y29sbGFib3JhdGluZyB3aXRoIHVzIGluIGFuIGFmZmlsaWF0ZSBtYXJrZXRpbmcgY2FtcGFpZ24/
CgpGb3IgZXhhbXBsZSwgb3VyIHByb2dyYW0gZm9yIGEgY29tcGFueSBpbiB0aGUgZS1jb21tZXJj
ZSBzZWN0b3IgcmVzdWx0ZWQgaW4gYW4gaW5jcmVhc2UgaW4gcmV2ZW51ZSBmcm9tIDglIHRvIGFu
IGltcHJlc3NpdmUgMTklIChvbiBhdmVyYWdlIHBlciBxdWFydGVyKS4KCldlIGFjaGlldmUgdXAg
dG8gMTMlIHR1cm5vdmVyIGluIEdBNCwgd2hpbGUgc3RhbmRhcmQgYWZmaWxpYXRlIG5ldHdvcmtz
IGdlbmVyYXRlIG9ubHkgMy02JS4KCldvdWxkIHlvdSBoYXZlIHRpbWUgZm9yIGEgc2hvcnQgY29u
dmVyc2F0aW9uIGluIHRoZSBuZXh0IGZldyBkYXlzPwoKCkJlc3QgcmVnYXJkcwpKYW4gUG9sw6HF
oWVrCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
