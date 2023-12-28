Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C936C3DA6E
	for <kexec@archiver.kernel.org>; Thu, 28 Dec 2023 08:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nJjg67EbZsxLb8Ph8Ue/RvaeM3R7keg7hJncsNG2Vss=; b=EyIimUme+mQOzr
	67Ji3hjAyIkK0xfLFQRLuPkH5/slovE+wEdOIT9UxmPl5OVJnCRfYbGx3EeF7m3Bjd8LBz3smcaSU
	Akf3Gt6+nK39mu46YJhmQZgqpo7AXDN6n4wQpHx9stYdG9pAazfyx2l/0J37+P7RsrOkRB/JqS2sz
	E+xGPHNVKMGheAuonkLsrSE1cEY9/HcaveFzaSbWC9MM+Zfp8b6uQcV/omHZqC4Aae3+zHKJdmcxu
	LZS0ddDR7ne27Y+4SaN5CaAIT0TSG9D6TDFnekV9pPc8rEpNNH2zuuwU1egTTqh+ZACrGOAhTbiaA
	yKFQ9dXecaUK2vNjTsHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIlnM-00GPcJ-2L;
	Thu, 28 Dec 2023 08:31:12 +0000
Received: from [162.19.155.126] (helo=mail.commercesolutions.pl)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIlnG-00GPa3-29
	for kexec@lists.infradead.org;
	Thu, 28 Dec 2023 08:31:09 +0000
Received: by mail.commercesolutions.pl (Postfix, from userid 1002)
	id 3F14F229A5; Thu, 28 Dec 2023 08:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commercesolutions.pl;
	s=mail; t=1703752259;
	bh=PcMncQpBfIZCnTOfZJY5G1G+gaLn4c9QPfFvoXrE4rA=;
	h=Date:From:To:Subject:From;
	b=kKw4gCOz73sD3i3bGzxtt2BC4MsLMkdNZ7S9CZtr+Y6bOBVARuFEZfwQuaaGGwm2+
	 ST754oG/QfyvwcpRKlVwkG9Smoxxz+nSXROW8jQyu5k1isig/1uPk99Aaa5Sknq2+R
	 jm0sg9wxy4mpLHsNpiMiKnFS8FMRoz4UzEVoF3d20IIUVW6WDZ+lqyBCoSRxCEKYXi
	 d1uxF2vpC34z4+SMyk6upNqRtsQJwcQBzX2wPdJ/K3mAGi34EdRUALPEJEKAM9+JJd
	 pUf3uwTDEe111COct4qHjh4EG5b9iLS9/rvmTWDAp4g/8/9NSnQ4RWZVsGzqwklOrN
	 gnOvWv/C5s01g==
Received: by mail.commercesolutions.pl for <kexec@lists.infradead.org>; Thu, 28 Dec 2023 08:30:57 GMT
Message-ID: <20231228074500-0.1.aq.2a0vp.0.pp3rr3c9mv@commercesolutions.pl>
Date: Thu, 28 Dec 2023 08:30:57 GMT
From: "Kamil Tralewski" <kamil.tralewski@commercesolutions.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?S=C5=82owa_kluczowe_do_wypozycjonowania?=
X-Mailer: mail.commercesolutions.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231228_003107_463208_A7DAFF9F 
X-CRM114-Status: UNSURE (   0.73  )
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

RHppZcWEIGRvYnJ5LAoKemFwb3puYcWCZW0gc2nEmSB6IFBhxYRzdHdhIG9mZXJ0xIUgaSB6IHBy
enlqZW1ub8WbY2nEhSBwcnp5em5hasSZLCDFvGUgcHJ6eWNpxIVnYSB1d2FnxJkgaSB6YWNoxJlj
YSBkbyBkYWxzenljaCByb3ptw7N3LiAKClBvbXnFm2xhxYJlbSwgxbxlIG1vxbxlIG3Ds2fFgmJ5
bSBtaWXEhyBzd8OzaiB3a8WCYWQgdyBQYcWEc3R3YSByb3p3w7NqIGkgcG9tw7NjIGRvdHJ6ZcSH
IHogdMSFIG9mZXJ0xIUgZG8gd2nEmWtzemVnbyBncm9uYSBvZGJpb3Jjw7N3LiBQb3p5Y2pvbnVq
xJkgc3Ryb255IHd3dywgZHppxJlraSBjemVtdSBnZW5lcnVqxIUgxZt3aWV0bnkgcnVjaCB3IHNp
ZWNpLgoKTW/FvGVteSBwb3Jvem1hd2lhxIcgdyBuYWpibGnFvHN6eW0gY3phc2llPwoKUG96ZHJh
d2lhbQpLYW1pbCBUcmFsZXdza2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
