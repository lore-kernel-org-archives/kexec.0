Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CAFC61DA4
	for <kexec@archiver.kernel.org>; Tue, 14 Feb 2023 09:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xsgorHrlIDblhV27SCeG1HsszmazWpbz+NTzWwicqKI=; b=K1GBSfiGI7n8xe
	lpKlIhWBWPAo8Sn2IUbKEnCQWB1qoEXf9GM0mXEU8JUe4ghoLSJj2IU/JHaxBsH/pEB45R4ZkbHaK
	cPu5VWwYFaJLT0a6sE39psAZnviPI4vvw2/HKnPJjoNRRTzxXH74sbXPyExhPHaQ8oD+13R1BoK6y
	ckfZtIJGZJqlCwWtjUJwq3d1Ku3RNx7h4iPVVFa+aUOv+QcezZ7kZneUfm40+r0XEOo/T1QSb6r4U
	2TwqoF3rq0Vq5IcPRsesUsMTcJ2HB6+0LKEtYcsF1CYTS+GBuKhEjHU2q7kEh6G97Qjs1tP4Puioa
	bkH9Dd8urNciQGeHEGAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRrBh-000cTX-P9; Tue, 14 Feb 2023 09:01:21 +0000
Received: from mail.culbokie.pl ([217.61.97.164])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRrBb-000cPQ-KQ
	for kexec@lists.infradead.org; Tue, 14 Feb 2023 09:01:17 +0000
Received: by mail.culbokie.pl (Postfix, from userid 1001)
	id 2A50983CEC; Tue, 14 Feb 2023 09:00:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=culbokie.pl; s=mail;
	t=1676365268; bh=cNbZL9WXZbgcQtzgDCharPn7EQBjUHnC1FAZ/+OQVjk=;
	h=Date:From:To:Subject:From;
	b=5NAjyobs42A98AtqMusFXN8Zo9pvxC4bmt4q6c+ffeyrOJSwprIxChE8oO7cMwPEw
	 jXAaSTAkk1nm3AkiHqXXOJxWURoxLLJXOSppNaO7TPxRL6ZpWcZWppTDofVYKg5mDB
	 Zbtdy77CNj4+KBHEYWC3MLB0ka9og0Y70iQMLnmgR9AnCOQSo+Tqzwdhd5ayB9iXGl
	 YisMv1XhnySRXOQlhMiZjY2hYpgDvtvA4WW/67MjcfQmk4RfEgvmElM3wxGVDP9cTK
	 51JWFq1C/He9FOOTOfnoPI5JzkqRMRB5TKr5CH6jCcJzlxHWxzjorBL+UH3AiyA4PL
	 Qx5HNnXJu8iRw==
Received: by mail.culbokie.pl for <kexec@lists.infradead.org>; Tue, 14 Feb 2023 09:00:28 GMT
Message-ID: <20230214074504-0.1.1n.40ug.0.rk6n7a012g@culbokie.pl>
Date: Tue, 14 Feb 2023 09:00:28 GMT
From: =?UTF-8?Q?"Pawe=C5=82_Kamieniecki"?= <pawel.kamieniecki@culbokie.pl>
To: <kexec@lists.infradead.org>
Subject: Prezentacja
X-Mailer: mail.culbokie.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_010115_872969_349E3AFD 
X-CRM114-Status: UNSURE (   1.27  )
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

RHppZcWEIGRvYnJ5IQoKQ3p5IG3Ds2fFgmJ5bSBwcnplZHN0YXdpxIcgcm96d2nEhXphbmllLCBr
dMOzcmUgdW1vxbxsaXdpYSBtb25pdG9yaW5nIGthxbxkZWdvIGF1dGEgdyBjemFzaWUgcnplY3p5
d2lzdHltIHcgdHltIGplZ28gcG96eWNqxJksIHp1xbx5Y2llIHBhbGl3YSBpIHByemViaWVnPwoK
RG9kYXRrb3dvIG5hc3plIG5hcnrEmWR6aWUgbWluaW1hbGl6dWplIGtvc3p0eSB1dHJ6eW1hbmlh
IHNhbW9jaG9kw7N3LCBza3JhY2EgY3phcyBwcnplamF6ZMOzdywgYSB0YWvFvGUgdHdvcnplbmll
IHBsYW51IHRyYXMgY3p5IGRvc3Rhdy4KClogbmFzemVqIHdpZWR6eSBpIGRvxZt3aWFkY3plbmlh
IGtvcnp5c3RhIGp1xbwgcG9uYWQgNDkgdHlzLiBLbGllbnTDs3cuIE1vbml0b3J1amVteSA4MDkg
MDAwIHBvamF6ZMOzdyBuYSBjYcWCeW0gxZt3aWVjaWUsIGNvIGplc3QgbmFzesSFIG5hamxlcHN6
xIUgd2l6eXTDs3drxIUuCgpCYXJkem8gcHJvc3rEmSBvIGUtbWFpbGEgendyb3RuZWdvLCBqZcWb
bGkgbW9nbGliecWbbXkgd3Nww7NsbmllIG9tw7N3acSHIHBvdGVuY2phxYIgd3lrb3J6eXN0YW5p
YSB0YWtpZWdvIHJvendpxIV6YW5pYSB3IFBhxYRzdHdhIGZpcm1pZS4KCgpQb3pkcmF3aWFtLApQ
YXdlxYIgS2FtaWVuaWVja2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
