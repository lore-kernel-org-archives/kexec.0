Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8AAC4332F
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 02:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=A/E90RUdGBs6W7UVh4rsGR+B9CpjeS9Yj8kOhI61aLg=; b=RARNpYkDPzjaxg
	RwHLoLGonNsTFSbfH+k1gS2wXZ/9vUfIgcvxli3z4EAE29Cwf3XFfM2sCnershYrzzHUtoTdCxKJG
	TAczx37Z1XvEJw141WffwnszktIaFZYgx0uJZCAVrOXAZimP177ihVg7mOLQFKgu93U48bjNVEcY8
	VGuo0UJn1oL9I4wEPb1+bCo3pm+d3e+cZ5PrH6fGSK0QUzXIfLYh/9UTGXmXbUZXCvqUW4qa2T5zG
	f6Z5UeoB69oppr4uiWgOHrDEndahppLeJ+vaVPrlA0pkMGd0d+cmR7MvWXWfhfPw1MhnhWcDUFdJ8
	AHyo96ZpLG5QcQAQ93zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDy5j-001oa7-2t;
	Fri, 15 Dec 2023 02:38:19 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDy5f-001oWd-1Z
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 02:38:18 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c6a71e88cso2648635e9.0
        for <kexec@lists.infradead.org>; Thu, 14 Dec 2023 18:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702607886; x=1703212686; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qAQi20+vSGpECaeGFUzVVGWI33tnksS2uNPlPyTsk44=;
        b=Rh1bO+1SaJHFIoBDDyigT9+J5j1kUebR7ixcLYFuQcyfvd8OY7LbWPhfMJYvYQoUSc
         avudcscjYAQt/RdMEiLkPY8g/FeWljM1pUsRwyv11LVBbdU6I08M2IjyCfM8/Fo+AoIJ
         IqlFtB4JnECShEwsZfS0yc1jmq9NQgg7RwJMoG8BR7bETkt454W4tqcomFYtLA/wht6l
         zO0BXOngciyKJRWgmhcRP5AWD686zgETfhItoHTYlnXfWq1/XTH2+KnmmV5aNFRml+jN
         TxTbJ3vo/+KUEWouEaDUu2XB+58FSrq8UPdl5LZn1qtTNz5/2hr6OJ/Jab5Oz8PgClI3
         gaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607886; x=1703212686;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAQi20+vSGpECaeGFUzVVGWI33tnksS2uNPlPyTsk44=;
        b=uXRNgVXhfh5A2kIe5zuYxCyThGxXwW+ssnun1UonjIweSkCIkszDjBxv5GMHj3N55G
         qRA0K0wdCYCpQFV56Am/1jsGA7ZcZ38qYZ3daa27dHsOMtPf7onuPiXzkuIYkVxqUBRz
         G3LPqRNkUxNmIDlI+2VKdf1MywODpjSwxfLB0lprwRCyt00RPykKEZcJ8qwRbIVM/lGB
         +Wv1rCoxo4NSUHPVDtKm1fYUaocUNqTp5JdLBHmFzRDzVBKRi9xoOf3vDcwrfGX8pZpa
         kzUb7tgxDdCLBbSter1StR5BLZFOZepR86vw1WlZswcqTAUzwPpzXiBd9Q5KodlWgaFp
         B82A==
X-Gm-Message-State: AOJu0YxMkhmA7ClIhtRzyYox5+zmkDemtEOblUn2wAXk8VMyf6Qz+S56
	G2kKSc9LUXt/qxHLH3w43TV45qkwA6pEq2QcQlY1qA==
X-Google-Smtp-Source: AGHT+IFmtgqra5fSU7wTBqwdsFqsWb399+4nFVUJ3RKOW3ODfLwVhODJdlIAfTmyvu361w9QUN3QqXrrMAwJatMEm1Q=
X-Received: by 2002:a05:6000:400c:b0:336:4a7c:f062 with SMTP id
 cp12-20020a056000400c00b003364a7cf062mr1325514wrb.27.1702607886098; Thu, 14
 Dec 2023 18:38:06 -0800 (PST)
MIME-Version: 1.0
From: Chris Koch <chrisko@google.com>
Date: Thu, 14 Dec 2023 18:37:44 -0800
Message-ID: <CAA0N8zYyGKraVW8v3roMNakuJxQJOo3ddsB=e0D_KaD+Ji=81A@mail.gmail.com>
Subject: The conflict between PHYSICAL_START and MIN_KERNEL_LOAD_ADDR
To: x86@kernel.org, kexec@lists.infradead.org
Cc: Cloud Hsu <cloudhsu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_183815_524903_4EE6F6FD 
X-CRM114-Status: GOOD (  14.44  )
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

Hi all,

we ran into some memory clobbering on kernel boot, and there seems to
be a bit of a conflict between the documentation and reality, and
CONFIG_PHYSICAL_START (default 0x1 000 000) and MIN_KERNEL_LOAD_ADDR
(default 0x100 000).

First observation: bzimage's pref_address is listed as "preferred" in
the boot documentation for relocatable kernels, but what is not
mentioned is that if the kernel is loaded below pref_address, it will
relocate itself there [1]. The default CONFIG_PHYSICAL_START seems to
be 0x1000000, and a review of bootloaders shows that in every case but
GRUB a kernel will get loaded below that, and then relocate itself
there. (ipxe 0x10000 or 0x100000 depending on config, kexec-tools
0x100000, kexec_file 0x100000)

This means in all default cases except GRUB, the kernel will relocate
itself and decompress in an area of memory it was not intended for,
and which may hold reserved data in the memory map. (This is what
happened in our case. It was clobbering reserved stuff.)

This suggests the following:
1) This pref_address behavior should be documented in boot.rst.
Something like "A relocatable kernel will relocate itself to
pref_address (which is equal to CONFIG_PHYSICAL_START) if it was
loaded below that address."

2) Documentation for PHYSICAL_START should be updated. It states

> If kernel is a not relocatable (CONFIG_RELOCATABLE=n) then
> bzImage will decompress itself to above physical address and
> run from there. Otherwise, bzImage will run from the address where
> it has been loaded by the boot loader and will ignore above physical
> address.

3) Some patches should be sent to ipxe, kexec-tools and kexec_file to
respect pref_address as a minimum address, not just a preferred
address.

4) The default values of MIN_KEXEC_LOAD_ADDR and CONFIG_PHYSICAL_START
should align to reduce the chances of this happening for users who
aren't messing with these values. Given what current boot loaders do,
should CONFIG_PHYSICAL_START be lowered to 0x100000, at least for
relocatable kernels? This might be the most controversial of the
changes.

5) Should PHYSICAL_START be ignored in relocatable kernels like its
documentation suggests? Is the relocation above that unnecessary?

Regardless of which change we make for the future, existing boot
loaders & kernels conflict in their behavior for relocatable kernels.
What is most likely to fix this issue for users & prevent breakage of
existing workflows?

If I see agreement on 1 to 3, I will start sending patches. Would love
to hear opinions on 4 & 5.

Thanks,
Chris

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/x86/boot/compressed/head_64.S?h=linux-6.6.y#n333

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
