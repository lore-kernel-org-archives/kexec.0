Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F54C001B0
	for <kexec@archiver.kernel.org>; Wed,  9 Aug 2023 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Cc:MIME-Version:Date:Message-Id
	:Subject:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y3UdDzUfxmGM3dVWVM39N54Tj/vCyp42vkVp4E/25SA=; b=nsZ6SdWDWqscLD
	EZGe8Q1N1Y0VyuV2QoRJXqZA7020GyDOO/Hj54uzGXaQrGdXQZLFfWB8HtAG2IAMoQ8eIX3xUZ9yk
	tW3a0Lh1H6NPsTBWgDZ685eQepUcF2wnjjQ/3V3ewyXgVZ2PpzcE0uH/5672N0aEHY13IPeTmjqHz
	U1zPBJw4IOkGCkDGaONM+xSz9ja70rVI8ML/eMRTW1CeLhBUhs0PwyBbNdseunRdx8M50I+Ho8C2h
	AIuwnds8xLX1h4N3JvLVUfaM8asU+6oNEFhUHc/aYjDr3aX9+TVwLLXe0W3v0fbEhhTkgMCZ5PcZD
	sg5TOQHQcfU/y1sndVOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTkI7-005BPm-0R;
	Wed, 09 Aug 2023 14:36:03 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTkI2-005BOD-2H
	for kexec@lists.infradead.org;
	Wed, 09 Aug 2023 14:35:59 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb893e6365so45085805ad.2
        for <kexec@lists.infradead.org>; Wed, 09 Aug 2023 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691591757; x=1692196557;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcSxbBrOV0WBg4EP6zgcLtNj8tR0tgK0git/8kLh/8g=;
        b=iFBxTWYgQIrj4gYHg7URBl9Kl5xOAcVL0HH5/QkB91x4HS9lNi6Ivla71SdJlNRENe
         3POAlQzTPJPQ3Azft+nt3ZFkUvTC+xctOQt7sHY1FIU0BybjtoelE8jK+/csTHOg/CWw
         2LFJwu2hoXwkJ5OXWlBnZfRa6XQpodvXkymXFF7uXChA8KsGQUP3o3K4uA3Yac5it+YT
         TkzwpivjCIFNw1gAxYzFN792eKnjLxRFDxu++b1KjVk2aFVcYvDpWDg/+JSaFdaZ9Xl0
         LSAMZdvIKAJiXQTHAkaBYCV/kZXwBTnDfIkYTt6GkbmW1vqzbTxx8vR5hREY4ztHK3xB
         HUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691591757; x=1692196557;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcSxbBrOV0WBg4EP6zgcLtNj8tR0tgK0git/8kLh/8g=;
        b=B5nfZPdafSCWOaYQmyO+C5OY5t49ltGwvX6V3tN3r4Wq41MLy0+sH0Dvd+W2zgXt17
         TqiMvByEgrSSsWbLQrTdbNIupj3a/MeOEuQmrFmNT5w+zwMFdSt+0b+uNsFLMNa3QQAr
         M4mhSHDCgTx7ggB6O5f/qfqS/nCiXmz4oHrq5+ZJV5prjnu1mRE26ytSO5b6xsLoZDDE
         uR/r9THamzR4pcWsjtDFyJOWqdwQcvf3ApdDMPHkWhRmLomIubFNaZvwWZ4T4cUi711t
         M96TT0+E3tHjHA6wNpGmXJf/BZ1cYQo3uClrcQmd0G1um12aUsErdWEleFyU4pfKKleA
         aD5Q==
X-Gm-Message-State: AOJu0Yz/CYelUjw1rAh1irD1K0inVJpa3cFNfKjVy3szWV5c/MEs2WgL
	tYJUYWyNobkiSqmfVF7T8KYweIY+YSqjhcYDIHjkOQ==
X-Google-Smtp-Source: AGHT+IFdVVu7L+xm66m6ILijRF86owhaQpuq4lcg6v7Vht4/WBr40AzWMsdamMMfe6osPRY5H6pnVg==
X-Received: by 2002:a17:902:d483:b0:1b8:a3e8:51d0 with SMTP id c3-20020a170902d48300b001b8a3e851d0mr2328259plg.45.1691591757300;
        Wed, 09 Aug 2023 07:35:57 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b001bc68602e54sm7307984plo.142.2023.08.09.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:35:56 -0700 (PDT)
In-Reply-To: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
Subject: Re: (subset) [PATCH v2 0/3] RISC-V: Fix a few kexec_file_load(2)
 failures
Message-Id: <169159174235.20984.13290949121654917312.b4-ty@rivosinc.com>
Date: Wed, 09 Aug 2023 07:35:42 -0700
MIME-Version: 1.0
X-Mailer: b4 0.13-dev-901c5
Cc: Torsten Duwe <duwe@suse.de>, Roberto Sassu <roberto.sassu@huaweicloud.com>,
  petr@tesarici.cz
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor.dooley@microchip.com>, Li Huafei <lihuafei1@huawei.com>,
  Liao Chang <liaochang1@huawei.com>, Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <keescook@chromium.org>,
  Andrew Morton <akpm@linux-foundation.org>, Heiko Stuebner <heiko@sntech.de>, Ricardo Ribalda <ribalda@chromium.org>,
  Alyssa Ross <hi@alyssa.is>, Li Zhengyu <lizhengyu3@huawei.com>, linux-riscv@lists.infradead.org,
  kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Petr Tesarik <petrtesarik@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_073558_741346_07E8FCB3 
X-CRM114-Status: UNSURE (   9.97  )
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


On Wed, 26 Jul 2023 11:53:58 +0200, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The kexec_file_load(2) syscall does not work at least in some kernel
> builds. For details see the relevant section in this blog post:
> 
> https://sigillatum.tesarici.cz/2023-07-21-state-of-riscv64-kdump.html
> 
> [...]

Applied, thanks!

[1/3] riscv/kexec: handle R_RISCV_CALL_PLT relocation type
      https://git.kernel.org/palmer/c/d0b4f95a5103
[3/3] riscv/kexec: load initrd high in available memory
      https://git.kernel.org/palmer/c/49af7a2cd5f6

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
