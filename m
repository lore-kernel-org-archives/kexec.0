Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9093EC71135
	for <kexec@archiver.kernel.org>; Sun, 15 Jun 2025 03:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=htnE6cZyQp3hBVThQwGfztzJ4wplD3wej7tv+PKbZl0=; b=BSNV49BHOlbeMmWyRxpRl54AaT
	Aan2gvvpmn7Fr8HAa+BvanmRGI3zgFuj607AtStBVYTD+5tac+VaGULfXLg13VEAxJPaSxsanUXZD
	o/HGt92T2C4ciysQG3uc6rN3SSOPGody5JZzta9m2U17da08QDdv43rWTVxC7zfVKoacRXR2/lCx4
	gkza2G+ViYbsTPrx5+8Dgu84N4ILU4dC6diWepNgE3ZV1hx9gFjnFDMHNwspDP3LUoHpnG6w9uqSU
	FGPD4gA6G4XsjE32LClDn1qKFY33mLh3chfmQjDNgq9y6ZbR1IpRITiVRQqtDBhrjQEI+SF69aTvr
	UUh7xE3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQdvb-00000002AVR-1qgm;
	Sun, 15 Jun 2025 03:21:03 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQdtP-00000002AOt-02c6
	for kexec@lists.infradead.org;
	Sun, 15 Jun 2025 03:18:48 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-235e389599fso159735ad.0
        for <kexec@lists.infradead.org>; Sat, 14 Jun 2025 20:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749957525; x=1750562325; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=htnE6cZyQp3hBVThQwGfztzJ4wplD3wej7tv+PKbZl0=;
        b=kWNRnkHY1bOo2EWA8pU6ODFm9w7NhNr7mUodoOjb6KD0yrroNWIdTXW0z+IVptd2Fz
         I5UzXs9NxatD/uElP7B6aBqRQzRuzgzycMLAbVwOB8C2uvJ8inrvy5BKQ9+NwL1EwFrV
         P8qCI1EI9vV5Agu6wRduP/cwPT5idzhkOvArmCHJaYrAOXinr5dL+/2LYyZl236uvYyp
         z2yT0s6hufFCdZ0eIItbUqg6zPjkZndKPzUHPrw1Tm5KG4WYAVmg7gSiYERjhqLIjUIr
         dBC8zqsjmIKwwKGQ9LlkdgSQGrAAD1NgYd3BbsKB2AQU8zXjb+tzUxUguGPV7nodmDnK
         djrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749957525; x=1750562325;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htnE6cZyQp3hBVThQwGfztzJ4wplD3wej7tv+PKbZl0=;
        b=dGWRvqMji7N2ghpuxLbmvGORwMiVgSRXiBi0Jf9uziEL0NIvE/O8tJuO5xqF1EFkjJ
         RW9Jok436xHhdEoBYICKo6j0Dlzer0x25Kk0YCliwvoU02H0MUl465J4hXVPCR+HaPBD
         N5F3mDEYSDLHJI3K7+8KVb6M8QGrwqkoI+fsdfdJ8v5Er/oakr+RoonlC0z0kIJsdAaE
         fF5yGu/Rsz1/xJmd2RqVASnYkSENj/qe1xAT2ho2+Z9vyaEPLMq5a3YJBx6iC4lUkKln
         xVS+QVvjqKXP1O7APivFLLz8LubUE6OgApOw/m2HFjiXxltTI/v7QPX515JnLwVr0iFi
         sMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYanBI0wSrjMGNGnqTxxm8y55/1+ZBtJ+Uvf0fXo4v6YH/WjpzCx9iAw1ECGqZy62t6TrR8w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxfDNU6rx3aYU/zQtmnN+DBfyuWQWO4CydlYZtGF0SxNWXiOEs+
	VCAL5aWdmc+xRefbRQTnkOEF2x2BvfeTbmZFuJHKje6nmEnh7HoGUO8rNrmpb7fSwg==
X-Gm-Gg: ASbGncvk7B4fwzAiYGzec0tZTWO4g0b/acJ10R4ZxM6J2oCXvChauKzJ1DRvjwvaXVm
	yB0f0UMLFBqe+bqRiWd/3/x3bjwMBiEEeNIBtWZVHlOL5uIjLl4ltloTwppkvqhAUUNjDFTCdsM
	ga2JwMg2pOLum32An7/hZ6ruGe7widyLBo2riB1DEEezknM9uU3X2VNA/fTH+R5+QSQjzWtP23M
	mVnfCpwUSv/kehJ12kJI+xFuE7n2ZXU9WdyOZGmQXCexXtUUchhkmDoOq5pCVYKNxQVUloiVE7X
	O+3ZGyJfQRFqVa4yHW3VY6ZT67JeDi9Ljh7bd/DYQb1kpJlviubK2dRMFkPJHFqwnRzJvnnwkGF
	k/VSypFCprrR9ou8b+HzXHHuGZbVWpP4Nvsv0l25mEv6qlhtLH5qnw+kj
X-Google-Smtp-Source: AGHT+IFEtaRYru155JQq7zLaRoe/Qil14tnoT1LZfbHXs/GCi7/BXOUQa8ukDEChHxKGPm+xc/wbqA==
X-Received: by 2002:a17:902:e74f:b0:21f:631c:7fc9 with SMTP id d9443c01a7336-2366c4f491bmr2243995ad.0.1749957524779;
        Sat, 14 Jun 2025 20:18:44 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:e851:5842:d37b:e796] ([2a00:79e0:2eb0:8:e851:5842:d37b:e796])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d2351sm4068424b3a.162.2025.06.14.20.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 20:18:44 -0700 (PDT)
Date: Sat, 14 Jun 2025 20:18:42 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    David Matlack <dmatlack@google.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, 
    Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from June 2, 2025
Message-ID: <474db0cc-7d27-9803-fbf4-d87470c1f232@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250614_201847_084482_7A2B6123 
X-CRM114-Status: GOOD (  35.55  )
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

Hi everybody,

Here are the notes from the last Hypervisor Live Update call that happened 
on Monday, June 2.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
We chatted about LUO v2 and feedback on the upstream mailing list.  There
was also some functionality changes proposed for KHO.  After the comments
for LUO v2 are addressed, Pasha noted he will send the series to Pratyush
who will add the memfd preservation on top for LUO v3.  This will then be
sent as a complete package.  I asked if Jason had the opportunity to take
a look at it, he had put it aside but not looked at it detail yet.

Pratyush planned on doing the review of LUO this week.  He also noted
that there were some improvements made for memfd preservation since the
last biweekly and that it is in good shape.  He felt that it was ready
for integration into the LUO series itself.  A lot of testing was also
added for libluo that is suggested for inclusion in the kernel tree
itself under tools/.

David Matlack noted he was happy to see the test binaries moving into the
kernel and into selftests.  David's VFIO tests would also need some of
this functionality.

----->o-----
I asked about the the entire scope of libluo and future looking thoughts
for it.  Pratyush noted it was currently only a very thin wrapper on top
of ioctls.  This could be expanded for more orchestration if necessary in
the future but no immediate thoughts.  Right now, it's just a set of
ioctls and tests and command line.

Pasha noted one extension could be asynchronous fd preservation that
might be done in the future with new ioctls, which could also be a libluo
extension.

----->o-----
Jason asked if the group was comfortable with the current LUO v2 design
or if there were any major concerns: we have the ioctls and the file
descriptors, it also eliminates the fdbox work, it reduces the need for
guestmemfs, it changes KHO, etc.  David Matlack asked about the
requirement of CAP_SYS_ADMIN to preserve fd's; Jason suggested using fd
permissions instead.

Pratyush suggested there were some complexities with fd permissions in
the next kernel, Pasha echo'd that it was likely safer to require
CAP_SYS_ADMIN at least for now.  David expressed concern about a
malicious process potentially being able to take over an fd unless root
permissions were required.  Jason said a somewhat different angle here is
for the character device itself where ioctl permissions are typically
protected by the fd itself; we may not need a capability check on top of
that.

Jason suggested a broker agent that would be possible to enforce policy
in userspace that would do fd passing, it would do an ioctl to the kernel
and then fd pass it to the less privileged entities.  Filesystem
permissions are much more flexible than capabilities.

I asked about future use cases where we may want capability checks, Pasha
noted we want to be able to change the global state for the prepare stage
and asked if that should be capability protected.  David suggested it
could potentially be a separate character device.  If this was needed
later, it could be an incremental add-on.

----->o-----
Pasha brought up a topic about the lifecycle of a file descriptor if a
process dies or quits.  When the VMM is running, it can add an fd to LUO,
but what happens if the VMM exits.  Do we explicitly remove it from the
preservation before going into the finish state?  He suggested that it
should be automatically removed: we should never preserve an fd for a
process that has exited.  Jason suggested the kernel should not be doing
that and is one reason we may want a security domain, the broker agent
could cancel all state associated with that process.

Pasha asked what would happen if the agent itself dies; Jason suggested
the kernel should fully clean everything up.  Pasha acknowledged this was
the current plan.

Praveen Kumar asked how we would maintain a state for a graceful shutdown
when the application is in the preservation state.  Pasha said that a
graceful shutdown and a non-graceful shutdown are identical from a kernel
perspective; the only difference is if the shutdown happened before the
prepared state.  If before, it's not preserved; if after, serialization
has already been done and it's preserved so if the resource remains
unclaimed then they are cleaned up in the new kernel.

Pasha noted that once we passed prepare, then we are in the critical path
to a live update, we're not going to continue running in this state.  It
should be valid for the agent to exit this state because we cannot add
new stuff to preservation list (the agent has nothing to do after this).
Pratyush said that with LUO when you preserve the fd you get a token and
the token must be saved; the agent would grab this token so the handle is
not lost.  Jason said that once we terminate, then we lost the ability to
undo because the session is lost; Pratyush said that we can undo with the
preservation tokens.

Jason suggested if you close the fd then the kernel should clean up
everything associated with the live update.  Pasha asked how would we
make sure we are not killed before the reboot.  Systemd may make this
more complicated.  He suggested that if the agent is killed or exits
during the prepared phase we cannot undo, we have to reboot.

----->o-----
David Matlack expressed a concern that the flow as described would fall
apart for KVM since KVM fds cannot be transferred across processes as
they have a lot of state associated with the mm struct of the owning
process.  We'd have to dig into why this isn't allowed as a potential
extension.  Jason suggested an alternative would be an additional fd
that has a container property that can only do fd save and restore
within its own container.

KVM would have to do its serialization outside of its original process
and then recreate its context after the kexec.  Jason said the KVM fd
would need to be preserved because it is threaded through all the VFIO
and IOMMU subsystems.  Pasha said we would only preserve the amount of
information needed to recreate the VMs.

----->o-----
Next meeting will be on Monday, June 16 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - discuss current status of LUO with memfd preservation and any blockers
   for upstream merge
 - discuss userspace broker agent that is responsible for the fd's, the
   ioctls, and the state machine that interacts with LUO, and any
   potential open sourcing opportunities
 - determine timelines for selftest framework for live updates, which
   could be a significant amount of work
 - check on status of VFIO selftests that will be useful for automated
   testing of device preservation
 - discuss forking off a discussion on iommu and live update that is
   separate from Hypervisor Live Update (due to scheduling constraints)
   but to include Jason and interested parties
 - June 30: update on physical pool allocator that can be used to provide
   pages for hugetlb, guest_memfd, and memfds
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

