Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7040FECAAA1
	for <kexec@archiver.kernel.org>; Tue, 13 Sep 2022 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fR7GA2WO3LZ+GVO+07IbqkfURG9gABypPUogaO+9OPw=; b=cYlYYGLsFwQHT9
	8coC0UoVxMT7ivKnvjadIysJf2uLZ4pcfuuIdoNtD7ITykRnqL2ByV3gTWh9AAP657wUQlXc4u7b6
	0xQMm1jTO1x05ZgWXKHPBh6kpDoXGlSsA/biFNgPOkFxngTtPg7aiXGs565KccfA/6JRb2KXm9Cty
	Bgl2S9kEggGFhymRq7J299rLoLWzKL94KDBpyjK6YeFlJfluMxBUKl2oc+H3PrAokj9A1PHb+nVf9
	wL6x5/8ZhsUqpf+tmbraj6cuWTeRpTEUH/b0uRu1D/akz56z1ae7fnd7fEjwOWOt+WpPk63GEEQPC
	PIBgp0JH+q/7fPiP21DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXvOQ-000Ap9-Va; Tue, 13 Sep 2022 02:11:19 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXvOM-000Ahg-QZ
	for kexec@lists.infradead.org; Tue, 13 Sep 2022 02:11:17 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VPboHmJ_1663035063;
Received: from 30.225.65.150(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VPboHmJ_1663035063)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 10:11:04 +0800
Message-ID: <8c298bd7-434b-393e-0a04-7fc6956d5eb1@linux.alibaba.com>
Date: Tue, 13 Sep 2022 10:11:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V3 0/9] Support RISCV64 arch and common commands
To: lijiang <lijiang@redhat.com>, =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IA==?=
 =?UTF-8?B?5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "Discussion list for crash utility usage, maintenance and development"
 <crash-utility@redhat.com>, Nick Kossifidis <mick@ics.forth.gr>,
 heinrich.schuchardt@canonical.com, guoren@kernel.org,
 Yixun Lan <yixun.lan@gmail.com>, kexec@lists.infradead.org,
 hschauhan@nulltrace.org, huanyi.xj@alibaba-inc.com,
 lifang_xia@linux.alibaba.com
References: <20220813031753.3097720-1-xianting.tian@linux.alibaba.com>
 <CANU+Zyd+276V6uDsWcyCtB+sfdu2xObvnh9Sxmr4d=UOt27nNQ@mail.gmail.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <CANU+Zyd+276V6uDsWcyCtB+sfdu2xObvnh9Sxmr4d=UOt27nNQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_191115_077432_53ABC5FC 
X-CRM114-Status: UNSURE (   4.28  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CuWcqCAyMDIyLzkvOSDkuIvljYg1OjIxLCBsaWppYW5nIOWGmemBkzoKPiBCdXQgYW55d2F5LCB0
aGVzZSBpc3N1ZXMgY2FuIGJlIGltcHJvdmVkIHdpdGggbGF0ZXIgcGF0Y2hlcywgc28gZm9yIAo+
IHRoZSB2MzogQUNLLgoKVGhhbmtzIExpIEppYW5nIGZvciB0aGUgY29tbWVudHMgYW5kIEFDSywK
Ck5vdyBJIHJlY2VpdmVkIHR3byBBQ0tzIGZvciB5b3UgYW5kIEthenUsIENvdWxkIEkga25vdyB3
aGVuIHRoaXMgcGF0Y2ggCnNldCBjYW4gYmUgbWVyZ2VkIHRvIHRoZSBtYWlubGluZT8KCnRoYW5r
cwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
