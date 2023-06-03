Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC1EC77B7A
	for <kexec@archiver.kernel.org>; Sat,  3 Jun 2023 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3LzUS9bEW5iVItmhwVmYeO2fa8WePFzSJUzIaTWO4CQ=; b=q9JJXBgw7UkKTp
	zIRVq4xpU2mra2URICC6QBrvkJDj1AbQnKx/AaCdaM9rqLxnbjHUIiK5lGkQJHK92wl6GfXnuSU+S
	jfRayEhItphtkAcw+j4W3HCp+2NCrmDRaY22552YevyzsMlABxFt7Q/p87OWugEBw2v7dMu+EghfG
	+aJhm1jE5gq2YsQzx4H7bV22eQ6XHAZ3RMGaksd0HpKhsW+eCbYbM4hO8PFD8F+zV70BiML0SoLF+
	d8t8HrBPruI0IG2Yo3q1RBXgBGQg/5LkJrbF27LDbyKkVEpRQMPjTkrzqAlyCg0MGTkcU+h4giBDS
	T0CUERHzI8e3gIYAv+qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5NTP-009Bw7-1d;
	Sat, 03 Jun 2023 09:22:59 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5NTM-009BvH-38
	for kexec@lists.infradead.org;
	Sat, 03 Jun 2023 09:22:58 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso417855e9.0
        for <kexec@lists.infradead.org>; Sat, 03 Jun 2023 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685784174; x=1688376174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5ZZccEjOJDauUyUc86UqVR1EPzXqg2YfD93ZA1ljqc=;
        b=qI0nJsNWcHPPAlmCysrUhMrmWKr27qMxZO5HMUxwnyK+gpI+LPc6MlMrzrSyF3ZCtk
         1Hft1SoBsmWFRXSmyJaSjpGBY1iimxIJH/04hSrN4Th377wHgQseNGGv/rWbfnir1d1b
         rJS2HdlJfYGXG8kTkozPEzTSIv6nc/5+/qD4Zt2zJbW/b8PzbGyxeDutsZa65rtWK1mB
         wF6dbclJzCRVzB6/vtbHfCHojqL3dxpFyi4bePqUmEHNfPWGwjMVzXviopAkC0UeA1zb
         u8SQESCLxYrVytCtxsfz9subGlJKQtTgJptNGa8pProfb38gx8d1k1L625HFWncg2VZ4
         Mbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685784174; x=1688376174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5ZZccEjOJDauUyUc86UqVR1EPzXqg2YfD93ZA1ljqc=;
        b=K+y26xrJDzIY7yoH1HfnDXxtwQmziiYkbibMkSxU2IvfprYN4QlRpL1KlsG8WgI26h
         ktWoQSJv+CSmNmyMLF3+nnaEUvKg9RTH264zniAQiDrJMMZVpXwV/HBgFpw6rPMvptj7
         HSTt/6OBTM0+I18Ud6PeOvx+g4LzTizxrzwtnUZKnF1Rli+Im7OaAtrbEjF/oc5qtifm
         1hQoPPIfrV9kTaEAplNNMkaG7EesiD7z2KioIf1ZEnIa3Uu2MviXmLTCIAb2trsXOX9+
         j+6O1arXYGc1R2jU3CtbiGN5MRjuXIEM/ygkjNVmJrMNZJKuYfKRb2PHPvwa1e8fGAN/
         BdLA==
X-Gm-Message-State: AC+VfDwBA9v5cLTyoJwwvRLeb2OmMKxKUOrzE0pI2hQEJgVILYj/tX4g
	bzX4Za95W4+WJFDiVBAXL/o=
X-Google-Smtp-Source: ACHHUZ7HrvGXynuCfe2Du1bVfjOvawLJSng9RyiQMVVgL2YM1NZ+L20ZQXh+OzK3OYRVGFQ/PlzrPQ==
X-Received: by 2002:a1c:4c0d:0:b0:3f7:5e1:f3fd with SMTP id z13-20020a1c4c0d000000b003f705e1f3fdmr4008232wmf.5.1685784174328;
        Sat, 03 Jun 2023 02:22:54 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id l5-20020a7bc445000000b003f6042d6da0sm4431638wmi.16.2023.06.03.02.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jun 2023 02:22:53 -0700 (PDT)
Message-ID: <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
Date: Sat, 3 Jun 2023 11:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, x86@kernel.org,
 dm-devel@redhat.com, Pingfan Liu <kernelfans@gmail.com>,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
 Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>,
 Thomas Staudt <tstaudt@de.ibm.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Dave Young <dyoung@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
From: Milan Broz <gmazyland@gmail.com>
In-Reply-To: <20230602213452.GC628@quark.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230603_022257_052844_F9815E25 
X-CRM114-Status: GOOD (  12.96  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 6/2/23 23:34, Eric Biggers wrote:
> On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
>> [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
> 
> The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
> happens to use.  But LUKS is a userspace concept.
> 
> This is a kernel patchset, so why does it make sense for it to be talking about
> LUKS at all?  Perhaps you mean dm-crypt?

Exactly.

I had the same comment almost a year ago... and it still applies:
https://lore.kernel.org/all/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/

  Anyway, please fix the naming before this patchset can be read or reviewed!

  LUKS is user-space key management only (on-disk metadata); the kernel has
  no idea how the key is derived or what LUKS is - dm-crypt only knows the key
  (either through keyring or directly in the mapping table).

  Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
  is used in many other mappings (plain, bitlocker, veracrypt, ...)
  Just use the dm-crypt key, do not reference LUKS at all.

Milan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
