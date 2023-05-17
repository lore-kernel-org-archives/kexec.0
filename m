Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41C7C77B7F
	for <kexec@archiver.kernel.org>; Wed, 17 May 2023 07:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nJjg67EbZsxLb8Ph8Ue/RvaeM3R7keg7hJncsNG2Vss=; b=DfsmDKkPCDsFID
	9w3WnYCoBN9NL3mLdXHpda5hq6bHTzMz11p7UX3p+mO3MMpbjYDZRztjYjoN72MWlN+FiRonD0R6d
	KEe/Zwz/wHzeG5JcvfzOMFjGxBDrzxOJItHaMQ3qmJeVXMfJgz3qf0ZzwC90d5A2WWp7pdLs+cmjN
	m+boWi1iAEY7KI41jHuhp/p1GHDcHP9BbQn4UfL2iaWwUNdZM1bl9oA8IFgHeQi/1lT8BswGs57Zv
	rGK/B56whnsCtjsF/qlCw3+dUcWbQxo/CPGg3LMXxuqMQwksfoOAH2nmlurPjM0ZVEZAaz/39ZcN5
	0slGJ/+7V4TgCSykgRaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzC1k-008lGA-23;
	Wed, 17 May 2023 07:56:52 +0000
Received: from mail.craftsplex.pl ([162.19.155.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzC1h-008lDS-0L
	for kexec@lists.infradead.org;
	Wed, 17 May 2023 07:56:51 +0000
Received: by mail.craftsplex.pl (Postfix, from userid 1002)
	id DD23D23BCA; Wed, 17 May 2023 07:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=craftsplex.pl;
	s=mail; t=1684310204;
	bh=PcMncQpBfIZCnTOfZJY5G1G+gaLn4c9QPfFvoXrE4rA=;
	h=Date:From:To:Subject:From;
	b=A/15vYzTyrQ5s0UlooxXaz5GMT3QcKdeqfZPKxRMczecOMsyAddvWvY+0Lnjh8BAk
	 kkHdZHFfjVMPHCLG50fmXCfpQf4RcDiTaA+c7YcsjHGVPgEw6MG5O45guyEs93Gg11
	 YxoSaDxkENHVPh25uaTcePNptZhcUNtZNyAHZB6IURm8JNEMBHJM0xh+oqIkZaJinj
	 0y/KVtDN+piS28LDet1JHBuTCz3VT4P9kndmLyoUnXjiANPapiYzuBJ2yvdIDNslxx
	 NT3rdsqA3HuKz5hwbVbMqng4qdr3U1UiMbRz75JhF42K5obNHzd2s87iPIhpUpls5J
	 hSoARdx6drn2Q==
Received: by mail.craftsplex.pl for <kexec@lists.infradead.org>; Wed, 17 May 2023 07:55:47 GMT
Message-ID: <20230517064500-0.1.66.vio8.0.shr2c7c9m7@craftsplex.pl>
Date: Wed, 17 May 2023 07:55:47 GMT
From: "Kamil Tralewski" <kamil.tralewski@craftsplex.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?S=C5=82owa_kluczowe_do_wypozycjonowania?=
X-Mailer: mail.craftsplex.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_005649_375730_C987E705 
X-CRM114-Status: UNSURE (   1.59  )
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
