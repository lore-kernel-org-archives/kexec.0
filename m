Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589BAC4829A
	for <kexec@archiver.kernel.org>; Tue, 13 Feb 2024 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nJjg67EbZsxLb8Ph8Ue/RvaeM3R7keg7hJncsNG2Vss=; b=FoRqUJjd+9Wnhh
	mabgAiA4q68mMX8V/izpHUnf/Y+UxJCLtJATnORTIQtgQRmH0e5FnJ6xr68sC/jvBFq59J5/iCliV
	jNAHF0j/fQnjvxzTnfYFDTLg//a1g1OKEN8vomMk0Sk+P4atYwLzNcjbPOs6AM4g9ZG6Sp84cOYP5
	Ih36hBb9298aZCStbK1ko4SOTnL0Dxg87wM7cShmujaB/rhX+NizlFwSnMqywVG243Vqdcz8fKsim
	vRG00jzmrc3hYQpTdDoZAoFuRdRMe2ffr9zkmtEMmJYO1mr3Uq3iMtd60G+7H2XrvLTAtCzzffo/I
	0PXiCw9yLt390J+nGFwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZokI-00000008XrD-3ufj;
	Tue, 13 Feb 2024 09:06:30 +0000
Received: from [162.19.155.126] (helo=mail.commercesolutions.pl)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZokC-00000008XnH-1Xp3
	for kexec@lists.infradead.org;
	Tue, 13 Feb 2024 09:06:27 +0000
Received: by mail.commercesolutions.pl (Postfix, from userid 1002)
	id 4EBDB24381; Tue, 13 Feb 2024 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commercesolutions.pl;
	s=mail; t=1707815178;
	bh=PcMncQpBfIZCnTOfZJY5G1G+gaLn4c9QPfFvoXrE4rA=;
	h=Date:From:To:Subject:From;
	b=oyURhA1paTBVFgwGBDFGu8+m0tUZ/bS1WoFr7iaXi5p/bwEFN2fyol/FDDrx76g93
	 zMABKy5HLYeC6OWYFI1D3XWcQTpD5IcuW+tlfjZKDopLh4uBjdv4XnQXH7lI1dG4WO
	 NSW0NRRTx04gFg/nErK4mrY6vRpWH27qbi7vAIeJd22TttOCgWgRtFiI2wIo7nIXCA
	 8IX4OP3Wlhu6VKZ6U4t16gS7Q9RoP2UcBv0kt0lyLqikQPZ5LpsF3thd9aFyU/qgvQ
	 gehT8/xBt/z7v1et+0XEuFf2sQ1KqY2YEKamLVVsuhoS/oXMAVf/ZzW7yjQDJ5fVyg
	 804LY7ewQc9NA==
Received: by mail.commercesolutions.pl for <kexec@lists.infradead.org>; Tue, 13 Feb 2024 09:05:27 GMT
Message-ID: <20240213074500-0.1.bl.2kd08.0.k7h8up7k5o@commercesolutions.pl>
Date: Tue, 13 Feb 2024 09:05:27 GMT
From: "Kamil Tralewski" <kamil.tralewski@commercesolutions.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?S=C5=82owa_kluczowe_do_wypozycjonowania?=
X-Mailer: mail.commercesolutions.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_010625_160672_1A4B2568 
X-CRM114-Status: UNSURE (   1.07  )
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
