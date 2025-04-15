Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1945C369AB
	for <kexec@archiver.kernel.org>; Tue, 15 Apr 2025 22:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Glra7fMFRLxrPIzQwxk8Qeb1or+7AFryoPxji38Wm8U=; b=Dfy38iQ1NaMDzL8I0Ql2/GObKd
	viYq6PsOi5Lp7wqreJMPUKPqLLP6smggSJV//g19d4BOpf+J5piPzJ9I/JqCMmIREstrBOmLJ0Run
	JTCBR2pzgN6tNr1ecfOdiZA1/NO/jE9xggGGu4pMU2v166bqjxINlVZLiPDffeCgGBJ8TmivoyMFN
	xK+4kFStnFSRCb4v6pta5QKVidptmYEkvWzV+IQKH5cPYYxt+u/8GjfQfKhLCsU5o+XtZL7MbDcd1
	jtdKoSeYkkTE1LOOP2vs7tT8c2QIpYVVYY34AeeetgVAFhqn70ZQ5gC5Gn5eeHW37BotjMdcDPapl
	8QVNojOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4oXW-00000007Iln-1d89;
	Tue, 15 Apr 2025 22:13:58 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4oWU-00000007ISl-16WG
	for kexec@lists.infradead.org;
	Tue, 15 Apr 2025 22:12:56 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so41786775e9.0
        for <kexec@lists.infradead.org>; Tue, 15 Apr 2025 15:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1744755172; x=1745359972; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Glra7fMFRLxrPIzQwxk8Qeb1or+7AFryoPxji38Wm8U=;
        b=E60Mo4wo3Dfk0v62XImLxgs92XwwkfLgmW4eDlZuMUfCqf0+ljAdhYyfGmDdwwqZQS
         MXbFoyFobD1MhwPcWVQaNVZCFsJtQR1Ei/oyZ1HIlQUVcqAf5oNoeOMQrOQ8UvGKKotW
         6ISazhovOeNQLLYAjM/sYyjUg6rf2GcHMsrNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744755172; x=1745359972;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Glra7fMFRLxrPIzQwxk8Qeb1or+7AFryoPxji38Wm8U=;
        b=Ajkagq/23mNLkcFjlarpMlAQ6bePVqgpzcwpMYxworxUEjIoFx0/Rn2B3aVM4dS/zg
         KLgdRxdp+h+P7wIYvttNDgwFLNyIbXOTCgXAmPNPUnLunmF25VKw8V3sHYncRH8zA8fy
         2iK46wn+em9o2noqoyLdBjNsfSqzpmbm1a4D+oBaSqTwuNqK/B93AZ5eVH/rLVNSeNPW
         K7p7FB5j+mHcUgqH3PwcjYWZ2RTsnpknSnQOltZWOw/xufdbkW2Z7CDbJKzsEgufrRYX
         jMCJ6g112x1xeC5BCHNPgNVcbV710XnL5wg8l0HYwVWXj3uNm34tkFfx8NpBbYUoJ9CY
         yDzA==
X-Forwarded-Encrypted: i=1; AJvYcCWun6+ke+rH3yGZXmefT1hyzdPvIFNsmx/K8lAdo3agpfPewWP6JtykLEbyUQZOa6rUnSMJug==@lists.infradead.org
X-Gm-Message-State: AOJu0YyXPu+0zzyx4U/VVObr3aPXBI39t/2WLyhC1tw98EPswstc0xC1
	hcMHZmMl70Lw4jm71wc4xBNYkpJ+OuQrVUwVvzMGvlC3B7xbeZL4CEcHknpwFLA=
X-Gm-Gg: ASbGncuNlpZFjANmSvCcBZm8ZY2V5gUcla3lf8VbI29IsZXucJjUnr+WjDwiK9HDZYE
	JRmjg6TkthU5VwXQ1mvk86sLCOw/QnTSAY6gNdYSZQVD7DfAggZ5aFfSnKeY9vftPQ6hr8p8uLN
	07vaS4wumMiCFbswz30pjm7lNvmaQQlI2pBUKzZeB4Npt8ypADhWw8gewKPDjyWtv4q1+M1QKUE
	Lf2SwjlL7zopAyUWu1bXB9qQtFla/6zUO4rYszxU2gnUiW6JA3O6gGcfefPrU9FZqjwubydabPP
	yBYGY+kDdQYG9UujgI6jAf9ysE24KW0wUCyXiqC7GU6kGqDBNM82YY6CHM1JoHkwEKdV5+bGfmr
	e1eKAuA==
X-Google-Smtp-Source: AGHT+IHMt3F9pL0n8daCGA27MStUQTKqmwZC5+FBFhrh37dgHkJZdg1MMLEuJ5Tc1qMw2mZGLdp7Bg==
X-Received: by 2002:a05:600c:3ca0:b0:43d:fa58:8378 with SMTP id 5b1f17b1804b1-4405a0ec7cbmr5103475e9.33.1744755172019;
        Tue, 15 Apr 2025 15:12:52 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4f2cfesm2246405e9.19.2025.04.15.15.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 15:12:50 -0700 (PDT)
Message-ID: <e781cabc-90ee-48cf-9a09-116a8edace1e@citrix.com>
Date: Tue, 15 Apr 2025 23:12:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/19] x86: Secure Launch kernel early boot stub
To: Sean Christopherson <seanjc@google.com>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev,
 dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-10-ross.philipson@oracle.com>
 <Z_mMaAykU0IVKsjU@google.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <Z_mMaAykU0IVKsjU@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_151254_458168_DD5E6B01 
X-CRM114-Status: GOOD (  14.07  )
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

On 11/04/2025 10:40 pm, Sean Christopherson wrote:
> On Thu, Apr 10, 2025, Ross Philipson wrote:
>> +	 * instruction can return for a number of reasons. Test to see if it returned
>> +	 * because the monitor was written to.
>> +	 */
>> +	monitor
>> +
>> +1:
>> +	mfence
>> +	mwait
>> +	movl	(%eax), %edx
> Why load the value into EDX?  At a glance, the value is never consumed.
>
>> +	testl	%edx, %edx
>> +	jz	1b
> This usage of MONITOR/MWAIT is flawed.  The monitor needs to be re-armed in each
> loop, otherwise mwait will be a glorified nop.
>
> More importantly, the exit condition needs to be checked before monitor,

after monitor and before mwait.

But yes, the prior logic was definitely wonky.

>  even on
> the first iteration.  In the (probably extremely unlikely) scenario that the write
> to wake the CPU arrives before MONITOR is executed, this CPU may get stuck waiting
> indefinitely.
>
> E.g. something like:
>
>
> 1:
> 	monitor
> 	cmpl	(%eax), 0

$0

Luckily, this will fail to assemble, rather than dereferencing 0.

~Andrew

> 	jnz	2f
> 	mwait
> 	jmp	1b
> 2:


