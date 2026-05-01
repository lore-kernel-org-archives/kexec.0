Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8D2CD3427
	for <kexec@archiver.kernel.org>; Sat,  2 May 2026 01:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n0E83EgdT3ony/VkYAJeXhWQa6c3+LcyfrsSsEshuFA=; b=PjQ+r7Q80elMCq83YuS21cxNws
	nzTPbrdBr9SYKeLBYDa6aD8vW1uPDMERbfy9KBt6+vd8nSmTMiQw+i7DlRiHvp6iH99ax/WS5MQsb
	r6lCZH36jvESygIWqbCOOWoYyGINUJTuvhbyTcfHKD91QPbv3jt4ZRtMtbnuWUzNY4ny5QLoUQtyl
	X4mxTewLTIsB5+3dEnipGT5bNDoKg72wvb++tMNNOeztjk1ofKGqp4Uzu1Q5ExDY321rYga4+Q0hP
	Mcoh9c1Pfv6iAeIshxcOArZwezmLAfbzCB+tXnF4t3TuXZ5iRy3vPjf8LeuUWgADzwHjEXfEwzqjd
	XXRY5lhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIylB-00000007xck-25LM;
	Sat, 02 May 2026 01:03:09 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIyl8-00000007xcG-10wg
	for kexec@lists.infradead.org;
	Sat, 02 May 2026 01:03:07 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so1119668b3a.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 18:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777683785; x=1778288585; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n0E83EgdT3ony/VkYAJeXhWQa6c3+LcyfrsSsEshuFA=;
        b=mXbYbx51BWz9F4Tc/jYEk9KxFsGpmck+0qQwV4anu7w+InSzsYnsYS/cwif9euXrR+
         K+mtwtUxJyzQgphcuUEmrDypZBxi4lxloGcSZUbO8Xe3EIE2IzlpppSBNkqsKZRbjWf9
         TeRgTRQEYA90KfpZjGlG+QfB6OAQpMo9cq5BaKf0LmG0OtN874Qm3c5OLjAO4OG1+GU8
         cblZLtAjO0ccDFcRup7DYGCaveZTrWDv34xkRYU9RYaQmne4lq4TpJL540buVHyXVp5j
         PpiDY4Z0Cch+9bzGDxDC95OxQpJTCT7xz63+bbLxurFWoKC0hye+i6EOIisACI1/eplU
         UT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777683785; x=1778288585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0E83EgdT3ony/VkYAJeXhWQa6c3+LcyfrsSsEshuFA=;
        b=iSe7u57TMjjNVZOxxSESZl7o7hYhadjs6rgst9NWzwSZBPRerFjF3kTcgDM2QXasIx
         PRpGK4wle9U7oXJbQEJQ260FNOme1rNb4ILpn2aPy994o8OKgq1e2fLZokC0N1BIFvtx
         4KbtWncDfljnTyjgc1AcuRacp+WDuHtPsgvXBqoixzEUoClv3CEPc5OqJw6bS8Q0A1iC
         nvsifTy3X9/DkunAIaKlL2+q7qgAzc/HyUj6ZMQ+blHHD6z9Mvpep9wibGrDiMzETd2m
         e0jFaVHe4DMARGC9GahRew4ZHMJxfNy2vjwsmq6PdJg1zkx4K0J1Y6qSSdAhPf0a6jXK
         3jag==
X-Gm-Message-State: AOJu0YwRpRUkZPyda7Pz/uP4liSTxBIH96DFn0UgzB8/J587WpeNhK2V
	7VXGKcV95Bwhvvz1m7ipduuuLbuLW43W6D4hW6PFSwO8Lt2c6RQs8g8v
X-Gm-Gg: AeBDiet1JIYD7Ue+iCfEcM0wLQOAgjNX/iNQiixFop+xylk5o9jPCbmShUSKn2aPQTS
	ywbctizF18kD9a7rpKjy6thzfaGMoZ9LHbcAx5RogfgRvFqfqgVuwPnFXOOvRNJZkpUca7Cft+8
	8GHeccIsGCq9DClvMO4leZbzuk7a50vqyOdnybmlZSGRoQhJVsOcTcwYN4poJyy17TFYj1vanHQ
	d29vcHJtmzl9u1Z87WyC9sB4BBn+o93Xk78qMZ7MRY3KZskQ6KCfzk+rgjkPXt2jJujrL4VJqmp
	DV8hBubcb2iKzjIc0jVHreZHbtBMB+8ujLkcOfkIqLFCU1y3ftqDJpbchqzmYRaLtIn7wPJloSS
	4gYPViGTpQaNaR64XiCxMmpfo1Cx5N4jfGKX+rB9r7b4uYEHjqc1E+sAeQ9a0+Ol5l/22628rTL
	Lwqhqf+SqqBUgdlVlJV1jXev26jK5ZAKX5bXPHNmF6
X-Received: by 2002:a05:6a00:9515:b0:82f:aae5:c7a9 with SMTP id d2e1a72fcca58-8352d26c18dmr1257773b3a.27.1777683785129;
        Fri, 01 May 2026 18:03:05 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b73affsm3743556b3a.55.2026.05.01.18.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 18:03:04 -0700 (PDT)
Date: Sat, 2 May 2026 07:54:05 +0800
From: Coiby Xu <coiby.xu@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <afU8HsdlkQo0oM00@Rk>
References: <20260403100126.1468200-1-coxu@redhat.com>
 <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com>
 <adRIwaLxqIoIDkTF@Rk>
 <401693ba-1455-4b45-8596-b81625f01201@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <401693ba-1455-4b45-8596-b81625f01201@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_180306_305942_1E4A92E0 
X-CRM114-Status: GOOD (  12.44  )
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

On Tue, Apr 07, 2026 at 03:29:18PM +0530, Sourabh Jain wrote:
>
[...]
>>>As per kdump.rst, restore was introduced to handle CPU and
>>>memory hotplug cases. Is it needed when there is no in-kernel
>>>update to the kdump image on CPU or memory hotplug events?
>>>
>>>But in that case, we rely on a udev rule to reload the kdump image
>>>again.
>>>
>>>I am confused about when exactly we need to restore.
>>
>>To clarify, reuse other than restore is needed for non in-kernel update
>>when handing CPU/memory hotplugging. Yes, a udev rule is also needed in
>>this case.
>
>Below commit explains how the reuse is utilized:
>
>commit 9ebfa8dcaea77a8ef02d0f9478717a138b0ad828
>Author: Coiby Xu <coxu@redhat.com>
>Date:   Fri May 2 09:12:38 2025 +0800
>
>    crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
>
>It got it now. This is helpful when kdump needs to be reloaded due to
>CPU/memory hotplug events using the kexec_file_load system call,
>but only when CONFIG_CRASH_HOTPLUG is not enabled.


>
>IIUC this feature is not support on crash image loaded using 
>kexec_load syscall, right?

Glad you've figured it out!  Yes, you are correct. If
CONFIG_CRASH_HOTPLUG is enabled, there is no need for configfs/reuse. In
v2, I've improved the doc and also added a patch to prevented using this
API when CONFIG_CRASH_HOTPLUG is enabled.


-- 
Best regards,
Coiby

