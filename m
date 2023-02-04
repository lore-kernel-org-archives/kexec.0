Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEB8C636CD
	for <kexec@archiver.kernel.org>; Sat,  4 Feb 2023 06:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:Subject:Mime-Version
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xFlMr0dogz9NSKYYxo4gEgiZut39WRAFvSZ/fmfIY1U=; b=jPAj3v8yMH2rO6
	has4/v2dZHUiLBtt2j3/4AKG8XRjNox/Horai6dBtCPwW63yhZPqVhrEc1yY6LT+oiAOmUrveo2w0
	Qze7+6EBzBSgFOuwxYlEi7SgJgUiP59j8BHEvvEgF3Pv9WDADLe4vpj+Ije8NDtAzF3uK0qAYxjL0
	E93lBj5KT20IZ8DWPin7e5WRAw7bLpFhQ8uNKV5O8EAm0nXvUzFIgY7mZDYWLjmANH4Euj6sHMrwd
	+pg2h3ZW//zDd0ZWtQaxKls8EW23Fg+MeVjq3mKcn9az0B57Km5pwOpcofM6lcbUITO5xbNi7fCg2
	lfe96xwzfm+agNgnCwaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOCJV-004aG8-N6; Sat, 04 Feb 2023 06:46:17 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOCJS-004aFl-HH
	for kexec@lists.infradead.org; Sat, 04 Feb 2023 06:46:15 +0000
Received: by mail-pj1-x102b.google.com with SMTP id ge21-20020a17090b0e1500b002308aac5b5eso982453pjb.4
        for <kexec@lists.infradead.org>; Fri, 03 Feb 2023 22:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TY5RTQSF5wOJD3pV9s/wHYnsrIWrQcdAYTC5xFu9fOM=;
        b=aO4zwHTPgdrJVwninSB+8FzOWnv4pOjoIY6PNlfn4XpOa85Ydn+IMopnrTrW5R45tf
         RTAFr8HiOJ6HRr+O77O5TcHvkZCU0CAMtbOJENbTRenP05+9Vc0wfAu4J1eJAfSXmMn3
         pEpCBpx2LU7t56HWYvsZkaibxpC7f6I/vh0mvwARyPXx7qOBiwL69LHBWdViCyZYy1vb
         e1aJnUen4Hs5Zm2AgBiZQ8GUM2IkOFA/ZlWlePlHRAB9XbItwaOzcTxCfZp/f+h6zAhM
         9WYDasg0jIDYDfC2sDF/efLnsnKoxLlYPwc/+kG1lO3GnvigeafQOnA144iQ1KRFIz41
         IiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY5RTQSF5wOJD3pV9s/wHYnsrIWrQcdAYTC5xFu9fOM=;
        b=l0dv4hdYYfy3wObJSpzkgFeSo2mryp80i0gtoqgAYDbZSa1MJPjc8Aqt8YJPcEZF+Z
         eTDlva6QWTpjDcq7Ab0J4ZYCM+mz+N+izAxo9R7hqVEi1jo9kuPGHrcgTwbN/IotMH/1
         lM4sVPxH4yDgd2rO/SgnNjqpOYf8G3G9eWBplvi86IxCmtdlTZWtfPurgXNoGtyHEghB
         DTVrQ/nauItQopUb3WClIFZUIJpmKsG14sYiyVOj0U0gcZFIfEQ07B7+BsMIIGvbqFcf
         I0cdmfXys/z9O7b/GopRhcU3VjSKtJ8YK6vrfUjoFyS4/LZYtgdbZdTEf+W6ehjjiYoY
         63Hg==
X-Gm-Message-State: AO0yUKX2s3j5QDPYaPIZMxJy9Uc/LivZok6YRq4R0m1ri9hzB9E9/HdC
	hU1DQR49Ij1puOKFvIrBVuEJ/GS9ATpqZA==
X-Google-Smtp-Source: AK7set9m3m2wBrh91/xgEUka8lvxq67iOAgJslUnz5P0mxjv1Mj0BkQ0bYaLo74g40XN/duz1wuK2w==
X-Received: by 2002:a17:902:ea03:b0:196:5cfe:70b2 with SMTP id s3-20020a170902ea0300b001965cfe70b2mr15178244plg.52.1675493172140;
        Fri, 03 Feb 2023 22:46:12 -0800 (PST)
Received: from smtpclient.apple (cpe-104-32-24-134.socal.res.rr.com. [104.32.24.134])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ab8800b00198f6e1f9f7sm361358plr.232.2023.02.03.22.46.11
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2023 22:46:11 -0800 (PST)
From: Yishen Miao <mys721tx@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Unified Kernel Image Support
Message-Id: <5D04A23B-9A82-4186-AFA8-7E3A0FBBDF86@gmail.com>
Date: Fri, 3 Feb 2023 22:46:01 -0800
To: kexec@lists.infradead.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_224614_610042_F648828F 
X-CRM114-Status: UNSURE (   5.42  )
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

Hello all,

I am experimenting kexec on my box. It uses systemd-boot as the bootloader and boots from a unified kernel image (objcopy'ed cmdline, kernel, initrdramfs, and microcode updates). As of kexec-tools 2.0.25 and systemd 252.5, when I rum systemctl kexec, it returns the following:


# sudo systemctl kexec
Running /usr/bin/kexec --load "/efi/EFI/Linux/ArchLinux-linux.efi" --append "root=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"(null)
Cannot determine the file type of /efi/EFI/Linux/ArchLinux-linux.efi

It seems that systemctl successfully identified the UKI from systemd-boot, however, kexec could not recognize it.

Are there any plans to add UKI support to kexec? Your response is greatly appreciated!


Best,
mys_721tx
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
