Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA80EC07E9D
	for <kexec@archiver.kernel.org>; Fri, 23 Sep 2022 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SXlAdxF9CpP36/ULiLAYp8XfzGbO/T5frKLwekYiT/U=; b=1NKintnDZ4WKkw
	cJM1p29XkSbfbS+Ya/fMB01emxqSyC/Zhnc5G+oPHoY8NKkgPFMhIe1NHepO0sGVN8JvZTbL1cOv3
	0VY3OCgr8iFY1MEf1ojhzcf0SkpuNEFOFiL8wzxRORelJeggSaSTHzOoToLvzC1rPxEX2NURtfu23
	CGFKxgp+6ZCdcGk6uyNPtyXQHexnwiIlmfAk2OTV7rzeu4kfnIz5Omd8/NRFRdUqhGS2Zz2g9amwr
	c1CkYq8Qj3loDCM6mUulSj00BiRjprQe89VVahBn/Vm5yU0yDDEwcPDvLeYNJYuD1tUfeU97Cyt9O
	IpNroSNykFfDDfa8mQeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oboAZ-005VfK-Gl; Fri, 23 Sep 2022 19:17:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oboAW-005Vd9-9m; Fri, 23 Sep 2022 19:17:01 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id D7BDD1F88F;
	Fri, 23 Sep 2022 19:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663960612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7ZPOnaCl1bvAhxAcIcfHQhBd3XlM8j/v3z+xwYqH9Y=;
	b=RxICWe9ShUOJ30yrxK1Sg337ibKGDWiBuCCfxe3PxnQDXehTnWoUAxFGm5efJJElnCRWYC
	T/EEFnwjXDbp1a3EUY+qRjBlZgJmh01Kq/w3WmKQrPle99zuvPSp1ZWQvpmJBRW3Md/Gh+
	hUMW16JhjAIT9slsMZQE8GgUslBWn+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663960612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7ZPOnaCl1bvAhxAcIcfHQhBd3XlM8j/v3z+xwYqH9Y=;
	b=3o5yz8IUMFuZYyHXKnE++yxz0+3AfWIuGDj2UVpRZKJG7D+gcy2qYgZToe/bEoYUVe37Df
	Pa8q+QubOpYRpICg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 841FF2C15C;
	Fri, 23 Sep 2022 19:16:51 +0000 (UTC)
Date: Fri, 23 Sep 2022 21:16:50 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Philipp Rudo <prudo@redhat.com>, Sasha Levin <sashal@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	"open list:S390" <linux-s390@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	"open list:KEXEC" <kexec@lists.infradead.org>,
	Coiby Xu <coxu@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 5.15 0/6] arm64: kexec_file: use more system keyrings to
 verify kernel image signature + dependencies
Message-ID: <20220923191650.GX28810@kitsune.suse.cz>
References: <cover.1663951201.git.msuchanek@suse.de>
 <67337b60a4d3cae00794d3cfd0e5add9899f18b7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <67337b60a4d3cae00794d3cfd0e5add9899f18b7.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_121700_489461_D78BB36C 
X-CRM114-Status: GOOD (  16.61  )
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

Hello,

On Fri, Sep 23, 2022 at 03:03:36PM -0400, Mimi Zohar wrote:
> On Fri, 2022-09-23 at 19:10 +0200, Michal Suchanek wrote:
> > Hello,
> > 
> > this is backport of commit 0d519cadf751
> > ("arm64: kexec_file: use more system keyrings to verify kernel image signature")
> > to table 5.15 tree including the preparatory patches.
> > 
> > Some patches needed minor adjustment for context.
> 
> In general when backporting this patch set, there should be a
> dependency on backporting these commits as well.  In this instance for
> linux-5.15.y, they've already been backported.
> 
> 543ce63b664e ("lockdown: Fix kexec lockdown bypass with ima policy")
> af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG is configured")

Thanks for bringing these up. It might be in general useful to backport
these fixes as well.

However, this patchset does one very specific thing: it lifts the x86
kexec_file signature verification to arch-independent and uses it on
arm64 to unify all features (and any existing warts) between EFI
architectures.

So unless I am missing something the fixes you pointed out are
completely independent of this.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
