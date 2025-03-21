Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4268C36000
	for <kexec@archiver.kernel.org>; Fri, 21 Mar 2025 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=luqQiyuyjNAsw515KM4PvvMhNhUysTYJueyAxpe0yug=; b=tI1XEGF1S8CPMh+MvKC9B7TVVa
	6Aq0TDzDos8oxO+ar3DvSahx7N3tAfk63nTwOEGI7mCT1KFdtjYBLPjVOXV8sptWfFWmomNHfs9fd
	pSTbqF4J7Q3iWiZezf+n2n1Us2c5ENcJibq9jqllrlQFpwcHUEqYGkA/1EoVh+TPPGJZNpQQbWSuP
	G3EbjXhekGgxcTv/e5AJ14yA2ZUF4niyxrW3wIITPy/sEMKeNNSOr8hkPdN2Jneu4atiLvSghg3mk
	tN+ZutuDkh5r2f6iIG16+lH93nfdZFq1BUNmwXzeUCfgb3WXBdYH/ENDiFoW6tGTZDZdkLvAlsmtL
	TqKE7zKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tveVA-0000000FKmc-2Yg2;
	Fri, 21 Mar 2025 15:41:40 +0000
Received: from mail-01.sigsum.org ([91.223.231.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tveV7-0000000FKkf-3abe
	for kexec@lists.infradead.org;
	Fri, 21 Mar 2025 15:41:39 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E3CCC13C8;
	Fri, 21 Mar 2025 16:41:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glasklarteknik.se;
	s=dkim; t=1742571687;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=luqQiyuyjNAsw515KM4PvvMhNhUysTYJueyAxpe0yug=;
	b=lygATNJoRFpCcBPZcqZ5jOsFBYAu0MqpGNT7OULyMBgUr16YQySZeU2yKf5xjiCvxEzSX+
	tV86wwUevzDxyNtCg+8N5qcE7VjULqbtSmywi1d12pkOUfF95QUmcvtF/JqwQeI7mNnOHt
	qduse6qPmJfM6i6Bx0oXOPc6t2tED4ohRfdCZR9WCbJIAkcBtgxcW2qSsxD7FqdA3kJhm6
	AwTTZOm0N+1VqP+1Hj4SsTsrj35lfKOUyPogBsZvU75iau7uiWwLthk9pUJfkb4wLnBYIg
	ILNsmTrOpgKNL/w3yyPF/59tmBolmIwgDXK/O7LbxzTjQWZ/mcJqwwoCr5iPnw==
Message-ID: <c368b604-9022-470b-8c23-60bf53892cb0@glasklarteknik.se>
Date: Fri, 21 Mar 2025 16:41:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, kexec@lists.infradead.org
From: Elias Rudberg <elias@glasklarteknik.se>
Subject: x86 kexec problem in stable 6.1.129 and later due to change related
 to PGD allocation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_084138_369009_06AA80AB 
X-CRM114-Status: UNSURE (   9.48  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello,

The following change seems to cause kexec to sometimes fail (not every 
time but about 50% chance) for the stable 6.1 kernels, 6.1.129 and later:

6821918f4519 ("x86/kexec: Allocate PGD for x86_64 transition page tables 
separately")

The commit message for that commit states that it is dependent on 
another change "x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating 
userspace page tables" but that change does not seem to have been done 
in the 6.1 kernel series, which could explain why the 6821918f4519 
change causes problems for 6.1.

This appears to be a problem only for 6.1, for the 6.6 and later stable 
kernels there is no problem.

I think the reason this problem is seen only for 6.1 and not for 6.6 and 
later is that the change "x86/kexec: Allocate PGD for x86_64 transition 
page tables separately" relies on things that are not available in 6.1.

In the tests I have done, kexec is called via u-root.
More details are available here: 
https://git.glasklar.is/system-transparency/core/stboot/-/issues/227

Cheers,
Elias

