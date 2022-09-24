Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE03C32771
	for <kexec@archiver.kernel.org>; Sat, 24 Sep 2022 09:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SVlPAJ+C+skTBda+4qlPgK8sK38mP4SHOXK/KhH5tUI=; b=1fje4Vvu/vdmPn
	rcVuhZNpxOpED8E/sPAsnReGbMiR8MwZ8Vi7f16YClsdLc33ZHwe5VPqgNfH17Ccz9nGg8gpKBXXl
	vw6JgmJdwtry3ufsGDnwR/+Y75VvrPCJcbkoSw1DA4K/nMjW9L4VXZ8lbcjnuZR9UDF8PWS5ANhtE
	PSKlF32Q7/jr+puiqWVQI6PG1Oxn3L1aICLAWfFA9qIgtrUoOvwUwxHoLriFFEha2LoZTT2iCpId2
	uqvGogDm+KweBdo9XytOCCAoQDS08754OiECbeTtL0VadtB1ubYl00DROslqoN4QMJznVe1iCNTbM
	y05aAqVfZ85RgKGCA+9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc1Jo-006m5j-62; Sat, 24 Sep 2022 09:19:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc1Jk-006m54-Pc; Sat, 24 Sep 2022 09:19:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2241360907;
	Sat, 24 Sep 2022 09:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A21C433D6;
	Sat, 24 Sep 2022 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1664011162;
	bh=+S04GeAW3/TLKjCQ5LxuuH1wKpbCajXi/U4ujhoS9mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAMjQHP6GB5PCvySH2eTGeFQa4Eu4alKUt9TbSyCeCJ0oyKGebB/oTW/EXr8SDuUQ
	 707Ema6O87JlR18n+dCXEG5gMDZi61PE7BeadC2oZltOeUqsokaNoBDT7Vr17ZFrxj
	 M5KYBbsgcz1iyAAKuAY/JiluhGQmF0jE/Ot3/Q/4=
Date: Sat, 24 Sep 2022 11:19:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Suchanek <msuchanek@suse.de>
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
Message-ID: <Yy7Ll1QJ+u+nkic9@kroah.com>
References: <cover.1663951201.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1663951201.git.msuchanek@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220924_021924_913608_55E94618 
X-CRM114-Status: GOOD (  12.13  )
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

On Fri, Sep 23, 2022 at 07:10:28PM +0200, Michal Suchanek wrote:
> Hello,
> 
> this is backport of commit 0d519cadf751
> ("arm64: kexec_file: use more system keyrings to verify kernel image signature")
> to table 5.15 tree including the preparatory patches.

This feels to me like a new feature for arm64, one that has never worked
before and you are just making it feature-parity with x86, right?

Or is this a regression fix somewhere?  Why is this needed in 5.15.y and
why can't people who need this new feature just use a newer kernel
version (5.19?)

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
