Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD70CCFD376
	for <kexec@archiver.kernel.org>; Fri, 28 Nov 2025 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ozvegxpQZ76Gmd4MPL9aKvB06f3a0E0RzNh/s6Socck=; b=CnU1qWJ+QuY2/DHaf//DELIFtS
	OZUwHvKR02EM09jUUXjV3Vlb94U5ExyLVCz8iGFZVXmwiUKZrtsn1NDQRxuxW0fWNzWmTpQIX3CI0
	TELL63B35W19D/P3OlSoZOK/MY89EmdnqzNCXl5VTW7Wu5R6SL/dkD9JAUE6QLmonkcpUE5XsDwZN
	sgiZHWQ/flW/vQWrlx9Yx0rC7LWydbfCdzPEoJk+8z+IvcrYhBoAnKp88NBvDPcU9LSacwpUfgUtq
	FocC70NIc5MMsZcpQo1sgXiFegmeMdcq0or7cWDCL4Gh3DPniT+j7YDWolOORZqBav5j8AugC+ik4
	YkMiohrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP0ku-00000000bHn-3H4V;
	Fri, 28 Nov 2025 15:51:32 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP0ks-00000000bHR-1waW
	for kexec@lists.infradead.org;
	Fri, 28 Nov 2025 15:51:31 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-880570bdef8so21236016d6.3
        for <kexec@lists.infradead.org>; Fri, 28 Nov 2025 07:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764345088; x=1764949888; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ozvegxpQZ76Gmd4MPL9aKvB06f3a0E0RzNh/s6Socck=;
        b=VeyBfQQlbPpWV/YpNXl9b8gDTy/q5b9Hy4Rin6eJT3hOMJHv6cQJhFkeiEG2yYVajw
         ZdNkpJ0x2C4Dx4GfivdKpn8HKDhdhbd/IXfh6tugdpiO7Dg9UXiHSrTOVspR2d5RfpWF
         hNdEtyF6f8Bc6YXx/s6jOzgrR7OoKhhhaq9Q/P0NWFieVlAVJiQfpNfrxofzy70iYJQ8
         UQ7gXmHSSjeVzRVWxXwoytrW89xa5zZr+OC7sxbsvAWN5HuQZXKL1Bd4PaD2/9NmuMMb
         rElZgqdZeAG02eH0JmGNAV1wt4ToBMSIYd44mSNEJ3dFVXnVva9DnxTu9VHDh9uw39bB
         OdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345088; x=1764949888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozvegxpQZ76Gmd4MPL9aKvB06f3a0E0RzNh/s6Socck=;
        b=oUtAeqW3x5A5txhyU9Yh9gJkTlASRd/VDOlwquY/4pKpPEs81bRqN9HoG5sGMBzfHz
         va5Y3Fw64gnYcVV3ItgYK6MvRp2IGEa3OjKLGevQBKYs+o+Xj+F55OmsWO2wCiVmLMpc
         hRbbE+9UFj3Mp6kVxMGE0lUq2TAJRMXHHdKODMZjhySJ/kP8fia6gbHGvenHMUoyOVeW
         wRVX2ZX4WkLtXjhfcEMMq0En11hl1ZGG5mzFH41awzsSz7npcFkAznqyZ3Ox90KIUT2B
         Z2cy27468k1N8YRsN2E4nopHy9xKgmO8Z7GpcWfg7Bou1ZnxZqpfIduz/fL+LBVHYDqd
         QL0w==
X-Forwarded-Encrypted: i=1; AJvYcCV7mwZSJpVVn808MF5Tpx7B2tsSoBDpruliHNIMEaUwQTNl/e7cXN7bWinjvDd4aFI3D6JpRQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwuArcphnkRib50Sw6KCfalZiWLElp2j6A5uGAKgm0iIowJ49b2
	J7tc4gAqbAJvUuEfVeXARJYXYysQEt0ZE3X/5HAWMxRXlZypARPg2mjVZ51ihRIEXcKvSvjWnPs
	62htPVcYkB3L8ILoKcEqT/ZraX6HFQsTMWwW2NL1K
X-Gm-Gg: ASbGncvrVTUuYwINvEwqV/89OGblZuDt/ybOi6qWO/JiUOeiA7zqZS4UNleTYYaLCxz
	d3lEZkGjXzGyc73mP8y/igA+TiaNFAjKB6uIoXA9TJkXO6f7eYwbz1KHf7LYov6VaOJeDkTYwz3
	qfxHsbzrwB0N74ExdbMjaU/+2h+7ZykBzBxfZNvvglFAyNK1t7Vl37XC2nOOxWQs9CGm3wz6Aiz
	3TYIQiWGHKmBCMKmTW18YYjqfHRpALMdV+8acnexxMu7If34avnGgz1jU7UJ9YgL5acZi5GJBEO
	sT5ljWBL+1Ut2tc2OdsmYnXsFRAmZcXElLw9
X-Google-Smtp-Source: AGHT+IFtScpt1Nn88BhPzS0M76f9pclabIXatA2MxZVyE6xow24YTfIN5+xoj84xP9E83CZGjyUfH3MOrsIHCxgycDw=
X-Received: by 2002:a05:6214:458c:b0:880:415d:a9ee with SMTP id
 6a1803df08f44-8863ae8a8b3mr216933026d6.26.1764345088423; Fri, 28 Nov 2025
 07:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20251128033320.1349620-1-bhe@redhat.com> <20251128033320.1349620-13-bhe@redhat.com>
In-Reply-To: <20251128033320.1349620-13-bhe@redhat.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 28 Nov 2025 16:50:51 +0100
X-Gm-Features: AWmQ_blrBdFoteeKgRy9ZgZrLR9hCgiNwq7F8c9neFw0fvcV5_-PUj9Uqs2bsZc
Message-ID: <CAG_fn=WpLtVhhOfU3pBKbJ2P3ih+PX4oW+MKAAmHRW0onOgSvg@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] mm/kasan: make kasan=on|off take effect for all
 three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, elver@google.com, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_075130_543143_E91CA0AA 
X-CRM114-Status: UNSURE (   6.69  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> @@ -30,7 +30,7 @@ static inline void kasan_enable(void)
>  /* For architectures that can enable KASAN early, use compile-time check. */
I think the behavior of kasan_enabled() is inconsistent with this comment now.
>  static __always_inline bool kasan_enabled(void)
>  {
> -       return IS_ENABLED(CONFIG_KASAN);
> +       return false;
>  }

