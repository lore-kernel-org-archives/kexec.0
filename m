Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC13C433FE
	for <kexec@archiver.kernel.org>; Tue, 22 Nov 2022 17:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7DfW3j3OpVlHzo5shtrI0fmeCuoJ/6qXuRSvOWauY60=; b=izNN1wl5HCypsW
	e5vY6CCBhYsDxrhp7SWtpy9WMCapQD+1dkPxFq0N2IfjA2FXm1WEm85H+NDdxCL5g5z/9P66anzPd
	BEp429OEGRbZkgNgif5cpL/5RGQ0HL41dv4kANNzunRQfJnWPa3VFseICctflVB5g5bUHmpF1KcgI
	++NjsDXBsuHXXCqUBTwxUi7RsHGnVBV5wyt8+MSRaHQobk6impgZ2tIjRcGQBvsZCTGiPEI0vJABB
	PUCvoNzQfADNxyUNuoxRy+YZ8ZeQY52rTKtODfZwIdRUS7ueWUQIp/c9LSprJjcrmlDI0oR/7Tfw4
	9pC9mmqGQ74PmEDWFUsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxWdX-00AuEM-M9; Tue, 22 Nov 2022 17:00:43 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxVcd-00AVkd-Tf
	for kexec@lists.infradead.org; Tue, 22 Nov 2022 15:55:45 +0000
Received: by mail-ed1-f43.google.com with SMTP id l24so8660998edj.8
        for <kexec@lists.infradead.org>; Tue, 22 Nov 2022 07:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh7zIHNaqUt9tu7IfYlCEpfnwk9Rt/70h7f9hwLslZg=;
        b=uCWq70gSKiJ7vbGuMiTQbm/IkW++Q/DWUv+O+ZkM0cmBi/QjKaWshfcIOGWNKE+Ej4
         mNwIa3JqB89IFeZKHJU18CUoSZZc/d6r4kgJ+lQ1K340N3i95yNtiiPh9ZkpNLY7PzUV
         WiiFzsh8KYTOEB9rm0mlPjpGKbqe7zoBOvGODtfHdf6UZ9KsTG/I0EeQ595o7E3sl1sg
         IvARnPIFPlJUlfOICFCca1cNteGRBAAm6I1Dlinf/B1SdqL/leK6Bwwi8nif4Y158+GQ
         XsHafZsfasGoJLRKw+ElCzdZRg32AlkLTpUymXTI45j0WyNNtoT9KNwMEoYk4uJ8phtL
         c+CA==
X-Gm-Message-State: ANoB5pn7YJPwzU2p0HZBccwlULWd7l/CBS0kBgZq5smy/MsZowmMOJnQ
	McklNJFXrRlZfw+zrpHaRH7cipvmxeH68A==
X-Google-Smtp-Source: AA0mqf4U1I4JMoEEF0wIL4tk5IpLvSks1ktxEnC/K38OFNasdNQirn0whv78F+3gAE6LhjBCkH/0/A==
X-Received: by 2002:a05:6402:448c:b0:461:7378:3501 with SMTP id er12-20020a056402448c00b0046173783501mr4618015edb.35.1669132538817;
        Tue, 22 Nov 2022 07:55:38 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id jt12-20020a170906ca0c00b007aec44edcfcsm6148933ejb.75.2022.11.22.07.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 07:55:38 -0800 (PST)
Date: Tue, 22 Nov 2022 07:55:36 -0800
From: Breno Leitao <leitao@debian.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, leit@meta.com, cascardo@canonical.com,
	hpa@zytor.com, jpoimboe@kernel.org, peterz@infradead.org,
	x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <Y3zw+LK5C2esYU8o@gmail.com>
References: <20221118194602.vpo4xjm4s7knm7ja@desk>
 <20221120120255.13054-1-leitao@debian.org>
 <20221121222031.uo2n7fv7ojusxvr4@desk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221121222031.uo2n7fv7ojusxvr4@desk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_075543_971252_2455EA60 
X-CRM114-Status: GOOD (  15.33  )
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

On Mon, Nov 21, 2022 at 02:20:31PM -0800, Pawan Gupta wrote:
> On Sun, Nov 20, 2022 at 12:02:55PM +0000, Breno Leitao wrote:
...
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 3e3230cccaa7..970b277d02a6 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -137,8 +137,16 @@ void __init check_bugs(void)
> > 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
> > 	 * init code as it is not enumerated and depends on the family.
> > 	 */
> > -	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
> > +	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
> > 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> > +		/*
> > +		 * Previously running software may have some controls turned ON.
> > +		 * Clear them and let kernel decide which controls to use.
> > +		 */
> > +		x86_spec_ctrl_base &= ~SPEC_CTRL_MASK;
> > +		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> > +	}
> > +
> 
> Nit, extra newline.

Thanks. If no other comment about the diff come until tomorrow, I will
send a v2 without this extra line.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
