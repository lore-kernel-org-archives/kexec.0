Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119BDC4167D
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 12:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TF9wBmaVszh0oguXKPV8ZgEoJnAa+uRxrErljz+0ARw=; b=a2rs5CQxeN+9wR
	V/+Ry/zmjhQqxtytxOP3q0sCJQ1GapStEwcwSb8NAsTX6Is4u+lCAHZtE6q5Csl0TEhmtV6rQQxlE
	R6mdAmM/ADIE8SNKC8oBsbtfVokFoaYzHxDjjMCLOlZpOKYsiuiVxEA4fhrsPkU1cqFuiM7RdeBdb
	/x3+zWAjGcBYLfdXgDetRHZnmpwvO3a6m0mWrQe6B7xZEDwKb237v1Msi7einlchp6JvpwTV0QuMh
	ezVdTDsr8FOnzHurr0o9HDnKCW+OJDorxc8NbFpx5xvV1OCkXnF44PI9jgfza9W2GnhMb0SrtJi4X
	RbWp+rz9WjkGr1BYUFhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozdf5-001gcn-Dw; Mon, 28 Nov 2022 12:55:03 +0000
Received: from mailsrv.cs.umass.edu ([128.119.240.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozdf1-001g8E-AE
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 12:55:01 +0000
Received: from [192.168.50.148] (c-24-62-201-179.hsd1.ma.comcast.net [24.62.201.179])
	by mailsrv.cs.umass.edu (Postfix) with ESMTPSA id 203AE401D753;
	Mon, 28 Nov 2022 07:53:52 -0500 (EST)
Message-ID: <103666d5-3dcf-074c-0057-76b865f012a6@cs.umass.edu>
Date: Mon, 28 Nov 2022 07:53:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: nvdimm,pmem: makedumpfile: __vtop4_x86_64: Can't get a valid pte.
Content-Language: en-US
To: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
References: <ac8d815b-b5ca-4c4f-4955-ba9adbce8678@fujitsu.com>
From: Eliot Moss <moss@cs.umass.edu>
In-Reply-To: <ac8d815b-b5ca-4c4f-4955-ba9adbce8678@fujitsu.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_045459_468979_27643533 
X-CRM114-Status: UNSURE (   7.00  )
X-CRM114-Notice: Please train this message.
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
Reply-To: moss@cs.umass.edu
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/28/2022 7:04 AM, lizhijian@fujitsu.com wrote:
> Hi folks,
> 
> I'm going to make crash coredump support pmem region. So
> I have modified kexec-tools to add pmem region to PT_LOAD of vmcore.
> 
> But it failed at makedumpfile, log are as following:
> 
> In my environment, i found the last 512 pages in pmem region will cause the error.

I wonder if an issue I reported is related: when set up to map
2Mb (huge) pages, the last 2Mb of a large region got mapped as
4Kb pages, and then later, half of a large region was treated
that way.

I've seen no response to the report, but assume folks have
been busy with other things or perhaps giving this lower
priority since it does not exactly *fail*, just not work as
a user might think it should.

Regards - Eliot Moss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
