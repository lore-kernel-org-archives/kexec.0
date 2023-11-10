Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5EBC4332F
	for <kexec@archiver.kernel.org>; Fri, 10 Nov 2023 10:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nJjg67EbZsxLb8Ph8Ue/RvaeM3R7keg7hJncsNG2Vss=; b=taDYwe9kFD/OUK
	sAdW+vL+LZ8fqAxYLOhGac+8mzmsNDuRB7rhGHe1zckGeZ7WmjuDOtCfSSqMIhSCceooMiYfKCvHN
	8VnwM2mFJAG4U40Of7wZ1wtley5iBPYbNKUiHcqekA+D6ZIfskz6BKGVzRGsCRBPC4sUXHdTmxhkR
	A8E6LciPa6sH5Jz8qgTFWB5r5MvaddUADw5CMUeUE9XYKipPV2U+SPxiLARCyDAaLZDjmFx1r6sZH
	o7hPOwdpwAQk5d4GkmqOu3RYCqEKQ/Y30zJHE14bd/Yd1wP36oFoW2/+UUkEAfWNRQ4UgS9eFvU8K
	1rjRDc7HLSo/diEVKkzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1OVb-008GaD-1z;
	Fri, 10 Nov 2023 10:13:03 +0000
Received: from [162.19.155.126] (helo=mail.commercesolutions.pl)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1OVX-008GZH-0z
	for kexec@lists.infradead.org;
	Fri, 10 Nov 2023 10:13:02 +0000
Received: by mail.commercesolutions.pl (Postfix, from userid 1002)
	id C97A624BEF; Fri, 10 Nov 2023 10:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commercesolutions.pl;
	s=mail; t=1699611071;
	bh=PcMncQpBfIZCnTOfZJY5G1G+gaLn4c9QPfFvoXrE4rA=;
	h=Date:From:To:Subject:From;
	b=X1EwxMcOI3M5BBa/I11oeMgxikyVM7gPVwXuLtv21UZWlGVVRdwzE/eh7tdyKpRcl
	 mczTPFletBcmql03uLe1OEaXZnlEJY2gr0SAc/vo4m4gRtcBpQ+NJ/CG+z6FVl4cKb
	 EIgj3PHECfFAuFRdlTrIG1FdaOUJSGyPzAPpIOnVIELF6hQA9oQUUcgZKVH8TwFCBm
	 pX+/ntSwRShCAvSVQooRHV9YSJu+jukWZ7v9WfDDkLeQrBdpjmyK1F9n5qz9nkjEvX
	 oCb2q22IbV1xnkymbOl07k9lrnJC95DXBkiDDuO2o7KA1F8csZS+U+y8j+E3H0QxjF
	 uc+vvHZFgccHA==
Received: by mail.commercesolutions.pl for <kexec@lists.infradead.org>; Fri, 10 Nov 2023 10:10:56 GMT
Message-ID: <20231110085829-0.1.9u.1zozb.0.zhjcbraw0b@commercesolutions.pl>
Date: Fri, 10 Nov 2023 10:10:56 GMT
From: "Kamil Tralewski" <kamil.tralewski@commercesolutions.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?S=C5=82owa_kluczowe_do_wypozycjonowania?=
X-Mailer: mail.commercesolutions.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_021300_112354_09F979BD 
X-CRM114-Status: UNSURE (   1.36  )
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
