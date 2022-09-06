Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600D6ECAAD5
	for <kexec@archiver.kernel.org>; Tue,  6 Sep 2022 15:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N4yYdha7fZ3bx/F5A1r5Yrx703uxi+aq+hLF4OxfGC8=; b=ugeWKN3kg+nNxz
	W8Yni/h27hfvS8vHZ7Sr0X5ATZYOCYc/wWr4l6HIJutbNDaaM2E76aqSHXyZ34WiYArDWeR0DnC94
	fDTUxjH7AyrxAtl2/G0/nxOG0CBNGzl6Xw4IhGDccCQv7TNlyL0RizULUdpNZhfhXu4uVrWyIfkpN
	Ps3GHfMz8chFyNttoX8Lm5N3pzXCHynyW0kL1Q4iEASFQo8LCuYwcR2FSyVvezBCczQG0B1t545Ar
	bDCWcDVS4pGE7KpD38NcCFIln2ajKiPw+vxBshfF5s4mXgR0HFK8/yhCuOg+BDO/mDZ7INGh9ybSz
	XXzCeCw71iJoDFZ+XUkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVajn-00EwfB-3I; Tue, 06 Sep 2022 15:43:43 +0000
Received: from out2.migadu.com ([188.165.223.204])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVZtW-00ES5s-DD; Tue, 06 Sep 2022 14:49:45 +0000
Message-ID: <d30c98c9-b0bb-2b99-c4f0-94b3e46040d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1662475777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKfDObdG6YvwMUOT+NGjuSPIDBSl/+OGS7uJUe/yCJk=;
	b=PEAC/pxfxBmpiaTHnan+GUhay2drgZlqqkDzgylZ3lENzn4GyiZvEHFR0iz5TRFv9XOiyd
	0ysPyzxJtUH3TBTKKcD0W6w4QpP2uy2EfS8ANfvV7HVJBcfp0a7bHnYSXz+J6ULQvJgB41
	QuC5uE6V6ED89VHNOZFqgOjUVfdJQYU=
Date: Tue, 6 Sep 2022 17:49:35 +0300
MIME-Version: 1.0
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
Content-Language: en-US
To: Nick Kossifidis <mick@ics.forth.gr>, Yixun Lan <yixun.lan@gmail.com>
Cc: Alexandre Ghiti <alexandre.ghiti@canonical.com>, ebiederm@xmission.com,
 kexec@lists.infradead.org, linux-riscv <linux-riscv@lists.infradead.org>,
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
 <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vasily Averin <vasily.averin@linux.dev>
In-Reply-To: <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_074943_724277_4C2DC244 
X-CRM114-Status: UNSURE (   8.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 7/5/22 15:23, Nick Kossifidis wrote:
> On 7/2/22 14:35, Yixun Lan wrote:
>> I'd also like to try kexec on unmatched board, and encounter the same error
>> as Alexandre Ghiti reported, generally I'm using almost same cmdline
> 
> The kernel-side patches have already been merged upstream, for
> kexec-tools there are some people working on fixes, I'm expecting
> pull requests on the github before I do a pull request upstream. You
> should be able to use kexec without initrd.

Dear Nick, Yuxun,
first of all thank you very much for your great work.
Could you please clarify about state of makedumpfile on RISC-V?

Thank you,
	Vasily Averin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
