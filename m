Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE43C77B7F
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 21:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JNbxB2m0tRZT9Y1k0gxkPXhfMvqaOo3VAHVdhYzfl1o=; b=ggFKShrqzRdLZK
	WrhL8uTmExTFBLXjLnTq8+vFomkvwxlzNNI1wYKOgk0XzlEXHg6XVNZhO/JXLDAUmTSPq3a4wjdpv
	ib67UC879WKnT13vna/rPq4QGTug2nr4CMbNBKtX08vegVcQIAErKGxlImnIXrKImCtwgJ7jKZKDf
	z6c7MyfdocYu0x+l5v8nlJVDPfnmfS0eT/Db1K5LV9dD0OTA1GMNA5nVOrYNP2VTAtLsfAYLoE2kx
	0H/kbsyCYyAYll6GspX4597Nd71TgxoP7Si5+2ZD8CZ0Fj2q37hZl52EbgNHX4wcTHgsUjS5m+emH
	3FKORi8f39tvf64qa3Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pz2Hn-007Bcg-20;
	Tue, 16 May 2023 21:32:47 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pz2Hj-007BbE-0I
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 21:32:44 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64cb307d91aso2372820b3a.3
        for <kexec@lists.infradead.org>; Tue, 16 May 2023 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684272760; x=1686864760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxYdFfNWgH8T3xza0b6h2vTAfCsIMX0iES+NjWywOvA=;
        b=bXzoKWHeThT08/25gYmYH/PwvxAModM/x18sF48hSGj6VfYx3AqwxvU/wbGQ5mK0I8
         8+IV3gwBatiY+/CsiJpzllvn6cxt3Da73Qsi7ikeS1pvjLSFJnKtNdk9H5CtJjTRxk/W
         NlheeFiA1lboSiLgxb1bD8vHNpJviFWLuyTFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684272760; x=1686864760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxYdFfNWgH8T3xza0b6h2vTAfCsIMX0iES+NjWywOvA=;
        b=iOy2OHqRxlhg2KsBQTu2tlTTS+mhswR2/M6D88HF9GZbulihgyf0RaP5+W0aeCqenA
         ENXJT1M9u3TyQZkx9D4vJQzQHiXhqr9g9hRQQkxk687hIF6Qe0BvRadEK/x0I2rzAQ2g
         pnzlu7VzqkFlS1UAkTtVlJqVN6+B//uQiNlbbLafBwtCu+WCQ4ZJBiPmt9IJXBsVRw9O
         lpuzHA1L3EkeOX12+fEud9f8Sc7p6W0+RVzal5+PbAo2NbJYKy9T6/4by0ogoYsQYabI
         s0WMzGF0NXnt+efxhia0bpG0VjaOWI5CiWZ+zopI5t9F4rWXBjNi+WoLG2paWxNkhSre
         8bKQ==
X-Gm-Message-State: AC+VfDwn/elrEkXaCX3K/b5r9uBv7Y7JR6xHx2L/l6xrCuAV7KhjgCAX
	8PSjHjVBFQNqN5C61M2uEmJPSA==
X-Google-Smtp-Source: ACHHUZ4VD+Jiit5nBg+95/NhuhCFqpi2Y3R98cX5qgMR2DjWCcb42bHIdO2wn+EhSDv5VMuUlg+loQ==
X-Received: by 2002:a05:6a00:1311:b0:63a:fae3:9890 with SMTP id j17-20020a056a00131100b0063afae39890mr49796503pfu.24.1684272760089;
        Tue, 16 May 2023 14:32:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k14-20020a65464e000000b00530914c3bc1sm8277026pgr.21.2023.05.16.14.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:32:39 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	bhe@redhat.com,
	maskray@google.com,
	ebiederm@xmission.com,
	brauner@kernel.org,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump, vmcore: Set p_align to 4 for PT_NOTE
Date: Tue, 16 May 2023 14:32:34 -0700
Message-Id: <168427275061.1358677.10611822490555556072.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230512022528.3430327-1-maskray@google.com>
References: <20230512022528.3430327-1-maskray@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_143243_145230_1A815697 
X-CRM114-Status: GOOD (  10.62  )
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

On Fri, 12 May 2023 02:25:28 +0000, Fangrui Song wrote:
> Tools like readelf/llvm-readelf use p_align to parse a PT_NOTE program
> header as an array of 4-byte entries or 8-byte entries. Currently, there
> are workarounds[1] in place for Linux to treat p_align==0 as 4. However,
> it would be more appropriate to set the correct alignment so that tools
> do not have to rely on guesswork. FreeBSD coredumps set p_align to 4 as
> well.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] coredump, vmcore: Set p_align to 4 for PT_NOTE
      https://git.kernel.org/kees/c/60592fb6b67c

-- 
Kees Cook


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
