Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE11C4345F
	for <kexec@archiver.kernel.org>; Sat, 27 Apr 2024 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0eYLVQ4JradaW4sqRCtnWNtA5N7X/SUiuWnv6rxqFUU=; b=KJ6P4lmrUbh97Z
	ST9jxMcrBtmpxqAfpAvOGzbJuwo69z2LuO/Xro5shbZKn1XpHPn9nVgbsUhf2A65phFP2FauH1ZOM
	H1jmQyRCOGGcw1XOyBHTgtwVckUTrAkxq0uf0VKm9nURd1y5Ub90OH+sc0HR702t2FuEghgMvbddl
	vJCAuQDQDtcPk1vkgjml47nhJXYKQ9zlqYvdHwZDmndqaoZJIkd1orJo9z1kcxdxzdP40V237ZUeD
	YlAvnyf37sEOhnmElsZk0c0YQ8cjsmi95hfEx+arbzPph6jgZfIaVXUwsGnzsTnOFDQl5OWLYHvxQ
	TsaVCVbgbMWPj46ETKzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0lDw-0000000Fpbg-1Nv4;
	Sat, 27 Apr 2024 16:48:28 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0lDq-0000000Fpai-1B8b
	for kexec@lists.infradead.org;
	Sat, 27 Apr 2024 16:48:24 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 05F6740E0187;
	Sat, 27 Apr 2024 16:48:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RJqSXYuWMYl9; Sat, 27 Apr 2024 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714236494; bh=SQR9m3AlnZH/DoVLOL78q+n6vHtGt70RLlgLJ3+EdQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjGXAN+b8wx5Km/bOJsO0ZI7VOO8xPDmfWqfW9OmLLleG0fdy/h8yBpHmZEFNOg7l
	 tQZd0ZkO/ujyqgn/tRcghWxqpMJL8W71cRx6yggVBsm5c5AsKPqH5mAatwZCB7xZTE
	 KorsprTHlyDtCLstPx/3aiTaQjasP2LdyvZW3TuVBRvK8UD8u+MSeJsgI7ww0v0dWk
	 lI2HFNxI1TmbgjPJ7+Q4NN2jfPCsi1nGWOftkZ/9mc1Kvhj+vdeTfilKimvNzOkGAw
	 syf9J5Ruw4c6Qw6R3h2f75cxRCyCcED9hFofDHFCgI3Sh/TtlKCt65mzh4CYNuEZR5
	 x8ZIU2Zw20taEdkP48LQ/eqVmzLY7aByaogExDmDokQhpWRCiLg8gRia1i7JXwb/nj
	 Sfh4DAXa4p9rR426wKQTOv0G+g4j0zEWBNbwKuf2qVco12zHvqyHmZDJNimQM6NGhc
	 nSyZOzlfQRkIEKdxZJ/oQmirPtXa5Q5a+48XB5ab0O1PV5G0XEqqQopa/gaG9Ia/ad
	 ChY80GmGaeXjVq8kNRbqkvF5QFmsnKI2kd8zYfNbA0AS5sdwG13ir5hSEaNx17vIw4
	 uYeA7jdWVeg+7GmxPjJHc11qf0yzFRgdOLzVS1ErEhxZplrbsG9wdobsPO44KRJ8/r
	 18rO1xRu2is89599r8DzbBoQ=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 831FE40E0177;
	Sat, 27 Apr 2024 16:47:52 +0000 (UTC)
Date: Sat, 27 Apr 2024 18:47:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 09/18] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
Message-ID: <20240427164747.GCZi0sM6HBCBYtgWqF@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-10-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-10-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240427_094822_792384_12847190 
X-CRM114-Status: GOOD (  12.06  )
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

On Tue, Apr 09, 2024 at 02:30:01PM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e74d0c4286c1..7a1560d7e62d 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -128,6 +128,12 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  #ifdef CONFIG_HPET_TIMER
>  	hpet_disable();
>  #endif
> +
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> +		x86_platform.guest.enc_kexec_stop_conversion(true);
> +		x86_platform.guest.enc_kexec_unshare_mem();
> +	}

This is not how this is done - the point of those function pointers is
to avoid random checks in the code but simply unconditionally call them.

The platform which needs something special to happen, assigns to them
its own function pointers and the rest assigns dummy stubs.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
