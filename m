Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83711CDB475
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kiPCDyNzOIKbl53u+lnYqtDRT4+hW6UwDXUqJMr90qI=; b=ty3MDFmDkgIUutK13Bykn4giL5
	VX9BC7d1Zaoj5ZnMG0hWWicIP+tAULuNOlkUaZWFIkCiDC3RIgxK/kS9dGfxqBMAuX1MfWHRzJ5hT
	Dpe7luw/q2zqZl4SGsJDBMXYXUeu6LDQciRBNLQtUh29N5Mor7bUSTc6IPeu5iMaGfn1vn2iBXEm6
	DcIZwp4X4Brq3FrdlWeMl/52hWmQDZDtFq2yYa9GAaSyDSNYH2veJ2YnAfzwpOWfEct7Zni7jvDIH
	zaHuBmcqcprD13jUHPnYWe7uA8jmcLvOtXD4dyGzoihhGyCP1AE8n1zLi7eTBPVGo5XILPuKsvvJd
	P5THgEKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbizR-00000005Hg1-3aBj;
	Mon, 22 Jun 2026 18:03:21 +0000
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbizO-00000005HfW-0yhb
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 18:03:19 +0000
Date: Mon, 22 Jun 2026 11:03:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=key1; t=1782151392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kiPCDyNzOIKbl53u+lnYqtDRT4+hW6UwDXUqJMr90qI=;
	b=SIk9ecjCRLwhneYqk1vfvdA3fBEkVhLUSg7wXeQd9wXwLfoioSwAtcrM1CwsJs4KVdl/I5
	dXgZON3x6bJqeYayCJZzD9duNyd+yxX2lteiHPlYnFbpe1M+wTtlygAKMreUEn9P1UGQpp
	8+xhgJz9hGGClUQ/pxj67Dh9xxB6AUMrQGic5eCuLUfln0RuiikuEkVWl50YJA67g/lU2M
	sFCYZ2yHVUCeHzLEGQmPKus1Ml5rMksXI2pCGUa6Q0voTMqBf/FXXLfpaKe2taSMCdBOej
	isQv6jXQNCkizAjuoRWu/zNLCbZ7Bm3sZEajvO1odsYCHmKlv7zTzbKh9sK1hw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Krister Johansen <kjlx@templeofstupid.com>
To: Tao Liu <ltao@redhat.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org,
	aravinda@linux.vnet.ibm.com, stephen.s.brennan@oracle.com
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
Message-ID: <ajl422McaqugeWHs@templeofstupid.com>
References: <20260414102656.55200-1-ltao@redhat.com>
 <ahoA_5MfC7FuC8CQ@templeofstupid.com>
 <CAO7dBbWOgztZPrazUGN6q+L_62ipywj4Myurcd4R4q95J0_XMw@mail.gmail.com>
 <ah4oINLOlhxpQuFR@templeofstupid.com>
 <CAO7dBbWZ8V_33MnXfgd_DfAwOVEBYtjwwm2DQxy8OrbipYBuBQ@mail.gmail.com>
 <ah5gyh2RfLg-JzDF@templeofstupid.com>
 <CAO7dBbVqBKmCzAXrRLvEOJg_+VjZOXxLkjfVkVHE0Emg976wew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO7dBbVqBKmCzAXrRLvEOJg_+VjZOXxLkjfVkVHE0Emg976wew@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_110318_683369_0B70906D 
X-CRM114-Status: GOOD (  20.91  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Tao,
I appreciate your additional investigation on these questions.

On Thu, Jun 11, 2026 at 01:24:50PM +1200, Tao Liu wrote:
> Hi Krister,
> 
> I took some time to think about the data erase functions as we
> discussed previously, and I have implemented one sample data eraser
> based on the current v5 extension framework in [1]. According to my
> test, this works well and has no conflict with the mm page filtering
> extensions. With this, people can do data erasure as well as page
> filtering in both 1st/2nd kernel as long as btf/kallsyms info is
> accessiable.

I took a look at the example in your subsequent e-mail.  I think this
would work for what I'm trying to.  I didn't realize that the extension
callbacks you built had the ability to call into the other erase code
that's also available to eppic.

> As for btf/kallsyms support for makedumpfile.conf based erasure, I
> forgot to mention there is one critical info missing compare with "-x
> vmlinux" dwarfinfo, is the type of global variables, please see the
> patch [2]. As far as I know, currently kernel hasn't enabled the btf's
> ability of including global variable's types. E.g. symbol "init_task",
> we can only know its address by lookup kallsyms, but btf have no
> record if its type, because it is a global variable. If we create
> makedumpfile.conf as follows:
> 
> [vmlinux]
> erase init_task
> 
> It can work with no problem for "-x vmlinux" because dwarfinfo
> contains all info. But it will fail to btf/kallsyms, for btf doesn't
> know init_task's type is task_struct. However this is not a problem
> for makedumpfile extensions, because when programming, we can cast it
> as task_struct by "init_task = GET_KERN_SYM(init_task); task_list =
> init_task + KERN_MEMBER_OFF(task_struct, tasks); ...",  but we cannot
> do the same to makedumpfile.conf.
 
Got it.  It wouldn't work with the current configuration file syntax
because it needs more information to pass to the APIs that perform the
btf lookup?  Trying to understand if GET_KERN_SYM can be dynamically
filled in, or if its a macro that's evaluated at compile time and isn't
dynamically changable.

Thanks again,

-K

