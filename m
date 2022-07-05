Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A21CCA47B
	for <kexec@archiver.kernel.org>; Tue,  5 Jul 2022 12:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mSl2YTCMdLl3r5Io879wYlOtlaHAX5XKxU/idlGARkU=; b=zuAMEm2yn0bP/C
	AMSAy6ooQiSD2vaC44CavseAWhaG+NyoL4n8O3giC6/7uzcqQaZLxpEtyRqT4gInVpldgt/2MUrGD
	PoIc3jT7QXk9ClOBft3D+zE1PGvHMR2QlurU4ohNKO08LVzdDgJpdDr/AQbDrhHwNpHFvINNXQSxJ
	y/zF+ELMrdlEqKc+Xv0vM8W9DVne/bChB3tg6A2blRmMG+fI2RG5BHhjt4mFaWTL3WAGBuNLGKAyZ
	FgLle1IHBqK0wpu/ezAp6OQHZ8c6uvvlXj6g0x8odvWc4LsUJKEbHQbBIry1A0GVA2oFeeBKy6Afa
	DhklRLEwyd3T5NW5LLCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8hbI-0009F6-DL; Tue, 05 Jul 2022 12:24:20 +0000
Received: from mailgate.ics.forth.gr ([139.91.1.2])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8hbE-0009Al-NJ
	for kexec@lists.infradead.org; Tue, 05 Jul 2022 12:24:18 +0000
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 265CO2gH031253
	for <kexec@lists.infradead.org>; Tue, 5 Jul 2022 15:24:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1657023837; x=1659615837;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t/A2bhKqXek2hWtLd3vlQT20t22w8cXN/y/jBkLVg3Q=;
	b=PTBtCmubCBSI5gv1/8wQA8PNoiq06p3LQHpEvhH8pb4aoMP7vIDEQ95eospPgImM
	tDJnpWdPMFFBs/BYTNvWAbKN5GZ1vlj3Lo1aF/BEU+p3q9oTEQqrmMHZcxm2lkzn
	Kk6vDliJSH7WodeTI+dLA7zkKA+n/e8lJ68e/LomFEwYxdDWWipQMImgXw1tsrUc
	kj06zeqZUvVmS8ShjEBxSOAsaVdhMDf/fbSoNC7jDL10uMBsS4EpNuj6KIqZMru6
	AMIfz5dsoWWpO5oLI6A4wbgVVBaBuhbNQFxAJ6Dgb4AWA/tMmPo4aJBnN5oEnhHZ
	HSXBdEvd366IfunvIZKVgQ==;
X-AuditID: 8b5b014d-f2ab27000000641e-68-62c42d5da359
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id D0.AF.25630.D5D24C26; Tue,  5 Jul 2022 15:23:57 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr>
Date: Tue, 5 Jul 2022 15:23:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
Content-Language: el-GR
To: Yixun Lan <yixun.lan@gmail.com>
Cc: Alexandre Ghiti <alexandre.ghiti@canonical.com>, ebiederm@xmission.com,
        kexec@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alexandre ghiti <alex@ghiti.fr>, Mike Rapoport <rppt@kernel.org>,
        geert+renesas@glider.be, Stephano Cetola <scetola@linuxfoundation.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
 <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr>
 <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
 <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr>
 <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
From: Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXSHT1dWTdW90iSwaNrChbP7nxltVi36AKr
	xZMPE9ksFq34zmLxf1sLu8Xc2ZMYLXaf/spkcXnXHDaLbZ9b2CxeXu5htuheWW1xZP12JovZ
	H5awWHzdNpfZgc9jVkMvm8ebly9ZPO6dmMbqMfGsrsfOWXfZPTat6mTz2D93DbvH5iX1Hp83
	yXnsvP2QyaP9QDeTx5RD7SwBPFFcNimpOZllqUX6dglcGX39DawFO1gq/raZNzDuYe5i5OSQ
	EDCRaN99ir2LkYtDSOAoo8SJ7kOsEAlLic2fXrKA2LwC9hKdi+4xgdgsAioSH39uY4SIC0qc
	nPkErEZUIELizKszYLawgKvEzt17wRYwC4hLHDn/G8wWEVCW+LzpCwvIMmaB/SwS+6c9ARsk
	JHCNWaLjfAKIzSagKTH/0kGwQZwCgRIXJx5ngxhkJtG1tYsRwpaX2P52DvMERoFZSO6YhWTf
	LCQts5C0LGBkWcUokFhmrJeZXKyXll9UkqGXXrSJERx5jL47GG9vfqt3iJGJg/EQowQHs5II
	76pJB5OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ865kbEoSEkhPLEnNTk0tSC2CyTJxcEo1MO1v
	7bjysb79Ybfm1/g7aSw9hleM18zh4HkXdPd56IeDy4y3TxLzrT9quG7bT3Gn4mpD9/v63zTO
	pVyaH7d5t0CL3jQ5vT0Hi7o/9V49tbrlv/HrVOMw27Z/cxheitxuZFnddP7gecbWme6flEI2
	fLmvvG7zjearJUdWWV45mTtV53TInMd1rAc3iAj+bRWVTk7gq2w8tvpVMuttidKlU+31Zm52
	ra5hk+fICubtmn8urbz/oLz4+tYwAds2d574NsPI1N9qxcmPnba9Mmxas+6ghsPxHzPfSmz7
	3fnQ3LT8E19BQ4GHBP8CsdAo1/Y9+z8bbz95uZ3r3K+6IplMhYUJvpG9ARdCeRYE+uzlU2Ip
	zkg01GIuKk4EANnNypArAwAA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_052417_241570_ECBA4579 
X-CRM114-Status: GOOD (  10.24  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello Yixun,

On 7/2/22 14:35, Yixun Lan wrote:
> hi Nick
> 
> ping, any update for this? any new patch for kexec-tools?
> 
> I'd also like to try kexec on unmatched board, and encounter the same error
> as Alexandre Ghiti reported, generally I'm using almost same cmdline
> 
> Yixun Lan

The kernel-side patches have already been merged upstream, for 
kexec-tools there are some people working on fixes, I'm expecting pull 
requests on the github before I do a pull request upstream. You should 
be able to use kexec without initrd.

Regards,
Nick

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
