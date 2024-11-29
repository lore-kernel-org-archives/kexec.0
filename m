Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1FCD6EBF9
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1EHb2L56DDpjtwU/UFh8uioIw0HOZZ1rlPpTrDEs14Q=; b=ybC3REDlSGQ8gNjEtXx94S91Vx
	W3Ob3GT+SuLbMxTfynx+LDe2bz0IQzSkKWgfsArW6IafwfPmyehqxuF4iGp3Q3xg6+QerGcJKcBvZ
	yIUdhcAxhRzlb9HG9+2+BCUGfOUr2dFdb4gbMiNW+qc7ATFp5pGaCsw8YxFCbpDjtA7MDG/b7knll
	NGhGFFUeI3BkC3Hc5T0uP/AbI4A9ckeThb5Pe7ctJ4kW7HE3V8QlnTCR3OkOw5z8DqN1Cqdt2D1dp
	CvjiTpp1dbBiy2PJ4ehAU5VQrdJnlk3cjwVF3R0qW05xGxhtWAMjY0Hwpzahv39qRAMOeGumHZlQG
	fSZIgqDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH16c-00000000CvP-0CEs;
	Fri, 29 Nov 2024 13:32:22 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH16Z-00000000Cue-2BEy;
	Fri, 29 Nov 2024 13:32:20 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732887138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EHb2L56DDpjtwU/UFh8uioIw0HOZZ1rlPpTrDEs14Q=;
	b=kLDb/kGRwiapc8IEHEJjX9JdZsSzN8BsAPa2RTHUSmua6pSEIlHIgFPZAriB/53oNtf7JZ
	kb08bkLnlTRGxBCT6bQPVQNny0HqGd6tAYTMi9Ky0a0Gy7cSBBru647vBSJ2gbiGAnM8CL
	K4CmqKSsKg+gcvEgc6iOJ6ErKbBM4liqw7b9gDPy6Rcf0GPoHN55zf7xb0QNa4jQbf2LNg
	6Fsofl0Jz8ofxH91BOzO8OKVBTLnFc6gazkfCzTaMa9hSmcBXen8PnbIfJ9u7HsoethIoe
	w/hDPRTTj2EFL4BE8Lv7tMlbcNS/RKZZ/3BUP/X0yf0KDF2mzupUN8apxs4v2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732887138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EHb2L56DDpjtwU/UFh8uioIw0HOZZ1rlPpTrDEs14Q=;
	b=tzt4zpj9BspmJyWB94OMHjwpdw2hmq+t+5FW1SE8HuJJfHm+iH++4n4CuIEmA74V5vgaEl
	zmueYz7U+7FFcBBg==
To: Eliav Farber <farbere@amazon.com>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, ebiederm@xmission.com, akpm@linux-foundation.org,
 bhe@redhat.com, farbere@amazon.com, hbathini@linux.ibm.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 songshuaishuai@tinylab.org, takakura@valinux.co.jp,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org
Cc: jonnyc@amazon.com
Subject: Re: [PATCH v4 2/2] kexec: Prevent redundant IRQ masking by checking
 state before shutdown
In-Reply-To: <20241129113119.26669-3-farbere@amazon.com>
References: <20241129113119.26669-1-farbere@amazon.com>
 <20241129113119.26669-3-farbere@amazon.com>
Date: Fri, 29 Nov 2024 14:32:17 +0100
Message-ID: <87wmgmw4gu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_053219_696397_6BB0AEC1 
X-CRM114-Status: UNSURE (   4.84  )
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

On Fri, Nov 29 2024 at 11:31, Eliav Farber wrote:
>
> This patch addresses the issue by:

Again:  git grep 'This patch' Documentation/process/


