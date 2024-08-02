Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F84C52D70
	for <kexec@archiver.kernel.org>; Fri,  2 Aug 2024 07:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hNM8EXp1sNtMrZyp9JQxPiZ9rseckud58iEvlEehqJg=; b=5CCruiMTJ1+jRf
	Ea5ZLfmkn0fj7aEbNBdpHGMf0YbBOZWXEg5ya0Mk8RgZY0HAjddsSDE0ki/2t4xGMbbv9h38Y+cZX
	zbai4FM3c5kdXSVU8wJysHW3Bq4p5+hfq6DArljbiug70TK9ZG83bqO9OYNihliW/3wyEJMKa/IST
	4QsYtfWRIntYyCWxZu+Da1MhOrR60yxgv38rCK4iUjS16b+yjSwJIiJml8OjSTwvknQmgkBInSztE
	lKpm9GS1KYvPsGVT/obGlczeo2Q3E4DmggAwA3Wt2EM07iPSojTbrt+zUAy/96yAtG6DTC+lEGXgO
	GOMRvZVf8z4U+u58ILlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZmpe-00000007yYe-3M5I;
	Fri, 02 Aug 2024 07:36:10 +0000
Received: from mail.originateinc.pl ([217.61.97.94])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZmpY-00000007yWU-0Uh2
	for kexec@lists.infradead.org;
	Fri, 02 Aug 2024 07:36:09 +0000
Received: by mail.OriginateInc.pl (Postfix, from userid 1001)
	id 08FE385498; Fri,  2 Aug 2024 08:35:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=OriginateInc.pl;
	s=mail; t=1722584158;
	bh=EywM+E+OIUr7RnYatSz3YfoNTVB6dOfImeA7tdj3yJA=;
	h=Date:From:To:Subject:From;
	b=gyprUzPfKPo6doAiwST2aXDL7iu4cljstfoqVXY08PcBA6scjNvlilAZDsRvT9LxQ
	 xqiBa+GwI+mFy/Dcp2eQ0Un4oTif+anXIeOOLlrlgF3alA5iDC3/Ht94AVbm7tZzlQ
	 IpBKlGdc/pvgprgx8wyVTMG55H3nFa5Ak3Vp3NTgKjVjgH1k7m8FgmlrwRNNLbuNda
	 kndob1zESgOrXKmG9ZXvjjOKFOVkB952uUfjnbZRJtGdFiaSRv2kejDSztAELWX3Pf
	 ycJTSpIIBU6UD3yUa0XHZ4E6E2Ghb6t+FWzCJz6st1f9OY7l5PMwojh68LkYzyl6B4
	 fG2ZE8m9ELFoQ==
Received: by mail.OriginateInc.pl for <kexec@lists.infradead.org>; Fri,  2 Aug 2024 07:35:19 GMT
Message-ID: <20240802074501-0.1.ec.1h215.0.s634l12ety@OriginateInc.pl>
Date: Fri,  2 Aug 2024 07:35:19 GMT
From: "Kamil Tralewski" <kamil.tralewski@originateinc.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?S=C5=82owa_kluczowe_do_wypozycjonowania?=
X-Mailer: mail.OriginateInc.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_003604_862890_916AA8E3 
X-CRM114-Status: UNSURE (   1.63  )
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
YXdpYW0KS2FtaWwgVHJhbGV3c2tpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
