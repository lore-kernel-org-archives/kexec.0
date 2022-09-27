Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C932C6FA90
	for <kexec@archiver.kernel.org>; Tue, 27 Sep 2022 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MLxUsM7WHGHC46G+Axkaq+etuPDlSur31ubr7GWTIgs=; b=KzmoToPGQ1tM8K
	onkTARWvIEer8V7hB64M6EUjSzBjrjW1kKBiRU8UJ+8dqMstjIwq0fWh5uRSv4GfIuNcX45EfMCI1
	lyc2kvOp9OU8NXUyPHqaZTo93wWWuinmn6/9xtAX81ZFLRStaNdG879r/wC9T71LCcye64Ku2tbgX
	Zr6ESkzL4TYvp5taB/5jzzOtdpPOz2N2LgY1SF2Ek2qkVM+KwOTXGDEu+j9Hx+yq6WuRw+0VroidG
	1J92MSuJ+cHD2LAX3j/2yuoDMydYFr7x3uBnUmjoA9qK5ANjpj+3AItls93cgh2LFlYRqQXXIERHG
	7YTIteePKMN8oj20oapg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5LP-008s1I-9s; Tue, 27 Sep 2022 07:49:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od5LH-008rxZ-Rn; Tue, 27 Sep 2022 07:49:26 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id A7FC721B71;
	Tue, 27 Sep 2022 07:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664264954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VwPyV7AtQHzloaAOjZRzxyWeQSrOsANjomRHJp33DQ=;
	b=v5VLFFd9wq5cE+//cZFZuH7cOpbibmgr9gVvKXGP9FM3RQlBO+gs3evfUkW+vCgxOrTshy
	n+2pVLHQFScJy3uU20eab0wUMdEHJSpALPLuLNpEjcsbcCFjLw9TqYLlXi2nC+ovevb+LN
	LO+UMRMB11+tySlxMbilfLNwj0Qfaqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664264954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VwPyV7AtQHzloaAOjZRzxyWeQSrOsANjomRHJp33DQ=;
	b=i72b3Uei1khrOAbpleZV6WJGrMDJTZm+ya3DC1m6lhLTuY0UD4gT1qMCwuelFNo5c1m1/S
	vdm3M/Qf50Z+mZBQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 6269E2C184;
	Tue, 27 Sep 2022 07:49:12 +0000 (UTC)
Date: Tue, 27 Sep 2022 09:49:11 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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
	Mimi Zohar <zohar@linux.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	"open list:KEXEC" <kexec@lists.infradead.org>,
	Coiby Xu <coxu@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH 5.15 0/6] arm64: kexec_file: use more system keyrings to
 verify kernel image signature + dependencies
Message-ID: <20220927074911.GF28810@kitsune.suse.cz>
References: <cover.1663951201.git.msuchanek@suse.de>
 <Yy7Ll1QJ+u+nkic9@kroah.com>
 <20220924094521.GY28810@kitsune.suse.cz>
 <Yy7YTnJKkv1UtvWF@kroah.com>
 <20220924115523.GZ28810@kitsune.suse.cz>
 <YzFLBJukjDy7uNVl@kroah.com>
 <20220926074024.GD28810@kitsune.suse.cz>
 <20220927023952.GB34139@laputa>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220927023952.GB34139@laputa>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_004925_434003_60C93E3B 
X-CRM114-Status: GOOD (  38.69  )
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

On Tue, Sep 27, 2022 at 11:39:52AM +0900, AKASHI Takahiro wrote:
> On Mon, Sep 26, 2022 at 09:40:25AM +0200, Michal Such??nek wrote:
> > On Mon, Sep 26, 2022 at 08:47:32AM +0200, Greg Kroah-Hartman wrote:
> > > On Sat, Sep 24, 2022 at 01:55:23PM +0200, Michal Such=E1nek wrote:
> > > > On Sat, Sep 24, 2022 at 12:13:34PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Sat, Sep 24, 2022 at 11:45:21AM +0200, Michal Such=E1nek wrote:
> > > > > > On Sat, Sep 24, 2022 at 11:19:19AM +0200, Greg Kroah-Hartman wr=
ote:
> > > > > > > On Fri, Sep 23, 2022 at 07:10:28PM +0200, Michal Suchanek wro=
te:
> > > > > > > > Hello,
> > > > > > > > =

> > > > > > > > this is backport of commit 0d519cadf751
> > > > > > > > ("arm64: kexec_file: use more system keyrings to verify ker=
nel image signature")
> > > > > > > > to table 5.15 tree including the preparatory patches.
> > > > > > > =

> > > > > > > This feels to me like a new feature for arm64, one that has n=
ever worked
> > > > > > > before and you are just making it feature-parity with x86, ri=
ght?
> > > > > > > =

> > > > > > > Or is this a regression fix somewhere?  Why is this needed in=
 5.15.y and
> > > > > > > why can't people who need this new feature just use a newer k=
ernel
> > > > > > > version (5.19?)
> > > > > > =

> > > > > > It's half-broken implementation of the kexec kernel verificatio=
n. At the time
> > > > > > it was implemented for arm64 we had the platform and secondary =
keyrings
> > > > > > and x86 was using them but on arm64 the initial implementation =
ignores
> > > > > > them.
> > > > > =

> > > > > Ok, so it's something that never worked.  Adding support to get i=
t to
> > > > > work doesn't really fall into the stable kernel rules, right?
> > > > =

> > > > Not sure. It was defective, not using the facilities available at t=
he
> > > > time correctly. Which translates to kernels that can be kexec'd on =
x86
> > > > failing to kexec on arm64 without any explanation (signed with same=
 key,
> > > > built for the appropriate arch).
> > > =

> > > Feature parity across architectures is not a "regression", but rather=
 a
> > > "this feature is not implemented for this architecture yet" type of
> > > thing.
> > =

> > That depends on the view - before kexec verification you could boot any
> > kernel, now you can boot some kernels signed with a valid key, but not
> > others - the initial implementation is buggy, probably because it
> > is based on an old version of the x86 code.
> =

> Buggy?
> The feature of supporting platform ring had been slipped in just before
> I submitted the latest patch series which was eventually merged.
> (I should have noticed it though.)

It's difficult to notice another in-flight patch that does not conflict
with yours, and is for a different architecture. That's why we have
followup patches and Fixes tags.

However, the support for secondary keyring was added in 4.19 by commit
ea93102f3224 ("Fix kexec forbidding kernels signed with keys in the
secondary keyring to boot") which was not supported by the arm64 code
either.

> Looking at changes in the commit 278311e417be ("kexec, KEYS: Make use of =
platform
> keyring for signature verify"), it seems to be obvious that it is a new f=
eature
> because it introduced a new Kconfig option, CONFIG_INTEGRITY_PLATFORM_KEY=
RING,
> which allows for enabling/disabling platform ring support.

Yes, and that feature exists since 5.1, and we are talking about 5.15
here. Not making use of the keyring that is supported by the kernel
results in inability to kexec kernels that are signed by a valid key,
arguably a bug.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
