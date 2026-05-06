Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E8ECD343B
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pGancg+Hm6RuQ5CrvC9iAES266oQrizaBXy/zKyB4a8=; b=cIde2UckwWtp4yGDRrvxgqcIvK
	aC54mBxXWqT1ScfaX24ri3tLmY3j7YRJ48SPUp+UN/a3Dxldm/NbXfucb80qKhYc2K2cDwPOwlow0
	vRFyALPEnnIcY2/iN9+Zxp0H6OZtrzKiIQZ9ZRnQyn4x/mdTj5oxAWLKMMuf1tlbE9UH+2cDyusuo
	ZK3f8BdHqH39WhvisPC3TmmtVr9Fo+kqhQQQXGbj/G+of58bWIRbBNLS7yVryUDz1fvv8/LoKjZXu
	lzsVDbgGG2QY3FYWPo5Vj2kZuS+AHJtss5/mde55J/4JQpVUIC3ru+KcInlla3CglfjE8gFerg3pZ
	r7UFtydA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdof-00000001EVc-3uNx;
	Wed, 06 May 2026 15:05:37 +0000
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdoe-00000001ETv-2K8s
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 15:05:36 +0000
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-79a46260385so76542017b3.3
        for <kexec@lists.infradead.org>; Wed, 06 May 2026 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778079934; x=1778684734; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGancg+Hm6RuQ5CrvC9iAES266oQrizaBXy/zKyB4a8=;
        b=iIX6CtC6o8ZxA9uueCTCXrh/VsCXBI7Y5oSr/aptvPgJV0PIAtPZZq3mGklndX0KGM
         tW8CFMnEZHMP9EpRIZse0VkW0vLUKZe7bD9jNecVXlf9ZyimsGZE/Ls6JvjVrt9Fw7ia
         VoRZK13bX1588+rP0iYh/B/6aGooS2tpPubirkl3uJpSoZN+68nZ4taTuU6w9Ezv9Jvq
         SPPZCjWYDWbI91yfqOcAFc5yl+WrEk/h+Pb4m17z1zlGPXrH1INxdh8tlm2dVSiOJO2a
         RX0UoxyfZSgOCndQLlmIKZj05jLUFc1AtbU4Ws58JqWyGZkMUEo1YtPnp5lLd9C6D8B1
         LGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079934; x=1778684734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGancg+Hm6RuQ5CrvC9iAES266oQrizaBXy/zKyB4a8=;
        b=kpEfgxfMcBM35qZ6WJD1GzCni28TEab06lqMbMF4OAOG/zArDQMK0U4xH9kfmRwKFC
         3pWQMeZ6Fki31eNJKcBDY8zvkKoCpBx2xtk0Pf7aLPvlyQZfzhPBB050zje+tYaq5kuA
         Hy94cUtl7Auwea1ARXfUQ4oYzaqQJA2zQA5IGxuuEKvLZnEZ1a5Z7xwG0bcpU5Vyjmzf
         ARzPA4Wpc3pBMjqHjWPtnG1+aWMxD80qOGni0CP9CBpJByaxHynDxeezuV1Ge9zw6f7f
         BX7HlX9i9jiZrg2QHuR3shNqVC8g9SPFXDnUod/aMEgzWt2nZMyZFRRys4becIj5bMAv
         qN/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+kZMUa3iAGN2SSKXqvEbZ/Dd6+RW+4OBFH8DNLYXWIkG4Ko0YAK62+PxaSntPPeCfjPzmGww==@lists.infradead.org
X-Gm-Message-State: AOJu0YxDRW+XLXHQvfZ8bB21gx2SLA+RXiCP6n3cz6tvteUHEUjB1jmZ
	r1q558TI9eiX1gihwGkx4O9nZLvFCMTRvIQZL3iIQziI0PFXHuKr9nGAruGpFO7cVaQ=
X-Gm-Gg: AeBDietzVOTplhBzm5IHiZ26r1eEpz7kmiq+95QunwYuCgHrsoowdAAT9+24yrv7e4x
	VZvzJ1atRat7KpSjZrUyS70cxMhm2w9lM45BmNeHV0V7Gys2rCOzmrxSQu3rRpAd6u7MpMuKmQE
	idHj867BiHo0tlF8XZHi+J9pLJgflYvJNZlHPa3sjQAB21Ve9lkQraF3KJlsuOrX5o337xPARQt
	eqRpm5RLW3GPyflwDJFla/rFZVcAWNB8Yz85BbSYHOHgj5eeLdDePtwFVeV7mwUhWNp+ykyGKMP
	QvHX3IXfgfOwcZb9YzaWFemIMhgPFzVirtKWyoBsJ6fsy2F3jdWz7glGBncPnhvvfGOl+8ERieI
	kDZdtH3jNoT0+s0v+CayFP0sui/gPiOn8nbtk/5uhBcNNzx9AjQgayHznrEmHKnNFjw4CS1Jtof
	+r3YZav+ppPcgOk+vCJFEwLDlE4CXxo4RnJsDIOXr4/d8W4f+xRTgUr/24Xer1Dp/valoGHNx4c
	g/9LH3rCAS+MalGE0+iOHet98W17RQhwZdDUkqA
X-Received: by 2002:a05:690c:f13:b0:7bd:4792:66f0 with SMTP id 00721157ae682-7bdf5f24c83mr42505907b3.46.1778079934356;
        Wed, 06 May 2026 08:05:34 -0700 (PDT)
Received: from google.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665694b8sm79860377b3.21.2026.05.06.08.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:05:33 -0700 (PDT)
Date: Wed, 6 May 2026 11:05:32 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Cris Jacob Maamor <crisjacobmaamor@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] liveupdate: validate restored LUO metadata
Message-ID: <aftVd5RnpnAi2jdc@google.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
 <20260501173053.73116-1-crisjacobmaamor@gmail.com>
 <afT_xHDuFwAUSR0X@plex>
 <2vxzse84zzag.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzse84zzag.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_080536_616390_D5FD776D 
X-CRM114-Status: GOOD (  32.81  )
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

On 05-06 11:02, Pratyush Yadav wrote:
> Hi Pasha,
> 
> On Fri, May 01 2026, Pasha Tatashin wrote:
> 
> > On 05-02 01:30, Cris Jacob Maamor wrote:
> >> LUO restores metadata from KHO/FDT during liveupdate. The restored
> >> metadata contains physical addresses and count fields used to access and
> >> walk preserved session, file set, and FLB arrays.
> >> 
> >> This series adds a non-consuming KHO preserved-range check and uses it
> >> before phys_to_virt() on restored metadata addresses. It also rejects
> >> restored counts above LUO_SESSION_MAX, LUO_FILE_MAX, and LUO_FLB_MAX
> >> before traversal.
> >> 
> >> As far as I can tell, this is root/admin-only; I do not have evidence
> >> that a normal unprivileged user can trigger it directly.
> >> 
> >> Changes since v1:
> >> - Dropped RFC marking.
> >> - Added changelog text to each patch.
> >> - No code changes.
> >> 
> >> Cris Jacob Maamor (5):
> >>   kexec: handover: add helper to check preserved page ranges
> >>   liveupdate: validate LUO FDT physical address before mapping
> >>   liveupdate: validate restored LUO session metadata
> >>   liveupdate: validate restored LUO file set metadata
> >>   liveupdate: validate restored LUO FLB metadata
> >
> > I have replied separately in the security report to clarify that this is 
> > not a bug. The behavior follows the ABI specification exactly: we use 
> > the PA addresses and ranges provided by the KHO FDT tree.
> >
> > NAK
> 
> I really do think we should do a restore-only variant for the
> kho_alloc_preserve() family of allocators and use it everywhere. It

That is unrelated to the provided patch series. The author of this 
series reported this as a security issue to the Linux security ML, and 
submitted this series at their request.

This is not a security issue, and in fact, it is not an issue at all. A 
restore-only variant can be added, but I do not see a reason for LUO to 
use it.

> would prevent problems in the future. Not because the previous kernel is
> malicious, but because we might have bugs and the KHO page magic sanity
> check acts as a defense in depth.
> 
> For example, I am currently looking at a LUO bug where LUO does not
> track if a session is outgoing or incoming. So you can do a retrieve()
> or finish() on an outgoing session. A lot of nastiness is saved because
> of the page magic check. Things like kho_restore_vmalloc() or
> kho_restore_folio() fail early and loudly.

I am not sure what bug you are looking at (please share the details!), 
but the fix absolutely should be to use outgoing/incoming sessions 
properly, and if we mixed them up somewhere, THAT should be fixed. Using 
KHO restore is not going to help much; however, I agree it can add 
some extra scrutiny (i.e., similar to an ASSERT), but it is not really 
something that would help improve correctness in any meaningful way. The 
correctness should lie in the LUO logic using incoming as incoming, and 
outgoing as outgoing.

> 
> If we want to squeeze out more performance later down the line we can
> move it behind a debug config, but having this usage pattern of always
> restoring before using is going to be a lot more sane than just using
> physical addresses willy nilly.
> 
> The approach this series takes with kho_is_preserved() is the wrong
> design. But a kho_restore() or something similar (maybe we can find a
> better name?) is really where we should be going.
> 
> -- 
> Regards,
> Pratyush Yadav

