Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FACC001DC
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 06:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZhFDdtsKKmMqT+7IZVYlVGzM+SpvwAo2AiJ687ph3pI=; b=mlQlWTxqTwEdTi
	URtXhbOUF42KoobmaXRcuLzXUvLBzMb1YDmiV19SVbRbpd1D1iXfmuW3L5k1AihfrrO5UFfMPawgf
	H1cfGGouYSbiK8j99bcbAR7+K19WB1XOJOmkA3DdRpkQrdJEsL9mBfcYg52VoMu6qpP3VC1ZGvbc9
	FjOaGXnRciKf1enPQftCCPIldsWPRp550jUlzY8bO/H/AhOsQ9BJjH+GZ+TDgAA9gLapb8Tf2E9jV
	8yoZ7Bk1CBxrhCRVWtwoaZnctHTqpPGHqqlRKL01+RBpMAbTZDuHF2VoTQ4JbZdk51fKMbl7YIccM
	B92faRcgpPRaUsxSCTtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOXcE-009FRl-03;
	Wed, 26 Jul 2023 06:03:18 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOXc9-009FPH-1V
	for kexec@lists.infradead.org;
	Wed, 26 Jul 2023 06:03:16 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fde57684d7so19997315e9.2
        for <kexec@lists.infradead.org>; Tue, 25 Jul 2023 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690351388; x=1690956188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7DlYDzASdtB1auF6MGXd712hY08PNEA8Sc8ogncFWE=;
        b=uygFj9vzXO/Dt/eBXzd/8ASkC2IBDZvl2C96A/iVjWASbQz3lN7c6SFRBX4d6B1Oj5
         qG0rT5uSzi+RC4e2bRHJWpwgJr8eCkqwF2+wJpvsYxvSvw1eGrKsO8q0XGBV/MD1T1Fl
         PKzpgOSdIeCmRQL9BWn+6DY28yr1r/t+xl2KvJZUjtbugk6RL8k2hClysps3vXTY3jOi
         chyh/qI/Z3/igWnNEKOnaBsUCSOU2XTqgglTkkGLUutf6H3t3NV7h3GD82kgryQM0/eN
         jCbwDkE8tIAdvUciXj2myf8t1FHMT8ym3m3fvotfMGHvr5vZdDXmcXYkg3jutSjJFTA/
         y9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690351388; x=1690956188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7DlYDzASdtB1auF6MGXd712hY08PNEA8Sc8ogncFWE=;
        b=DUSU1zx/TLD1v82JjNWSwr+/L6+hXQv7SfNeIFcgSqvgKLGvtZ1qw4fZlnkMBPiNdT
         NlXXE2eESdUwmgF1YiZDRSOKpl8MVz9fTJ0r6f65CmGhhCpeT6oqq/G5V5R5zt+EMZD8
         LlAXcIESH9e2mA5ay2CzY6w7lSYBtK06AunhmwDRHVVY2jLxxUR/bBYG6Wwmt0UBRDeq
         DZsJO0Qab6BA+UeJ9fuCgyD8fAtde7h6MMf5pR+BlBhaXIx30VXTYpeN6kSDhY/RQPC9
         rRwkJuL3RA9ILdAY822hKpmoeqiUvEm3O3CQdH7iOQSkJSHxeMr3uSD2I/bfxAxlnISM
         vF0A==
X-Gm-Message-State: ABy/qLZkkLa6JUpWPfSxIGtHiXMCLcixxZ6vRgvyGVfiA2fmArFUHF0Y
	U1pR/YlLmcPGoPfOjAJzDF1q8Q==
X-Google-Smtp-Source: APBJJlFvo7VsS/C63g22gwEOfDJ6YOIq9GHt7yP68E/2suA/U58tj3MYmTlNyJew1cBo1cvwNpe5EQ==
X-Received: by 2002:a7b:c394:0:b0:3fb:a62d:1992 with SMTP id s20-20020a7bc394000000b003fba62d1992mr570581wmj.0.1690351388549;
        Tue, 25 Jul 2023 23:03:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003fc0062f0f8sm1031520wmo.9.2023.07.25.23.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 23:03:08 -0700 (PDT)
Date: Wed, 26 Jul 2023 09:03:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Baoquan He <bhe@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vivek Goyal <vgoyal@redhat.com>,
	akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix signedness bug in read_from_oldmem()
Message-ID: <c770613e-1f11-4bff-bc5f-9bc6f07a4da5@kadam.mountain>
References: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
 <ZMC1jU7ywPGt1QmO@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZMC1jU7ywPGt1QmO@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_230313_548673_DF4D61FD 
X-CRM114-Status: UNSURE (   8.63  )
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

On Wed, Jul 26, 2023 at 01:56:29PM +0800, Baoquan He wrote:
> 
> Thanks for this fix. Just curious, this is found out by code exploring,
> or any breaking?

It's from static analysis, looking at when error codes are type promoted
to unsigned.  I pushed the Smatch check for this yesterday.

https://github.com/error27/smatch/commit/a2e6ca07e2ef83a72c9ffa3508af1398a6ecc7ed

regards,
dan carpenter


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
