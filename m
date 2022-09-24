Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A73FC32771
	for <kexec@archiver.kernel.org>; Sat, 24 Sep 2022 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zUp6JSWhZ/vm5ggnkOSAxYr77Yo9Eng6dbmqT5vSEmM=; b=bdN50txB3Vbimp
	Gyb27flg6UcEZL0YrjrHNUJvn6Ym/ObRvfkXsgsx/fsANNhnCGHnLlykFgKx4xSDDxlvYh/1VzciA
	aKthmRjwmYjB1p2Tmt5O8WTm3rRhmR1gZugPfeqrgCxO/0vHD45Kj9nGJlhyDaS6klH+6chBi+zUx
	zoUYd0+ZP2jB48EUe4iWmFJN1FLpCkYjhbH17b1iP/G0byY8bUbsDPgNFHfUyIvNmGVdbKGBpl9lo
	99NLFNRNi40WEZscybsunSkt1FZ+3XelQQc1+/O9tCBspOz5DkWE/y2YQGVL/8R5PnmgmNC8Tnp3E
	4l4PjMUUKMjJ4QzqFoAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc6O8-007RbT-JT; Sat, 24 Sep 2022 14:44:16 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc6O1-007RZe-V8; Sat, 24 Sep 2022 14:44:11 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 854FE21880;
	Sat, 24 Sep 2022 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664030646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldCH7q8JyvLEKaktegyDOVQARi1eF2vv5KGzrW1iCKE=;
	b=ZYYExhvhe3hvVYy4oVk/eFH8gYNpGCko5Ihe7Zb9d4XHzj0gN+cbmJ5znD+HxwJBv4rbaf
	xOAiTy+7OSutCerOOUzrNf7vSiurU7B6noAUxrtuNDY8e/xv8++TCq4sPot33lF0rn5bY3
	j5D7iIgKtKQkzwHDFuKS1s7nX1iR+bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664030646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldCH7q8JyvLEKaktegyDOVQARi1eF2vv5KGzrW1iCKE=;
	b=LwyQx+Mw9MIzMldTchSCV/M9BlwXBCMS+77FXL0rg1zfTVtmjUy+KUTCczSeB7Oi5a4eGF
	DV0wxb7/VTheveCg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 2218E2C172;
	Sat, 24 Sep 2022 14:44:05 +0000 (UTC)
Date: Sat, 24 Sep 2022 16:44:03 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	keyrings@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
	"open list:S390" <linux-s390@vger.kernel.org>,
	Coiby Xu <coxu@redhat.com>, Baoquan He <bhe@redhat.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	Philipp Rudo <prudo@redhat.com>,
	" open list:KEXEC" <kexec@lists.infradead.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 5.15 0/6] arm64: kexec_file: use more system keyrings to
 verify kernel image signature + dependencies
Message-ID: <20220924144403.GA28810@kitsune.suse.cz>
References: <cover.1663951201.git.msuchanek@suse.de>
 <67337b60a4d3cae00794d3cfd0e5add9899f18b7.camel@linux.ibm.com>
 <20220923191650.GX28810@kitsune.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220923191650.GX28810@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220924_074410_173244_994418B5 
X-CRM114-Status: GOOD (  20.62  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Sep 23, 2022 at 09:16:50PM +0200, Michal Such=E1nek wrote:
> Hello,
> =

> On Fri, Sep 23, 2022 at 03:03:36PM -0400, Mimi Zohar wrote:
> > On Fri, 2022-09-23 at 19:10 +0200, Michal Suchanek wrote:
> > > Hello,
> > > =

> > > this is backport of commit 0d519cadf751
> > > ("arm64: kexec_file: use more system keyrings to verify kernel image =
signature")
> > > to table 5.15 tree including the preparatory patches.
> > > =

> > > Some patches needed minor adjustment for context.
> > =

> > In general when backporting this patch set, there should be a
> > dependency on backporting these commits as well.  In this instance for
> > linux-5.15.y, they've already been backported.
> > =

> > 543ce63b664e ("lockdown: Fix kexec lockdown bypass with ima policy")

AFAICT this is everywhere relevant, likely because it's considered a CVE
fix.

> > af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG =
is configured")

This is missing in 5.4, and 5.4 is missing this prerequisite:
fd7af71be542 ("kexec: do not verify the signature without the lockdown or m=
andatory signature")

> =

> Thanks for bringing these up. It might be in general useful to backport
> these fixes as well.
> =

> However, this patchset does one very specific thing: it lifts the x86
> kexec_file signature verification to arch-independent and uses it on
> arm64 to unify all features (and any existing warts) between EFI
> architectures.
> =

> So unless I am missing something the fixes you pointed out are
> completely independent of this.
> =

> Thanks
> =

> Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
