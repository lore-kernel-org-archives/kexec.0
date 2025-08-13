Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36324CA0EE4
	for <kexec@archiver.kernel.org>; Wed, 13 Aug 2025 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HRNTXRYfcLW654zREqydzcRC5UuFcZMiCEgImG3T+ZI=; b=3q5VhJ3OIwccOBu6rwXlkTSseQ
	ZEEoEkmSemesKS1ZCQUq81CnN+pxPAceqQdALA/u+q1YRclDToDYzEYuhYFWp0jxwFPlETvEJAuzP
	Rzhq9d/cqLGs5JKG9RHOQ7MdGZ+hGl2iNp8FsX5+lT53/d/aqnrLItcPLacSrWBO2T4mndcHEcX9s
	HcMRD1eUUqZmTJcPKNza9Wa2fCnVSCZpvQDFG5Wru5SuLul/Bs3JpoYqUQFwlLqVVTQbSPq2t3SIT
	tJtVUKu/CjDws2Xhqucv73w1kwBxk2+DJ/SM0nBIrzHRocUJ4qet6XN4FF4hkvoIvBhvEpIbARmBW
	CDHL2DCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umCQ9-0000000DuQU-0S70;
	Wed, 13 Aug 2025 14:25:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umCQ6-0000000DuPG-0bgg
	for kexec@lists.infradead.org;
	Wed, 13 Aug 2025 14:25:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 883925C5821;
	Wed, 13 Aug 2025 14:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E096C4CEF6;
	Wed, 13 Aug 2025 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095137;
	bh=s9+rxMFL44IKToOutqxDtZw5jz/ESi8pUno0QbbD/hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ErExK45KAh3taU5Ay7lJ7MJ0BMkjWDiD1DN0JR/zuy5xUd2msBop/vOSselq0P951
	 xqaTacLr4JhC6juOA4x7iB/ICnUr91Z6DOwtkW7YEBLK8BOn6VMNdPLf6s/gJAyqDf
	 wz9mpbOVw45GKbGKmjoqBkjluU1Kbvsvyb6kJTUtCyZcPX8JRc1HxQl06bXJNhzkER
	 ce9WafJQZ8HSp7R53BwGs/NZ53f2B42giPZrrJllQc+T8yfZx9Ko5Zwzg2Alnu/cJR
	 Grg83L4s85KTn/NZGLzo8tA2ilXtoRL7JIw9wePMzXiMSqBRw8ZumQmP0uYiEH8+oT
	 jgB7rSEXyuNog==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Baoquan
 He <bhe@redhat.com>,  Changyuan Lyu <changyuanl@google.com>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Shuah Khan <shuah@kernel.org>,
  Thomas Weischuh <linux@weissschuh.net>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 1/3] kho: allow scratch areas with zero size
In-Reply-To: <aJycKRCEqbW0pgwR@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
	<20250811082510.4154080-2-rppt@kernel.org> <mafs0349vwd1i.fsf@kernel.org>
	<aJycKRCEqbW0pgwR@kernel.org>
Date: Wed, 13 Aug 2025 16:25:34 +0200
Message-ID: <mafs0ikiruwm9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_072538_265000_ADAB2F51 
X-CRM114-Status: GOOD (  24.68  )
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

On Wed, Aug 13 2025, Mike Rapoport wrote:

> On Wed, Aug 13, 2025 at 03:45:29PM +0200, Pratyush Yadav wrote:
>> On Mon, Aug 11 2025, Mike Rapoport wrote:
>> 
>> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> > Parsing of kho_scratch parameter treats zero size as an invalid value,
>> > although it should be fine for user to request zero sized scratch area
>> > for some types if scratch memory, when for example there is no need to
>> > create scratch area in the low memory.
>> 
>> Can the system boot with 0 per-node memory? If not, then perhaps we
>> should only allow lowmem scratch to be zero?
>
> In most cases yes because most of boot time allocations have fallback to
> "any node".
> And there's also an option to omit the "global" scratch and boot with only
> per-node scratch areas, so I'd keep the possibility of setting any of these
> to 0.

Makes sense. In that case,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>
>> > Treat zero as a valid value for a scratch area size but reject
>> > kho_scratch parameter that defines no scratch memory at all.
>> >
>> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> > ---
>> >  kernel/kexec_handover.c | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
>> > index e49743ae52c5..c6ac5a5e51cb 100644
>> > --- a/kernel/kexec_handover.c
>> > +++ b/kernel/kexec_handover.c
>> > @@ -385,6 +385,7 @@ static int __init kho_parse_scratch_size(char *p)
>> >  {
>> >  	size_t len;
>> >  	unsigned long sizes[3];
>> > +	size_t total_size = 0;
>> >  	int i;
>> >  
>> >  	if (!p)
>> > @@ -421,11 +422,15 @@ static int __init kho_parse_scratch_size(char *p)
>> >  		}
>> >  
>> >  		sizes[i] = memparse(p, &endp);
>> > -		if (!sizes[i] || endp == p)
>> > +		if (endp == p)
>> >  			return -EINVAL;
>> >  		p = endp;
>> > +		total_size += sizes[i];
>> >  	}
>> >  
>> > +	if (!total_size)
>> > +		return -EINVAL;
>> > +
>> 
>> Looks good. BTW, unrelated to this patch, but should we also check that
>> p == '\0' here to make sure the whole argument was consumed?
>
> Care to send a patch? ;-) 

Will do :-)

>  
>> >  	scratch_size_lowmem = sizes[0];
>> >  	scratch_size_global = sizes[1];
>> >  	scratch_size_pernode = sizes[2];
>> 
>> -- 
>> Regards,
>> Pratyush Yadav

-- 
Regards,
Pratyush Yadav

