Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D06EC02191
	for <kexec@archiver.kernel.org>; Sat, 14 Sep 2024 11:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cvuxxN1oH/e0K9CBrYOTqmj/Q8w30OyPIVHW+msbJxQ=; b=awY5hat1mA/UaM
	imDkM6geHZYDu0YTfk/6M0z2jC6DrCd07c4z1GV6hCc2LounW09FdVkdGR9Tf/v9kncsJwb1SQv7a
	A1VnEzEmUBW8l/oUVKlJV5GpON/b7GqZcjfs8S6nSpn+YkXddRD8v2bD8BAEEuw9JVGNsyfwqtKHJ
	rC9V/1qjJxd+ZzDIyNuBYjPhCvvHsI73lWmqcsL71s29AWO92A85PnoG0Iv4fp0qwTE9W1Za0Mc6W
	m4P7IjU1WRSiTXn8U5hXW6yRWFP2ObHJgCutCgILReGcrq/bFyKazXmuhX+Ae62o6YsL22G2ve+yx
	4T6QlLRHVBjEbh9Zlt0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spR3q-00000000c9p-3cCw;
	Sat, 14 Sep 2024 11:35:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spR3l-00000000c8x-44dI
	for kexec@lists.infradead.org;
	Sat, 14 Sep 2024 11:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726313724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDWzsATt7aJa2rBgBdkq6jbTGGmqY54BlI5F5qY/RY4=;
	b=UMTrj3cqlDhMo7EsdqC406BmjbtUwr0Tf+Zx9oFTyFx9E0droA3zNLOOWMtMfQrLr4keH3
	1fiiSQVhdGybmCyiTE76Ry1YxbtG+3L2TEZjdyIi2+/DJajY1LqNhx29mdJ7BPkNkNab1a
	tEIZ3Dcv59iOKX5chUA1IK6NAoRdMDM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-DAThRQeHNFGm3D6daBao4Q-1; Sat, 14 Sep 2024 07:35:21 -0400
X-MC-Unique: DAThRQeHNFGm3D6daBao4Q-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82aad3fa5edso519357439f.2
        for <kexec@lists.infradead.org>; Sat, 14 Sep 2024 04:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726313721; x=1726918521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDWzsATt7aJa2rBgBdkq6jbTGGmqY54BlI5F5qY/RY4=;
        b=sP4JwTyKmSEJJwK/e0xn2eXO5zTO2UsfPF4waRm548Te+3Ybn0myQFJvD/g1nKr+bT
         NMSi+1ZsyJ7D37BIBB41jFOkTXYqUzrmw9jlUtytbAiVWCRI32J/Kk1h8TkaMzWQv2QG
         zn8nBFHrD9HQK5+ltblMdBuedFDIVx2bINLFcTYdYiDnsDdK7h8YdOaJS5ySfvF/cmkQ
         zfgR2pu7s0P1H8FM1twCd0XpcXbVx0TPUyaUdGGGlVam1k0mSOIIRMOG2JBuYLdDbsLe
         gC/jFAm4+JKmzMzYvcHKgPhpeKyMDv2CXe/gFmpbIYT8ov2uRiGm8+5Gu/koTBkbG2aF
         CJGg==
X-Forwarded-Encrypted: i=1; AJvYcCVk7+YVCBvmnNFVKS2uH7QOYuMS9+c5nBtR08yCjBUdiT+wsrewIBpz0cj7SkFned7ifxm2bA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+8H3ir9KvjqGhNcb+udiTZ43VFiET+0ILz3cQPH/CWu4ohoS0
	xPoXL+JXnTFFuom8+CVBEzE3thGrROtBlnBToHXyb/gnlceb53+U1EP8wNQ5OMpyzccgoeX6q3m
	fxw7mnlwcRfVyxlyU1a6OIIeEQG3CSmMQ/q1N6oGS7mz/ablMHzObxa0/avNRxrau7lkX9RjbZk
	kt4uW61/jxoZAvLpPovRztya8oAA6oS9HB
X-Received: by 2002:a92:c24c:0:b0:3a0:4b2d:78d7 with SMTP id e9e14a558f8ab-3a084911895mr104421515ab.13.1726313720862;
        Sat, 14 Sep 2024 04:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7DdPLXzBdCIfP0PRwTULiAqby7AgynlJb43d5a8t3nN14uLk0BXzE5/S/B2NkhXok8GSnQEvt9O0sSbVkHqY=
X-Received: by 2002:a92:c24c:0:b0:3a0:4b2d:78d7 with SMTP id
 e9e14a558f8ab-3a084911895mr104421265ab.13.1726313720517; Sat, 14 Sep 2024
 04:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
In-Reply-To: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Sat, 14 Sep 2024 19:35:29 +0800
Message-ID: <CALu+AoQyGN2m1ss7GSPCn5UqiEWb+M5BK9MStzMn64k83egtQg@mail.gmail.com>
Subject: Re: [PATCH] x86/e820: update code comment about e820_table_kexec
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240914_043526_108130_941E2447 
X-CRM114-Status: GOOD (  25.01  )
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

On Sat, 14 Sept 2024 at 19:20, Dave Young <dyoung@redhat.com> wrote:
>
> The setup_data ranges are not reserved for kexec any more after
> commit fc7f27cda843 ("x86/kexec: Do not update E820 kexec table
> for setup_data"), so update the code comment here.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/kernel/e820.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> Index: linux-x86/arch/x86/kernel/e820.c
> ===================================================================
> --- linux-x86.orig/arch/x86/kernel/e820.c       2024-09-14 10:39:57.423551301 +0800
> +++ linux-x86/arch/x86/kernel/e820.c    2024-09-14 18:56:30.158316496 +0800
> @@ -36,10 +36,8 @@
>   *
>   * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
>   *   passed to us by the bootloader - the major difference between
> - *   e820_table_firmware[] and this one is that, the latter marks the setup_data
> - *   list created by the EFI boot stub as reserved, so that kexec can reuse the
> - *   setup_data information in the second kernel. Besides, e820_table_kexec[]
> - *   might also be modified by the kexec itself to fake a mptable.
> + *   e820_table_firmware[] and this one is that e820_table_kexec[]
> + *   might be modified by the kexec itself to fake a mptable.
>   *   We use this to:
>   *
>   *       - kexec, which is a bootloader in disguise, uses the original E820
>

BTW,  the conversation below drived me to read the e820 code:
https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u

It could be better to clean up the e820 tables, anyway the comment fix
in this patch itself is good for now.

Basically e820_table_firmware is used by kexec-tools kexec_load
implementation,  e820_table_kexec is used by kexec_file_load code to
pass to the 2nd kernel in boot params.

The e820_table_firmware is said to not be modified by the kernel in
the code comment, but this is not true, at least the sev code updates
the table.    The hibernate code generates crc32 checksum and verifies
it, but since AFAIK e820 table update only happens in boot phase, it
will be stable on runtime.  So we can just use e820_table_firmware for
kexec use and drop the e820_table_kexec. With the change the
kexec_file_load and kexec_load see the same memory ranges.

Otherwise I thought we can use just one e820 table, dropping
e820_table_firmware and e820_table_kexec, but then there will be
fragments and memory waste  due to the setup_data ranges are reserved
and updated in e820_table, so the e820_table_firmware being still be
used for kexec makes sense.

Anyway I need to think more about it,  please let me know if you have
any concerns.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
