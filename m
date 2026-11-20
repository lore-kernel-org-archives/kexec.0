Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0A606A320
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OI0ARlab;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=f9cQug6M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NXbyh/zLUD7PEdLtCVAgHutA0kCgtrDRw7/iSzMTz60=; b=OI0ARlabJqIKSI2PuqgjiGXAql
	vDe0sg2FzxfHwlRWNdAEmNK5k/zleXaJhE6k1xoI+LNvU+4Jm95zaWN5tJ+ETYmZHZFssNJH7JIWT
	J8tNeVD94GG41lts8TLBZpdKyusj3JkcL7zkUJ2SNFk/ynb0GyHUWd2CvZM+MNVoKM/hyx3SJoEPJ
	FDKbl12KC+Om2gX4UG+b7D8s3wRkvfqtU09FS7/jR3OZqlrPDXuOJM+71JShsrIwkQGR/0UTQ4O/n
	ubhJHKDb+rwo2aHJb8GwTm9v3L+SshNI/NG7dCB+eOJIZg6aC+VvfrUUlpzcNvLY4nZz2t2ZR4Dsq
	05Ebh/zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUKmN-0000000EReF-1Qm0;
	Fri, 20 Nov 2026 09:19:35 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUKmD-0000000ERZV-2mC8
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 09:19:29 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so5884875e9.2
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 01:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795166364; x=1795771164; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NXbyh/zLUD7PEdLtCVAgHutA0kCgtrDRw7/iSzMTz60=;
        b=f9cQug6McOvDUdKB++yjefy5aNjs83AhgfTVtxV0gs44t4imitiNIwRMpzlUPLsfcD
         mvhmCWDg3IuJQshbq6F/6vrgJFm+AKJryR9LhouQl4aHDcg4oe6nPmAoVLy7EWbMWtFn
         sYg83/pJoBKDx7KSzvMyY6rmY45BOftDHhZwDLsgxMAELywU0ahhBTq/CZv/fcyGZF8H
         Rks8Ou4ql7AsX7zwo54vvD1YGID0+eXYjv/Vi3gzTwzR59aZ9mhmo/3rrx7uRbBf79jl
         C/TnbQavXuP9Jro3CTsP1p4W+b2uUEwXAWf3nyv3M+xWfxu47yCAjf68fb4eGguo/r4x
         SHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166364; x=1795771164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NXbyh/zLUD7PEdLtCVAgHutA0kCgtrDRw7/iSzMTz60=;
        b=1yk5e4OQSK//fMhwG2P3Lnz1I4xne4wjl5bIolPnJUNVVcMwvshEJNbTkC2qqbR4s4
         TZVc1SovBGuw25poEe4VEZ450jg203A77Vv5OIlU+lQCLxLovKsqxrI0MTFd7rlysrVZ
         eYApRA6ua8j8cDKpsltFTLT93dUrbX86ND0Xg33YOlSChSs8OuMzTtOlX+Fzh1X3aJJl
         R3swaEJG6ad5MD/HoTpkdYPKbiQwv+7NqdVTTpxAeJH/h7EU9pFyHBhFkIhVuM6bZn+6
         ZFKntXzMGRceEl4Xi5NXr7xTjgyhkRUyXe93oBVGj2m4HCW0o5LUklMfJOgddS2nv7Re
         tXjw==
X-Forwarded-Encrypted: i=1; AL+hErE8G9H5RBEdq5PCji0qwMrTl+u0cmis/2n4w20dOaExMw5qbyXPHfKGvURL/8yPAyCq+AZGFQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z+3WtSuYvFAhcCgH4blnIAMgp1rEIaf7qqvXkbYyQUZmPtn75k9
	UzX4sBGeN+p1pcrwTZnmtqeuEwLFActgarI8qcXQ4U/mlsZOMvOiRdzRzC69ljozSNI=
X-Gm-Gg: AYBFou2nIPPixzQkEyEOXYldJ5AtgHNukPiA6X6T/Zj4Bdj0h8e/JpYBytoEbQPknpO
	B3Wu4VE8RlC3PVPGnmoZo9lxx9maUFtRR2id2T5MKpovOBuBpbsbImHZF+iPCnAlxkOFhuokdvq
	miHkg/YpZ6N93idKGIsr+SF15bHJRG5w3uJZ56gLoxc2FlP3dCG81Q/Am9c3cMDISpQTw3WsKpT
	58EcBtBjpWs/1JYlq4jZ27/r4J4rzLo9EPwQjCiJ1YS8njfMlBSsq/VMHQ46GYVw51PcdiYGo+z
	YLLT6O3kcswmEriAmjRvfPEh0DqLQ3LjqUo+WazODuyeu2q7sOQyqvDcrPvMciUF1Jez+HPyCP0
	7X8jF4fQ20cWaEQwgZI0YxVog05QmlS333z45N0Fi+9pQwC0Ie7KhtW4gGBKD+y4un26n1TDoIT
	z5NEM0MzfWBm41ToKhHNB+uEQc8+GdUecQdmHpF82rMvwQ0sRqvfiKgCC2Tsq4K2kzZvTsH1OVu
	56ESfNh2U7evtGVCEaV+GoYf+mDhT1bxYkvNyWOzbBfBHEhd5rwAT8pemWjgDlk4vqBPIVzWcWs
	ivK2Fn9BwO3BVSXlFLEk
X-Received: by 2002:a05:600c:530e:b0:4b2:2ec5:8a2b with SMTP id 5b1f17b1804b1-4bb887fe8f1mr53972495e9.10.1795166363741;
        Fri, 20 Nov 2026 01:19:23 -0800 (PST)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f643adsm27023055e9.1.2026.11.20.01.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:19:23 -0800 (PST)
Date: Fri, 20 Nov 2026 10:19:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Message-ID: <awAQmI2wu0rI-efH@pathway>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_011925_769729_642FA86E 
X-CRM114-Status: GOOD (  10.79  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, Baoquan He <baoquan.he@linux.dev>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed 2026-11-18 01:01:50, Zack Rusin wrote:
> Allow administrators to disable host log transfer on ordinary guests or
> opt in on encrypted guests. Expose the boolean recording policy through
> kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
> Zero disables recording, nonzero integers enable it, and reads return
> 0 or 1.
> 
> Register the sysctl only after the logger is ready. A registration failure
> leaves the internal default in force. Document that the log is sent
> before kdump, and that disable_panic_notifiers_platform_list also skips
> it.
> 
> Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

LGTM:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

