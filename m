Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967B606A336
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=viogDspA;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=kOh3LgAZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qOHVTuC5hHIVI7UZZ0LVQbOrU8lnvBC2EJDORqtQwNI=; b=viogDspAvOzYJhtnPrck0rl/+s
	NY2LdR4t7kr2OICkKj6w3uzQATEu4JT32rY85RIAOLiKaknq74L2IXN8OlduUzEROgzHZbIq06IyQ
	0s/81k7t6HCgjbb8v0bhd/M5B0lhvgogTtm4oJ+ybPm8JL1PlwaGSnha02DNZUPSBEmX5DEzuScZi
	mWJTRCio7ibEA3LK/LaJqwm4Rxs8NCdcmvNPpKfXCMhGXj1EZNkYvKXk/+ds0DEmAB/kVBppK3t4B
	4CavGV+rIIfjzwWqL3zbF2Ga8bim1DcAolev4xWZRb2gbXqR0mKOL3eneylSG1jycZbF1GLOiU9Yc
	98C7Q5Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR3Vj-000000061dl-0UPv;
	Wed, 11 Nov 2026 08:16:51 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR3Vg-000000061dB-3Kob
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 08:16:49 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1531175a12.0
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 00:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794385008; x=1794989808; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qOHVTuC5hHIVI7UZZ0LVQbOrU8lnvBC2EJDORqtQwNI=;
        b=kOh3LgAZFu4JebGI1ep3SifsNuSL/sDv3HWpp5y9SgRtrGe3npmJOcP8knDvgCj/Py
         A7+6mWhIunxxGtEIe1UqjOgTx9SYc0QRfPqNEtDoA3Lyg24jwZ2GPnHFarQAUqGy2Rzb
         HgDS4LbMd1hc/Ct+P4lh5uaf4pwZ85K4UyoCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385008; x=1794989808;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOHVTuC5hHIVI7UZZ0LVQbOrU8lnvBC2EJDORqtQwNI=;
        b=Ry5SHY10DQz6rCZIc09/rgCjkF0gq0jpq52hkHctV9pnpJ2EoaHfH8IJohnrnBJepQ
         ccWDamtVY4V4w5wsvCUsONx0A3NvtQM+PhX2Y6U/aetfhtMUMd23MRF2cAvULS+w9XxG
         aGaQjyfCiFFmDa6YT09s2ABPLrSV3Z4DPYG409Jrv0tvXCwLY5obLI+FqwJx4wKrUhBI
         u3sdJhWEY9l+bPd6PDlksXSH4Oc9RPAauODaqGNbgjtKkOOJRzRZI2zfAJcZXViVoMQF
         trzdjGHOemu8jabhoKTS7J1kPGOJDor66FfwGmXULlp6j2ENwZZ0kw460TX++Cs6xTiQ
         4Q7A==
X-Forwarded-Encrypted: i=1; AL+hErFPQ6VYIUMhWi7rzCpJp4uFecJvLBQAg7dtYcVQVbPIehsTdPs0BwD3nNHuM/uebSJtWJTMtw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8W+hilzFeRPCIpv+agEnWPPVVQsFxbw4AhmexOlz8ICWQfoiUN
	mES7fB+Ttm5z3hEtNTMzZYC9HeSWJxdCZSrEBorjeWmkHMN/n5ki6CPE1CEtfuT/cHM=
X-Gm-Gg: AYBFou3HxPPjS+fzUyvN9OZxiiJTvsyytSTER8KYa4WopCIrIjiG2pndHe0iyucwkMg
	QrsdiqfIzmN+nrDxbbEUjY119HXEJRSeBvt+1KhVoyIZzUGBTBZUWhcScN1aiRNAIxQtM1kkWmf
	3m0T5la5Y3qq6UQx7BZgHoAGGoApw1CKRwbPtidrSPPQQNLl5lzbkadSmP6HfafOguOsYX17LKw
	Q5D2OJzsSI2XwKTX5Z9EO0NrFhB99wzW144E/FyG5ySKYZ1j36eVbUC4Qwvu01479y2eKEZxqOM
	5uy+QUFLk9TDRw1NQQFFaNefrjGKt+jxjgalKyJKFVR4UwOulGdsAgJo8i9JvhLRYmFX6ERIrrv
	H7g5ga7R8r2FKvCwUxWgYsWRjFy149raphbTNHhM6rXp7fbLqKATi+IpLFOJ3C0YeYb+c9/l+9/
	vxsxBe9AIrefQIb9dIRZD18G7Mo8UveJ3+3zoV/0gUpK9uko6qV67/iD9nDLiftPu5XVMnViLUc
	6LtuGfeoKcqI98A+l+n2PMRhMYFy7SrAXivPVVxjtUH9lWjU1vyhX/4fp1M8oLE+PNhcQy7PUvo
	7X4rYiHwS9miaTihEUeUE06zCLv4U7pj7L6OG+dS0lTl1f/+qLJvIL+g0PwH19K4DkXTH5EGL2X
	L5fMVzz8M5tNA1CScl46HMeMtDlnK1OWEE/ZR9Ogbb+1HAQ3drPTFT8eNDPlYWYls8ghoK8o5Gv
	YwXuVmobt05tccFMgDSn8Zx0UYZezXUT0IOGcEHyzVV4hokNfbiDZ6
X-Received: by 2002:a17:90b:4985:b0:39e:6c6a:6580 with SMTP id 98e67ed59e1d1-3b182f3801cmr1550647a91.67.1794385007677;
        Wed, 11 Nov 2026 00:16:47 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181fc804csm1360430a91.1.2026.11.11.00.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:16:47 -0800 (PST)
Date: Wed, 11 Nov 2026 00:16:43 -0800
From: Chris Down <chris@chrisdown.name>
To: Mike Rapoport <rppt@kernel.org>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] kho: Prevent reuse of preserved pages after a
 reservation failure
Message-ID: <avQka0wY-EdLkspv@chrisdown.name>
References: <avQUquBK6cO6tUUI@chrisdown.name>
 <avQg0_jFY3get3wG@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <avQg0_jFY3get3wG@kernel.org>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_001648_868452_388A877B 
X-CRM114-Status: GOOD (  15.57  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mike,

Mike Rapoport writes:
>On Tue, Nov 10, 2026 at 11:09:30PM -0800, Chris Down wrote:
>> kho_preserved_memory_reserve() reserves each range of preserved memory
>> in memblock and marks it noinit, but ignores both return values. Either
>> can fail when memblock has to grow its reserved array and can't find
>> room, which at this point in boot it may only take from KHO bootmem.
>
>Is it an LLM analysis or you seen this happen?

Are those the only two options nowadays! :-) In this case it's just eyeballs.

I happened to notice this while preparing my KHO/LUO observability patchset and 
thought it made sense to send as a separate patch, since it doesn't depend on 
anything there.

It's probably realistically quite unlikely, I would think it would require a 
lot of fragmentation or a very small kho_bootmem=.

>> Dropping the handover at this point isn't safe either. reserve_mem=
>> revives its regions from the handover before mm_core_init(), and
>> relies on this walk to reserve them.
>
>reserve_mem_kho_revive() can memblock_reserve() its memory itself and we
>can carry on, can't we?

Thanks, that's better. I had thought carryong on wasn't possible because 
reserve_mem has already reserved its regions by the time we get to the walk, 
but actually you're right that there's no reason reserve_mem_kho_revive() can't 
just do it itself...

Looking at the code one thing we would likely trip over then is that 
kho_mem_retrieve()'s error path only clears fdt_phys, but not bootmem_phys.  
kho_init() then thinks that it's a cold boot and runs 
init_cma_reserved_pageblock() over the inherited bootmem which has already been 
handed to the buddy allocator, so this would need adjustment first.

So then, let me send v2 with reserve_mem_kho_revive() sorting out its own 
range, and making kho_init() skip the bootmem setup when the bootmem was 
inherited, if that sounds good?

Thanks!

Chris

