Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BCBC77B7C
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vqq3kk+OPuvtx0k7f0M8BaYj2rEorOjXc9nxavSS+Y8=; b=14+igdoneKmTT3
	g3rlIM2W2xCbSkRTkWclpMI1WYl8T1MoD5NlwBc3o9e7SMG+HEuh+FqHtIQI1Z5IQD53XAXFiTKzF
	cLvO6cdl0m1+OrCZT0BR2YZMgEo09h389GaWRkNMpR53ppASJ3vTGie1U5GvMl3zuZ0q+EUxBIqjH
	YZl0qXT4K6eKqYRujlXLhguc7yQKobEP5TWKwHk2ZQ050bZOtMqSyqKccmrgPRI0VHoZ7RJARS6Ea
	Gs0I4Hu8pZFkxntoKJPH+NGn8sr24hmJNwj26S7pxHCAB/0OLO7FPybk4hV4tVkigIYAhv/20CGf8
	FRyZnr2Xidplh/K4Xobg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puzdu-00BTTu-1E;
	Fri, 05 May 2023 17:54:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puzdr-00BTTA-1s
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 17:54:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 23CC760F29;
	Fri,  5 May 2023 17:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4700C433D2;
	Fri,  5 May 2023 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683309290;
	bh=iGxlMMfHq5zekP1cLLlA597ifNT3g2z8NHymFlQCd4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwja6AwnW4smOMGRvawHd98VsnoIFBSK6V0Q7CWqwqpW+qLg4TnkjoEXb5RTczp2T
	 H07bIqfn8yxspOmufiM8hf7fNhnsOdCexce9/d/ezR8WycIYoieyrINfU54O74/CF8
	 BkTMvbNq2yJFNqMqCs71QXMf7i7+w3t+L20j8nrckRfVZ/KwKnjDEXJ5oY4B5cqTnv
	 Lsk1y/8yD+JH/9r19Orhvb8pvG1Io1rOzioDerHmQfbQhl0TZ9VEstOquq01RaGDPp
	 nhSu9KZwx8NAF+ojYagr0e1ZZ5hoboZprPhyn+OeFJ0qg0HkwHdgVtIRLdu9NvEQek
	 uq9EJ14iow/xQ==
Date: Fri, 5 May 2023 19:54:44 +0200
From: Simon Horman <horms@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 09/14] x86: Secure Launch SMP bringup support
Message-ID: <ZFVC5Fv0wO0Awt0N@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-10-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-10-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_105451_660934_9A577F2C 
X-CRM114-Status: GOOD (  15.41  )
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

On Thu, May 04, 2023 at 02:50:18PM +0000, Ross Philipson wrote:
> On Intel, the APs are left in a well documented state after TXT performs
> the late launch. Specifically they cannot have #INIT asserted on them so
> a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
> early SL stub code parked the APs in a pause/jmp loop waiting for an NMI.
> The modified SMP boot code is called for the Secure Launch case. The
> jump address for the RM piggy entry point is fixed up in the jump where
> the APs are waiting and an NMI IPI is sent to the AP. The AP vectors to
> the Secure Launch entry point in the RM piggy which mimics what the real
> mode code would do then jumps to the standard RM piggy protected mode
> entry point.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Hi Ross,

just one minor nit on this one.

>  /*
>   * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>   * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
> @@ -1132,6 +1210,13 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>  	cpumask_clear_cpu(cpu, cpu_initialized_mask);
>  	smp_mb();
>  
> +	/* With Intel TXT, the AP startup is totally different */
> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==

nit: spaces around '|'

> +	   (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) {
> +		boot_error = slaunch_wakeup_cpu_from_txt(cpu, apicid);
> +		goto txt_wake;
> +	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
