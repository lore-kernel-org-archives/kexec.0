Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B8EEEAA56
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QXuksbHynrnFaZWCFzq1zzqWkIsA1vZIJgO0lMXEsgI=; b=CgpijEBePLLY8A
	cip1aXSiSDKXBTItnD+cuVOjPmo0/dofenDdGiBBVu6bQLnCduAAWdF+qkuHgwUXdhItC65H3CRnq
	PwzKVashxAk76YF1ZCH7JcmwyERU0c4mZ0YRqxqtLEdnYjv86LvONUZFavElGy8qyIoogZJKagc+c
	9aCnWdAMpTisHDIeagDlY9Fo7Ce8CXoG9Y+PTOJ4LA2fCzAgzkpahuxkxYm6+GeD8hRdey1E9Sgvn
	5FxHj8489aCxX+l27f2diKXRfgHulPm0iVB9DFyh9sNrqPPpGIC8PrRo6CBcUr+mtrC0m4LyKcmCa
	J00M8daRUNAvlL/UlRLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgpIe-008v29-2T;
	Thu, 14 Sep 2023 16:34:40 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgpIc-008v0j-0A
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 16:34:39 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-65627d499e1so2901456d6.0
        for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694709271; x=1695314071; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XASZo9YTM/nTEYGFKuVlo/54fQU/sete5YVGxHMmtGE=;
        b=kqBIGlleJ4iXp1AvJq8wX6c7Y2sRD4tT9yFbCCJoanYZh2EB2Y6bUXFFdCUZv4EU/K
         sZ4eV2GNk/bZdGg+lO9LN/X6f6QQtxVkf4WX/fI4dy8w349d2+PUi1NI0hx/t/wkwiBd
         KJofA+OjqLxtZoBNvF+byR23AHavkYp6C/bEyKrBxScNJGl/nsomybDJp/edWRwaQpYg
         BPgC53aw96qynhiM5QDkLoPuijFrvgHq1EdL1hetyHG/BqOvVBuSL99WQOkZLM77Y6Kr
         yeZOqif17+UZuL/CUJ4emvwE9UvoeNHY1w9/2OHFNKar5HA5blxFgGw6xRROeWSCcegz
         aixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694709271; x=1695314071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XASZo9YTM/nTEYGFKuVlo/54fQU/sete5YVGxHMmtGE=;
        b=KAxtgaKp3GQjo8xQYVAkY5GPeKVQrvjVLbdSkdj5yKLECEKdCv9s01JmAObWJrbct0
         TOL3OZugWVNCqmKohc0WqMTGnqivd+OTD9n4SowjHT7gqzPDDfImhgUHKaotm+MGw3OU
         zq0gCZDEZckVpcBukReUUzDo4TXAkXJLp0dX0303VmWj88enaqAb3j4pdWZzzQy2kq3b
         bnGisuhbJusRCIjwVy9F4Mte2e+MZVcup9slxizrNpMtKY8tWgZliUgrlHGAPRQoHa/q
         DqBDIAqTTtyI14JGTe9GdURt9j/Rt+uETjguzGGzw2ZicX49exZMovlHJoRQvMmXnM9A
         E8AQ==
X-Gm-Message-State: AOJu0YzyxKmpFdbgMeegdLRJDHAKJcHFHJM+HeeEc+fND+/O13Fx1zRp
	ogUYQf4UYL1K3vPXL1Diasl+QclMgnUX7AMB0W4jog==
X-Google-Smtp-Source: AGHT+IHg7UmjBEGVkEhvOpg5Q7l9qEP6HqefOiFuxlirIIM6Mj2/H8NYbCInlRHktmnsTl9fFeuW1sLvb4zQBpyU210=
X-Received: by 2002:a05:6214:12e:b0:64f:59b8:cfd9 with SMTP id
 w14-20020a056214012e00b0064f59b8cfd9mr5860447qvs.18.1694709271421; Thu, 14
 Sep 2023 09:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230908231244.1092614-1-song@kernel.org> <CAPhsuW5Xy_K=6u4s=pNAZ8+eGBtX8v16Fr+9quL-FftEu+DWOA@mail.gmail.com>
In-Reply-To: <CAPhsuW5Xy_K=6u4s=pNAZ8+eGBtX8v16Fr+9quL-FftEu+DWOA@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 14 Sep 2023 09:34:17 -0700
Message-ID: <CAKwvOdk6FeQjbh7b5K4pps50HZa6Riw6o7huGKzYcHFk_R8MLg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/purgatory: Remove LTO flags
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, x86@kernel.org, 
	llvm@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_093438_090367_49D97FA6 
X-CRM114-Status: UNSURE (   9.14  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgOTozMeKAr0FNIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5v
cmc+IHdyb3RlOgo+Cj4gV2hhdCB3b3VsZCBiZSB0aGUgbmV4dCBzdGVwIGZvciB0aGlzIHdvcms/
IFdlIGhvcGUgdG8gYmFjayBwb3J0IGl0Cj4gdG8gb3VyIHByb2R1Y3Rpb24ga2VybmVsIHNvb24u
CgpQbGVhc2Ugc2VuZCBhIHYzIHdpdGggdGhlIGZpeGVzIHRhZyB1cGRhdGVkLiAgSSB3b3VsZG4n
dCBtaW5kIGlmIHlvdQphZGRlZCBhIGNvbW1lbnQgdG8gdGhlIGNvbW1pdCBtZXNzYWdlIHRvIHRo
ZSBlZmZlY3Qgb2Y6CgpXZSBjb3VsZCBhbHNvIGFkZCB0aGUgdXNlIG9mIGFuIGV4cGxpY2l0IGxp
bmtlciBzY3JpcHQgdG8gcmVqb2luCi50ZXh0Liogc2VjdGlvbnMgYmFjayBpbnRvIC50ZXh0LiAg
U2ltcGx5IGRpc2FibGUgdGhlIHByb2R1Y3Rpb24gb2YKbW9yZSAudGV4dC4qIHNlY3Rpb25zIGZv
ciBub3c7IC1mbHRvKiBpbXBsaWVzIC1mZnVuY3Rpb24tc2VjdGlvbnMuCgotLSAKVGhhbmtzLAp+
TmljayBEZXNhdWxuaWVycwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
