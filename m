Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFAEC05027
	for <kexec@archiver.kernel.org>; Wed,  1 Feb 2023 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T3hpRvumQJbIi2R/5DownO4ZmgQ+Q+hnlVNncSCWhGs=; b=AG0TavSIHMeaDo
	XthRi+ZWXsncB840BGJz3A44g4RLQm1uKWB+ktmSqSGEoflW107OjtNFOAbeL5ccefJmJ3wnDCWnK
	c/fqX6174YnQpcFne0XE+yIK7VriSukcDXulalhhm/WxAdXSyID1j+22sV8mWDHGY3s8T6+Jrme0j
	mbB+2A0fI6OSzphTwUDPAKi9Rqpve9TNVpoEMa9EGqjgZV1ZSSd22cnpyN2Dl6d742o8BGHl1pblY
	cq2JYyGe9N6YFc5lTtqvAKG/IxVPvb2c0DvzuborWdXUFHfEbNmi6IaxI7xP/lfz66CQZ0+f64R4q
	VrHA7v/f5cuGDePQPkcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNBMo-00BUOW-4J; Wed, 01 Feb 2023 11:33:30 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNBMk-00BUJe-Vc
	for kexec@lists.infradead.org; Wed, 01 Feb 2023 11:33:28 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1675251198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nI1PAwKddaSlonMOIonB4C8xfAlPiE+lPzih70stM2Q=;
	b=DEP0O1kN6+ScaSW6M0RPcv/dP/fRnYqSxB1GUlqBk3fBf5Rz31zEVvaXsgLWhJ3l0q9qDf
	p88rrVpmb+uDEhJ2WEcn/qm6KA/lyhhRAj6y546vrUFf1H1Iub12F036/L18p7LH3HenTA
	1j4JwR2ZNFJwx7Enz0GGndT0LLLTWFqZ+c3NH936h5hv2vKTWnSDBmu7k2HZ2hBSnBYK/F
	44KVo0WHhUmy2nuj306rJt6lbcdmSUf/9ljZJK+GcdkB8hbz5J7ufdlsSbo9LCDru/renp
	2sjsLwwMD2shZgKiEZn5BOXr8MHczLZp7SaYQBQqRZ9Hd1lpMnkt/oqj6vsBkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1675251198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nI1PAwKddaSlonMOIonB4C8xfAlPiE+lPzih70stM2Q=;
	b=Ig6VyHyEiPO2YkxAMHiu3NPx6My5ePCG7Qh0v6zCmtEwdojwebYra/4Lti5kIshJvQsSNN
	Haz3abKT7gzfHVCw==
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
 dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
 robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
 sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
In-Reply-To: <20230131224236.122805-6-eric.devolder@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com>
Date: Wed, 01 Feb 2023 12:33:17 +0100
Message-ID: <87sffpzkle.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_033327_182577_0539336D 
X-CRM114-Status: GOOD (  11.58  )
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

Eric!

On Tue, Jan 31 2023 at 17:42, Eric DeVolder wrote:
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -366,6 +366,14 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>  
>  	/* Prepare one phdr of type PT_NOTE for each present CPU */
>  	for_each_present_cpu(cpu) {
> +#ifdef CONFIG_CRASH_HOTPLUG
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> +			/* Skip the soon-to-be offlined cpu */
> +			if ((image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU) &&
> +				(cpu == image->offlinecpu))
> +				continue;
> +		}
> +#endif

I'm failing to see how the above is correct in any way. Look at the
following sequence of events:

     1) Offline CPU$N

        -> Prepare elf headers with CPU$N excluded

     2) Another hotplug operation != 'Online CPU$N'

        -> Prepare elf headers with CPU$N included

Also in case of loading the crash kernel in the situation where not all
present CPUs are online (think boot time SMT disable) then your
resulting crash image will contain all present CPUs and none of the
offline CPUs are excluded.

How does that make any sense at all?

This image->hp_action and image->offlinecpu dance is engineering
voodoo. You just can do:

        for_each_present_cpu(cpu) {
            if (!cpu_online(cpu))
            	continue;
            do_stuff(cpu);

which does the right thing in all situations and can be further
simplified to:

        for_each_online_cpu(cpu) {
            do_stuff(cpu);

without the need for ifdefs or whatever.

No?

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
