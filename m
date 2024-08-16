Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30702C531DC
	for <kexec@archiver.kernel.org>; Fri, 16 Aug 2024 11:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=myXJSCZCEqATnBxAIyWoZbhGyGRs3NBaA4s4pAxGMBw=; b=GeW0qTTPX4EY+o
	XxBQgvbLFKVEMBoOzF2vBlaOPQWFwrh0P1ia32jJFhI9R8zAiis0SnOxDCYUpaPETd6hxlMl8+xnh
	brh0dvli07sF8yjfHcVvA5fQ99+WfAXBBxxAXEkfjjKa6AiSFtMxx21FhzA8aCaRa0othDCcsuqtr
	IHPKlur3d+mFyUecyYHyDszw6LxkqbfjYQsmxsfsfRpXCbjxuQIjr9EWgBGziHfX/hoQWnwADtME2
	EW1BeoEiT2GW4VEbGylFMaBZdqVRAvyWygvTOJczt3gx05NSrWRzLFDe8jcnkw6IPZY9UeTHmuIY8
	CA63Viv42oQezJqBQ/fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seul8-0000000Cgly-1rJo;
	Fri, 16 Aug 2024 11:04:42 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seuht-0000000Cg0X-2fpD
	for kexec@lists.infradead.org;
	Fri, 16 Aug 2024 11:01:23 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-52efdf02d13so2982638e87.2
        for <kexec@lists.infradead.org>; Fri, 16 Aug 2024 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1723806078; x=1724410878; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4qsz+7mQYKMGsKT5Lq9NXZ6sjzsnZVAWwIJdiaA3GZU=;
        b=afEse6HIX92QeyE2UFZWS6D4UefESV/SS2SLgSFJ6mXiHTNPqwEEO97/7eQJN5hM0I
         ZyRpLZwjBdFJFCq+9yx1KpBi8XcD41afO9W68l9iiiOFz90cXK/iijL9QLVTHjMmYN7S
         Fuva+qNKFT0fr/j/oNZv7h2gu2TjVBVBgIUuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723806078; x=1724410878;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qsz+7mQYKMGsKT5Lq9NXZ6sjzsnZVAWwIJdiaA3GZU=;
        b=KJIOgv5dk7+9BtfZ99KCVkYpWNihJM8coy8Xb7tIcVatgp8qbR5XabJYtNIwmdPQlL
         DLBZUXY5qF/2gGsxRik0JHiX+6oyy1JkcRkdGVt+y+6p6MeR1nbDBkDcHHGAizwa/ZNc
         miMsvtJ5ghA6bYCO88u9mixENm0McvCJNgvVybXqsXm0B38Pysuly85HI5XpI0HZv9oY
         Sy0SJH1zp7rJoEelGN+kLjQ6hA0/jwM5XkdoG3KsvHMSm0CASMYIdi869Rv+KUgzf9Hb
         O27PZ58iRIr8Uva0EBtiJUMXLFh3+GtU18ilMGJ64iyaX1Q6k8dknGnoOwQYgE/EyIB7
         oAMg==
X-Forwarded-Encrypted: i=1; AJvYcCUbr7LwTmEavL4jY1z2AGwvfDYYMBqx9JMGkYtpxHMDKKMtoAX7Kq/NaC8nacDsPJF6hcL8N5XK1mkhnwMXcQ0/ULymCobZdHD/
X-Gm-Message-State: AOJu0Yzq4+yyU7jyUoDhKT04aBXgue/nqznoEdcBXYhgNWrfhOMqHtyr
	0wi8fhEjpnbSPa2LhZaO0yGTzK8NfgWwY1PjowtlEHYRC5r2w5pUZ1eUE3Kfuhw=
X-Google-Smtp-Source: AGHT+IE4AZiVE7kjprocqnllW5JlMr4sYvdQRlM74n9w7KXPCquuL65elKkFvCQuUxcO79Gv2cLBjw==
X-Received: by 2002:a05:6512:3d28:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-5331c6e4088mr2153159e87.55.1723806077291;
        Fri, 16 Aug 2024 04:01:17 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6ae6sm238812066b.35.2024.08.16.04.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 04:01:16 -0700 (PDT)
Message-ID: <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
Date: Fri, 16 Aug 2024 12:01:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Thomas Gleixner <tglx@linutronix.de>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <87ttflli09.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_040121_865103_61C34E6E 
X-CRM114-Status: GOOD (  13.88  )
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

On 15/08/2024 8:10 pm, Thomas Gleixner wrote:
> On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
>> On 5/31/24 09:54, Eric W. Biederman wrote:
>>> Eric Biggers <ebiggers@kernel.org> writes:
>>>> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
>>>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
>>>> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
>>>> but why would you not at least *prefer* SHA-256?
>>> Yes.  Please prefer to use SHA-256.
>>>
>>> Have you considered implementing I think it is SHA1-DC (as git has) that
>>> is compatible with SHA1 but blocks the known class of attacks where
>>> sha1 is actively broken at this point?
>> We are using the kernel's implementation, addressing what the kernel 
>> provides is beyond our efforts. Perhaps someone who is interested in 
>> improving the kernel's SHA1 could submit a patch implementing/replacing 
>> it with SHA1-DC, as I am sure the maintainers would welcome the help.
> Well, someone who is interested to get his "secure" code merged should
> have a vested interested to have a non-broken SHA1 implementation if
> there is a sensible requirement to use SHA1 in that new "secure" code,
> no?

No.

The use of SHA-1 is necessary even on modern systems to avoid a
vulnerability.

It is the platform, not Linux, which decides which TPM PCR banks are active.

Linux *must* have an algorithm for every active bank (which is the
platform's choice), even if the single thing it intends to do is cap the
bank and use better ones.

Capping a bank requires updating the TPM Log without corrupting it,
which requires a hash calculation of the correct type for the bank.

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
