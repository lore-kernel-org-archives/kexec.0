Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4ECC433FE
	for <kexec@archiver.kernel.org>; Fri, 14 Oct 2022 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8A11qBai111xhtLBf3GUlt4BhIcdkyPa/mKjvtVP4kg=; b=LanqqhbupOaBxV
	ClpzkEDDkQJuq52oTZGf4+uitRtoBp/UVJO4En//pU6tNUDRC18F36KSWBVaSi43orXtBHE1nqKRv
	jV5KtKP2EQo9Qg6e418mo3pSXySKvDYF+bGWPh8Iwd2SzVUwnaAc5+fXhxX2RVfVvbPP504wsp3WS
	ADvBOVtaVfiPgl6x5Eet6VUAzfDVtsHlEXqGGiRlIIWtTlmU00B27JcjJFfj1CjS2CHhbQnLMh9gS
	gYfbFLiwuHDkHFm7EeRDoYl37CRoxJHVrDNDSIbbpUsOuyKrPGz2UJqGzNLTdm0jAb+v4ud/3UX6A
	O39CJG1BwBMSTrYhy9qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojKf5-00El4j-61; Fri, 14 Oct 2022 13:23:39 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojKf2-00El3U-Ik; Fri, 14 Oct 2022 13:23:37 +0000
Received: by mail-pf1-x42e.google.com with SMTP id p14so4903804pfq.5;
        Fri, 14 Oct 2022 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4xjddBFiOmnGZiEUX+Vkve3fnj+3YiCzJcAITektSg=;
        b=poRwLrKa8hytQgqfDrCIrlZsIKc/WjHdmwh5WVCOLwwN5YTtz0Sj6kNQQfbTZtVsyo
         iHncZ6EQWssbnwHf1jWsb0BjS5kHSBMH6eacY0aisCxYT+TAqpafPfK0qsaPAanoG3N5
         4pzcJr6YeJ9C4ip+7tEKw+Hm0Cz7HUUxjnhgqvqX9gqmuDFEBzkh2SfwBFMpmdAhpIO8
         7DOshSJ9Y9PKsxRnUWBcJK7J2IbQmUHrM5nbu7HFCmJEQywaVU83Gi1hhRf+xAK2hsjc
         HtW0I9BQdcsLYJabD/FLJdmlGOEKMXFzgWP4pyvlWIGBvolmvingHAasKl43QnbIQWCf
         VV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4xjddBFiOmnGZiEUX+Vkve3fnj+3YiCzJcAITektSg=;
        b=R5ElF2oIyKwVMXfh8SPWeKUV+D6h4h3F752XaGHsH7O5SX/XvDAbVpIM2582PG63Vv
         RziE5ncAh/qBXrqe/jCbzaWiaUPkhR6dXHv7cb1nUjAab3K6A+6MBygfHHfnXsNmYC4r
         yGyE8NR7rb+YGX2yIyCQD04m7C5L1j5aTrYeHntJIoPw6R3w0MF52Qi36YjQA4EF3dAl
         PNCmMQO2jQDWhBbj5FwnPYRp/sYxMNSO7pYFLdmgWTySL+jZ/qzJS7eLs1qfjVxw9Est
         a7iosIvfeTsTc74F7cVSsRFHS15visLiBBZSvrhUbLc6EXJwzcTd+1V0Ieq9FBWkCC6R
         Oqww==
X-Gm-Message-State: ACrzQf127qthHndYjCQHZUtsO/MR745pwlj8qhl1XH5zbOGRLa35Diz4
	BJpxrxQFRdxxqCwvLo92Jxw=
X-Google-Smtp-Source: AMsMyM47NgsJUD3wlIBoNzJ/JovZeZncfRVPxI7Qv48gn0JbBAbhB6rbDZS5KFk4nKXRKDgbyhfZPw==
X-Received: by 2002:a63:f07:0:b0:440:5c6e:5833 with SMTP id e7-20020a630f07000000b004405c6e5833mr4625962pgl.375.1665753814898;
        Fri, 14 Oct 2022 06:23:34 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79852000000b005631af4ece2sm1665778pfq.182.2022.10.14.06.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 06:23:34 -0700 (PDT)
Message-ID: <7353e949-17cc-ed8e-7e98-b3f3e0840623@gmail.com>
Date: Fri, 14 Oct 2022 20:23:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] Documentation: kdump: describe VMCOREINFO export for
 RISCV64
To: Conor Dooley <conor@kernel.org>
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
 k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221014074810.4471-1-xianting.tian@linux.alibaba.com>
 <20221014074810.4471-3-xianting.tian@linux.alibaba.com>
 <Y0ldrJ91ac0um3++@debian.me> <Y0lfuixXue4k4poY@spud>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y0lfuixXue4k4poY@spud>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_062336_647269_0F671FD2 
X-CRM114-Status: UNSURE (   9.71  )
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

On 10/14/22 20:10, Conor Dooley wrote:
> Without whitespace highlighting, your change threw me for a sec.. But
> yeah, having the overline is inconsistent with other headings in the
> doc.
> 
> What I wanted to ask about was the linelength as I don't know anything
> about rst. Is it possible to avoid having the ~150 character line or is
> that a necessary evil?
> 

I think the section describes correct range exports; however since there
are many such ranges with distinct purposes, it is better to split the
section into multiple sections describing each range.

If we go without splitting, the 150-character header is necessary (I don't
know how to split the header text line without trigger any warnings).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
