Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB83CD4F3C
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BHqthI1CDxGfCxTi7gsLzzy1qcENONWCFt/VwaPCNVg=; b=5FsCC4mcsKPmt22VXlnSwfRfyd
	gjHR7wbZGF+gtQEfsGBwwnini4R0reEl28eunc2VCJZx/G9jwMk9Rba2ZofFjDfFztPif32UCa+PH
	Uj/T9YLVDpyrHQq0/2PnoCXlJrGd2kVl2ngXsArNiP0iPhrB6pxXZXHyxQvGzCkszHyBepX0RrQJx
	9cP7jsa17IyCwjw0wM/hLbMRo9LtLAQcexBiBLOAFd3aH2JOPSOuev2IjaryUWrxLU9Gp14MxnDuk
	pO8//XSXjKN9P/KDHSMbvecZnQ+mlAz+/Rb9ZfC4k5ZbpFRi0DcsxzuOKL4KxG3a1Fgf91ZY/4TqI
	z0qskW5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOgk0-0000000DHoX-3DWR;
	Sun, 17 May 2026 19:01:32 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOgjy-0000000DHo2-2uxX
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 19:01:32 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-8b7ec7bedcbso6654086d6.2
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779044489; x=1779649289; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHqthI1CDxGfCxTi7gsLzzy1qcENONWCFt/VwaPCNVg=;
        b=D+AVr/dyR7JvKyl0/ZqkAzJnZUMzSYOnLCm8QL33Z/S3s55/IxbwdwJHnb5PQRPwqp
         /qvpf8m07TG8WvvK6vqBjuUm492cKbS+I5rrlWFmWrkbjU+CpsorrXOcrG8gXLSRiV3V
         SFdSPci6PtFdD5uFloKdmMoxP3pnaRi02ARKgB4kXn1lOHVTwtr2PNYZtFnyrr5vZoHn
         tkUfG30jRIUB6jdJw4ADvbcJIMzSRqz7uyw9H74MgNhr6ZA10I1MKHjtUz1BY/7DLlej
         tETdsCv538Tg+w6Yr/riHJEoa4FCqLRYych5csAzWLg+fHuOajbBD057aqtVFo1nTMCc
         FFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779044489; x=1779649289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHqthI1CDxGfCxTi7gsLzzy1qcENONWCFt/VwaPCNVg=;
        b=M4sytbZYqr1ESjiTIoQSl46qNQg+igLY7E2rTgPVF/ToIhxvUV5f4OjbXmo4WYZixa
         ByZCtJ7gob1xHE1Bti3KY82DRChT65vj1/a4G3+CaTW3gdbk4wUfTC/8UUhEof/E7+8/
         5Ir55T83EXv6WT6iHQ0PGP9cUL5gY8nnCyI69G+oj+MtGyLnpUE7OUtZ3tziP0nQZWGK
         9D/1VjwD/xNPYk8ti+7l6y7ijxyJjRWC7UQn+luUA8QVCmLTtYIB1wG52Xb9KEv6JMPF
         Kp6FlO8/psVcWi4QblAuDiyZDf3f0ynzGX0MYdHUxKh0e5nOiowPWQUd63kXv2HuYPsf
         L9bg==
X-Forwarded-Encrypted: i=1; AFNElJ9ztH4xUEM6Jcmko24X6yHV+p5WhYNWaP/RwVjFzfcMFR5IbrlviFb2QgWnwUJ37O8qJz2HzA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwCEAsB1xI3o/yBxbTvOWBDTozrZSVpFHfDrVgPreDBjHGZE33b
	cQWIDDv0w7HDa7GANv+k5EudOAuAqTcRDBsy0BMUnnRv6spnrilDw3svrUypH8XsPlk=
X-Gm-Gg: Acq92OGEgpdcDs69fP1NLrXJOZDZjZXbIBSQtDWDe3zVTeUsf+g/xLihZFx7teTaTp4
	MOKfq8aUCE1O/1VNeZepBjF8Y3aHy0NYe6KMWoZuT7yu9e2X9VdyVnJkdw2a3uP7HywmhUNWWAi
	L3kv+ZisPPz41O3VgzVxVReUJ+9utvclAIRQgnyVyfPo1RuV3S6qD0bKYQL1WkIOOjDgQ7CgqWm
	asEbVk4qq0tZMmWF+w86OLOYP28dnuuoeOoGHi+oTdn4ba3F5FiytCK37s9IOzjnnsBhyqEc2hs
	Y5Jv56VODgqnGbrNnt//AVs2mTaflNHmXb6cRZvRM6TvTj3kjt+Mi2uYGp6G2gde9Rsxu0PfeGy
	HEBSVFizbnFj/4MDSoTNfITUCL87WHvwIzM1l76tfvhC+fTis6liUXEymnFZLdJyvayOScC2Kzs
	CzVuw85gR0FHYuCs1c5mzFeWLAwOQjtAjPZalc2Nyaw4nW6XvY/9M=
X-Received: by 2002:a05:6214:2b93:b0:8ca:16a6:3d60 with SMTP id 6a1803df08f44-8ca16a64337mr155957446d6.17.1779044489207;
        Sun, 17 May 2026 12:01:29 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361ad694sm29945406d6.45.2026.05.17.12.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:01:28 -0700 (PDT)
Date: Sun, 17 May 2026 19:01:27 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kees@kernel.org, 
	sourabhjain@linux.ibm.com, jbouron@amazon.com, akpm@linux-foundation.org, bhe@redhat.com, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, rafael.j.wysocki@intel.com, 
	piliu@redhat.com, kexec@lists.infradead.org, pratyush@kernel.org, 
	skhawaja@google.com, graf@amazon.com, mario.limonciello@amd.com
Subject: Re: [PATCH v3 0/5] liveupdate: serialization safety and race fixes
Message-ID: <agoOe_BjM4IKJM4Z@plex>
References: <20260515003722.938123-1-pasha.tatashin@soleen.com>
 <agn-R5TPNmUSeU3y@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agn-R5TPNmUSeU3y@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_120130_745907_0075622E 
X-CRM114-Status: GOOD (  22.45  )
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

On 05-17 20:43, Mike Rapoport wrote:
> On Fri, May 15, 2026 at 12:37:17AM +0000, Pasha Tatashin wrote:
> > This series addresses several issues related to the synchronization
> > between the reboot process and LUO session management.
> > 
> > Changes in v3:
> > - Refined the session mutation blocking to use a dedicated global
> >   rwsem (luo_session_serialize_rwsem) instead of pinning individual
> >   mutexes.
> > - Fixed a use-after-free race in luo_file_unpreserve_files() where
> >   a module could be released before its file handler ID was erased.
> > - Fixed a TOCTOU race in luo_session_retrieve() by extending the
> >   lock scope to overlap with session mutex acquisition.
> > - Removed an unused 'ser' field from struct luo_session.
> > - Dropped the KHO skip patch as it was not needed.
> > 
> > 1. Skip LUO serialization for context-preserving kexec: A
> > preserve_context kexec returns to the current kernel, which is unrelated
> > to live update where state is passed to the next kernel. Skipping
> > serialization avoids unnecessary work and prevents sessions from being
> > left in a frozen state upon return.
> > 
> > 2. Block session mutations during reboot: During the reboot() syscall,
> > user processes may still be running concurrently and attempting to
> > mutate sessions. To prevent this, we introduce luo_session_serialize_rwsem.
> > All mutation operations (create, retrieve, release, ioctl) hold the
> > read lock. The serialization process holds the write lock indefinitely
> > on success, effectively freezing the subsystem.
> > 
> > 3. Fix use-after-free in luo_file_unpreserve_files(): Reorder module_put()
> > to ensure the file handler module remains pinned while its operations
> > are being accessed during cleanup.
> > 
> > 4. Fix TOCTOU race in luo_session_retrieve(): Extend the rwsem lock
> > scope to prevent a session from being released between lookup and
> > mutex acquisition.
> > 
> > 5. Remove unused ser field from struct luo_session: Clean up the
> > session structure by removing a field that was never utilized.
> 
> Sashiko is still unhappy:
> https://sashiko.dev/#/patchset/20260515003722.938123-1-pasha.tatashin@soleen.com
> 
> Didn't verify it's actually right, but its complaints seem legit.

Reviewed the complaints, a couple things are legit, I will address 
them and respin.

> Among other things sashiko noted a TOCTOU issue and then found it's fixed
> by a later patch, maybe move the TOCTOU fix earlier in the series?

Sure, will move it earlier, while I think, as long as it is fixed in 
ther series it does not matter where it is :-)

Pasha

