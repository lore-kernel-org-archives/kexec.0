Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E94DE728C4
	for <kexec@archiver.kernel.org>; Fri, 29 Sep 2023 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fUU5GiYneJeSr/re+LTfbFWY2yvMzG7MiNEw/9wMrj4=; b=ImEWkRcfXbZaxW
	6Oly3m53ma0zryYqYin0tLPIzvfXDQ48TueVhYVnBBnxNup3Z+Dt3eND1ndJjnAC7adXuCcaVwdey
	/Vx7ZdupgSdA/Ukw8R2S/xkttrAwJ6RqGAiTduLks6LpaZKrgVWkJx/1EHOYGJ9167Dk+VUDmw/ni
	dWeM1SP0/TM+otWHKDO0sJ/I1Ev9RDm9anXyPao+tkxpzMCfwoG1f7h3p1KTRUZPLQgSJJIhPo0MU
	uJGJQ7XruqxVKLgq8ZSgnG3lgDloZfuA8+7JDoupFJWIRDleDM1XjhhvoP/kY3DdD9poMNfm2bDBI
	yaRqk5wWuDFJ/uKNvwLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmG3m-008GTb-0E;
	Fri, 29 Sep 2023 16:09:46 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmG3j-008GTH-12
	for kexec@lists.infradead.org;
	Fri, 29 Sep 2023 16:09:44 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1E11020B74C0;
	Fri, 29 Sep 2023 09:09:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E11020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696003781;
	bh=hBRFFChWfIJKYy72bpQH7xKGGzU+r4Wzml1eGPFHEBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lv3AqhUOg8n151/bqh1okWzXQRnbJgv18TSyBOBoKBUSs7z96qc9wIslOfmYcIj20
	 CX5yJ/0tbuQmucA2aTIQJ3ol3I886vdUGrp40UFE1NeZwEgGJi/tVjsIKiezjtqnti
	 YKg4s4TCMmGlxuZx+vugASYdS7colcK7Tnp+TSbs=
Date: Thu, 28 Sep 2023 02:16:41 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: "Shutemov, Kirill" <kirill.shutemov@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Baoquan He <bhe@redhat.com>,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ebiederm@xmission.com, akpm@linux-foundation.org,
	stanislav.kinsburskii@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
	wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	graf@amazon.de, pbonzini@redhat.com
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <20230928091641.GA20562@skinsburskii.>
References: <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
 <20230928000230.GA20259@skinsburskii.>
 <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
 <20230928003831.GA20366@skinsburskii.>
 <340596c9-d55d-5f8a-fa27-d95b0e10b20a@intel.com>
 <20230928024636.GA20423@skinsburskii.>
 <20230929101324.jgixt4jmqialchno@box.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230929101324.jgixt4jmqialchno@box.shutemov.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230929_090943_412978_ED9F9CA8 
X-CRM114-Status: GOOD (  18.29  )
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

On Fri, Sep 29, 2023 at 01:13:24PM +0300, Shutemov, Kirill wrote:
> On Wed, Sep 27, 2023 at 07:46:36PM -0700, Stanislav Kinsburskii wrote:
> > I'd answer yes, "System MAP" must be persisted across kexec.
> > Could you elaborate on why there should be a mechanism to tell the
> > kernel anything special about the existent "System map" in this context?
> > Say, one can reserve a CMA region (or a crash kernel region, etc), store
> > there some data, and then pass it across kexec. Reserved CMA region will
> > still be a part of the "System MAP", won't it?
> 
> Em. When crash kernel starts all System RAM of the the first kernel
> becomes E820_TYPE_RESERVED and only memory pre-allocated for crash
> scenario becomes E820_TYPE_RAM. See crash_setup_memmap_entries().
> 
> Can't you go the same path? Report all deposited memory as
> E820_TYPE_RESERVED.
> 

Sure I can.
This approach will have the corresponding command line option as a
requirement, and therefore is less flexible. But if passing device tree
across kexec on x86 is the major concern, then of course I can change it
the way you suggest.

> Or do you have too many deposited memory ranges, so we would run out of
> e820 entries?
> 

No, I don't think I have.
I can imagine how such a pool with a lot of regions can exhaust e820
table, but the implementation currently proposed is based on CMA and thus
limited by 19 entires by default, so I guess running out of e820 entries
is unlikely in real world scenarios.

Thanks,
Stanislav

> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
