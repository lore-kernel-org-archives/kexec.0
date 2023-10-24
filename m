Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A8EC25B6C
	for <kexec@archiver.kernel.org>; Tue, 24 Oct 2023 21:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z2qIn98tI9NT6aypqnsQ4YGRHz9YGF4tRrNOe5BMYKI=; b=E/m4PgqB5rwcCs
	Y7qTuxEhgVjn2tTuiV54XAZipJ4X3o3MuVcX77q0yqIz19kYjrQ+67f08WkCOOJGwV/aQpwMTMq6A
	s2zddaYC8hlNz6ulyxXcYbKZCqWpCnGeDrQAFhZc+WdFS0XGF4LgVvoLBviI5xI2P/O8rCv4R/S0H
	/qqcdIfL0KZv/PeUZCPuw1IT6DFMoRTHeKxeLlzNdd0b7ISS0e/FGTSLB7YMMvy9eGex8EA4wzOVj
	0WVYn/JRMl8xYaM3tSH85W1BaIxyfGh31CFdf7z87of+VVs7NutExinQJp5ZFaX0kVbjMgB+jRo8Y
	JF26JJmogueicHo138Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvOo1-00As2F-1m;
	Tue, 24 Oct 2023 21:19:17 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvOnv-00As0v-3B
	for kexec@lists.infradead.org;
	Tue, 24 Oct 2023 21:19:15 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5aa7fdd1420so2973474a12.3
        for <kexec@lists.infradead.org>; Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182350; x=1698787150; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf0I5QNq2gKNhp+QWqAtgU2BkAhFb6b7w3QJr2Rt56I=;
        b=gQDcq0HwhOclKUTiNKOnv9sT9Hau38tjFsZJ5IMuVbjE/8G7/A6TNBmVKe8O32tYVV
         D42RUhqtCi9SshwOQWAK/JhvffQYQbK6BEtwb4rjaluYHGcM1FQR6/wL+cz5o6kPFp0c
         dKnf+1Z1YELtEYrzR3AB3mqleenrA/K/p5JbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182350; x=1698787150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf0I5QNq2gKNhp+QWqAtgU2BkAhFb6b7w3QJr2Rt56I=;
        b=SJ8ckhHN3EtGK0c9OdgLH0ID/0aWkpmUHVO24yNB75PYlkXNOe3itE210Pd+J449jU
         No+CUrZKVp43wHxiTvspnqvRN9mWqjBoSNut1wE3yRfqdb4GUmQBIqUbV4NP/eEl4xy8
         YIOnNfW6Tje5jrJqky0g3ocMZRS92L0CmEDL4z9iT4z9pnfH7cb7E4oBzG11TB1I+Py2
         5B9UEp8W/KOLEm3G+jXyNyCDAkzN3Ceb0rqUU2ruHQwZ6Bt8XtKrw9xWcnr+n2PFsCcE
         nkwOGIOjFUw+NqtHUubd2cTEuPeCX4Z2pwS0BUxFZayxkldeEJM58K5BoXZzCH/ZPO5d
         VU0A==
X-Gm-Message-State: AOJu0Yw7fnwxZHbNneqo0FzO3w+RjI+d34HNg2vl7+40V5eBbssjjas2
	qBhhLeqHCqMrUXgRd2xde+5R9g==
X-Google-Smtp-Source: AGHT+IG4QxdxC8vQGJgNfcCeZZI6jENfk4ntlbbjFZnDCc1T/n//1rqezHHk0nSA1UzaU5cN06ODAQ==
X-Received: by 2002:a17:90a:d995:b0:27d:4901:b0b7 with SMTP id d21-20020a17090ad99500b0027d4901b0b7mr9801197pjv.30.1698182350137;
        Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ci7-20020a17090afc8700b0026b46ad94c9sm7669915pjb.24.2023.10.24.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>
Cc: kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kexec: Annotate struct crash_mem with __counted_by
Date: Tue, 24 Oct 2023 14:18:54 -0700
Message-Id: <169818232965.2100071.5860676864005280334.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175224.work.712-kees@kernel.org>
References: <20230922175224.work.712-kees@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_141912_029151_F15D8CA1 
X-CRM114-Status: UNSURE (   8.71  )
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

On Fri, 22 Sep 2023 10:52:24 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct crash_mem.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kexec: Annotate struct crash_mem with __counted_by
      https://git.kernel.org/kees/c/15fcedd43a08

Take care,

-- 
Kees Cook


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
