Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA47606A325
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ueeFERuA;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=XnSgkqE4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FroopTMuPleqi9xrjHNZRUYAbvATL8axnG/vJHY5tGg=; b=ueeFERuA+eyrKNodqi/Fx3GdfN
	dmbeCod0/bqvmZd6C7c9xTEI7D0pBXp9ClRYj3FK1JpV1HPqAEgsdTKwdVCqSxTApEsCbECMhqCYw
	daK9kS8BPMztgzbnfLqscFSlWyfLoMyFFa1dTgNTC9eVmoGgMy77wm8WunmZM8qYJXyBE8Z4LYzee
	lamjEDoGicRfbfj4Gc9hJJf2IslLrrXn30rlEcoGVxzNhXXK4A8NgeWAlRl4DVfS/kh1cnYbEHU6o
	5EsfU0/CXO3w2bQlaM3UcfK2gH40bQA3GlGH/omd87Skfl36MSXJ+GTm4mWeyAJaMdIeKG++ns6uT
	+MahD5AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUK6y-0000000ELhT-2cIb;
	Fri, 20 Nov 2026 08:36:48 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUK6t-0000000ELfn-13Uh
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 08:36:47 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-49465892f7bso485396f8f.1
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 00:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795163801; x=1795768601; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FroopTMuPleqi9xrjHNZRUYAbvATL8axnG/vJHY5tGg=;
        b=XnSgkqE45AeTH2TEBx2Ar+4fsPm2A7WNK2YW+strfzGWsYNk5VdCn72E99M1z9Rboy
         WDxVEb6oCt2rCMB2NpME7X4n43pm6GGOTkD7/Z/rAF2wSMuQ3Xq2PWL35aaihjP+gnK2
         RPJCNP1etkF8cMdxLPtxzwdJSOrjZ4NkEQRg2ZAKXsKO+gPEqyZ7aJSBW6ZwXIcBl6jJ
         HBN6QMsAqOJFIqiWGhrjEK1TXHwZBt+/iRes4Q9x/bjKsy3L6Lh+EXKOvXQzvNl79SUi
         SRy1o9HEygK2fOKuvdO1s1X3MCxWDsqluc9MMI88EnXFlB3NgHkkUxaCQOGHwlq9sfPo
         kYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163801; x=1795768601;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FroopTMuPleqi9xrjHNZRUYAbvATL8axnG/vJHY5tGg=;
        b=koT04j6Ywh7Wk8NuxyAk6xeVklVzGq1ryeuC920bAnSpzAyv1+EPKdntS8MWWMGcCz
         yWUABXrU1t6J0b+3WU+A/h9MRjozi1YTdH+AIhhs7M+rLqSuOyO/TEnYuvGCrVLOY93D
         NLG+gDMMQyqbLWiTIaQfdoCGxsr/4q2073uc3WZOIBQ1NbyyZP0Kj3TptM9Rxkiea25c
         Oj30JCEZu2UNB8IPCiy+Jl21k/m+4HAKRBUU0Z7NUnWexqeBXEJVMCh/gZ9BYlxEaxdy
         yvcGmfV4PVfNwAUWWHwlf9MInCE6pkYwNBAd483wJ8o6ilYZQ0gN9Oi14n/YnNSWQXQ9
         gTRA==
X-Forwarded-Encrypted: i=1; AL+hErGAuG+y3nx2UHiLthdUL7lZIMs60ehxR/hWxG4Xcpg0cMQPuaxNK622iKC+dOBz1z7c1Jwyuw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8BoQBqc+Z9fHRSRRVsndjS6nuevsYvnlvDhqka2y3VduCXA0AH
	JMrDWqpH9aQIy0erRN85XFmMQ7keMqoE8aBaXE7j820ZPbtFyQ2iFUSEr5UoXgLMESk=
X-Gm-Gg: AYBFou0hkbHSIXkl5u8StQ5tYnV+uyWbApbjRtnx36uYKL0JAtvovdDTVrkf2xuDWP4
	D0DvHNmOZNCQhQCbTGT7qWK6MjqFsS0oEQkC3CI2Nx2/ClV8CIJbKFG++n3JdKshg43YIZ/+FZm
	Btraf9um86/tudsz2FRXStZFc5bTO5IlTmOldd44B3kvuvF+rQtogMlqdl5hOW7LXMn2j8WYMxt
	gcBuRcYH/woutt3iXoC0VkLFRfjjl/zKrGtb/qDKCIlpsAoshzYeXQRyx6pcp2sbNpJ8/n9zMvS
	nl85YQyK1blFgtsvPS2Md6uVx6n4JE87CCru76SgBclHkNSn//ylU4cC+DDRRCuWb6KxR1n4DAp
	pIG1ohVy3h3evDyJQhDFh0qhTS1b+SRXZg7u9ScIsUElcOxsW1+Geiq2OtcTOtHjO+0U8HRwq30
	JD4LelVtHPoSSg+b3b0Rfg251zwDjhsqfSnm8WuTeWZh8UTGp2CjNYUOl6Z0Wjwp7oKpckKOhs7
	6snhT3FrRfjYjGRmByBMYaYvbwMBnf0fFBRAFhDYRZfZP3iusSf2LeTYQ+cCnwmvGm4nqL8wOFL
	yRmDLiVav0iYngoZ4b8w9ZLs/yTQTRez5BpjcvkztQ==
X-Received: by 2002:a05:600c:4e16:b0:4bb:6f77:1e35 with SMTP id 5b1f17b1804b1-4bb88810991mr53940545e9.21.1795163800697;
        Fri, 20 Nov 2026 00:36:40 -0800 (PST)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm126587935e9.0.2026.11.20.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:36:40 -0800 (PST)
Date: Fri, 20 Nov 2026 09:36:37 +0100
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Subject: Re: [PATCH v4 1/4] panic: Add a platform panic notifier list
Message-ID: <awAGlQhpaLtrHCAR@pathway>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <3d156f7b5ec4f3d6f91e288a38f87d2368f1365f.1794980455.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d156f7b5ec4f3d6f91e288a38f87d2368f1365f.1794980455.git.zack.rusin@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_003643_315038_66A476BB 
X-CRM114-Status: GOOD (  14.75  )
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

On Wed 2026-11-18 01:01:48, Zack Rusin wrote:
> Some platforms set crash_kexec_post_notifiers so their crash handlers
> run before kdump. That also runs every other panic notifier and kmsg
> dumper before the crash kernel.
> 
> Add panic_notifiers_platform_list for platform callbacks that need to
> run early and are safe while other CPUs are still running. Call it
> from vpanic() before kdump and before stopping the other CPUs,
> independently of crash_kexec_post_notifiers.
> 
> Also call it from __crash_kexec() if a crash kernel is loaded, since a
> fatal oops can enter kdump without panic(). Call it before taking the
> kexec lock, so a callback that panics can still enter kdump. Run the
> list at most once, including when a callback panics.
> 
> Add disable_panic_notifiers_platform_list to skip these callbacks
> when debugging panic or kdump failures.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Link: https://lore.kernel.org/r/ateYxCu63pRY9EGq@pathway.suse.cz
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

JFYI, it looks reasonable from my POV:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

