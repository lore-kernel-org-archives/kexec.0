Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07F2C77B7C
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Rk32wNPQUvVsOaUwm1J6AJGqYgNDAophcqAzK1Xl9w=; b=K7wrgd9XGdRwSS
	mCokl+k02jTMsHmy7boIVotmuW+SlZKoJlDhuizaPOaJ+AAWrvGDkzpMhKiA8JpjcPYIOw6E+Gx1D
	/SKtRoKD+MrcjlHkTS4FkEOb7qg8kvUbA2NTmCXeI6k5v32yjqdaLBipFTX5ED5Ehlg2hRvxiYhcu
	AMsbrLbzeSRACMJUd+l1mqfWmRguu/o9s94czMPiCqqOzxFBQ/856UVWsVLYA62RYiPXBuHYv9lEr
	dC9JU7o3RvMEEEunMKsAnzaRn85pHY3NWBImx7WraUxDqA1jYMHAP1ebx5viEv/5BnsOHTfyTKY6K
	KLDkgAf2We8j/YlL4eQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxXUU-00ChHt-3D;
	Fri, 12 May 2023 18:27:43 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxXUS-00ChHC-1G
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 18:27:41 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-643a6f993a7so6357803b3a.1
        for <kexec@lists.infradead.org>; Fri, 12 May 2023 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683916057; x=1686508057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wu7QjxyIEj8Ln0iJ7kC1lictfM5N8E9aPqKarxQcnRo=;
        b=mVWTZPifMoHLSVHy4Y+TkqiPsN5TBnj8pw9/akxIyVJwOmHNbjAXiei7xFChDHXtk8
         UgPD+eFo5yiRVXIvsSrzHmLZIk2wgtMCVBQ1a/ieZOm9+IZsNleOG3Z7r8tcxmqaNcH9
         HCGBf2lqfK0w6tZ7WND306xHjlXb0gbgfi1gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916057; x=1686508057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wu7QjxyIEj8Ln0iJ7kC1lictfM5N8E9aPqKarxQcnRo=;
        b=Uj5j5VHxTDQeZHehyJ9+FXftx4w+N2Lx+j5TWV2fLUT9iVkNsM5gglgygatXzzycqq
         J+DH0iEKLE5iHnBiEbNTBLUcqac2C33V+Z7iB/w3m5dg73Mbo7TLNv/JpCSFDeeKBNeI
         eU2bJ9C4pJJhMFoY1rQinRc5hrrLv7S208ODffm/yuvJbKOd88G5VyGrMhKf7Z8X0F01
         l0rIR86+BXnsJlBM3KSUKrhN4Rah6UjGBE5hteUZGusAd47gJ1a44Ei75tN53n2toYjP
         B77PNecGMsBA4mDl8BD+sUsmtvn5FDn/vDhHteb4gcg1dnA66JLImWRRI5bp1XOlr1UR
         kdhg==
X-Gm-Message-State: AC+VfDy5Ih6hTATrxwKKjkJV1asdaBPzdJJ03OohEjWKW0KR2LgMS8Wt
	4Bq/AzCXzhf1vuin0BobAFgxGQ==
X-Google-Smtp-Source: ACHHUZ7p/urZKZskQu20+A4odA3ca2trpKf9+C2kVlEdDBeyGa5r+sUN4pDeYAbVnf/yzpt4mWqLyA==
X-Received: by 2002:a05:6a00:1703:b0:644:c365:50d5 with SMTP id h3-20020a056a00170300b00644c36550d5mr30144377pfc.6.1683916057299;
        Fri, 12 May 2023 11:27:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b0062e0515f020sm7328051pfb.162.2023.05.12.11.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 11:27:36 -0700 (PDT)
Date: Fri, 12 May 2023 11:27:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Fangrui Song <maskray@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump, vmcore: Set p_align to 4 for PT_NOTE
Message-ID: <202305121126.E5AD334AA3@keescook>
References: <20230512022528.3430327-1-maskray@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230512022528.3430327-1-maskray@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_112740_448447_54DA131C 
X-CRM114-Status: GOOD (  14.12  )
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

On Fri, May 12, 2023 at 02:25:28AM +0000, Fangrui Song wrote:
> Tools like readelf/llvm-readelf use p_align to parse a PT_NOTE program
> header as an array of 4-byte entries or 8-byte entries. Currently, there
> are workarounds[1] in place for Linux to treat p_align==0 as 4. However,
> it would be more appropriate to set the correct alignment so that tools
> do not have to rely on guesswork. FreeBSD coredumps set p_align to 4 as
> well.
>
> [1]: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=82ed9683ec099d8205dc499ac84febc975235af6

The interesting bit from here is:

  /* NB: Some note sections may have alignment value of 0 or 1.  gABI
     specifies that notes should be aligned to 4 bytes in 32-bit
     objects and to 8 bytes in 64-bit objects.  As a Linux extension,
     we also support 4 byte alignment in 64-bit objects.  If section
     alignment is less than 4, we treate alignment as 4 bytes.   */
  if (align < 4)
    align = 4;
  else if (align != 4 && align != 8)
    {
      warn (_("Corrupt note: alignment %ld, expecting 4 or 8\n"),
           (long) align);
      return FALSE;
    }

Should Linux use 8 for 64-bit processes to avoid the other special case?

(And do we need to make some changes to make sure we are actually
aligned?)

-Kees

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
