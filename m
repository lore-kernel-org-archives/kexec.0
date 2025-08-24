Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FF8CA0EFC
	for <kexec@archiver.kernel.org>; Sun, 24 Aug 2025 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HGeJdxflg+OSNnP7CbO1iIoz8WJ7W0qhiGLDCSBW4vo=; b=2Y5h7rBVdCDY3jcJXANvYr2F53
	LzE8Yg9icKjm9Iw9nKN2FxL+GfA8pgbBSNCmx08JtCQAxJqzh3Q8o0ExlPvYJ7hhyZZ7+9o0nDqUe
	MBa4Z4ufMD+b+kq68cbf1pYY0yyUnTX0ofeqGHiJ2u4dFxZkKjPgiuJ1gaaOa6xBQAnnwwLgB1LQe
	sLNt9V0jsaQRex4VAjsMtXNseQrn4RUPn5m/AxlflEO60KDmPAEma/t+3dHWJU5tNkAgKj9BNCPQT
	KBEvYb7F3CGRQpm22CWq77iyhsRgOsPEOwzBMuToQlptM2QGxX5mgP+kDGhHLBN0GAXphX7R1T3DR
	n68UfI7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqGwI-00000006WKM-00Jm;
	Sun, 24 Aug 2025 20:03:42 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqGwD-00000006WJ0-1MRV
	for kexec@lists.infradead.org;
	Sun, 24 Aug 2025 20:03:38 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-24611734e50so199525ad.1
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756065816; x=1756670616; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HGeJdxflg+OSNnP7CbO1iIoz8WJ7W0qhiGLDCSBW4vo=;
        b=SdZVVdzqTJjZHSXZKXGMPMC5CDwmVD1BNHVohgWHtqpNUgMNNpa3wbY0XTQ5rC6LEG
         26E6xmk7mo3RdXldTg0xuiI7Eraq8Xu0kKUB0m0vFt0aifP3FfklDUp7tRYdQNF0VB5r
         LEAzPAkJkQ3rIqOd37G1esdVKV/9SZJC/DmOMwmY/vBXeqLooR0aPimLDaymb0pNqZNq
         12sDQ9fFIMAPgFJA6gzllc1yFe0zOFq/WFe6y2FyW4Nc5KJzoZJ0pNzOIeizI3b+NBEX
         amXqNlOo5J2A3MQihRvixG4VLsz514dMGTDugQWveAUELR0mV9pRA6TOh6UDhxSQc7wb
         +IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756065816; x=1756670616;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGeJdxflg+OSNnP7CbO1iIoz8WJ7W0qhiGLDCSBW4vo=;
        b=n/kNmqH8m6ti/pUa4PoGaOPtLTp0zXot2trgQiSKCQXKIcqbKwqkzHhjLbobsRgA1F
         MlTsmbG71VOPYty7K6UyePVSuaBhJjDzWhVymfTzJCB/ryZAE6X+NWbqQbVsbDIdH3/0
         y36/SmN7ulFAIgRdAeSl6nw/wNM2HiN7V4dQmT0aV6dK8VM/mVGCQHVeUbSYYCz/a5zo
         /vP0SEqEm7m4UGGGtp0x2HA8605sscmHkF7D4MHG56K9bcmaDq40iuN2M37AzNv/4wRh
         iVYqTF9MoqCM/+ebJShQ+kleqEwp4QE7uXNhhcQk+8LZ6QZMDi03zLbAF57nkqy1A2ch
         gvWA==
X-Forwarded-Encrypted: i=1; AJvYcCVfsK8Izcs2YrQczbDVE67i1ZX8qgLIjlT/LuF6JohJXu4aF/g95hRdRMUaQbkUdEHgTL+Y3Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YyXk00NO1kndEt+j02mXDLXPO7/YJCQ51dsoVpaRqsi2/tO16FW
	VlU2iID0hpkH0LZL3/0//aaHC/lIaQ971/kPNAjTdK8ie+UttEEZd2yqrRexuentqg==
X-Gm-Gg: ASbGncu6rnUzx5TlHwHsWtRkcyBn1naG1jA3FFvYGobjQRQyybEmOjf0qWGZdF8etDz
	DSz1jZITvFF1JC70+rbCbWzAFezfX9WZDQDU0TeVjCDN3bR7u+LZdyRo+lthfYWc+XZWA9Wisf3
	qzq31Hhu0FgLcdlrNo5d8/wAK/kpIYn6i+vt1DuwdV7KId7n0m2zQ1PGVtZitlkAv+G+wdUqSUg
	JqogtoLApDzkG5WRHTLJAo1s9Dl5XH0ezy3WiSIqfW4PrOxk3YXbrvztQVTbABni0H8RkBypoBb
	YgrxmYNkgCASsXjSzw9ACMmEUYigj2kkXcrO6blsASMB+K+yLxu3U6oHQHpBdYb0Qwlpog1uuya
	IEiXV+8pbjffV4qxp3uZFiYWjyQKzUGhP2sWsRQ0x1/lzpWTgQL9iTk7C1Sj9zOzpHd4Gk1asX2
	/654jCEsfpGGFKEeRyruKKo/4I2cUmjhpO+cp38b75wfTFUu8itA5W
X-Google-Smtp-Source: AGHT+IEBkizRb5AOm4HmomONRCZ5EWlBY1x2iOyj6Q7u5nfkDELjRtZxkwo4LPzKn2rRVqy+vuxTOA==
X-Received: by 2002:a17:902:cecc:b0:236:7079:fb10 with SMTP id d9443c01a7336-2467a21e4c1mr3270305ad.3.1756065815516;
        Sun, 24 Aug 2025 13:03:35 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:da63:34a:a93c:1b0a] ([2a00:79e0:2eb0:8:da63:34a:a93c:1b0a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254ad9321bsm4998298a91.0.2025.08.24.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 13:03:34 -0700 (PDT)
Date: Sun, 24 Aug 2025 13:03:34 -0700 (PDT)
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
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from August 11, 2025
Message-ID: <365d38fe-50d7-4a1d-ba13-942af26297b2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_130337_386149_EDE71D68 
X-CRM114-Status: GOOD (  34.09  )
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
on Monday, August 11.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
We discussed the current status of LUO v3 which was out for review.  Pasha
had pinged akpm about merging this into mm-unstable.  There were several
changes from v2 -> v3 as a result from discussion upstream.  Specifically
there was discussion about how file descriptors could be orchesrated
independently from each other; individual fds could be moved into a
prepare state before the global state changed to prepare.

There were also changes so that only one userspace agent could control LUO
at at time.  There were also design changes around IOMMU API based on
feedback from Jason (making it more similar to iommufd for extensibility
in the future).

----->o-----
We discussed Live Update Orchestrator Daemon (luod) and the external
design doc[1] that was shared upstream; this includes a description of the
luod lifecycle (started early, cannot be killed by systemd, and continues
after the reboot phase).

We discussed sessions in luod.  Previous discussions suggested that this
should be managed in the kernel in LUO but there was a realization that
they could be fully managed in userspace through luod itself.  This is
intuitive since there is only one agent that can control LUO at any given
time.  Any user that wants to preserve state with LUO would then create a
session through luod (its UUID is a 128 bit value).  This is required on
the other side of the live update to identify the session.

Imagine VMM establishing a session and then luod monitoing that connection
so that when the connection dies, everything is removed from that session.
If the VMM quits but still wants to preserve across LUO, it can commit
everything to a session so that everything associated with the VMM can be
preserved (after entering the prepare phase).  This also ensures that on
the other side of the live update that the client has to provide the
session ID to ensure it is connected to the right data.

Non-privileged processes can also preserve state if the admin process
makes the sock accessible to non-privileged processes such as the VMM.

luoctl was described as the CLI for interacting with luod.  This allowed
dumping the state in json format including for debugging purposes.

Pasha expressed a general concern about security including for a
compromised host; he did not believe that LUO should enforce that security
boundary but rather wanted to have a security review that would help to
establish luod's role for security.

There was no implementation to go with this at this point, it was only in
the design phase and people were highly encouraged to provide feedback for
its design.

----->o-----
Chris Li discussed PCI preservation and the latest RFC patch series that
was posted.  He received great feedback on the mailing list for RFC v1
especially from Jason, including for how to handle config registers.
Jason suggested starting from preserving as minimal state as possible 
rather than preserving everything from the start (MSI config registers
should likely be recreated on the other side of the live update).  His
suggestion was to minimize the preservation state as much as possible.

Jason said one of the biggest open blockers was how the kernel would
resynchronize with all the stuff that wasn't reinitialized.  For example,
for MSI, we save the registers but there was a question about what happens
next time someone allocates an interrupt and what happens then.  Jason
suggested that the interrupts should be reset by the new kernel on the
other side of the live update (interrupt preservation was never the plan
so far).

Vipin Sharma asked about how MSI preservation was never the plan; he
suggested that KVM be able to check that some interrupt happened.  Jason
said the plan to date has been that interrupts are lost during KHO.  David
Matlack echoed this, that the plan for now is that any interrupts during
live update are lost.  In the future, posted interrupt preservation may be
possible but this could be very complex.

There was general feedback given to avoid leaving behind placeholders in
the series that would have to be addressed later and potentially by other
developers.

Chris asked for feedback on the scope of v2 and the minimal viable patch
series to make progress.  Jason suggested preserving the bus master bit.
However, he suggested the very first series of patches should likely focus
on allowing DMA to continue to system memory.  Chris agreed with this.

Chris asked about which PCI devices would be good to start with.  There
was general feedback to start with a network device that does interrupts
and basic DMA (like e1000).  Jason suggested after that, that we shift
toward PCI DMA with an IOMMU present and start talking about how to
preserve the IOMMU configuration.

----->o-----
Pasha brought up the point that in the context of Chris's RFC series that
we have not yet discussed how to pass old data to the new kernel.  He
suggested spending time to design this.  Chris said this was out of scope
for the original patch series but now that the minimal viable approach has
been discussed, it would be possible to discuss this in a future call.
This was not predicted to use the device tree, but likely something closer
to KSTATE.

----->o-----
David Matlack noted that the deadline for proposals for the live update
microconference was September 10[2].

----->o-----
Next meeting will be on Monday, August 25 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - discussion on whether these recorded sessions should appear on YouTube
   to share rather than only on the shared drive
 - discussion on latest status of LUO for the upstream kernel after rebase
   on top of 6.17-rc1
 - update on feedback received for luod and the next steps as we head into
   implementation
 - update on the latest status of PCI preservation, registration, and
   initialization
 - [15 min] KSerial serialization protocol designed for exchanging data
   between live update kernels (BTF to extract or deposit data into the
   kernel native C struct with unique member id)
   + overlap with KSTATE and next steps for implementation
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] https://tinyurl.com/luoddesign
[2] https://lpc.events/event/19/contributions/2004/

