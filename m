Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A995AC07E9D
	for <kexec@archiver.kernel.org>; Sat, 24 Sep 2022 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lyo4AUyPF+Z0izTJCd8/xVUByq1uGomH5dc9R8Je4L4=; b=38ZWhO/OSo/A6/
	phKAXVnP/Jms2ytw5TD8+GW57n1cfptkbnAiYcnu4Gn4fkiOpMC6R3/a3ApNHYxDndJ3SfHyY2B6J
	To7pNvvywWPENWfie6Bakp2IztQ6uGVamDHl8dy9C9/yU5DeGsoNgEMxQ3CDDZoieS8GvI97syS2T
	eeQPiAdc1SVRkYHfjzHFFo1liV2QwSXNhKg4yzQ4OrzJ0we7bX+e1VHE5oVsdJXTGZHi7bwv4CJkh
	pzQxv6gm9iUdkBvkvQSJvYe8YlQzhqYyERNOXKQuXmxNobxhiHx4IrtSt8hTHlN8ZAjhcy8KQNpft
	fsYGa6e2JRuaEtftNsuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc3ky-00733b-BR; Sat, 24 Sep 2022 11:55:40 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc3kv-007302-GJ; Sat, 24 Sep 2022 11:55:38 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id B8C341F901;
	Sat, 24 Sep 2022 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664020527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79a8D2Ac7u6BFH11MTZyHbw/7iUCqU/F8iDUx62qwgI=;
	b=YGEJD2FnZ9chHMjXQmq8tdyuK381YZ49y8Fwu6+QAESAODmoRFO6jaBrLA+UNJOD74ZXgU
	hRqDPRKM+aBa9zhQ/rw0ACFs90S1D1jpjzgf4mysd+w97EHzqCfYBn+ncLZekTVmq7ELnj
	5l7eXJMwaYodicCd6KkAfOLiw6C7qbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664020527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79a8D2Ac7u6BFH11MTZyHbw/7iUCqU/F8iDUx62qwgI=;
	b=nzWakO9kDNhf03FBvsJdphgf1O0ls25eU8ml4O7M7wQRDydBm7NdZbDWeYkgsiPNOJC78F
	Y/Fua/kXHZSDahCg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id D8EC22C16E;
	Sat, 24 Sep 2022 11:55:24 +0000 (UTC)
Date: Sat, 24 Sep 2022 13:55:23 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	Mimi Zohar <zohar@linux.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	"open list:KEXEC" <kexec@lists.infradead.org>,
	Coiby Xu <coxu@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 5.15 0/6] arm64: kexec_file: use more system keyrings to
 verify kernel image signature + dependencies
Message-ID: <20220924115523.GZ28810@kitsune.suse.cz>
References: <cover.1663951201.git.msuchanek@suse.de>
 <Yy7Ll1QJ+u+nkic9@kroah.com>
 <20220924094521.GY28810@kitsune.suse.cz>
 <Yy7YTnJKkv1UtvWF@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yy7YTnJKkv1UtvWF@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220924_045537_699221_8AB3CA78 
X-CRM114-Status: GOOD (  25.39  )
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

On Sat, Sep 24, 2022 at 12:13:34PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Sep 24, 2022 at 11:45:21AM +0200, Michal Such=E1nek wrote:
> > On Sat, Sep 24, 2022 at 11:19:19AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Sep 23, 2022 at 07:10:28PM +0200, Michal Suchanek wrote:
> > > > Hello,
> > > > =

> > > > this is backport of commit 0d519cadf751
> > > > ("arm64: kexec_file: use more system keyrings to verify kernel imag=
e signature")
> > > > to table 5.15 tree including the preparatory patches.
> > > =

> > > This feels to me like a new feature for arm64, one that has never wor=
ked
> > > before and you are just making it feature-parity with x86, right?
> > > =

> > > Or is this a regression fix somewhere?  Why is this needed in 5.15.y =
and
> > > why can't people who need this new feature just use a newer kernel
> > > version (5.19?)
> > =

> > It's half-broken implementation of the kexec kernel verification. At th=
e time
> > it was implemented for arm64 we had the platform and secondary keyrings
> > and x86 was using them but on arm64 the initial implementation ignores
> > them.
> =

> Ok, so it's something that never worked.  Adding support to get it to
> work doesn't really fall into the stable kernel rules, right?

Not sure. It was defective, not using the facilities available at the
time correctly. Which translates to kernels that can be kexec'd on x86
failing to kexec on arm64 without any explanation (signed with same key,
built for the appropriate arch).

> Again, what's wrong with 5.19 for anyone who wants this?  Who does want
> this?

Not sure, really.

The final patch was repeatedly backported to stable and failed to build
because the prerequisites were missing.

So this is a backport that includes the prerequisites for it to build.

If nobody wanted this why is it repeatedly backported generating the
failure messages?

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
