Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6E0C4332F
	for <kexec@archiver.kernel.org>; Sun, 18 Dec 2022 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZxImXlcp1Puh/kV/3JbDfs1XumnBWSQHrnDCSZ1Lb0=; b=UzAH3loAnY2HgJ7lOqNjr5nGaS
	2BTpKNGYbrnEeasbkLzYs1lnLo8/T5ZWgx9UKCbfiJpamQbzI196alHFqDSnxfB5VRzLcK69Ae8x1
	JWIGNDRPuET+xI9IujLs6tpIyrNNhyHraIZvBO93hJMZtJVlw92mKM0xbdAV0ptQtKuqsPjrmXGKl
	r5iHJEtF77aB61Bx2cn3760pE7JFUUskcdBlcmAPho5m7W0b0rJFsGrJKKk8BmZGDHWWrygEDeDRI
	tBSuwZJD25wT9VwU47D4ECMLvChvQd4nK5q3kR9dd+Lja6KIT1vulozNH6BJmOy57GFhA5io0SyHX
	X7cz2H6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6rst-000tXY-7Q; Sun, 18 Dec 2022 11:31:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6rq8-000snu-6t
	for kexec@lists.infradead.org; Sun, 18 Dec 2022 11:28:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8516560CF3;
	Sun, 18 Dec 2022 11:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3BAC433D2;
	Sun, 18 Dec 2022 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671362897;
	bh=rKarePoInVMhPInoT0xrFhG2KjCel5on4231oJ7+bAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqh0jI0pE8fyC8WRZDI+j+AtDfYNnA7r5CSE0Whv2lcHXFaXYxSYWQpdBli1OIqwn
	 rUtlz4qwZmKAqR/n/7klvlHb6gxXOc7TYsyeFMzwfdJahq2D+u2/uRNbxFDiK80EVB
	 yDetXjJE3wvX0aTnaqqOXfkXvx0aXtmXDslyQisVOTsaj7RtAZxEG/dH6zakiyQ1vj
	 IIBa3kSoRLko8KfwlmxGZed2oq8aM6jQOcabYfaUX+lFzeDOnfF08Y/LbzK3fe50fE
	 RPt9m8pPTEaYYxViC7Ku4b2q3PrNBkvANs+TEEprTvaUtetHLaLI+XodfYzC6yJGWn
	 jzLxCLl2Ij5Kw==
Date: Sun, 18 Dec 2022 06:28:16 -0500
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianglei Nie <niejianglei2021@163.com>, Baoquan He <bhe@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Chen Lifu <chenlifu@huawei.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Li Chen <lchen@ambarella.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Mackerras <paulus@samba.org>, Petr Mladek <pmladek@suse.com>,
	Russell King <linux@armlinux.org.uk>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL 6.1 13/22] proc/vmcore: fix potential memory leak
 in vmcore_init()
Message-ID: <Y575UCk+lwfJ2CoE@sashalap>
References: <20221217152727.98061-1-sashal@kernel.org>
 <20221217152727.98061-13-sashal@kernel.org>
 <20221217163228.9308c293458ceb680a6ffed8@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221217163228.9308c293458ceb680a6ffed8@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221218_032821_987441_51085012 
X-CRM114-Status: GOOD (  17.22  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, Dec 17, 2022 at 04:32:28PM -0800, Andrew Morton wrote:
>On Sat, 17 Dec 2022 10:27:14 -0500 Sasha Levin <sashal@kernel.org> wrote:
>
>> From: Jianglei Nie <niejianglei2021@163.com>
>>
>> [ Upstream commit 12b9d301ff73122aebd78548fa4c04ca69ed78fe ]
>>
>> Patch series "Some minor cleanup patches resent".
>>
>> The first three patches trivial clean up patches.
>>
>> And for the patch "kexec: replace crash_mem_range with range", I got a
>> ibm-p9wr ppc64le system to test, it works well.
>>
>> This patch (of 4):
>>
>> elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
>> kzalloc().  If is_vmcore_usable() returns false, elfcorehdr_addr is a
>> predefined value.  If parse_crash_elf_headers() gets some error and
>> returns a negetive value, the elfcorehdr_addr should be released with
>> elfcorehdr_free().
>
>This is exceedingly minor - a single memory leak per boot, under very
>rare circumstances.
>
>
>With every patch I merge I consider -stable.  Often I'll discuss the
>desirability of a backport with the author and with reviewers.  Every
>single patch.  And then some damn script comes along and overrides that
>quite careful decision.  argh.
>
>Can we please do something like
>
>	if (akpm && !cc:stable)
>		dont_backport()

Yup, I already had it set for 'akpm && mm/ && !cc:stable', happy to
remove the 'mm/' restriction if you're doing the same for the rest of
the patches you review.

>And even go further - if your script thinks it might be something we
>should backport and if it didn't have cc:stable then contact the
>author, reviewers and committers and ask them to reconsider before we
>go and backport it.  This approach will have the advantage of training
>people to consider the backport more consistently.

This is what this mail is all about: I haven't queued up the patch yet,
it gives folks week+ to review, and all it takes is a simple "no" for me
to drop it.

>I'd (still) like to have a new patch tag like Not-For-Stable: or
>cc:not-stable or something to tell your scripts "yes, we thought about
>it and we decided no".

No objections on my part.

-- 
Thanks,
Sasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
