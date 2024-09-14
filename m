Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81433C02190
	for <kexec@archiver.kernel.org>; Sat, 14 Sep 2024 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SXbwQNrfFFKNvzN6aetbVQBwvNqzJppwSUg9h6i5/ko=; b=t1NR1pq5jwJhBF
	XJ3/Ib5eg/lOtsZ6XJTFrqHADCMSzIYeaA/tBGNxxM9lraQZfnC83lNCwRYZfENYURZMmfMueuelL
	cZDNtxFTaTp/LYQzveRKPU+tkVxNmKX3VUuxIAm1K65BPSa+oluF1LDidivw3BrhOSI3i10kzdKGs
	wuMPWrQlSFLFxSVGpRdi4Jmdfk8syPb7r2X1ppGOKaQfaVJItmifnN88aDH/UQglPSDF04TinzKXX
	vH1uB0czg7wOBMR22RUQTqu4MoYvImHphYpjQ7kqFUWh6izzOtj2G2WxJLFmVf8nLJiu1H+lzsBM9
	PnmMlnWPy88FXSPlu7fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spQe4-00000000ZmI-1SZk;
	Sat, 14 Sep 2024 11:08:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spQdz-00000000Zle-3WsH
	for kexec@lists.infradead.org;
	Sat, 14 Sep 2024 11:08:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726312125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5hWv2p2YsLipAZ5vTTG2ulS62USpNXTSCdiYtz6i4es=;
	b=Tu+HMbC9MQhYR7Pw6HPyjonlV/owaJ6acsmwEg8JdcfWzk5vTO/Rov897NW3FIQ7q5qbNa
	i/Mpi//I/579gEycpP+Oophw8oQxGtUIGnGEFtxtcYFPyJNEHaForu13kZk4a48VQZJXGh
	CiUNq/3p0jafeUAuN8mYE6S1lTc9WMA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-2zku8UpANBi4RvT1qDMfbg-1; Sat, 14 Sep 2024 07:08:43 -0400
X-MC-Unique: 2zku8UpANBi4RvT1qDMfbg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d28a70743so52326935ab.0
        for <kexec@lists.infradead.org>; Sat, 14 Sep 2024 04:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726312122; x=1726916922;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hWv2p2YsLipAZ5vTTG2ulS62USpNXTSCdiYtz6i4es=;
        b=jHYl0o4hIaA0qU6Rapxc/wn7v9Zf4l2Dji9Al6bj0QjXcdX6pvlPPUYpx0d1KjmHRN
         n+NcQej3uo/FiX6U7wJ8UbK/CQR/fKkv7bdYNY+SqJxZ98qwmzmZyTYQlAFmJbWufzOv
         My2ztBz36ZEbI/+Ivurbtms8Gvzv+UdN3buhERaQRgyTUcxs2gqw9GScTmyiUraRNqme
         qc8GfIF29oIqR74mmaFTgmVlc7+7SzByHvXw34U0ok9C6th1tvcYqOqiUdNnPiO+QMZD
         8t29At1RL9vL0yEB7DZC0scVkSXAWvwVxjyoFyKEVh8pNwqW5ZWjd5H5drEFSyfTdn1g
         XldQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjPcSAjcy6q5hfCBF2a4gFH2W3hUNgfgR/OkMD2Q+7FC3bQPy9jOqFtUhPrJKu5Mnan1KXsg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwaPLsUoiPWC00/3FzLYrLIfUybfd8dc6jI/omZzyj0sQwJDk7A
	C5LuTKdD3P3qg65F/hOh9wPS8dEVnVV4bWvHwod78EyQrpFXlqszSuThXDJ19EgPuyMemGIQUHc
	z9n+hpDcBKlGbCapc+WqCugIlTlCnrek9h0RlP/dd4dpQzb7ZmrTp3nzOrJslsuWEpOtR2sXhJo
	UsjGRN6V9fb1TSfRis/SqTMQaYHR+peYPWKamiLYiR468=
X-Received: by 2002:a05:6e02:1d88:b0:395:e85e:f2fa with SMTP id e9e14a558f8ab-3a084611b38mr80010865ab.1.1726312122586;
        Sat, 14 Sep 2024 04:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLEgZRYuK78TvhEpzPipQjXBQpjmz90/JWHNwPzBDfQVodpJaRcUvzxokERl4ytbOKVYQGFjB3CUpDJ2OizQk=
X-Received: by 2002:a05:6e02:1d88:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a084611b38mr80010695ab.1.1726312122279; Sat, 14 Sep 2024
 04:08:42 -0700 (PDT)
MIME-Version: 1.0
From: Dave Young <dyoung@redhat.com>
Date: Sat, 14 Sep 2024 19:08:51 +0800
Message-ID: <CALu+AoTKBRGgZW6JK19AV6QRTi7_eCzJbh9JCKENxsL7t061rQ@mail.gmail.com>
Subject: question about RMP table fixups for kexec
To: Ashish Kalra <ashish.kalra@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240914_040847_982138_2C726F58 
X-CRM114-Status: UNSURE (   7.78  )
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

Hi Ashish,

I'm reading the code about E820 tables related code,  I noticed with
below commit you updated all three e820 tabes including
e820_table_kexec and e820_table_firmware.
commit 400fea4b9651adf5d7ebd5d71e905f34f4e4e493
Author: Ashish Kalra <ashish.kalra@amd.com>
Date:   Fri Apr 26 00:43:18 2024 +0000

    x86/sev: Add callback to apply RMP table fixups for kexec

...

+       if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
+               pr_info("Reserving start/end of RMP table on a 2MB
boundary [0x%016llx]\n", pa);
+               e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM,
E820_TYPE_RESERVED);
+               e820__range_update_table(e820_table_kexec, pa,
PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+               e820__range_update_table(e820_table_firmware, pa,
PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+       }
+}

A question here is, have you tried only updating e820_table and
e820_table_firmware?

I do not know much about SEV,  if you update e820_table, then the
memory range will be reserved in resouces, and kexec will not load
segments into the reserved ranges,  during the 2nd kernel bootup  your
code will be run again so I assume it is not necessary to pre-reserve
in e820_table_kexec and passing to 2nd kernel.

Could you confirm this question?

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
