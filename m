Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CBEC52D7C
	for <kexec@archiver.kernel.org>; Fri, 23 Aug 2024 11:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zoip7BoHm3WphC55GF8qvQWg+FFUI3hvRTiva80KKAU=; b=b/F6F98uk+PLN8
	E4c3craaKRkUhAGHEpfKcX8NAqZmYvDXmTBxk3jKb9ZcP/mNXQxDL6h7O3ElkkIM6egD4r5jB3N3i
	qApd8PHErKjLwjaFL1zmc8MVknQoRGlgXri2nVgMNAYvokFsbbHKHw1W+wx6mLoT4UNIaWKpahAdq
	oLm4JnTimcWOTtZlL5DHscsDji9Et9NhXJ/gfk7rmb/SScd8m3NeKJ62UmpjIjSI+Nq8LqKk73FE3
	rh+2Fr2QK4OoBKNsCsqB61RKmCuYtssjjT9kedWeEW/XChnl1a7kqMR7L+HhiMN+NuFDiwMt2yuXp
	JbfXiIks4w8v2LmRtfWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shSwr-0000000Gc0y-0IBw;
	Fri, 23 Aug 2024 11:59:21 +0000
Received: from mail-vs1-f51.google.com ([209.85.217.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shSwV-0000000Gbui-1P8T;
	Fri, 23 Aug 2024 11:59:00 +0000
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-498e1fea1a7so605923137.3;
        Fri, 23 Aug 2024 04:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414338; x=1725019138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOuGLLp2dNTeHW8uT+dUzwnOGJ7gbf7VhrhQyr4Xe6I=;
        b=IqTCxp62XSIs/aEN+vxDYYrucBU60dhYetUM9jIz4IYOfe9i07z3QWhFYZZykmqaPI
         4Ue789RgHxNHftCNKMI7+wo7ikQzmFrX3kPUzuPyJmFgqyeYzQ0SzU5wg33EMlIlW+4H
         aB2QTCi8ZyDzlbz6Ak9y4V+YtV2jXdW5p/0Vcq/gD89gUNHbvCQ1En+M2pMPcapt++8P
         gY+iJlzAiMZO9Yc/nWfacPj0aIPagFbvWRpX1Z8NucY/P4L1NZ/8l/YjQ/OwDWKMLTrn
         ms2+ula6x+pMDR6QMqRDUwfQRikFl1UhwNVN5aXJ7f44k2Ye0ANggwf/8NXD+lzEhtL+
         flmA==
X-Forwarded-Encrypted: i=1; AJvYcCUd8+E6RvnaZne8v2GmPqjePHJ4auBx1Hssp39dUbnYexr9w+XFsqEhf0lZHk2W/yPHfxrCGTQiS/H0BGo=@lists.infradead.org, AJvYcCVP5aKvk+QUBAqGHPUjTEJziw4TUXGXsQA/dWrNiQFm/ziTf+1eRn8EXUjBVgVmldLowEMOtg==@lists.infradead.org, AJvYcCWoXDt9BpIPZn/8IcK/Ol4ktx/z5xkBykmDnOwhBnWJF6KrIAUIQsVyiuY0WhQ9DHmer+w5AdJzXt2UA8EjHrJqsQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyADTVBZ4g4aEe/D9WV0iC6C4V30TCv+5Qb3XJXwtMf+i4Fhs7c
	ZazuZKf1grlwtYl5etM80WvfTFq25qnClcxZTcVz9Ittt+1XRxG1
X-Google-Smtp-Source: AGHT+IGTnsj+vzaB6DUYSRe4ILJB8y8mubsJfwnJ5TjC90dt1P9FzBdqUNam7n18s/aSRrNdBhBpzA==
X-Received: by 2002:a05:6102:26ca:b0:48f:40c1:3cd0 with SMTP id ada2fe7eead31-498f4633bafmr2258426137.12.1724414338017;
        Fri, 23 Aug 2024 04:58:58 -0700 (PDT)
Received: from [192.168.2.219] ([65.93.184.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d6db58sm17621556d6.65.2024.08.23.04.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 04:58:57 -0700 (PDT)
Message-ID: <dc4a1941-6671-4e89-90c2-3a1c19fd3e1c@vasilevsky.ca>
Date: Fri, 23 Aug 2024 07:58:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3 05/14] crash: clean up kdump related config
 items
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 kexec@lists.infradead.org, debian-powerpc@lists.debian.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev, akpm@linux-foundation.org, ebiederm@xmission.com,
 hbathini@linux.ibm.com, piliu@redhat.com, viro@zeniv.linux.org.uk,
 Sam James <sam@gentoo.org>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-6-bhe@redhat.com>
 <a9d9ecd1ed8d62eae47ec26257093495e6cbd44a.camel@physik.fu-berlin.de>
 <ZscCMLfNbj2MDiaB@MiWiFi-R3L-srv>
 <c5e9996e4d2ba2a0849d65f68e3dce94fffc5828.camel@physik.fu-berlin.de>
 <ZsfR9rdMt8yn1+Bz@MiWiFi-R3L-srv>
 <768dfe3e-c437-40cc-96a5-6c5b34b2d19d@vasilevsky.ca>
 <c74e24213fd98b252a2a1ff02a107005e50f4f7b.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <c74e24213fd98b252a2a1ff02a107005e50f4f7b.camel@physik.fu-berlin.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_045859_403400_44F12E9B 
X-CRM114-Status: UNSURE (   5.13  )
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

On 2024-08-23 03:16, John Paul Adrian Glaubitz wrote:
> It should be disabled on m68k and sh by default as well.

Sure, I can change that. What's the reasoning, so I can explain in my commit message?

-Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
