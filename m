Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E81BD26280
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 18:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GDMPLKA0NvtUquTBXi8bx6F+PKsFGu9VN4ljw7/OJJ8=; b=yprazcMCA1KH+v+VHLthYYwnCo
	RFyXULFMo94KQeUoTFpQAShbbwU0dWb3gCkpZAVjwbrOcrIPHVxd/1XmvzDQxqOnmALBJN5M10lNH
	g0yMf+9++o/V/xR18gtAVMQDbTrcSa95YVscm556XlFVePbe2BYIVMZIhPl6ffTQoIY7z1wwthUEB
	lfVxHVN496cl51iiT0eJaaXwwrHs1oHst7CnaUHrV1vS1CfQalfffBS6Pc1cJm0HPoSZY8LZa5Nwy
	b3PsFh0GdaqVO+LjDcz0CT4ucwmhhQKnBDyXzzX8QfcwQqAGhfkd87cjYjQ6hRyJCVygVQvoUgUWR
	Xk+QQ/SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGan-00000004JGi-2rpx;
	Tue, 20 Jan 2026 18:36:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGaj-00000004JGU-3jeC
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 18:36:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DE02160007;
	Tue, 20 Jan 2026 18:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA94CC19422;
	Tue, 20 Jan 2026 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768934196;
	bh=QYKth/XopUUmN2w5/xA9zHlbSfdy2ir24LbewWEwvOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nWDbIb8C4Pdc9S6Dmuhx0sP4s0TJLIBQyQ/AcWbVHuZ0hRe0PoKYtU9Hxw7X8LLHA
	 aGURL8szqEnjBpSMEtjFVGh8C/URSKLfq0rrzoK8uC9cmJppJqsnolI/JyuUHEPJr8
	 9reBvNxeN1DY9U2ZV2noPOjkpnUU3Bqg1QxrwnPWOSnMq58zo1iMYa7l2HieqrX0oA
	 8ApTo/v7yNwJwAlbNpibuU1nZvgD952gLoAG/3qwjwIPsbPb7UPar6tliXWZ4G/KW6
	 LfGny8wlbK+Hk9h47zxldaGYXNLdGVZCr+l+U1QnflucJkAB4DfAjL3btK3jNCFHlr
	 C+4tPohqzOZ5A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Jason Miu
 <jasonmiu@google.com>,  Jonathan Corbet <corbet@lwn.net>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 3/6] kho: docs: combine concepts and FDT documentation
In-Reply-To: <aW_K7QZj8HYzA00t@kernel.org> (Mike Rapoport's message of "Tue,
	20 Jan 2026 20:35:25 +0200")
References: <20260105165839.285270-1-rppt@kernel.org>
	<20260105165839.285270-4-rppt@kernel.org> <2vxz7btce06f.fsf@kernel.org>
	<aW_K7QZj8HYzA00t@kernel.org>
Date: Tue, 20 Jan 2026 18:36:33 +0000
Message-ID: <2vxzikcwcery.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jan 20 2026, Mike Rapoport wrote:

> On Tue, Jan 20, 2026 at 04:08:56PM +0000, Pratyush Yadav wrote:
>> On Mon, Jan 05 2026, Mike Rapoport wrote:
>> 
>> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> > Currently index.rst in KHO documentation looks empty and sad as it only
>> > contains links to "Kexec Handover Concepts" and "KHO FDT" chapters.
>> >
>> > Inline contents of these chapters into index.rst to provide a single
>> > coherent chapter describing KHO.
>> >
>> > While on it, drop parts of the KHO FDT description that will be superseded
>> > by addition of KHO ABI documentation.
>> >
>> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> [...]
>> > diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
>> > index 0c63b0c5c143..03cd9afbdb2e 100644
>> > --- a/Documentation/core-api/kho/index.rst
>> > +++ b/Documentation/core-api/kho/index.rst
>> > @@ -4,10 +4,73 @@
>> >  Kexec Handover Subsystem
>> >  ========================
>> >  
>> > -.. toctree::
>> > -   :maxdepth: 1
>> > +Overview
>> > +========
>> 
>> I ran a test build and Sphinx complains about:
>> 
>>     Documentation/admin-guide/mm/kho.rst:10: WARNING: undefined label: 'kho-concepts' [ref.ref]
>>     Documentation/admin-guide/mm/kho.rst:31: WARNING: undefined label: 'kho-finalization-phase' [ref.ref]
>> 
>> I suppose you should add these labels here.
>
> It's already in Andrew's tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-nonmm-unstable&id=bc1a060da2a76161ba65f1badc551de15056e398

Okay, nice. Then with that,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>  
>> Otherwise LGTM.
>> 
[...]

-- 
Regards,
Pratyush Yadav

