Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F0AC87FCA
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yEUJrNTVfNIvacBySzD/xtaOi3Go1shw4gqk3/yKQ60=; b=Vm7lSvJxtkpjbQYNPpcWBHiTh/
	kZ7sYYe9eamN5bWRni3dYeq2AS91GMXUFM3HbnDiXBNGGd3k+2Xxj5s54Oso+QIVEBFamgmkdJx1Y
	UMoSbep57qJjeLE4eQQEr/QTAVZPeVMBIXC537nND6XYDUoJPJH9FKua374giWuBOiyk6wesDlExk
	tquYp8ojsQ0+Yi3hM9G7eM6XI9csw1GAbCxBDsqXrPOkJjXFSPAvtCdfOIKv7aVzq3Vv1yWV4EcVB
	9/L4SEhB8w2vx7aznvmkJg630z+8FJabBFHP9/frfdV5+GkGpXrgHOV0LFmnOtDhEIPwzJcJGEy6+
	sKIC/LNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk4Ai-00000001Dxz-41bW;
	Thu, 07 Aug 2025 17:12:56 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk4Ag-00000001DxU-1jUm
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 17:12:55 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-55b753e2a32so97350e87.1
        for <kexec@lists.infradead.org>; Thu, 07 Aug 2025 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754586772; x=1755191572; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEUJrNTVfNIvacBySzD/xtaOi3Go1shw4gqk3/yKQ60=;
        b=jPaiEd4RH7+2rldxtfcy7FRYfMnN9aE/zKgJWpmXIhgpB1cPzcwWRL1tlVyk6S8z3L
         qDaJAe/NABx7APQml34HEvsLcmJ8ClVkjJQmsl6pzafjZLe03/U6HSohhlywbrG5dNOV
         dS5ti9ovrbnO5+qLfHdZQ0n726XHmhL6XyUixAoEMrw6+v4/l6PLskQ0kh17mZfoG9je
         vHE8GFQvkWnoG3LwSC15HNHh2mqG6qwKpZzx/hncGxiSm2soVbwG/fkgmQVk5HW574fL
         l4cfJxq7deLnyetnllHC9MV5WuC+pBSTk9IbVLHw8DX50VdH7b0O8QtWjPOj6UW2BaaS
         fclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754586772; x=1755191572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEUJrNTVfNIvacBySzD/xtaOi3Go1shw4gqk3/yKQ60=;
        b=OvUoEspcFHkH10LKjnFy7DlOTbDq3beo+9k1De8w0sHeygajpMUM+3jc02BQPCJBpI
         7zCcGavE907B5Sn17iZlj98lMdk7UXC4TOU12btQzm5Wq1npENyMQ57qxu6fzNw3UxHs
         dzXxunPDgSHjt1qvPSEAf5bRHOtb1y1RiKGIMXKFf7TCsZUO+Im719PMnWFxlIX6bPmO
         hyImOLzbuj1PaRmsUiMY0yq32it18t6v9U6bPOTy7mzbGUaY2v5ebDCwxX/9umYk3jMt
         zhS4km/FLD/ARvtmvzwfTSvd8HvVuVMxLDGvsMFM+4iiI4Dnxi2Llt9MFfDZSEhCv9xs
         hQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsaR39gVHtzO5RVi48hwzS+SefqxvsMp3/Qp0QyR2lEp/Mzd8w+xWLtU27XyWqqQqxu7wIIw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzv7W1FxFiMQEgI4jnh8Dm91+S7N7rrHaAWHZe+6zCxRYy/gWlb
	kNelp2lhwuMdyGLWRuHROuhE+dXPnAcxtFHyifHcp5hqvgcJqdrrfP6r
X-Gm-Gg: ASbGncuHzhmIa5ELEnEV2sD81P5nWm+yNLSBFE8ZMhMS5xozaZis7LVpgh3dCMByiy7
	0NlBRjKUIZK5SDAxwJ1SYBRClIR3/u5fWY5+cRTewqIKYXmhYU7S2/ngtaxRQnJIwPzrGtmBMZ8
	szQYkGL1Ckxr6IF3l/WB1EgkvofWpdspJaO0MIby8HEHkNkCtYNs9UMkY7Icq+XngjM09swYnFu
	crjTTOPI/6pDgkUKBphVh14dHDkgawagXwgBfnsR/tSzZYhFAW7GaPPLLqe/pDJOgvELBc+BKiT
	82n6raCnV6m8VR5b09Zh8pGaZsKor0n+RpFbCjVgQ8Xn75efwrqDf+mD0jjLFnEbECyPwYds1qD
	Ks5witlJG3I5Pb+veqsmNZcLXBhdY
X-Google-Smtp-Source: AGHT+IFDp/pH+iVJaWVs5CYee08Thd88h164T2tOnvjWqZ6T+8QyA37ORG7NjbZDbwdSaJmL+/ye8Q==
X-Received: by 2002:a05:6512:3d8b:b0:556:2e02:6957 with SMTP id 2adb3069b0e04-55caf35f712mr1032543e87.9.1754586772390;
        Thu, 07 Aug 2025 10:12:52 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cae595sm2715631e87.155.2025.08.07.10.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 10:12:51 -0700 (PDT)
Message-ID: <c540359d-b609-425f-a921-c7dad3213811@gmail.com>
Date: Thu, 7 Aug 2025 19:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/kasan: make kasan=on|off work for all three modes
To: Marco Elver <elver@google.com>, Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org
References: <20250805062333.121553-1-bhe@redhat.com>
 <CANpmjNP-29cuk+MY0w9rvLNizO02yY_ZxP+T0cmCZBi+b5tDTQ@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CANpmjNP-29cuk+MY0w9rvLNizO02yY_ZxP+T0cmCZBi+b5tDTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_101254_457762_38F65CDE 
X-CRM114-Status: GOOD (  18.20  )
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



On 8/6/25 9:16 AM, Marco Elver wrote:
> On Tue, 5 Aug 2025 at 08:23, 'Baoquan He' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
>>
>> Currently only hw_tags mode of kasan can be enabled or disabled with
>> kernel parameter kasan=on|off for built kernel. For kasan generic and
>> sw_tags mode, there's no way to disable them once kernel is built.
>> This is not convenient sometime, e.g in system kdump is configured.
>> When the 1st kernel has KASAN enabled and crash triggered to switch to
>> kdump kernel, the generic or sw_tags mode will cost much extra memory
>> for kasan shadow while in fact it's meaningless to have kasan in kdump
>> kernel.
> 
> Are you using KASAN generic or SW-tags is production?
> If in a test environment, is the overhead of the kdump kernel really
> unacceptable?
> 

kdump kernel operates with limited amount of memory, whatever was provided 
in 'crashkernel=' for the primary kernel. So it's quite easily can ran out of memory.

By default kdump uses same as currently running kernel, but it can be configured
to use a different one.

At least in fedora it's in /etc/sysconfig/kdump:

$ cat /etc/sysconfig/kdump
# Kernel Version string for the -kdump kernel, such as 2.6.13-1544.FC5kdump
# If no version is specified, then the init script will try to find a
# kdump kernel with the same version number as the running kernel.
KDUMP_KERNELVER=""


>> So this patchset moves the kasan=on|off out of hw_tags scope and into
>> common code to make it visible in generic and sw_tags mode too. Then we
>> can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
>> kasan.
>>
>> Test:
>> =====
>> I only took test on x86_64 for generic mode, and on arm64 for
>> generic, sw_tags and hw_tags mode. All of them works well.
> 
> Does it also work for CONFIG_KASAN_INLINE?
> 

I think it should. Because we don't initialize init_task.kasan_depth we always
bail out in kasan_report().




