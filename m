Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5D4C19F2A
	for <kexec@archiver.kernel.org>; Thu, 11 Aug 2022 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QJC0FeGI1N7VP9M15fTTJTm3nBIr+5IruaCDhYd5/g4=; b=f3CohxV0Zn1hH6
	5iwzxKVA3hiNi0tn9jmy7F4tYbfbNpcqE1xGA7JL5m1ESM3juEjMEQpJD0yEWZZ9ctbt1HlgQ2+m2
	P+9DdcUnjW8inNuvqy/vO+niaGE75JaDNcNepA5pLy3eLg7nt1tdh28T7nH8aMmF3Q+ZdNbLZ5pUA
	N3ueqwW1kCdNyfhWdDhuUSIAWJy7GEPVREScYNxBS1OnLBAQgK4TscyGrxsVYOSDdib/BVxjv7J/Z
	J9iIXdAb5uTHtX89GQmb31yrlZi/i/P8ktptuAjLUBOqNTtrFw3jepj3bGc8EtjC7W4GbQa0qL0MW
	+rwp5pC7hrQs9yX2ug3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM8Da-00CdQ4-LT; Thu, 11 Aug 2022 13:27:22 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM8DV-00CdLj-2w; Thu, 11 Aug 2022 13:27:18 +0000
Received: by mail-pf1-x429.google.com with SMTP id 130so16447378pfv.13;
        Thu, 11 Aug 2022 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=cnf/MAxWiWhTvww3StaIlwbuuIs/IrBQv9ORD2Fnzb8=;
        b=hhPtoXRk4+PMkZG0gZrNZYrmTu9yA5qnBlJW/2XP1icOeQdYBgKVgkMbHgOpOKC57a
         fc/S6afY1H/glfIdPydeAvLShJHuTnYm58U0zvqTKxx4wi6lWk98E4Pg0+2hjd9P/GPg
         i5R5cAmbRMUyTI8diaSBjd6o90JhNnWjlOuTi+k9x9W27uMu8ibnrboZIunXU2w4xYtt
         uebnfFQBZJELurcjq5g+4gCgW/r5rqUp2RW7oWtVDrz0iqDCauBtgPOuPS6q4WjpWmMO
         m4Z7PyO5A7R8KtrQobFQ0BstZLgzzW0Zhd9FepB7/OfA0ywYwdtBdM3UUUIsgitDlpiN
         K9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cnf/MAxWiWhTvww3StaIlwbuuIs/IrBQv9ORD2Fnzb8=;
        b=M4p8EjZUIy7mfodmbbqJMz0519zOY/Es1y/vtaz61zttC9pq+DU0rF+eBio0MlAOPq
         XOljPSIIe7F+lWla9+bmjXX7K8QdL43B9dGjNPltnRQdg6Zdyfca/SJqxOCizlciTu+y
         I6+G3tVnendcStmYsYm2Wp1mDnXKZFqHajWQI96p0WSVpgBK4Uk74AR4gXxPTvCQB76W
         uH2SwJcVMx3CLJUYRtbq8xpJcvOcUaheEQbmk7lid6R7zxUAu5v/kKUd+Ei79Hv2y6lJ
         y1BNtvINBX6Q1KCCLmJR+SmYlYZypMR++Z5tchxxSEr0G5zfMG1XKCldMQjQZAKKGbvf
         5Cgw==
X-Gm-Message-State: ACgBeo3+uk8BngONRWwg9fOjfTrtvXo62QAQg/MF4/jlybYDEv0YjhCM
	zJ0WjdhNbzT0bodXlAiz1W8=
X-Google-Smtp-Source: AA6agR5HAInDscx1ZEMqvtifjzDB5GvCTp7d9zggxvQzL5N6SNN9kA68Z6Wvry9fG8i2/7CjEkGCOw==
X-Received: by 2002:a63:8a42:0:b0:41b:dddd:b81f with SMTP id y63-20020a638a42000000b0041bddddb81fmr26717842pgd.229.1660224434107;
        Thu, 11 Aug 2022 06:27:14 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-16.three.co.id. [116.206.28.16])
        by smtp.gmail.com with ESMTPSA id x130-20020a628688000000b0052dd9dbe291sm3972954pfd.105.2022.08.11.06.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 06:27:13 -0700 (PDT)
Message-ID: <f2336f93-53b4-b031-9e1c-67b6d1470f64@gmail.com>
Date: Thu, 11 Aug 2022 20:27:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V6 6/6] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
Content-Language: en-US
To: Xianting Tian <xianting.tian@linux.alibaba.com>,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
 k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
 <20220811074150.3020189-7-xianting.tian@linux.alibaba.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220811074150.3020189-7-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_062717_154367_CBC64EA9 
X-CRM114-Status: UNSURE (   7.58  )
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

On 8/11/22 14:41, Xianting Tian wrote:
> The following interrelated definitions and ranges are needed by the kdump
> crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
>     VA_BITS, PAGE_OFFSET, phys_ram_base
>     MODULES_VADDR ~ MODULES_END,
>     VMALLOC_START ~ VMALLOC_END,
>     VMEMMAP_START ~ VMEMMAP_END
>     KASAN_SHADOW_START ~ KASAN_SHADOW_END,
>     KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END
> 
> This patch just add the description of VMCOREINFO export for RISCV64.
> 
Better say "Document these RISCV64 exports above".

-- 
An old man doll... just what I always wanted! - Clara

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
