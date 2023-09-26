Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21B8E7D24C
	for <kexec@archiver.kernel.org>; Tue, 26 Sep 2023 07:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nJjg67EbZsxLb8Ph8Ue/RvaeM3R7keg7hJncsNG2Vss=; b=oE2JQ8Kl9rLd9y
	RrDDE3fs0CFumbeirPmkdkbMXhFFSZs+tpMkPyNIhb6Bf+b+CSOEOsi5j5KqhIQYQQ2QhsPSfli9/
	ikrf/wUUp43puT6Doccaetk//4blqcl8kwIFujnERvxtZVQYfXaFxSMq28cN5aFLsHhaEd3AK5lbQ
	kgvek2BGmTtCTzA4DReJqc/7X8feTlUxSIajTNL+YtGIxPRtZVme9GTDD7XPEEK0QcpdGPyB3hG0j
	+TnK/cvcidzduya2XBQWPEzn9f4775OsLcV7tF5C/7Nl37xKE2NG8K7l+HP/CtZ6laDdT2SR7CPE4
	a+OUPh7/cGqISZikWi/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ql2r6-00Fp8S-1h;
	Tue, 26 Sep 2023 07:51:40 +0000
Received: from [162.19.155.126] (helo=mail.commercesolutions.pl)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ql2r0-00Fp7R-1w
	for kexec@lists.infradead.org;
	Tue, 26 Sep 2023 07:51:37 +0000
Received: by mail.commercesolutions.pl (Postfix, from userid 1002)
	id 2A9002308D; Tue, 26 Sep 2023 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commercesolutions.pl;
	s=mail; t=1695714682;
	bh=PcMncQpBfIZCnTOfZJY5G1G+gaLn4c9QPfFvoXrE4rA=;
	h=Date:From:To:Subject:From;
	b=Ya3dyRrSsHKLHKLunnF0c/+eXJ+MLp9hjoioOovFCIG3LQOIykchkHqyXoUxgUnDo
	 +3EpCk0aDAv1JmiZ99dE0444nNOo9WxvkSj9ENWVwrjBlDr/WB1nfWVDv4zn4gETuz
	 2lMikX+WZ8DFFn5E3ij816v9z3YXQwLXp4Tq6D8Xoay1DaiHEqU4CeKet+SrGbv3AM
	 TUvNBfas8OXdeL4O2XcvE94rkrNRpeqBYJgeESXsMh59EhOKZY2AeIqbbVMDY000sA
	 uoeMy5uiMiNAHiY2JCpTw0YWFFDL3gG4DPX5p9Z2Vie2jj9W4mMMkg5533XPNrTMP5
	 v4oHjUuZK8egw==
Received: by mail.commercesolutions.pl for <kexec@lists.infradead.org>; Tue, 26 Sep 2023 07:51:07 GMT
Message-ID: <20230926064500-0.1.8w.1pga6.0.ad0b93qqv8@commercesolutions.pl>
Date: Tue, 26 Sep 2023 07:51:07 GMT
From: "Kamil Tralewski" <kamil.tralewski@commercesolutions.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?S=C5=82owa_kluczowe_do_wypozycjonowania?=
X-Mailer: mail.commercesolutions.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_005135_381303_C68D8F5B 
X-CRM114-Status: UNSURE (   1.56  )
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
