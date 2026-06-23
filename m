Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3850CDB470
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Duz8Zx+8AiYnCdBwNjKZl5RmXQ31zXqUNM7RLp7vFfQ=; b=quvWqFjIfSaam3pk8qS2dV5gN7
	+KuGLsU7x6E6PnQ69EEj/B7yU6DAda/AbpDyK+DOTKTKRcTG5A7W7mkSVMzcUExFogDLKEvKfvlL+
	Q5xykQzSmEFkn9gnFbe/tbtkLJHLGHrD0L4ygRUp9jfRqXCXH70Fe7qmnzPSQf1q/CxksFjotzHgB
	0dXgXaimOpUT2Dr9gq7f1PsHO3W1kFdUgB8b7zSTHGh09G2fkZ6/6bptCEPaHBSNQJtdzI77hZ//j
	OP8lML6BIoqr/ZWlrusxVyrxAq/qH5MaXTBTqQyIDFhvCNO+ixvpmRakNMSiULSQuLnD6hxqK+KXe
	JPgccU0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbylK-000000067Ec-3OTo;
	Tue, 23 Jun 2026 10:53:50 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbylI-000000067Db-2YBe
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 10:53:49 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-695e7929975so5223456a12.0
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782212026; x=1782816826; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Duz8Zx+8AiYnCdBwNjKZl5RmXQ31zXqUNM7RLp7vFfQ=;
        b=VJFDO12DTqOU78+YjJDNLHAPwdwF0K/AwyYQ+zFuxHKLi7HlaCazJTAuBPNzcTa8ir
         l7yHltwA+xE6nh/nVvKK6e0xlof60uvFQ0FNwFrdEQc/PbMN4JDbbUKlfi2l4A04jg45
         zbuMYsapHHW3xCPyzCY3OOkC181N3OM5qkEsKzi4ttzxnvmK1wNZxRmq92eP5wrnythJ
         lYkIoaLhtuWTtPYrQfkb2n8oe3YYCeFHFXma9O5J57K/OVSFlRQ+Kj55bB3DOodXJ5iB
         JTD3qcABSic6zT7OTmJJit4xae3g5HCucz6mnsm2aacwDN/6UReyuPHVwQw4c6A6c5Xl
         CfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782212026; x=1782816826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Duz8Zx+8AiYnCdBwNjKZl5RmXQ31zXqUNM7RLp7vFfQ=;
        b=Ylf0rhalv3AaMML51pbWsmKwFMzQQSbsY/+9sQEu/SKuvTezNfFtXDMZSrFudopLHJ
         KCf0iBgrPQlLV5tLnNRfbGp43JfiWhchZ74I5uUbFkTK/UTlb3Wqr/eT086lAF0q2Dct
         /2xSnSB1Q/CezcHo1uvQxEHjgwPSiH0bzpnW3cicE9INYUGNHPS4VJ609BisazRF3hks
         tiV+LinoJwKx3HpNbm4gOxjIbPP+Ke1eZQfv1vG5uomWkA7rTxkAHaJEceOW45WtAO1j
         hJADJW4bEXQKkqo6fteuQAbYvI4j/n9jx37WdMPulevdrdEGLq2MzOkE9FcTRTgdvr+m
         eZ4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+tcRKWK1fxNRWnooGHBRLo2i6gncW1XXdEK5tc8mVjFfREVasY3nu+CgX0jBgVcBWJ1dYwIQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyEZUhh+pYIUqKigg79lkupg10FlZKawe69tCMRxxQmqSs5GvNM
	PXqrey+l8koPQZ/1cXeGlgEvQT+YaNeKSEJYZDLlOLfiWpdDp3imUYBYKYlncrTALSiw985ndbY
	k0VPdWrMBxh9TqXjpeA==
X-Received: from edah41.prod.google.com ([2002:a05:6402:ea9:b0:68b:8a53:a28e])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:380a:b0:691:b5aa:5a57 with SMTP id 4fb4d7f45d1cf-697dbb55ea4mr960674a12.18.1782212026359;
 Tue, 23 Jun 2026 03:53:46 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:53:45 +0000
In-Reply-To: <ajpbHkuWiGQrUec8@kernel.org>
Mime-Version: 1.0
References: <20260622225736.2961438-1-tarunsahu@google.com>
 <20260622225736.2961438-3-tarunsahu@google.com> <178220761164.162773.6384380547612711985.b4-review@b4>
 <9huzpl1h37hj.fsf@tarunix.c.googlers.com> <ajpbHkuWiGQrUec8@kernel.org>
Message-ID: <9huzse6dle86.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 2/2] luo: Update serialized data to use KHOSER_PTR
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Mike Rapoport <rppt@kernel.org>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_035348_659370_C2B53990 
X-CRM114-Status: GOOD (  16.70  )
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

Mike Rapoport <rppt@kernel.org> writes:

> On Tue, Jun 23, 2026 at 09:56:40AM +0000, tarunsahu@google.com wrote:
>> Mike Rapoport <rppt@kernel.org> writes:
>> 
>> > On Mon, 22 Jun 2026 22:57:36 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
>> >> Convert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).
>> >> This series also takes care of resolving the bug with memfd of using
>> >> phys_to_virt before checking the args->serialized_data value.
>> >
>> > For easier backporting the memfd fix should be a standalone commit that
>> > comes first in the series.
>> >
>> > Other than that
>> 
>> It will break compilation for individual patch. For example, memfd_luo
>> changes are hard coded dependent on the args->serialized_data
>> conversion to KHOSER_PTR?
>> 
>> Maybe I did not understand, Could you please explain what you mean?
>
> Sorry I wasn't clear. 
> If people think it's important to have the memfd_luo fix in 7.1, the fix
> should be the first patch in the series and shouldn't use KHOSER pointers.

I dont think, this is critical issue. But it will be a good practice. I
sent v5 with these changes.
Thanks for the review!

~Tarun

>  
>> >
>> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> >
>> > -- 
>> > Sincerely yours,
>> > Mike.
>
> -- 
> Sincerely yours,
> Mike.

