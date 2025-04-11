Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7295FC369A2
	for <kexec@archiver.kernel.org>; Fri, 11 Apr 2025 21:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9FKI0EnGL+ITiUEghed0r99tXKZdQe5KG58x8/Jte0=; b=aT0OM8JJgpHm3TqaweeVx9CeVk
	HJnAtwl1p1WXFUpstlkQnrKkRr1Vt9Id4hfweMiOh7A85Rfbq7uZZVrLJ0gkDRHBVkD4jJH9P1EH7
	zjlsSP7Ui3BF9ObfnpRa8b7M/VJFtZsCrOEkKJZ11tDF66VWrQj8AQSuA+HOqoTn9WQsu1mGkC7Lk
	wdiwZ4A5e2JKuLIr34/5Z00aC1uTRAjz1sJyH6UEIXqv2rrqgLbRPT7jZbhANZzlYtW5YWSnDGefV
	K/JEKpuyJcMfWXX1k5H22Gx518WUpNw8dUh33DRPW2lYdHedRrxsXaTFCZx1benEspypGXAyzAc/a
	n5M7Klag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3M7R-0000000EwuA-1EMA;
	Fri, 11 Apr 2025 21:41:01 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3M7O-0000000EwtS-3Vpm
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 21:41:00 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-7375e2642b4so1802966b3a.2
        for <kexec@lists.infradead.org>; Fri, 11 Apr 2025 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744407657; x=1745012457; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9FKI0EnGL+ITiUEghed0r99tXKZdQe5KG58x8/Jte0=;
        b=WCGJ23IsCBV0QaetTG2cQ4K33xzTnvnVp9kb+3pgvbT5vPmYg0en+Jq6IQs0oLahXj
         Y+SEQxL/tlwIPwlKOlsNHm4j5pCBsETKMq9uHjYu0sICzLufAV3x5S3E9Cn9qcjuhmai
         +CGi1i3V13Laxez9YUYisxRULwNVWdOvTFaDTqf6vkBBWwl67ISlxG37WsRjwNDfrZA3
         K1DgXyFkpKRRJ0c8s8Hx/LQ6VSqDFREeDYReUKKTdD3veMhNHH9bRlfd6TUBk/39n4EH
         QT1ZzTcoLOaDcePjBWejf0ANZnem35KpRHQCyQ/zsw9iHvpuaMxXZA+Ndk+0qwTOhjB9
         RV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744407657; x=1745012457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9FKI0EnGL+ITiUEghed0r99tXKZdQe5KG58x8/Jte0=;
        b=HQjgtwjZA+qyER+ejLLJcZvJaAp6r5FfMfG2B57lTYnR6IIlhudF5pbEff2hUAD+Rr
         TYTY++Dc950rUqxkGb+3iEbNdkt2XeLJi6zmf85UHsDwnrmL9mh717NZ3yyDniH+wxow
         Hf53QGmD+QHO7fXv//qwGDdPDnNBV385ye27cJbsuRSchzEeNlCJlNgXUndaXzXIMYzZ
         xok9GsqV6m0NYrEH7UHL4DAKGCcEWPPeIayrOsCmad559dieIyoa3nZ5EsXJWmdoaqyh
         68qCQdnMkG9y87opHzNj2hKrqn/1603MVfnqfAiZ9tw4R4LsGwJqH9Jx8saj6kZP6PEV
         SzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIzGl9Pv7oPyRjBISGU9Q9Mwm7bIBgnvejvrZcgHYkec8K8so8EGDIARjnhaVuc5dH/ncvlQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQEZW9PfRQNCDLlGyTgI9PLJi0OBhXhUDzrX4JgEmXy3T6CeqM
	6mq5lTWqMM+7kPtdmfWaCgUiDVnjbhuDbVy7PxaYqHiDrQ9xslIA9zLRKHdZoUydCAiniJuuapR
	kWA==
X-Google-Smtp-Source: AGHT+IHlHwSyxV0LTUHRGhNseRoHCYNIY6ncZEyXAVZHr/jzCGvSjE4K7i+J2dif5I4fTGdH0/RJAkcUZUM=
X-Received: from pfbeh4.prod.google.com ([2002:a05:6a00:8084:b0:730:7a22:c567])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4644:b0:736:9e40:13b1
 with SMTP id d2e1a72fcca58-73bd12b1315mr5481503b3a.23.1744407657218; Fri, 11
 Apr 2025 14:40:57 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:40:56 -0700
In-Reply-To: <20250410204149.2576104-10-ross.philipson@oracle.com>
Mime-Version: 1.0
References: <20250410204149.2576104-1-ross.philipson@oracle.com> <20250410204149.2576104-10-ross.philipson@oracle.com>
Message-ID: <Z_mMaAykU0IVKsjU@google.com>
Subject: Re: [PATCH v13 09/19] x86: Secure Launch kernel early boot stub
From: Sean Christopherson <seanjc@google.com>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250411_144058_876015_51D2AF12 
X-CRM114-Status: GOOD (  12.09  )
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

On Thu, Apr 10, 2025, Ross Philipson wrote:
> +	/*
> +	 * Get a pointer to the monitor location on this APs stack to test below
> +	 * after mwait returns. Currently %esp points to just past the pushed APIC
> +	 * ID value.
> +	 */
> +	movl	%esp, %eax
> +	subl	$(TXT_BOOT_STACK_SIZE - 4), %eax
> +	movl	$0, (%eax)
> +
> +	/* Clear ecx/edx so no invalid extensions or hints are passed to monitor */
> +	xorl	%ecx, %ecx
> +	xorl	%edx, %edx
> +
> +	/*
> +	 * Arm the monitor and wait for it to be poked by he SMP bringup code. The mwait

s/he/the

> +	 * instruction can return for a number of reasons. Test to see if it returned
> +	 * because the monitor was written to.
> +	 */
> +	monitor
> +
> +1:
> +	mfence
> +	mwait
> +	movl	(%eax), %edx

Why load the value into EDX?  At a glance, the value is never consumed.

> +	testl	%edx, %edx
> +	jz	1b

This usage of MONITOR/MWAIT is flawed.  The monitor needs to be re-armed in each
loop, otherwise mwait will be a glorified nop.

More importantly, the exit condition needs to be checked before monitor, even on
the first iteration.  In the (probably extremely unlikely) scenario that the write
to wake the CPU arrives before MONITOR is executed, this CPU may get stuck waiting
indefinitely.

E.g. something like:


1:
	monitor
	cmpl	(%eax), 0
	jnz	2f
	mwait
	jmp	1b
2:

