Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BFFC54EE9
	for <kexec@archiver.kernel.org>; Tue, 13 Sep 2022 06:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/PIDE0xA58n1AV/umPw84HpFKUOuOtcjuFm9ZCEa4F0=; b=XAodBPl7vZuECm
	63VuINHGDUii9xp5alPzWpJv1E+AP4HYY4YZffKsyPcuDIUY5SWqbAMrVdtzquNV+3VECNc1sgdtV
	3twESct5/QOUXhoTcZLwDz6xAvaQlZ1TKbNxsf2jevB5nS7VurgmSUm1/0fsH+g1SEuIvF2SKqLlV
	u34TQtlFtJ87HDpOLqm39aJVGcBBnDWyxpFQk23jOs7ZugoQZrqgcMUvfMRn2SvMJw394iOO5AWFr
	N0Jy06wz6uiX9bhZZKR7EKSCufxAfNnat6I2pa2NY6+a5gHu/JPgpUFiKRfuDti0WFmPjFzLwlZ8k
	vm7Sd37200GeDijNXPqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXzW9-0035Np-6R; Tue, 13 Sep 2022 06:35:33 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXzVv-0035Jb-MR
	for kexec@bombadil.infradead.org; Tue, 13 Sep 2022 06:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=URvJwIGuP97ABBt8+HgWagxhk5MVBssXZoiF39WbDV8=; b=djBs1tFnbBGK7QjEVhVFhoShmk
	oT5PaiW8JImMUkBJk97/7OgsY/wPsQZmBuwd5dMJ0kENXy+Y0+NpR3wYM8BGXDsciw9HxqnB1rxXg
	UISsSicLzm1RtnkdqqXdMYpGoyzsWe24Z05VR4VdKc2xalYt2lEmYRPenvc8QsQxw2ZvKOaY+e8Gl
	CtCkF7qEqZFn6I/8bDxOZz3mMAvqZCLD1uPtNFsxgJ31K4oGxmEf+7KoQRwB5TFcVBy35j2Hs0swY
	yWQALJky+hrEMy5fsFXIzpgif+DzxQoK+M/HWAnOQelb0MjWd5Qc1sBCEGrautpRls/hVMsGfy+Sg
	IwB5j7qQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXzVt-00GeRn-HV; Tue, 13 Sep 2022 06:35:17 +0000
Date: Tue, 13 Sep 2022 07:35:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jianglei Nie <niejianglei2021@163.com>
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix potential memory leak in vmcore_init()
Message-ID: <YyAkpQNWXrkMGdYr@casper.infradead.org>
References: <20220913062501.82546-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220913062501.82546-1-niejianglei2021@163.com>
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

On Tue, Sep 13, 2022 at 02:25:01PM +0800, Jianglei Nie wrote:
>  	}
> -	elfcorehdr_free(elfcorehdr_addr);
>  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
>  
>  	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
>  	if (proc_vmcore)
>  		proc_vmcore->size = vmcore_size;
> -	return 0;
> +
> +fail:
> +	elfcorehdr_free(elfcorehdr_addr);
> +	return rc;
>  }

Did you test this?  It looks like you now call
elfcorehdr_free(ELFCORE_ADDR_ERR) if 'rc' is 0.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
