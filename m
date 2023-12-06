Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDA3C4167B
	for <kexec@archiver.kernel.org>; Wed,  6 Dec 2023 09:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+ahsqDGA3PIUBAOWXlgep7BfFd8YQkvJ/+gM4N3wmEM=; b=18QIqB6TKVswKZ
	PfOREIHFmK4b+YLwScaeO0pi2FNJHfIizhPesWoxeFzFqJx4yWLgcDB0pND8TNhKvb5xWjUzx89m0
	NppjAzinCP18DuBiftK5zysjtn5+AOLVP1nFuv84lmT8Btyr35PevZfVMHazbPDTQ31vZd9VFJoMS
	F4LDM4mUhiJXPdpkDv79DTZfFZtdJkVH4K7H6MGBDhgUNWlsekZWRW4Ms/LQg2EXfAdZu9vZZ4K/N
	uJhf4aRXAzQuPd3mZcJBPofBh3iFzRNo5kjAHLfUKAswNxB7YZCr5CCtg8bAqa3nKfL9dWxPccEeW
	ZTZzn6dKKy9y6XlX4P6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAnmj-009Uz5-18;
	Wed, 06 Dec 2023 09:01:37 +0000
Received: from mail.corebizinsight.com ([217.61.112.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAnmd-009UwE-0a
	for kexec@lists.infradead.org;
	Wed, 06 Dec 2023 09:01:33 +0000
Received: by mail.corebizinsight.com (Postfix, from userid 1002)
	id C3B9F83469; Wed,  6 Dec 2023 10:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corebizinsight.com;
	s=mail; t=1701853283;
	bh=CEmchsDu5Oe+RNHCZSBmKSgMOuy1xnO2dydqkEjt3Qs=;
	h=Date:From:To:Subject:From;
	b=6Z2RyB9OKDrOC1nz1TV2IbH+I2SWuPcAJRhPKxIi4MG0499mY6DAF9cZankzc6gzA
	 B7jaj29Ku1DlqBu3Y/Qt2MJkwp6zlbiBq1XcQ53mUFFogZiDt0oYF49/kOarYYwfy4
	 8o3sfKXgzGkJuYsl5J0PbBwabqgsS1XbrTqQilzTyrlfG59OzZwiEDrZvXocNcCTLe
	 32buZIT+bz6P4Z8JMMFdjIlbn2uRYU6CSjzJYEDrMQQLC0Fop2Gg8ouItMSd7+fOxX
	 ignl2sQmqZWmoBCbxpgsMtqUuHw+nGhxnCAysMsxnqHAdKqptyLCYs8HQ8G2k+lJXQ
	 Ou+U/g00zvjVQ==
Received: by mail.corebizinsight.com for <kexec@lists.infradead.org>; Wed,  6 Dec 2023 09:01:00 GMT
Message-ID: <20231206084500-0.1.2f.c578.0.de57ci4b2j@corebizinsight.com>
Date: Wed,  6 Dec 2023 09:01:00 GMT
From: "Jakub Kovarik" <jakub.kovarik@corebizinsight.com>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Pros=C3=ADm_kontaktujte?=
X-Mailer: mail.corebizinsight.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_010131_945399_E0138221 
X-CRM114-Status: UNSURE (   1.58  )
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

RG9icsOpIHLDoW5vLAoKSmUgbW/Fvm7DqSBzIHbDoW1pIG5hdsOhemF0IHNwb2x1cHLDoWNpPwoK
UsOhZCBzaSBwcm9tbHV2w61tIHMgb3NvYm91IHphYsO9dmFqw61jw60gc2UgcHJvZGVqbsOtIMSN
aW5ub3N0w60uCgpQb23DoWjDoW1lIGVmZWt0aXZuxJsgesOtc2vDoXZhdCBub3bDqSB6w6FrYXpu
w61reS4KCk5ldmFoZWp0ZSBtZSBrb250YWt0b3ZhdC4KClYgcMWZw61wYWTEmyB6w6FqbXUgVsOh
cyBidWRlIGtvbnRha3RvdmF0IG7DocWhIGFuZ2xpY2t5IG1sdXbDrWPDrSB6w6FzdHVwY2UuCgoK
UG96ZHJhdnkKSmFrdWIgS292YXJpawoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
