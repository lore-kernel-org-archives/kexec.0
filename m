Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C65C79FBB
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 21:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ozbwghE9AMpwIIhz2P8UJs4AXIT1SYFdl3Q4CzsGjEs=; b=W7cUCpCiEXwtfzrNc1KRoHEJtb
	nS0KitM6QFHL8dMOBjyDXC/htikB/vRzRQLadyS5lJaLhXAnx3q4XrW4YkNm2u8yqucJuq5KwsoI6
	n6aaO+mu1lY1AFu4FVd3YFh3DFWDkwvQ0NAQR7mtzB76iUkfDhfCyMMeHlYRyZPstdfUZ3B8BuUyv
	Ur5EJhuf5ewXLYlfL2RyUpYYlOFWBlnQz5EtbFgY2k5PMYx4GSFVRt9ia3zxjU0z9kebK+hQUd7CR
	GzgQ60SkPLcouqOB5IAWDXufQkT0pRsr00Wbfa8ETl28N2sUEecr8zdWorIoUeeEWSmHMwiDK6K3T
	2NF+dkZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4mSn-0000000FQtq-3X6M;
	Thu, 10 Sep 2026 21:37:45 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4mSl-0000000FQtC-15wV
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 21:37:44 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-52f83889a93so3198921cf.2
        for <kexec@lists.infradead.org>; Thu, 10 Sep 2026 14:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789076261; x=1789681061; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozbwghE9AMpwIIhz2P8UJs4AXIT1SYFdl3Q4CzsGjEs=;
        b=k/JOTzJP6u9HpJUkotx462XKhBEf3WCT8yhgVzTusvmZ/pZBDgalxi8jkwaSS4qTGn
         zF/g58G7BU7cQ9qjL3E83yDl0fL5FEd2aoIWyvDrnPe7UYWZVG8oZRYAflCm/F8cA0np
         cHj4hbF/g+SwADaS6aUh00LblGtho9zXD+WpvwGAdxmB/Qq8yMx+XQCmVsFuKiOhKYMq
         dwJY9d5cM1vH/dKYKZoGcjFXLNb8yZH2CEDV+UphEZbX8Sb8jsfNZhLcZbIIEinoQVYJ
         iZHlCvhYcPC4JO2HODweF5WfFM597iyXuZ/ttQ566EYMM39W5VyifrY7sHDtsffMW2JM
         fJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789076261; x=1789681061;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozbwghE9AMpwIIhz2P8UJs4AXIT1SYFdl3Q4CzsGjEs=;
        b=SnIfUixRHYEZgqdoYo3NgEY+s9jA5GAF/ivIEWeeVOpt4V8twICEu6KDgLrRNEs5jf
         SkbhDZKr9W3a86amcfe7ViO5G/QoBr3xISq8RfbkYCXkKatiuxVW7nKcraNCaLqK4kdI
         bMADPLZVzsliffXmT7SMQ+OeISyNNsU5UeJLSH3JA7r631BayLw0qC/SgPcqRcVQsXgD
         u61c5QLq6FP/y5wfLGM771I4PWj9DsPKUbGKVlnxI/b719rdXgh1D+6G6kt4vUyXSEml
         FeuvCUOFFhhcsNtWsb5lYpjHZzJWlVDhuwl5xu+r0g2cTXJWEiMXU7FvxNsKiJuStOYy
         WTAg==
X-Gm-Message-State: AFuF++nJ+ntD0kCmlyWSM2qZepvpawzDQDRsuLIUcGgJb8SluTLDZrJB
	91R5Cl8OWesu3omteaQcx4TjsUGWFCW4HQeuduaY6IXdlYgnp5Zm5RVmXhx8FHFpNCnOA4VzNz4
	LJKcONH8=
X-Gm-Gg: AYBFou1IDlejDrMa3rYvbcs0Ocr6trYzrYbvgw0yzVevaQQMElLIRF3QKWr/s0loysK
	bEuty5eBv6QDORa/OWJSeJyWFRcTz/aCszXYiO0mYeRgnEvftdhbWD69zfpzCRohUncSAr1EkST
	mXVMzpDuoEfzL9V5VD1m09/yBFrPS7tVTp99xvica1Yxvv27H8DKiz+Vx6uArhj4Oxj68eK5dFv
	YdPE4rTeFrfMdN2YMjG8eSFQ6XKNCeCfiikABA9uNVeogYm6Ke+xMsf2PFN7kLrplAQFNF2bhuo
	3bE8+qRO4NRgTlJsKzxrkwnK7diGAGmjREK7MT1ssprPq4AwmB5bvW+CgHT7eNn5ib+hHqfk7h0
	/yrpzeIVmldbyU/BrLtNWyckmj3t3wocCvDpA/QKZU2LJniBcCWnJPoXW81Ni0XsieFWGxWmNvh
	3L1nlshpdnqDw0f911wX6Fguzzjo+9Ow6mVchjNuxV9aMgm3/adlZniShB321ZUaR9p6/wA4tij
	n5N4SAF4EAxim3tN0lX7eNQc6ui+t78u2VT
X-Received: by 2002:a05:622a:393:b0:530:a441:c52d with SMTP id d75a77b69052e-530c876307fmr21122731cf.46.1789076261010;
        Thu, 10 Sep 2026 14:37:41 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d3779sm5444196d6.43.2026.09.10.14.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:37:40 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v8 00/12] PCI: liveupdate: PCI core support for Live Update
Date: Thu, 10 Sep 2026 21:37:36 +0000
Message-ID: <178907602445.560913.2482730956380750475.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_143743_324122_8C4D74CD 
X-CRM114-Status: GOOD (  10.41  )
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


On Tue, 28 Jul 2026 22:09:54 +0000, David Matlack wrote:
> NOTE: I am sending v8 out a little earlier than I normally would since I
> will be AFK from July 29th (tomorrow) through August 6th and would like
> to post the changes made in response to v7 feedback before then. I will
> respond to any review feedback on v8 on August 7th or shortly after.
> 
> This series can be found on GitHub:
> 
> [...]

Applied,

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=lu-pci-preservation

Thanks.

[01/12] PCI: liveupdate: Set up FLB handler for the PCI core
        commit: acff3a35a49097424762f255afdaf2a122e926a3
[02/12] PCI: liveupdate: Track outgoing preserved PCI devices
        commit: ced0d433a98ccc33495a985580bfefb62d73b16c
[03/12] PCI: liveupdate: Track incoming preserved PCI devices
        commit: d96e637021905ee22ef75f3608b46287b3d44508
[04/12] PCI: liveupdate: Document driver binding responsibilities
        commit: 4d9305a6938a66ccc1154dc5fa5a8a9ac56eb549
[05/12] PCI: liveupdate: Preserve bus numbers during Live Update
        commit: 8db5cb4011d0ebde5fbadf1236dfcb23bb8ce007
[06/12] PCI: liveupdate: Auto-preserve upstream bridges across Live Update
        commit: a7709b31ea29cb7d65b75beb844e0b92a20d4ab0
[07/12] PCI: Refactor matching logic for pci_dev_acs_ops
        commit: d2cc005d11de82f352e1f30f7b9aa2a4c463dec0
[08/12] PCI: liveupdate: Adopt ACS controls in incoming preserved devices
        commit: bd5970669fa8a2c1bc04c3fa516a0667a090c604
[09/12] PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
        commit: 48928296f529d15ecf66c263f3cc5fc657894e26
[10/12] PCI: liveupdate: Freeze preservation status during shutdown
        commit: 09907e211d2d63cc74f5a00e5949866f1078da76
[11/12] PCI: liveupdate: Do not disable bus mastering on preserved devices during kexec
        commit: 7f44eb94b1a85d2827610726e43de5554795cbdc
[12/12] Documentation: PCI: Add documentation for Live Update
        commit: c08eff447b966b21511c997272612e9665b0bd6e

Best regards,
-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

