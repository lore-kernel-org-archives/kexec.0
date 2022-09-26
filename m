Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC36C07E9D
	for <kexec@archiver.kernel.org>; Mon, 26 Sep 2022 07:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mhj8znN4Ezxdeq2o5YPxAVVD0OqVZXF6Kpe9B5RyONc=; b=w/bQ/NRJDdUVF3
	9KOK5t5KjwaK1i/W2zpZ0Sa8iKAF2Oi6x0zvyeXUrf8+96sHTQHIQLzjqWcPJN2RV/QWtY4ImtuHN
	iD1wp9jqiQgfyVUDBJipQ3WbxfOw5GryD56vhL+G6wuQJfagPuV12qBJTF46mD8LmxD2njvZqZkPS
	bDO9KvxQM05OQIbYw8SBr9SVEIAkjr5g96ZhsLYitBVJkJbtP14fRsLPOB008KO4/Wd3KjShvMB+k
	+r8RhhKJ1//u4vp+W4bx4LjmVRs4ZNGlb94lyZlpZNIyit1MKBke/RCU6OZgzr7yPRQNEtRJPoDNv
	XrFWXbFczde+c+Hl5t+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocijG-002oFY-LN; Mon, 26 Sep 2022 07:40:38 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocijD-002oCR-BN; Mon, 26 Sep 2022 07:40:36 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 047492202B;
	Mon, 26 Sep 2022 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664178029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGZgF0E5n6faFRHhYY7N3tOGSEz4OpXs9crU58jmWdU=;
	b=ajctCEzyJ9wmkcfXOUq0jfEs4L/5cNYEyNJOJ1KcieGxEAQvc732ap1pHIJ4C92tIF0uXq
	NXUcABSHaygqzdjrzMFCTQqDUTokrml15WfmjyvY+Bv+c27iRvkzAfPAFJlU8QEOY6fYgi
	zwbZ/0r921bgS71pHwHfHYkgpx2cMX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664178029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGZgF0E5n6faFRHhYY7N3tOGSEz4OpXs9crU58jmWdU=;
	b=x+OxzRwQ/tUWaClskW5Kd19q8pt6RZ7bPmXvleufQQRIc0MJ3nhgKPbqF9RxnfM88P9yS3
	f6x7a0flFLubCzBA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 395402C145;
	Mon, 26 Sep 2022 07:40:26 +0000 (UTC)
Date: Mon, 26 Sep 2022 09:40:25 +0200
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
Message-ID: <20220926074024.GD28810@kitsune.suse.cz>
References: <cover.1663951201.git.msuchanek@suse.de>
 <Yy7Ll1QJ+u+nkic9@kroah.com>
 <20220924094521.GY28810@kitsune.suse.cz>
 <Yy7YTnJKkv1UtvWF@kroah.com>
 <20220924115523.GZ28810@kitsune.suse.cz>
 <YzFLBJukjDy7uNVl@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YzFLBJukjDy7uNVl@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_004035_564427_29A16356 
X-CRM114-Status: GOOD (  33.39  )
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

On Mon, Sep 26, 2022 at 08:47:32AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Sep 24, 2022 at 01:55:23PM +0200, Michal Such=E1nek wrote:
> > On Sat, Sep 24, 2022 at 12:13:34PM +0200, Greg Kroah-Hartman wrote:
> > > On Sat, Sep 24, 2022 at 11:45:21AM +0200, Michal Such=E1nek wrote:
> > > > On Sat, Sep 24, 2022 at 11:19:19AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Sep 23, 2022 at 07:10:28PM +0200, Michal Suchanek wrote:
> > > > > > Hello,
> > > > > > =

> > > > > > this is backport of commit 0d519cadf751
> > > > > > ("arm64: kexec_file: use more system keyrings to verify kernel =
image signature")
> > > > > > to table 5.15 tree including the preparatory patches.
> > > > > =

> > > > > This feels to me like a new feature for arm64, one that has never=
 worked
> > > > > before and you are just making it feature-parity with x86, right?
> > > > > =

> > > > > Or is this a regression fix somewhere?  Why is this needed in 5.1=
5.y and
> > > > > why can't people who need this new feature just use a newer kernel
> > > > > version (5.19?)
> > > > =

> > > > It's half-broken implementation of the kexec kernel verification. A=
t the time
> > > > it was implemented for arm64 we had the platform and secondary keyr=
ings
> > > > and x86 was using them but on arm64 the initial implementation igno=
res
> > > > them.
> > > =

> > > Ok, so it's something that never worked.  Adding support to get it to
> > > work doesn't really fall into the stable kernel rules, right?
> > =

> > Not sure. It was defective, not using the facilities available at the
> > time correctly. Which translates to kernels that can be kexec'd on x86
> > failing to kexec on arm64 without any explanation (signed with same key,
> > built for the appropriate arch).
> =

> Feature parity across architectures is not a "regression", but rather a
> "this feature is not implemented for this architecture yet" type of
> thing.

That depends on the view - before kexec verification you could boot any
kernel, now you can boot some kernels signed with a valid key, but not
others - the initial implementation is buggy, probably because it
is based on an old version of the x86 code.

> =

> > > Again, what's wrong with 5.19 for anyone who wants this?  Who does wa=
nt
> > > this?
> > =

> > Not sure, really.
> > =

> > The final patch was repeatedly backported to stable and failed to build
> > because the prerequisites were missing.
> =

> That's because it was tagged, but now that you show the full set of
> requirements, it's pretty obvious to me that this is not relevant for
> going this far back.

That also works.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
