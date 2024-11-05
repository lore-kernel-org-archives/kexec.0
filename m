Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF7AD3E778
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P9OuZmlfxIZVKCxtbHEfIqI3pghW40Mosulo59b7Cik=; b=A7LK5vryhviUBj
	RWpCfsDVeceEQG3d9rpU3mY1Z1AOUr9Y03Vvgl+h1KvHD2n0AnGmD/0GpS1pm/thFagYVDkDaY6s3
	8iZwC8ABauqpZ0ytKJ/Y/YISaVI+T8H1dRICQVtM4k0SYJpvq/7F1fNN3vR1U59rk8lfztS9gfWyy
	RxijcPZxUS9lzS/31WdsnwFBWSCB6Rgjx+V/L0glq4kh7UR015+xowX98dfHeaj5HbH4jvH/A8Mko
	K9gLLVtAdQYHSr53O33Xs5I74sBY4ZJHgkqK6B3ztfNk25wtV+loEIxOx91OFwOaPZCa9CNbz2hZs
	/5jFaFJZm2gcUGz0Gtcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Raq-00000000wDz-27Zi;
	Tue, 05 Nov 2024 22:00:08 +0000
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8RZt-00000000vza-0Ref
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 21:59:10 +0000
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5Lwedd402063
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 13:58:41 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5Lwedd402063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730843922;
	bh=2V6lRRSml+PQc28h+I3/xRbrRkRKAck28ZK8sI5GONw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UxeSXAxPqP6VQxiw3vIIxphOaAavmGtUaYhIs+dh//9lX7gajRr3XqZXhd0rB6kmj
	 ZSU//kHoEi/lIYJpwITEDzB6Ep2PMftaQCE8q11he7qiir92TotAl+7odiM1NMqvEI
	 tCyOKJVdCs35bYB7eM5tQPpeYH3h9RuLANih5G4nTEKVyf7FdFgIb+PmjemEdD00qs
	 k6MWaB/Xmt9D8CRoqlneT2AIJ+Hc1QBRp0fbvzOYufPSGn8P8kjJz/1X3X0lWrLxGW
	 coLcJQB270xDNMhu07myslOC/k2xmSP6ONiRgFu+faPZk8OufQJfVYfi2xEPN4TtRK
	 6zdBipzVD79Bw==
Message-ID: <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
Date: Tue, 5 Nov 2024 13:58:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on
 exception
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Woodhouse, David" <dwmw@amazon.co.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
Cc: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kai.huang@intel.com" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
 <20241103054019.3795299-7-dwmw2@infradead.org>
 <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
 <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com>
Content-Language: en-US
In-Reply-To: <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_135909_203318_C49613A2 
X-CRM114-Status: GOOD (  12.83  )
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

On 11/5/24 13:37, H. Peter Anvin wrote:
> What is the point of writing this code in assembly in the first place? A 
> much more logical thing to do is to just push the registers you haven't 
> pushed already onto the stack and call a C function to do the actual 
> dumping? It isn't like it is in any shape, way or form performance 
> critical.

arch/x86/boot/compressed/misc.c has some code that you can crib, both 
for writing to a text screen (not that useful anymore with EFI 
framebuffers) and serial port. If you factor it a little bit then you 
can probably even share the code directly.

(__putstr perhaps should have a __putchar() factored out of it?)

Then you can just do the obvious (have your assembly stub point %rdi to 
the base of the register dump; set the frame order to whatever you'd 
like, except rip/err/exc, or reverse the order if you prefer by changing 
the loop):

static inline __noreturn void die(void)
{
	while (1)
		asm volatile("hlt");
}

void dump_register_frame(const unsigned long frame[])
{
	static const char regnames[][5] = {
		"rax:", "rcx:", "rdx:", "rbx:",
		"rsp:", "rbp:", "rsi:", "rdi:",
		"r8: ", "r9: ", "r10:", "r11:",
		"r12:", "r13:", "r14:", "r15:",
		"cr2:", "Exc:", "Err:", "rip:"
	};

	for (size_t i = 0; i < ARRAY_SIZE(regnames); i++) {
		__putstr(regnames[i]);
		__puthex(frame[i]);
		__putstr("\n");
	}

	/* Only return from int3 */
	if (frame[17] != 3)
		die();
}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
