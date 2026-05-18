Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFE0CD4F4A
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 23:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7KNTaIG0lsIqN03Ekvf0L0UIuEbXXSLWDvqyaaegcdY=; b=jcWjED98j4lFV8jEtTFiKiyTfT
	Dtqmazd9hYKx9QpYUt8uangtvjIl0xTY4dAKvVP/j/9khV95AXCdszmsoOjIDZ1r9Mou2i8EShZEy
	pQ/QVXVmVafUzjpQBo8hk1fDB5gfBpH3ZxTLNMc0YtRfzOzkq86/7kwEALsS/r8b6cH2fvFOy4R5I
	YHTrrxBArn3zbWJlbyPFvhOXQ6s8IYb0LdnHTMOjlLhxAd9RkWWLZGsElx3uyODvdcC0M5hlXPGJL
	ZK3fBQh+BdCsGPiS6FC+3KRlrLP++6KEYSgwX+IwYqOXQJ5cG1aDRqFTbrUcsfxtyphYVsbp+/nHq
	fjTYbuQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP7BD-0000000HAUJ-0Kcv;
	Mon, 18 May 2026 23:15:23 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP7BB-0000000HATo-0zvk
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 23:15:22 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-50fbd79350dso34230281cf.3
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 16:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779146119; x=1779750919; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7KNTaIG0lsIqN03Ekvf0L0UIuEbXXSLWDvqyaaegcdY=;
        b=faBhyj5ZB5EApWj5xVdMsx4BGBMYDpn80T5uPwlH1Kdy2MeonFwlDLBVSAXRC/SRb1
         hDPbRI05NMS9lZCR9fjqn4eh5DAD96WP2idsVc4pO99hqXF96/tT84/pgEZg381xXjA3
         DYodpnOjhwxL3AvMLVoAWaoaQPGXtoi2At44tv4HuypvyO+Gz0tCbnc7pKvGDPfPQ3g/
         abIW28BGpcP3ZR2cN69BxtoeJo84NtYAaAJ3u/HVwxvpCBkC1YGUJtCB7o/Pj2UAYE1U
         g2RfnHNuEquXqE7aWvmCSGb3PUZAXYq3Ap4Gss03yQVzWWysFU6jmEy9dbfdXezpcIVp
         wQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146119; x=1779750919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KNTaIG0lsIqN03Ekvf0L0UIuEbXXSLWDvqyaaegcdY=;
        b=m6lUWZo+u5svVzYl37WbaqjpnnfVCwwjw87ZXckim/9wlHMLfhRJGW+YLjj4HoQJtE
         IusgxFvqLqZoQO6XK3wEknVYhxIJD8jWWjFhDQmJlRRuSD/PP9QSPyyxi5dSrO3B+OX6
         zUEfvIG6dBPoyZL8IGP7SpdCtamsCXBgC7mnnzvgdcplxj7JDsEjCmXWoo270x65W9Ge
         kWOXlnee25wo/A5CL0XXAnds8UEHnDkcZLNv755UmSmu2dpYAUaJRI7EwlWYCzZGnVQ7
         9+jzLgEzEbn/BtGD333foI+8AAY+YQmezTMsaoZMoWWiGR71pz3pbpBnIbL4ZYfA9CWh
         mTsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tA3gSiSPSoTI3gczJHo20h+5nNSIkpw4jsTrDiqYfQpuXIFVWSlj8rxx7yBW2UuC3JtOS7w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxB2YXoJGVbiDBt0hx2ymHbVFECf8kh0ul88WjBrddFVqhQScPj
	clyxgsiWF7anO3robYnYnQzeJ7LmmvmWT2P2Ny1ORh+uJEu//2dTFNebbDBp+o92mTc=
X-Gm-Gg: Acq92OH+Sg+0xINe2mtbONj5RUfSWd7OxMjXdRe/bQWiaFlreqxc/hk2t9WZAOhj16J
	mXn5Q89rdOcmKYJeMaFd1skZ3VaL9+blUUDnFmtitcOMyBEG+4Os8H0YmU6c54uymhbGAgFJSxi
	L1bMHN/q5VLj1CNfztXHaIRXznaqCBDqhMpkc+eslykHT+sykoMH9zkHH7C4zSBLdLmcPX0dKfH
	t4QhbBGgX3rCt+cGwVjvmlbRAmdv+k2p2pL9SCBhW/jUg9+jXpZPYm5LNpMMKsmYM0+D7030Ocb
	5HE1Kq/ZciP76DhE4NeZV3gQglIEcBmX0M/IzcUmJlZb1YFwfDWkZjzcPiq3s0qIAF3+3ZuATMv
	cvDH9tcU2pi2/29OnxXV+AhODpV72HCY7kvp3uD52Q7c7NrsmTPAtV+qscxaq4sKCNO5/4Ot3HS
	yuRsXx4dz2aY9SICupsgEt6WyzZA08xJcmNCkjd819DmBXXqOV37E=
X-Received: by 2002:ac8:7f8f:0:b0:50f:b3d0:c5ed with SMTP id d75a77b69052e-5165a0e568fmr252479931cf.31.1779146119282;
        Mon, 18 May 2026 16:15:19 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456df09csm146874721cf.13.2026.05.18.16.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 16:15:18 -0700 (PDT)
Date: Mon, 18 May 2026 23:15:17 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, rppt@kernel.org, 
	sourabhjain@linux.ibm.com, jbouron@amazon.com, akpm@linux-foundation.org, bhe@redhat.com, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, rafael.j.wysocki@intel.com, 
	piliu@redhat.com, kexec@lists.infradead.org, skhawaja@google.com, graf@amazon.com, 
	mario.limonciello@amd.com
Subject: Re: [PATCH v5 3/5] liveupdate: block session mutations during reboot
Message-ID: <aguXhxrjhvmxAyb2@plex>
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
 <20260518125459.1092373-4-pasha.tatashin@soleen.com>
 <2vxzo6ic8ysn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2vxzo6ic8ysn.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_161521_291632_0FB8142A 
X-CRM114-Status: GOOD (  17.83  )
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

On 05-18 18:31, Pratyush Yadav wrote:
> On Mon, May 18 2026, Pasha Tatashin wrote:
> 
> > During the reboot() syscall, user processes may still be running
> > concurrently and attempting to mutate sessions (e.g., creating,
> > retrieving, or releasing sessions). To prevent this, introduce
> > luo_session_serialize_rwsem to synchronize mutations with the
> > serialization process.
> >
> > All session mutation operations (create, retrieve, release, ioctl) take
> > the read lock. The serialization process (luo_session_serialize) takes
> > the write lock and holds it indefinitely on success. This effectively
> > freezes the LUO session subsystem during the transition to the new
> > kernel. If serialization fails, the lock is released to allow recovery.
> 
> Good idea I think.

Hi Pratyush,

> 
> But, do we need a new mutex? Can't we use luo_session_header->rwsem?
> Session creation and release take the header rwsem at one point anyway,
> so perhaps we can just reuse that?

The sh->rwsem is for protecting the the session list. We only take it as 
a writer when modifying the list (insert/remove) and as a reader when 
traversing it. Also, we drop sh->rwsem as soon as we've acquired the 
per-session mutex to allow other list operations to proceed while a 
session is being modified.

Because of this, many session mutation operations (specifically ioctl 
calls) don't touch sh->rwsem at all—they jump straight to the  session 
state via the file's private_data. To use sh->rwsem to block
these mutations, we would be forced to add down_read(&sh->rwsem) to 
every ioctl path. This would be a layering violation, coupling list 
management to per-session data mutations, and would introduce a global
bottleneck for operations that are otherwise independent.

The only other way to prevent mutations without a new global lock would 
be for the reboot process to acquire every individual session mutex. 
However, since LUO_SESSION_MAX can be large, this would exceed lockdep's 
maximum lock tracking limit and trigger failures. The 
luo_session_serialize_rwsem provides a dedicated signal to freeze the 
entire subsystem without messing with the existing fine-grained locking 
logic.

> 
> Also, do we need to block incoming sessions? They won't participate in
> serialization, so perhaps we can leave those alone, and all the outgoing
> sessions get protected by the outgoing session header rwsem?

Incoming sessions don't participate in serialization, but blocking them 
makes the code more robust. This provides a level of future proofing if 
new ioctls or operations are added later, we won't accidentally miss a 
path that should have been frozen during reboot. It's safer to treat the 
subsystem as a single unit that freezes entirely once the transition 
begins.

Pasha

