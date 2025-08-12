Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE5ACA0EDC
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNSs6KOwqyOQOFmsrg8IFO4ZjDR6oQrd/gvk1o5f7v4=; b=yquuRqbx1rLdYO+/clzerkl0Bt
	jjZFudIAC/H6bPqdNFU45ZXOmXvprOxHcl/kawjEuDiXfs3LBU+Qu3JlMJdhrnO67CoytF1wakV68
	JIZC9pnaiJKLm94D2Zx4SnX2Hyk1pQ8g5k8ysyBVhq5d0ju2TS3TcS5uYZV6BylBWjkeE103luez4
	X74bkiOp5NFijEDVO1EEFTtYl+d+dLXwigTAlVpL4cuANE+L1oQukMUQBU8PXug32UhCVud0Np4to
	yuexXejJ2vNHUHqoxmb2SfYdCPuHBWeKsx7AHw0duYJQbM6OejdUjzF0gxMr2NGTA/n92bB+Ebsef
	B9evJZJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulri2-0000000BHfm-2PZF;
	Tue, 12 Aug 2025 16:18:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ully3-0000000ATgZ-02Vt
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 10:10:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754993453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNSs6KOwqyOQOFmsrg8IFO4ZjDR6oQrd/gvk1o5f7v4=;
	b=UTLWF1/mSA4/r3i2L+WzO6FcpHxBbn+przBd6pJluGDkEK0orEtIbz5yBaqikIyAyPqsuw
	QnSjMCHMEnect0L2HkSZcTuNE6kySKyEG5+8QT9jyz+IHp0ibYTJ8ZdJiRVsDfsdBS9jFO
	EqpujGikeOdtG8wV5o2M62/cVW5g7gQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-E89ioReYMEyeTL1k3plD4A-1; Tue, 12 Aug 2025 06:10:52 -0400
X-MC-Unique: E89ioReYMEyeTL1k3plD4A-1
X-Mimecast-MFC-AGG-ID: E89ioReYMEyeTL1k3plD4A_1754993451
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76be6f0bbfdso7061227b3a.2
        for <kexec@lists.infradead.org>; Tue, 12 Aug 2025 03:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993451; x=1755598251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNSs6KOwqyOQOFmsrg8IFO4ZjDR6oQrd/gvk1o5f7v4=;
        b=UyugI4EXGg0i8QBwRRavSAmAZNbhXBo8iSr9SXoh47S+pNlEkbxjLfOonkEvD+V6MU
         A8yTbAZJ235gF8qqHkVpcre8b1dM+dVPL8q75ctInecqvuRwAN7mmTEo8luk6Q3tkZ9q
         76tSaJ2isEDC00SCn/sfDm7YBd7zPhkjZIum2Mqfl0aB52nt++Yi0Mhaxp8JmI2kwl3d
         5m+4DOoVZ1x3oJ0SviavfPGqNAEcfSvU6CuKaBFKGt0ruAOHyjiyHAUy+R1CHvwQ8UVq
         FiORf++6+2jKzWsooYIAK2KC2PA0lEBqeLDkJ0WJgnb7UAfhLN5884Fu4TRqN9LnUu7b
         MA1A==
X-Forwarded-Encrypted: i=1; AJvYcCVS3SyQv+TEJAHpC9bjRF0ATa+xbJpqGPOfaoPPjXYnG1C92PdFuuKBRR7/vxg09D/M97w1Kg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yza5wVWK7bBaNPfm4nU29owPJljWkP7YrSiprVa2+fs9dvdIjt7
	4n1FpiKNQ27qyYSMpLhnCXIVp8PqOLjyPrHW9RhtBji+AYB4zyr9Z4zD8ifDSiEDXZwUmnwLlP6
	S45sD782QE4Napz35EWYXeNN0a6OJU2yu/IsH0u5tnOweWjLle2bWHyWa9pJIHQ==
X-Gm-Gg: ASbGncunHwsTu7SGomaOJygVBOH5QS06NeOcFuzgsKNAvvh2DFEvnzpldF9hPLjAc3r
	r9bHLXMH83A6SNCITvg+ZiSuXZ7NOEWUZ7IjL7bZooA4tikr/p18LXTEey6b6dYlTzj3nXOBtpm
	InP8BFPvydbI/tRQ48Q1Np93hdF62FBF5XZQ4pkABIegciHE9FIKuDpYAb6eClbH8GYskx8snBB
	cPS6VCjsLeMhbgVxO1vVE6p2juGTK6QWF+lU7tjgqOp+qqOUFBGrV3ysFZ4TNk6jd19XVIUMmPI
	AqAp+kRoB/hzHBqS2DRRxJr56TNVK1k=
X-Received: by 2002:a05:6a00:460e:b0:74b:4cab:f01d with SMTP id d2e1a72fcca58-76c4615b6a0mr21473770b3a.12.1754993451051;
        Tue, 12 Aug 2025 03:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLAmaQr1HIbt/+T8A3Xj7cx8a6v2gYbnrKNkZvVwyFoSL03wtB+5VA+cs4MTHadDVFeK0cFA==
X-Received: by 2002:a05:6a00:460e:b0:74b:4cab:f01d with SMTP id d2e1a72fcca58-76c4615b6a0mr21473742b3a.12.1754993450666;
        Tue, 12 Aug 2025 03:10:50 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdd2725c9sm26811520b3a.6.2025.08.12.03.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:10:50 -0700 (PDT)
Date: Tue, 12 Aug 2025 18:09:12 +0800
From: Coiby Xu <coxu@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [Regression] kdump fails to get DHCP address unless booting with
 pci=nomsi or without nr_cpus=1
Message-ID: <i2l2ujhqjd6akzosvzj4njv2vemsfuvywz4gsnj2nwo3fwyjyz@cfhekxpartf2>
References: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
 <87bjom8106.ffs@tglx>
 <878qjq80yu.ffs@tglx>
 <86v7mt9ai3.wl-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <86v7mt9ai3.wl-maz@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bz90tplSvntjjCPVxlpwzVzWuVwr5akvEm_6vZcVZz0_1754993451
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_031055_124829_E9672877 
X-CRM114-Status: GOOD (  20.90  )
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

On Mon, Aug 11, 2025 at 03:52:04PM +0100, Marc Zyngier wrote:
>On Mon, 11 Aug 2025 14:03:21 +0100,
>Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Mon, Aug 11 2025 at 15:02, Thomas Gleixner wrote:
>>
>> CC+ Marc
>>
>> > On Mon, Aug 11 2025 at 11:23, Coiby Xu wrote:
>> >> Recently I met an issue that on certain virtual machines, the kdump
>> >> kernel fails to get DHCP IP address most of times starting from
>> >> 6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
>> >> Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,
>> >>
>> >>      # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
>> >>      # MSI_FLAG_PCI_MSI_MASK_PARENT
>> >>      git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
>> >>      # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
>> >>      # Provide MSI parent infrastructure
>> >>      git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
>> >>      # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
>> >>      # Prepare for PCI MSI/MSIX
>> >>      git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
>> >>      # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
>> >>      # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
>> >
>> > There were follow up fixes on this, so isolating this one is not really
>> > conclusive.
>> >
>> > Is the problem still there on v6.16 and v6.17-rc1?
>
>Yeah, there are way too many things that have been addressed since.
>kdump is also a particularly nasty case, as it tends to rely on the
>redistributor tables programmed by the previous kernel.

Thanks for providing a clue. This may also explain explain why I fails
to reproduce this issue against 1st kernel even with the same cmdline of
the kdump kernel.

>
>Also, this says "virtual machines". What's the hypervisor? 

I'll contact the lab administrator. What kinds of info I should collect
to help you narrow down the issue?

> How hard is it to reproduce?

It can be reproduced reliably on certain machines. But as of writing I
haven't reproduced it on other KVM virtual machines on three different
host machines.

>
>Thanks,
>
>	M.
>
>-- 
>Without deviation from the norm, progress is not possible.
>

-- 
Best regards,
Coiby


