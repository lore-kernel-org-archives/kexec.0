Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734C2C32771
	for <kexec@archiver.kernel.org>; Sat, 24 Sep 2022 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MrCfyagu1eOp1vY5s9CwqaasbhPDS3XuYZ+hZ5PU5s8=; b=zlPJITcAuL4X+n
	gjyTg5inpn1w+34xGfUb1peIIZCSvUSNfo2NRwC74GUv2ojNDnLehwzd/dFFXe+NfmowDXShGYlji
	KhKEuhS/tbof6GxeDAHXmx1lm6DkHwtU21Z5M/mOM6bp9MVD/Wll57pQVx+RAcCAfPKcHVFAWFE4U
	C84Jvr0aWa0u9w6jpuaiqySBGSqf3v8wRH1JWFdSy2jTOaQtL+rZxD7uUC6lbUj21HFoXc25mXDlF
	Dd/BUgXvgPn8nPUtEx3vwpl8BzHskKiY+lKPqqLcGjXLHCKecO0TrCeu3d3jjxhhJCSZchT1k8tH/
	eSsNko7FzFuXKcCbcnlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc1j7-006pdz-U1; Sat, 24 Sep 2022 09:45:37 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc1j4-006pco-Db; Sat, 24 Sep 2022 09:45:35 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id F35621F88E;
	Sat, 24 Sep 2022 09:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664012729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+31A8c9OfnUMfxPv1Vio1hLtPmcDuwGTIjcRm3tKEs=;
	b=P3Jq6HqOy5gS7m6FJDMINZyRR8CzuNUbJKkzyYtwRnM1R6DvQu2CQdR/Gu7CeEdmQQPJAw
	eikEp/i1ZBjrdwZ6P8CoMJZBKJIqkRRRCvTDJG/R09FprsSWTCkTi80jVyNXKlEHackQvb
	bvTZPj63OV+ovtHhsrQC4iiLXdkpCiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664012729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+31A8c9OfnUMfxPv1Vio1hLtPmcDuwGTIjcRm3tKEs=;
	b=KTkOyriFJKJx9Ejq1tpe5tI5kJSiUXMkJzZuFFrtte0p785wK6VotBiKdeVD1Tkp8h9r2k
	0jOgM+O9oS7vA3Aw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id E91CC2C166;
	Sat, 24 Sep 2022 09:45:22 +0000 (UTC)
Date: Sat, 24 Sep 2022 11:45:21 +0200
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
Message-ID: <20220924094521.GY28810@kitsune.suse.cz>
References: <cover.1663951201.git.msuchanek@suse.de>
 <Yy7Ll1QJ+u+nkic9@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yy7Ll1QJ+u+nkic9@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220924_024534_637059_908ECA35 
X-CRM114-Status: GOOD (  17.94  )
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

On Sat, Sep 24, 2022 at 11:19:19AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 23, 2022 at 07:10:28PM +0200, Michal Suchanek wrote:
> > Hello,
> > 
> > this is backport of commit 0d519cadf751
> > ("arm64: kexec_file: use more system keyrings to verify kernel image signature")
> > to table 5.15 tree including the preparatory patches.
> 
> This feels to me like a new feature for arm64, one that has never worked
> before and you are just making it feature-parity with x86, right?
> 
> Or is this a regression fix somewhere?  Why is this needed in 5.15.y and
> why can't people who need this new feature just use a newer kernel
> version (5.19?)

It's half-broken implementation of the kexec kernel verification. At the time
it was implemented for arm64 we had the platform and secondary keyrings
and x86 was using them but on arm64 the initial implementation ignores
them.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
