Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DFDC3DA79
	for <kexec@archiver.kernel.org>; Mon, 15 Jan 2024 09:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vyFMdlzXfwMqSfNh9fiW95dWIO1pPZvO9RU3TRsypvI=; b=2GMU/ZdJELTs2z
	oByr/8r/0mstxmv9avTW3Sa+wVV/MfvHEgjYU9on44VRHOgu39GPc1MRzqiwsEmWvPEr+mqw9ussu
	cuUixvNF6pMDI4j4fZ3UEs9ZmAopnh/EGxgpnhhrAGSeI3VMytKNXtqSCkoIYLtL/byHXPKD9eOAg
	cza+T96GTjkxtwFZoVeW3cAuFMeX+82pDvT3W4+caxTH9opiKFpeOZvWFoxjU1H17Zw7NcXlSIItF
	B4CXDH7DT8jWQLBKUISRKkfd955DOHc1gR090+j81pK2Z7JUinswByLWDo/GYDe7W9HR+n1n/irH7
	6POPj34KTmxur2sVy/kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPJ6O-008ODp-2Z;
	Mon, 15 Jan 2024 09:17:52 +0000
Received: from mail.integratradelink.pl ([217.61.97.192])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPJ6K-008OCQ-1Q
	for kexec@lists.infradead.org;
	Mon, 15 Jan 2024 09:17:50 +0000
Received: by mail.integratradelink.pl (Postfix, from userid 1002)
	id C915E83C59; Mon, 15 Jan 2024 10:16:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=integratradelink.pl;
	s=mail; t=1705310180;
	bh=+Nq8tO042bAt/j3//Q5cgHUOyegNlwMUiuy68BIYBsE=;
	h=Date:From:To:Subject:From;
	b=gP5QO9sfLgqcnQ9L31s883l4r0hK4pb2/thIQ3tpTt6UZAQwBw/46RjUNIcgKM5Zg
	 Ky2FGs6IyM6kZogKvnp7AO1Z51cB7sWMyl4DOD9fxo+N8Jmy25+wRTc9PwFhuojchQ
	 UlRXuIIxFaf1pbHAICAaynXsZm/cFQtsJUAIwT0K+F2KPd5xzvDTzn3LMw1OnJfO4p
	 inTbitEs/bvxq5lf1MwzRtz+e11D6HiWeugkp1ScmDBXvbgGAgZonAVBgvAsy28gJ3
	 Z4/0eRpdCT063wx3oCedI1QKwxT/B+7NFG0cF7sPyj7iBDleY7lEnMeJ7BLaNugupv
	 s0col9YmThQpw==
Received: by mail.integratradelink.pl for <kexec@lists.infradead.org>; Mon, 15 Jan 2024 09:15:44 GMT
Message-ID: <20240115084501-0.1.2x.bw3l.0.j82c4kn3ad@integratradelink.pl>
Date: Mon, 15 Jan 2024 09:15:44 GMT
From: "Karol Winiarski" <karol.winiarski@integratradelink.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?S=C5=82owa_kluczowe_do_wypozycjonowania_?=
X-Mailer: mail.integratradelink.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_011749_223362_E7879EE1 
X-CRM114-Status: UNSURE (   2.06  )
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
ZWNpLgoKTW/FvGVteSBwb3Jvem1hd2lhxIcgdyBuYWpibGnFvHN6eW0gY3phc2llPwoKClBvemRy
YXdpYW0gc2VyZGVjem5pZQpLYXJvbCBXaW5pYXJza2kKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
