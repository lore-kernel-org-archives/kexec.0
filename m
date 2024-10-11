Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5496CFC618
	for <kexec@archiver.kernel.org>; Fri, 11 Oct 2024 08:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CTcmsQ685HgQByCm+ZHSthm+DLLKj16QHmIiq+c8T90=; b=pY8aFCBjTPaCi7
	y7hKG6YYnDNoxoq233frjDv8Psrn7nWGTRq/3H6qJCYypOcjRNvk3tSyOst6TU04ZFsuj+SsezDgA
	8rgeyjG84GhgWJ6cW//7Tir/OBkapJM4LK78qyW8yNoVuZaaq7czbF5Hak9XJseFiHxOzyWJWcLqW
	NIRKDPtCfuwEpV8dCN5zJAazxdsoTWxdPQsRTJs8czPA0QB/cTGO5KfGUNipbfMehX5P+8FZq3X0T
	jrHwJZd60SZwxm8q8bly85fJvBRaHMJw06dbqs2ywhCzMb8Tm5Kk+j3VnSlUPIwKimC3T3UVXCeL0
	sse/eq4fjYzI53/eekiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szAkK-0000000FeaG-0ZE8;
	Fri, 11 Oct 2024 08:11:36 +0000
Received: from mail.originatepro.pl ([162.19.155.125])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szAkF-0000000FeYG-3Ifv
	for kexec@lists.infradead.org;
	Fri, 11 Oct 2024 08:11:34 +0000
Received: by mail.OriginatePro.pl (Postfix, from userid 1002)
	id B42EC27A4A; Fri, 11 Oct 2024 10:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=OriginatePro.pl;
	s=mail; t=1728633755;
	bh=HDodNtmiQ0oQNph7sp+h4NRbkxw8d1NmRLmJ4HyiCoQ=;
	h=Date:From:To:Subject:From;
	b=MBVUn1Jz0LK/ZMGdVj5pyJASeBvpxCAER9FmLR3m9nctS2MeKz6Z0BOBpyo0d5rrQ
	 7ezsUFI8UJiv6tSd4fFJRjQ8tdb0usbFWiyTDpEyNEHCwZiuWWpCarq0QW8hmcSVZp
	 HcEiHXg1OkRFntVoZHpPp3+MTNQAoggYzoGTvVEbDxB3Iw1nyXXTWZhkCswsIl3czN
	 LnHvMo+ZmGfkc9q30RPajhXUh3cPohGA0S+4p/wxqwFS7CGHUOx+RGB+NwrqvfB+Je
	 6mQzZw3xtTVL6DFTDTkKazqk5lwMBukgjoL8NQd/IJT/zV0fLmWJ07rB40x9qgczV1
	 +JDXW0NAN4Zjg==
Received: by mail.OriginatePro.pl for <kexec@lists.infradead.org>; Fri, 11 Oct 2024 08:01:19 GMT
Message-ID: <20241011084500-0.1.ek.2dzj2.0.ylagkgkrte@OriginatePro.pl>
Date: Fri, 11 Oct 2024 08:01:19 GMT
From: "Marcin Wojciechowski" <marcin.wojciechowski@originatepro.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Zam=C3=B3wienie_?=
X-Mailer: mail.OriginatePro.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_011132_524081_BA3F4F95 
X-CRM114-Status: UNSURE (   0.12  )
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

V2l0YW0sCgpDenkgcG90cnplYnVqxIUgUGHFhHN0d28gYWt0dWFsbmllIG5vd3ljaCBrbGllbnTD
s3cgQjJCPwoKT2QgMTAgbGF0IHBvbWFnYW15IHBvenlza2l3YcSHIG5vd3ljaCBwYXJ0bmVyw7N3
IGJpem5lc293eWNoIHcgUG9sc2NlIG9yYXogemEgZ3JhbmljxIUuCgpQb25hZCAzMDAwIHpyZWFs
aXpvd2FueWNoIHByb2pla3TDs3cgemFyw7N3bm8gZGxhIG5handpxJlrc3p5Y2ggZ2xvYmFsbnlj
aCBrb3Jwb3JhY2ppLCBwb2xza2ljaCBzcMOzxYJlayBnaWXFgmRvd3ljaCBjenkgdGXFvCBuaWV3
aWVsa2ljaCBkemlhxYJhbG5vxZtjaSBnb3Nwb2RhcmN6eWNoIHNwcmF3aWEsIMW8ZSBqZXN0ZcWb
bXkgamVkbnltIHogbGlkZXLDs3cgYnJhbsW8eS4KClogd2llbG9tYSBmaXJtYW1pIHdzcMOzxYJw
cmFjdWplbXkgbmllcHJ6ZXJ3YW5pZSBvZCB3aWVsdSBsYXQsIGdlbmVydWrEhWMgc3RvcHkgendy
b3TDs3cgc2nEmWdhasSFY2UgdHlzacSZY3kgcHVua3TDs3cgcHJvY2VudG93eWNoLCBwb21hZ2Fq
xIVjIGplZG5vY3plxZtuaWUgdyBzcG9zw7NiIHBvd3RhcnphbG55IG9yYXogcG9saWN6YWxueSBw
b3N6ZXJ6YcSHIHBvcnRmZWxlIGtsaWVudMOzdyBiaXpuZXNvd3ljaC4KCkplxZtsaSBtYWrEhSBQ
YcWEc3R3byBwcnplc3RyemXFhCBuYSBvYnPFgnVnxJkgbm93eWNoIGtsaWVudMOzdywgemFwcmFz
emFtIGRvIGtvbnRha3R1IHp3cm90bmVnby4gIAoKClBvemRyYXdpYW0KTWFyY2luIFdvamNpZWNo
b3dza2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
