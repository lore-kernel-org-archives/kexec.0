Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F333C77B7A
	for <kexec@archiver.kernel.org>; Thu, 25 May 2023 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=aOahtPsa4/mft13/yrM2if7/3QRLRbmW6o84QzLllFw=; b=YdpvqV6JbAsI6Z
	PQbrpIjFCi48V5ZXiljZYzLuo+nnTtG9pXJfr9rAXj6tf6fW+THEYOYcqTQwMKyi6BuTN5YKFlNM9
	jOCRMTVobUay34t0MGEhx69TXV1kknT2dj4ZYMsxtgjf+KK//zVFSiD7bZCkJAhsIESkh1XtmMwDM
	HyrFhp26YeJRtpBTu8uzL0x86Z03Pc5qa96EzcZ8ZvppoeJGjruXo8SNVcGIzez8S0iI1J5KlL665
	3fcgRXTx15siVkdVwQTSvK8vVJhblOt9JwdUlosG8Vcp1YKaKR3zLccBhfQXY+cq1QuDhX/CIjbDt
	fYWGti3xtL3xQaXt7SIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q25R0-00FnuA-0t;
	Thu, 25 May 2023 07:30:54 +0000
Received: from mail.mahavavy.com ([92.222.170.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q25Qy-00FntK-0q
	for kexec@lists.infradead.org;
	Thu, 25 May 2023 07:30:53 +0000
Received: by mail.mahavavy.com (Postfix, from userid 1002)
	id 65924222C0; Thu, 25 May 2023 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mahavavy.com; s=mail;
	t=1684999846; bh=IfqQW79nVX/qUpmHcJiWDpV9BQnOf/s+Zcq9ON74QJY=;
	h=Date:From:To:Subject:From;
	b=oYIDCu5e7/rgggkvD9dhyjeFeSFmr8baL99CDG1BUxTT/lgL6WhGaGgvzAeAhu3Bv
	 wTFwrZ0Nnr4rQkvsKcMsB0smlFcF6uG9DFpgCQj5C80ejm2r49FsKNO+rshTqsI/Dy
	 Gu78pNaAKLELJlPSFBoWOUtmHmIdJhJ2+RbBDOsJ39KDhSeICdyAhsM3MB9zmV3BBu
	 xy5R3MPok8i6ia9YUL9niqPQkTqfhE9U9sy/etEcNCab957hagpMOMj3zs8HlRscRq
	 WpDCFTPVV7bA8F95txCJUO91cEmHo+i0fmmRVGXnhIE3jQiIv2l2S/Srzw5X14B/E2
	 CzYJKIewKmKPg==
Received: by mail.mahavavy.com for <kexec@lists.infradead.org>; Thu, 25 May 2023 07:30:26 GMT
Message-ID: <20230525064500-0.1.2q.55yy.0.yaleqzl1u6@mahavavy.com>
Date: Thu, 25 May 2023 07:30:26 GMT
From: =?UTF-8?Q?"Kristi=C3=A1n_Plet=C3=A1nek"?= <kristian.pletanek@mahavavy.com>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Tlakov=C4=9B_lit=C3=BD?=
X-Mailer: mail.mahavavy.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_003052_557722_4790D882 
X-CRM114-Status: UNSURE (   1.52  )
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

RG9icsOpIHLDoW5vLAoKemFqacWhxaV1amVtZSB0ZWNobm9sb2dpaSB0bGFrb3bDqWhvIGxpdMOt
IGhsaW7DrWt1LgoKTcOhbWUgdsO9cm9ibsOtIHrDoXZvZHkgdiBQb2xza3UsIMWgdsOpZHNrdSBh
IMSMw61uxJsgc2Ugc2Nob3Bub3N0w60gZmxleGliaWxuxJsgcMWZZXNvdXZhdCB2w71yb2J1IG1l
emkgbG9rYWxpdGFtaS4KCk5hxaFlIGxpY8OtIGJ1xYhreSBqc291IHbEm3TFoWlub3UgYXV0b21h
dGlja8OpIG5lYm8gcG9sb2F1dG9tYXRpY2vDqSwgY2/FviB1bW/FvsWIdWplIHbDvXJvYnUgdmVs
a8O9Y2ggdsO9cm9ibsOtY2ggc8OpcmnDrSBzIHZ5c29rb3UgZmxleGliaWxpdG91IGRldGFpbMWv
LgogClBvc2t5dHVqZW1lIHBvZHBvcnUgdiBrYcW+ZMOpIGbDoXppIHbDvXZvamUgcHJvamVrdHUs
IHZ5dsOtasOtbWUgc3RydWt0dXJ1IGRldGFpbHUuCgpDaHTEm2xpIGJ5c3RlIG1sdXZpdCBvIHNw
b2x1cHLDoWNpIHYgdMOpdG8gb2JsYXN0aT8KClBvemRyYXZ5CktyaXN0acOhbiBQbGV0w6FuZWsK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
