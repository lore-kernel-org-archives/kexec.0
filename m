Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3842C83F2F
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GGS8uphiIwNIVjCbhuLKnwJysaXJRwPduxm/NtYWKFU=; b=U4xIpDUUYfprX5rGu9kP3yVusD
	UdGZMRgnpGbFgW2ppHObzICtcsI8WKiGk8APsKSFn/vBzIlyjRXAlRFehoxc9vKaIxm1dHbSFKiXE
	7ii8XndiPckVTNmT+ssI/wFbxvyYL4S6rMlK5jqofRpgMcwOVyXIcz4bEW4+NAU83sxq7vae0pXru
	0ag0cP9r4z7iiGCLs/KZeJIWxOV2/0SeFzi++cxY6XA7Cb+PsfueLzEIdR7BTXxmTt5aqfMo/rhHa
	pGysdPJR6u+orAJgedc19ELws6yHKdtD5hADwGo0lda6pbR1h+qYhh8lEwUIRqsX2KKH1vHoiVXQI
	GXLxKFzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjgTe-00000002U08-1B02;
	Thu, 29 Aug 2024 14:50:22 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjgTc-00000002Tz0-1SS7
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 14:50:21 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-6d34c57a88eso6107097b3.0
        for <kexec@lists.infradead.org>; Thu, 29 Aug 2024 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943018; x=1725547818; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K40x/XxYGu996xFAIHnF019vu74x3oRUZW/VL978XPs=;
        b=l8DSSoyaRS37FQGf+g/ZiYbdU9zadUlUHk3yWKSCAPz4htP685pRUb67V6Ijq23/Jm
         z6io/J/Z1vkyKtNDBhd/WGxPbPlqt8q6iSIo2F7jJV/PMzMhG3gVeJeFTD625cTKiA3n
         Y/dd+nwFc4xtQ28EI4DrSiAh7Vltk5QxmEYEQKMPZjg7PfzSTJWmH763lojRkT6kpTo3
         db/KJ38C9TLJ4sg2rUvQ1Pw1EoE1nTISWtaYNKq/753z3NNU1Cuw/GJE9jgeGTOGAHIL
         UVrNlF+ygPg/iFsV6pKdHEXoYXqU3OMSAfmRpx4aDQ1Ngw0lp1tCihoqj1LVjiZx40x/
         zong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943018; x=1725547818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K40x/XxYGu996xFAIHnF019vu74x3oRUZW/VL978XPs=;
        b=i19DVd3qAMpVL1njcsg700zNR+LSk7pzJ2h9biMrJfIyrRf84WIsLkj02FU9mTQ2hs
         tp7pM/m/57EqJnbD6FUUy2SJNuCRScC3iuebExluGJNGf0v64VGpJhjr4rbcoPsNbkfi
         QF6xoGquTxeAaqG7bfwjJmd3sVa9mWThXhbNdmrGnEAWmJaBxbGPQBiUi8pKwLjCHU1U
         z30X7cLqzwNpDxGo9KL1NdcrxhrPGdzYWtdA2ke0QcBIIlftXAXjX0JwTtFHoB//9+jV
         Vksqd55XvmKwJTfwfK2U2pW+bfhjtz2JJDTb6fwcnCt26fEiLowyHgJFY0a06L28Yupk
         tj3A==
X-Forwarded-Encrypted: i=1; AJvYcCU07IxLSHN4w19CpEwnvn7yZI/XAHRYVC6GS1OGNXB1R5//1lGBGuByaAyBwkyeOusWNsYA0A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwuA51V2UsrIpEsIRWUt/DOaoKzELpXAGJnNZFNDLMDV41XVut6
	wmDqc/W1IFtvrIhbUylFmvI4Vl7KuBw3JFsWuNagzWl98YLeBQOzuperICNWB1jGiWn8TmR7AzD
	Jqg==
X-Google-Smtp-Source: AGHT+IGmzsl+rb2EC+zOzjzhADg2nn9Mafe2WTKumDpKYR0ktqk4W9+2ZAHTw7zGoStxNYtfttKBQBxzE5Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:680d:b0:64a:e220:bfb5 with SMTP id
 00721157ae682-6d2e6f71327mr398347b3.1.1724943018336; Thu, 29 Aug 2024
 07:50:18 -0700 (PDT)
Date: Thu, 29 Aug 2024 07:50:16 -0700
In-Reply-To: <87475131-856C-44DC-A27A-84648294F094@alien8.de>
Mime-Version: 1.0
References: <20240827203804.4989-1-Ashish.Kalra@amd.com> <87475131-856C-44DC-A27A-84648294F094@alien8.de>
Message-ID: <ZtCKqD_gc6wnqu-P@google.com>
Subject: Re: [PATCH] x86/sev: Fix host kdump support for SNP
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	thomas.lendacky@amd.com, michael.roth@amd.com, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_075020_403441_EC099B64 
X-CRM114-Status: UNSURE (   8.61  )
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

On Thu, Aug 29, 2024, Borislav Petkov wrote:
> On August 27, 2024 10:38:04 PM GMT+02:00, Ashish Kalra <Ashish.Kalra@amd.com> wrote:
> >From: Ashish Kalra <ashish.kalra@amd.com>
> >
> >With active SNP VMs, SNP_SHUTDOWN_EX invoked during panic notifiers causes
> >crashkernel boot failure with the following signature:
> 
> Why would SNP_SHUTDOWN be allowed *at all* if there are active SNP guests and
> there's potential to lose guest data in the process?!

Because if the host is panicking, guests are hosed regardless.  Unless I'm
misreading things, the goal here is to ensure the crashkernel can actually capture
a kdump.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
