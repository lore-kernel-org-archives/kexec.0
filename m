Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453F3C77B75
	for <kexec@archiver.kernel.org>; Tue,  9 May 2023 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+g1kON1R74ttgeGwiVLQYrB7b85i/yoTAFUC7TBhfwA=; b=gcolZaas7qVY77
	VMr6m6aKz0Irjpm11gGWB2RcEsYDIvYDyu3qg12Z8Td4lWhcoNTp+6G/rqQv2AN3wqhuxAg+zueb/
	Az2sKykEtYmk5kaIHc2KYIXZ7Mesr16g1xhelGu+tHNbnW61hFSXy3tm7CONYSlIvoD6qLXHvE42D
	576xRzgVgAwJWHMTy06obRyZrxXzctnBglRGfpO52tfJFA0YOM5xp7UmYrHEiQgZas1OeCCiRN0YR
	xN/5Zo172P+L08A479I6Ub6yVt8V9GB9aFV07oIBx3m4Mf1iKAE9sdSBfjLBy1lb3JY9FFBfM+nBF
	gh8QQjmFGVyAnri8fzpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwM9i-003EO2-2t;
	Tue, 09 May 2023 12:09:22 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwM9f-003EJT-38
	for kexec@lists.infradead.org;
	Tue, 09 May 2023 12:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1683634113; i=deller@gmx.de;
	bh=SSP2D0buVNvjEi9SU9T2UBPjDgOQCn0+r8mPHaHboGA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=rwkFbAQTqvbAW14E3pe2FgIEvGvcDaaeVuNV2scBb2siYwx7HvlA2JefUKBVhwN2s
	 Iy6lBRPlqoeLkRlBAdCxyQats14ohehBwMv3V78LjaCe/o/53C/jHgJdGfi3pSZOAp
	 Qm68jdDnTDG3RjTJm4fgkqLxeQ7O617z56PdLr43QVIv92OVhQlVF9zXDpXOkozjsn
	 OtM7Ne1zzd+Vo5yZ2kqiBIHVNVJ97XpmIbDs9J+uriLgfpdiH0ilJD5MUvH2NdNFgH
	 U2HsKYWPZIxZGn4LY5b5oJNwF3etkJkGpeExa0YCquBcUPEXuzfJkb3/iA2KexL3CL
	 f+zh9HacJ1IAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.17]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUowb-1pnrgO1Sb3-00QmTh; Tue, 09
 May 2023 14:08:33 +0200
Message-ID: <ad64af5e-050a-e103-3619-3ef0468985c6@gmx.de>
Date: Tue, 9 May 2023 14:08:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] parisc: kexec: include reboot.h
To: Simon Horman <horms@kernel.org>, Baoquan He <bhe@redhat.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
 kexec@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230508-parisc-kexec-include-reboot-v1-1-78a155a8a0a4@kernel.org>
 <ZFoL9ntYCCfZFCNs@bhe.users.ipa.redhat.com> <ZFo0Gd/Eucw/0gtC@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
In-Reply-To: <ZFo0Gd/Eucw/0gtC@kernel.org>
X-Provags-ID: V03:K1:huQVl1MfhsA2PJtPDXj3magrMc4c+GchOIrEFlqTz1QU4gwklwX
 1UAiIPp4QD3+ro32aCeHAlc9f8uWlp7NRrLhGiyIDqAHqtxcGPSZGotXaxMEZjsK8mShOVt
 X6JPZRtjwbzKtjAARM3ySetJvN5TIvrTOaTJhBDAp3Vyz6D9ja67ZlPSqgUQOG/yf0VZ7cw
 x09qUnsuZH9N4CHsKdOFg==
UI-OutboundReport: notjunk:1;M01:P0:8kXG0SA0J80=;fnZ+jx+0PyaBK4EpXc2kcDzgp6x
 vcfebN7G8qetIF7ZQVY6lWwUaOGDt5VFoiyOb/wjY5x6YyJOI8q2zpw5QlejhOAHqv3GmeDr5
 GXzPqqQwhtC/4OseGJ7XtbT66o7nGyyq5uY+vfgB3O0Q9mTM4yOj8UGMmKWCevzvyzE/jxlgZ
 JM9rMvtR9umAspewFSYEG/fVMnE4Vsm6ThKu18nZ+aG5pbnZhznR0s0Kul5L5VtgoId9WLIds
 0RRadYK+lpaIzILOs+JDMSYFRQatGicOYLp3kh98yLPSMc1tulXMyCFgmYecEZrOjy45ERPSe
 9NjJ1XMGnJ2lfFbP3MPlq2hr9nD3qcgdGXHISlm6m1iygQR6HsI/UmbrYoWCy1WAXXYV8N4Pp
 lCaT4XAJ0Vo4mJeoGurGgkD4Wu2qdqsVGDanjYV1KD56kgaQcqK4Uw7v57TPIbRaNMbBBltcc
 iWxG7ieq3kAZ85tRE3PKVbLR60LJ/ETUu9mv303PTBMx7vLLgyLnwNP22q7dnkYB7D9sqKyue
 OwkiJNFHi2gvhXPTWcT4YXXj7sURJOexoN1B0Z138A7zVtosRYOrm1R5cjKjoXcYiDnIK2jDU
 yRVSBCVwnGgSXh0cq2G4XCtiLkWWBCoW7RBm9r+zb05lzbYYlwaaj3rvI0cTQynx98W6D6xSS
 yvC+sKH4aqeXZFM6NGFK2f4Yu7Q45A0QNipIrTY9jPr1BYFg9PgvvfHicEsnyhtxMLBqZ+yat
 0ouSTZABlcz6we942mtjL/Lgj0xs1s/63zMvtJHLkxCIBhtIlYaWjheH3h20X+j0EXmeVYNz7
 Y3LZ9U2jPrWIfs8EU0g7MqguyTZuiaRomPz/0i3AsYQa62UQVM+HSICbjUjmCY5Ob4SuF19LM
 7uRAJgKfUA8J3eilgMTio6VXE4gfsYkt/H+PVzPrErmtdwC4sast+h1a/RLCaRs6+auYA2UCU
 Y7fzIQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_050920_318578_E026DDCC 
X-CRM114-Status: UNSURE (   9.03  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 5/9/23 13:52, Simon Horman wrote:
> On Tue, May 09, 2023 at 05:01:42PM +0800, Baoquan He wrote:
>> On 05/09/23 at 09:01am, Simon Horman wrote:
>>> Include reboot.h in machine_kexec.c for declaration of
>>> machine_crash_shutdown and machine_shutdown.
>>>
>>> gcc-12 with W=1 reports:
>>>
>>>   arch/parisc/kernel/kexec.c:57:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
>>>      57 | void machine_crash_shutdown(struct pt_regs *regs)
>>>         |      ^~~~~~~~~~~~~~~~~~~~~~
>>>   arch/parisc/kernel/kexec.c:61:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
>>>      61 | void machine_shutdown(void)
>>>         |      ^~~~~~~~~~~~~~~~
>>>
>>> No functional changes intended.
>>> Compile tested only.
>>>
>>> Signed-off-by: Simon Horman <horms@kernel.org>
>>
>> Acked-by: Baoquan He <bhe@redhat.com>

applied to parisc for-next git tree.

Thanks!
Helge


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
