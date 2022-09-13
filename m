Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEB0C6FA82
	for <kexec@archiver.kernel.org>; Tue, 13 Sep 2022 05:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kyxN6SbRTPkx99QjQTxUS8Z5flsJjFUtTuRTSPZTYj0=; b=3BWc7tIa4PlUuv
	XGBUArU7HoRAM3jYM6dsWOgElGD4Xy/qxVbTGKiayLSxA7kJlLZPz9hWy75sjgXU+3HYb58GXTOiW
	TmDtDhwvZ12UlceojLSl4JfKjJmy6ijn6YOCfcb2WsgHRk5w89FIgC1HtmPbMKIEePQECG4Zajx8Z
	nFYuIUeYzk0dglEAbpGtraNkCvVTIWMpuW3J/jtLhdAqFRAVBYaqI6Ew+g2m7E/ZTRSozGaxQENYC
	tIvrjbicbDzFrC84V3dZMUJ3H48VlKRPF7i/LXCoZHJ5OGeo0YBHkNUZkzHExwwXyQD/V1qCycI59
	GJF6I9tiMKcU5HHUUJXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXylw-002buA-FY; Tue, 13 Sep 2022 05:47:48 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXylq-002bk8-Nn
	for kexec@lists.infradead.org; Tue, 13 Sep 2022 05:47:47 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VPdQfWt_1663048057;
Received: from 30.225.65.150(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VPdQfWt_1663048057)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 13:47:38 +0800
Message-ID: <c429f8d5-332f-8d69-79e9-5a585cc7b11a@linux.alibaba.com>
Date: Tue, 13 Sep 2022 13:47:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V3 0/9] Support RISCV64 arch and common commands
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?=
 <k-hagio-ab@nec.com>, lijiang <lijiang@redhat.com>
Cc: "Discussion list for crash utility usage, maintenance and development"
 <crash-utility@redhat.com>, Nick Kossifidis <mick@ics.forth.gr>,
 "heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>,
 "guoren@kernel.org" <guoren@kernel.org>, Yixun Lan <yixun.lan@gmail.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
 "huanyi.xj@alibaba-inc.com" <huanyi.xj@alibaba-inc.com>,
 "lifang_xia@linux.alibaba.com" <lifang_xia@linux.alibaba.com>
References: <20220813031753.3097720-1-xianting.tian@linux.alibaba.com>
 <CANU+Zyd+276V6uDsWcyCtB+sfdu2xObvnh9Sxmr4d=UOt27nNQ@mail.gmail.com>
 <8c298bd7-434b-393e-0a04-7fc6956d5eb1@linux.alibaba.com>
 <e9efc067-360f-3144-a1c4-728b12a7a148@nec.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <e9efc067-360f-3144-a1c4-728b12a7a148@nec.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_224744_903467_15E3A14A 
X-CRM114-Status: UNSURE (   9.42  )
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

CuWcqCAyMDIyLzkvMTMg5LiL5Y2IMTI6MjcsIEhBR0lPIEtBWlVISVRPKOiQqeWwviDkuIDku4Ep
IOWGmemBkzoKPiBPbiAyMDIyLzA5LzEzIDExOjExLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+PiDl
nKggMjAyMi85Lzkg5LiL5Y2INToyMSwgbGlqaWFuZyDlhpnpgZM6Cj4+PiBCdXQgYW55d2F5LCB0
aGVzZSBpc3N1ZXMgY2FuIGJlIGltcHJvdmVkIHdpdGggbGF0ZXIgcGF0Y2hlcywgc28gZm9yIHRo
ZSB2MzogQUNLLgo+PiBUaGFua3MgTGkgSmlhbmcgZm9yIHRoZSBjb21tZW50cyBhbmQgQUNLLAo+
Pgo+PiBOb3cgSSByZWNlaXZlZCB0d28gQUNLcyBmb3IgeW91IGFuZCBLYXp1LCBDb3VsZCBJIGtu
b3cgd2hlbiB0aGlzIHBhdGNoIHNldCBjYW4gYmUgbWVyZ2VkIHRvIHRoZSBtYWlubGluZT8KPiBV
c3VhbGx5IGEgY3Jhc2ggcGF0Y2ggaXMgbWVyZ2VkIHdoZW4gYSByZXF1aXJlZCBvciB0YXJnZXRl
ZCBrZXJuZWwgcGF0Y2gKPiBpcyBtZXJnZWQgbWFpbmxpbmUuICBJZiB0aGUga2VybmVsIHBhdGNo
IGZvciB2bWNvcmVpbmZvIGlzIG1lcmdlZCBpbiA2LjEKPiBtZXJnZSB3aW5kb3csIHRoZSBwYXRj
aCBzZXQgd2lsbCBhbHNvIGJlIG1lcmdlZCB0aGF0IHRpbWUuClRoYW5rcyBmb3IgdGhlIHJlcGx5
Lgo+Cj4gVGhhbmtzLAo+IEthenUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
