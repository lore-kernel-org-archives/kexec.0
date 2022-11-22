Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49043C433FE
	for <kexec@archiver.kernel.org>; Tue, 22 Nov 2022 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UhwaQjh+Ia/mFtN/5LUyTZC+iVCvaI8pf7D82ZuYA1w=; b=rCZtr+xwdzOV70
	Cc38qVmhx00bSg0r42bY8REMjqrPmKMypIt5y6YW89isqiBh8H1qai8/5yQmEZh627jpkqKlXc6+o
	GvYeBagh4R88lOyy8f3La2WXTS1J8kfhOsUWWydFWEMGkeQGNKKpBa4ZIfIXdudRavlIljwqPSlKF
	fLBo7Kt4G8LZgSeqd5rwxYMT09WwmA7f3t/RqJzfhBXX8VlwqVqKqfRgKnDoRRVv5BjqEgQA9Uzue
	XBM1TDTFvP45YOQj+W5A3D0eu31wgoJveYgbLqDO284XOOVDKzG50CGdXnXyYEbVKeSlsAwAQFL+b
	kJffwLACujkmYl1JV08g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTEv-009cVW-OE; Tue, 22 Nov 2022 13:23:05 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTEr-009cR6-JM
	for kexec@lists.infradead.org; Tue, 22 Nov 2022 13:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FY+JqUTCgihErrGkfvd81tTDafGHo4/Ls5aZBztvCRI=; b=AYvzjRrTruNeQnueKgELb+zCk8
	UVbGiVtGj9aoxeLpY3IHAd6Yyk/0XAO+o2htBjsFecMi89SKtq9feHUApjGt4pHm9mbOA9I+V6mQy
	eA1GZ6fQ6GWJNN3dCHh8ww04qprqnImBnhWQLBqyOQGGeGjftBRgox+qxDxtDwCs7Pe3JTcckNuWw
	22NGy7Gh2WlrpbVnmNlxHaFUiSJQ0FGaPuTPCZR61CqiCeq1X2BlTCgPo3VjT41nAbu/kZbhSbP3E
	nCOY/8g75zWymxjFr1MTnfhgzD0q7u7PDtf6dQ4r8PSil1SrtlAunMWnkjmPGBICS5bbVJH8nkYfS
	sle/jWGg==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oxTEh-006xXr-3p; Tue, 22 Nov 2022 14:22:52 +0100
Message-ID: <3f0bc380-e6c9-d1fa-a22f-6ba9051d4219@igalia.com>
Date: Tue, 22 Nov 2022 10:22:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 03/11] alpha: Clean-up the panic notifier code
Content-Language: en-US
To: linux-alpha@vger.kernel.org, Richard Henderson <rth@gcc.gnu.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, richard.henderson@linaro.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, Petr Mladek <pmladek@suse.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-4-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-4-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_052301_699391_AC589103 
X-CRM114-Status: GOOD (  12.59  )
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

On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
> The alpha panic notifier has some code issues, not following
> the conventions of other notifiers. Also, it might halt the
> machine but still it is set to run as early as possible, which
> doesn't seem to be a good idea.
> 
> So, let's clean the code and set the notifier to run as the
> latest, following the same approach other architectures are
> doing - also, remove the unnecessary include of a header already
> included indirectly.
> 
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Richard Henderson <rth@gcc.gnu.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - No changes.
> 
> V2:
> - Fixed rth email address;
> - Added Petr's review tag - thanks!
> 

Hi Alpha maintainers, is there anything else to be done here? I'd really
appreciate any advice on how to get this merged.

I'm also adding here Richard's linaro email (and trimming huge CC list).

Thanks in advance!
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
