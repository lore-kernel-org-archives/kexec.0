Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460C2FC72D4
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 19:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qezk6G018iXhbEGoOaR5h2fb7tphPgejzlyz8Y9AoPQ=; b=Y1RxavOrGynlz3aPWIhyC40vvB
	Qcz6wn+9Wxsp2u723qvbwr41XR4v7uBOsyciTuFIKJAWLU9T2fuueRxCFXxJ92jA84H9HGZzG6x4L
	pTmzrK8dWg/vwvKyq0XWUBfzVqCvILNZ5+l3EbgVPnMqZmNmEUKXrA0u8hTLKY9ReMazyLWF+77/m
	xK/1ifbNFon4TZ1scHSshNfUx/kfckWcO4/Wr4UWOqrK+I3Wsoh9e6CH6z+f+YgGrK13ScBYTvI3b
	IyTaX7H4Q/9+nwXTTPHk07wGhORzKgvrR6SeeeQvCFmojY4j/Xgh9tGEdpmGzO48P/YffCT1FUhwu
	C2II3uYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4O5q-0000000FaNx-1l35;
	Sun, 22 Mar 2026 19:04:10 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4O5j-0000000FaNe-0Tg3
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 19:04:04 +0000
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 62MJ3WiX700427
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 22 Mar 2026 12:03:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 62MJ3WiX700427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026022301; t=1774206213;
	bh=Qezk6G018iXhbEGoOaR5h2fb7tphPgejzlyz8Y9AoPQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=RtFEZOn+LYOeg9TVY8jJge4wqhDSIGa6HYizssFdrVE6d6lT3CZw+FSBLV2x0wQi5
	 EB3OS+peFkHDjbY24TV9Y5FUgOoh4p3/f0651op8UC2O0n9ln7As4rl8MmgOWD1B/L
	 zITTGPO9HyACWWj2Z+XIyUOzf97ESza/NzSZ2ynE19M6o9jpCJV0FNMy4W0grhr6+l
	 VDDvBhX3P3neQv8MkoAhjC+0uEFHHbND2qox9PkB7cneFfErOeR1tNSvlUbVDG7oc5
	 koWh9OAd6c7R8nU8lfloSR7vGuuDMXYovIxuA8dsbJ8ZS8pz4CF17t9WGlVa3IJgWt
	 p0Ot34ACRo8Kg==
Date: Sun, 22 Mar 2026 12:03:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, x86@kernel.org
CC: pengpeng@iscas.ac.cn, kexec@lists.infradead.org,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: bound bzImage64 setup header copy
User-Agent: K-9 Mail for Android
In-Reply-To: <20260322031924.58050-1-pengpeng@iscas.ac.cn>
References: <20260322031924.58050-1-pengpeng@iscas.ac.cn>
Message-ID: <E205DB4A-5916-40AD-BADE-8DE331626E0D@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_120403_157149_9452927D 
X-CRM114-Status: UNSURE (   6.40  )
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

It is actually harmless, because we have to have that space to reserved any=
way (up to the maximum possible size=2E) However, this is a *signed* byte, =
so if interpreted as unsigned it could overflow=2E

