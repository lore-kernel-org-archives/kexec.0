Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C69C4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 21:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PbG9CJvPefKOu99S0dyqYxHDaCNEbEnY7DBzUGKwq2o=; b=P7lSvwi9JlJVWd
	gZ+4vPlg/tbokmSKMmuLYUqeBwtO9xY5BF3rcw1yOarqqGLFY7fecjfk3mM1FAF6ww+lBFGLLoRvr
	Qls8UoRpdnFd03hC7Q9a10B4y/s9boEkjvdTX9n1jLf98P06pu42yq7PJFa0gQ2IYLG+ighYj4+i9
	zkjHNMoc5ULYle3LS+eZf6SS+MZxhd15l5KD0tcJd7p325Lyvr31ytPnpUwaPtlloo9Qqq4j3zaw0
	VcItTk8MyX6C+l+wUPC3/VATwXzBMCC4PpYWl0/RWe7asZL71yMOcDPxbjdKiKXhJxjVEA96HSUbg
	NnwTJtgYsD/KxBhT90Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0TBo-0000000E5IV-3MSg;
	Fri, 26 Apr 2024 21:33:04 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0TBm-0000000E5HO-0glE
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 21:33:03 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7dddba0f02fso111559539f.3
        for <kexec@lists.infradead.org>; Fri, 26 Apr 2024 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714167175; x=1714771975; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XapD3Vo/MqdiQRWrwhL6vAMNi8r75ljjq7FJu80J9ZI=;
        b=xLa+XuaiP4jmdCYX59ib8PdrAUVm2hiKA9HfGhOMiohiGnAf4lq+bio/c07yJoj6By
         U/nC4F7KkG/J0uz+/5AMD4fVpgmt/Yiiw4eI1JvvmnFDCflqDQvgE9x1PldCwI+QgCQh
         hUxGeXjMi6FnWQgyBVlYegXRcEGi4uB/KMCG8Ynwjg8wCJmZmZRApwxPIM1mBa+cHiRj
         bofPRzCkUCq8SzA4AAEDCI+9T5cKZqces3DDOVLW445THgtYfLLI9neVthbrOKYmml8a
         P7UMZPlSjXcXu84CnZQbkHAEkafSaKFjRVjfmzZNzwQxK7KNkdirxe6JRvMD7s5p8pmi
         OjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714167175; x=1714771975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XapD3Vo/MqdiQRWrwhL6vAMNi8r75ljjq7FJu80J9ZI=;
        b=eIsUvTzLhsCoUZK6B115jseuCHxkt0hAq2i2wurvQNMepWg6pLMI87B3xpmG8dLlPT
         ibBwW2z3hVaMrUqWJwer1tzWkx+AKXzaIWTdz1fCl5wUhWslbHv5Khj4xuwcdOqFF78F
         pW1yGYo9DVY7q1zf6r8odo2JciNJSegpEfo1Cegk4CqicrP8+MX5vYtWkF73hB6IB5DE
         hwP/DKDEbmXkdapgGTOtvaR98aXfevo2+NLZZz5heTVhP8eFwrlsnCd8M0R0vySTvB3b
         PR2Xcl8roD7rzwxQJPlUoZG5qWaO6z/dsrOjBuAFv7BEGrVdR9T+pe8smyVAiacGIEP9
         iyew==
X-Forwarded-Encrypted: i=1; AJvYcCWRiT+OYLZcNy/G4y/98VXTnfSR6oohRSfEPEwGBeAnEvKAXYWfC5EpXgVejf+IH5K5AOIEtsL9GES/mGr2Vpwy4u6aZlqbNN3B
X-Gm-Message-State: AOJu0YzLJ/wT+/b7HV9A6SDEGloiPjnZ2TzcXgjTXux5sn0QjoaVYIX3
	Z1DPhbMtfm8TnX/ukWJuS92H//qJVamKNMrs5M+sMuHVzQ6RUbnLW7HnK10gaQ==
X-Google-Smtp-Source: AGHT+IFoiCg3OWmOf8Xqm+Gm5428k85SPoCpAbrANz2kTgoAcSMf8TRwNrwGQKHHoyB814lzfQGPTw==
X-Received: by 2002:a5d:8d16:0:b0:7da:1896:9e7b with SMTP id p22-20020a5d8d16000000b007da18969e7bmr3901716ioj.20.1714167175399;
        Fri, 26 Apr 2024 14:32:55 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id g3-20020a05660226c300b007deaecfe190sm369755ioo.7.2024.04.26.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:32:54 -0700 (PDT)
Date: Fri, 26 Apr 2024 21:32:52 +0000
From: Justin Stitt <justinstitt@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, 
	Bill Wendling <morbo@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 2/9] x86/purgatory: Simplify stack handling
Message-ID: <pgsqflimo7d2ozhpmdrmscx25mxs5lypcvwq6mgjs7uixsxvsl@5papnq46mwbs>
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-13-ardb+git@google.com>
 <20240424182659.GA2126602@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240424182659.GA2126602@dev-arch.thelio-3990X>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_143302_268353_32E9C08F 
X-CRM114-Status: GOOD (  23.12  )
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

Hi,

On Wed, Apr 24, 2024 at 11:26:59AM -0700, Nathan Chancellor wrote:
> On Wed, Apr 24, 2024 at 05:53:12PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > The x86 purgatory, which does little more than verify a SHA-256 hash of
> > the loaded segments, currently uses three different stacks:
> > - one in .bss that is used to call the purgatory C code
> > - one in .rodata that is only used to switch to an updated code segment
> >   descriptor in the GDT
> > - one in .data, which allows it to be prepopulated from the kexec loader
> >   in theory, but this is not actually being taken advantage of.
> > 
> > Simplify this, by dropping the latter two stacks, as well as the loader
> > logic that programs RSP.
> > 
> > Both the stacks in .bss and .data are 4k aligned, but 16 byte alignment
> > is more than sufficient.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/include/asm/kexec.h      |  1 -
> >  arch/x86/kernel/kexec-bzimage64.c |  8 --------
> >  arch/x86/purgatory/entry64.S      |  8 --------
> >  arch/x86/purgatory/setup-x86_64.S |  2 +-
> >  arch/x86/purgatory/stack.S        | 18 ------------------
> 
> This needs a small fix up to build.
> 
>   make[6]: *** No rule to make target 'arch/x86/purgatory/stack.o', needed by 'arch/x86/purgatory/purgatory.ro'.
> 

I was trying to reproduce this build failure, but to no avail. I am
curious what your build target / build command was.

It is clear that stack.S has been removed so your change makes sense, I
don't doubt that -- I just cannot get that specific error message you
encountered (what is a .ro file supposed to be, anyway?).

> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index acc09799af2a..2b6b2fb033d6 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  OBJECT_FILES_NON_STANDARD := y
>  
> -purgatory-y := purgatory.o stack.o setup-x86_$(BITS).o sha256.o entry64.o string.o
> +purgatory-y := purgatory.o setup-x86_$(BITS).o sha256.o entry64.o string.o
>  
>  targets += $(purgatory-y)
>  PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))

Thanks
Justin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
