Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA890C7115A
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 00:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w0k2OgKY6E3aksEUpy2Tv2gePnxab+bwdfH9S15BR3s=; b=T1/1nl3Ts1QW29GmD9XTk06Byi
	xSy10sge4kO9nRSD2Mjiby9JioVTSCrpTyxfaeWR+VXXzIjERvPpj7fAdmJ05QAcENxUo6K1tNUOF
	HRkIUvdTyfeehc83De1v77YnJFPzOUzIGftRsl40NFATvAQa1vGNb2gip6H20cpPE2BzYKx9C98DW
	DELuslVd5llSSnB4LSJxbxEuDEx8NinBsCtioqCNMEGprtodyEzaF1ElxZksl6gGRtubIhsQjkFT7
	cWgx0leDDPWSnrvLyrjrgkj2Oxhdiq1TsVIdRf8X77TquxGknpUW+EZQriWxo3AnY68bmHVKdmJuj
	ylPtHskA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTUkk-00000001LPQ-1wtp;
	Mon, 23 Jun 2025 00:09:38 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTUke-00000001LOd-2FXx
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 00:09:33 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-235e389599fso217745ad.0
        for <kexec@lists.infradead.org>; Sun, 22 Jun 2025 17:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750637372; x=1751242172; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w0k2OgKY6E3aksEUpy2Tv2gePnxab+bwdfH9S15BR3s=;
        b=xbU5H/hz8lWvqlXGoqby1QWxvLwqnCVExGVqNhCes8huAmOSVUv2jIADCJIT58ijlx
         dptQ5o0hdStO/OceIBsMVlX65WabiByZkuBHF39CIoDXTpwtkIYW19UYe/m1aGMzVPzi
         Fns72t8MefpjPl3kH0hx8D6ombDLjwCzknzFheP6Zj2JaTgDs0cYzkunnEl1mXj3zvs+
         ochtNwN5wtuIBHjU4597RSoIKZy6JAmSIzSma/ax124zes4Tue3c09s/145S0axIIVUZ
         3veg4pFh8lsNbyJQgZkzTePeLX4IUFQiQznQICjhwB1yxZe/kPtis7H6wNhsiS0t7tCC
         znKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750637372; x=1751242172;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0k2OgKY6E3aksEUpy2Tv2gePnxab+bwdfH9S15BR3s=;
        b=brb9CTOStMVqjTy1w/Pt+vbH5M5xtNN7SDrkwiH5VSrTvpjsW5mOYN8Kmgd0TYt38j
         sz4/qY+VkWgVGwXUYabk0k3bUOyQr5NPgBbrBuu7oXaHhPr2gd6jFaGf2qZGN3pSOWqU
         vgQSSEMtZGPczNn9UOHeAfnb4nVuxSzUeTtDG+pDpdSYIuvLW8sAMHLFExfIvMcdW1cw
         ASwIdHg2FVWsxyqizJ7PexhbxiWbUtnAGumtFf5CLYojXfLA55MZnomA80AwdqcD8urB
         3TPqqEuzXr2Om3XDXaZOjtycFOh0IaXAjxDEFTUta0NCRIm2w2GI+GEk5M3EQEr6efn2
         Zv9A==
X-Forwarded-Encrypted: i=1; AJvYcCVBZfbHORuVHaCHisNFrD5ajN7yT/WDN1TqX+Od+jQ3Q4rc+DY3ZO8HItJdCX1VndafRt/0pA==@lists.infradead.org
X-Gm-Message-State: AOJu0YykVizIKgpqsOkHzWgCPyWh9SE8UYlsf8quFrPM/K5mPqSwOMs7
	+5UO7GmiobB/4pM79WCEZCohN48o8Q0GR1H0YH6oMnBGrY2dcEJnF7Egp5H9jFJRTA==
X-Gm-Gg: ASbGncsKLZcSjy0FAbvQZb3nERYR8tq9Wf24lz3uAg7/XiQQBoOl2yuOHJ8b8Avoou7
	YbcLhZWaVEAwhefigPNCpv4VzRTY4Acv9oT//D6MKPkmsUlqYw0ExPB0t2D1KUaF2VMhDYSZ6/Y
	ti94+vPoXbF+yxdTVQKpDs/EPo0OJh8EZ1nTCALB9hLrC+smA3SnjVQfatbZXi704WIaVZoRhAE
	mBAvZ6Dc1YJhqk55bnnAw0o6rAl66h74Io7gtVarHUIaOdsGxztv4asyKclidntNrhYrQetCDmR
	MbHb5igPhodAHnk7qr3VS15ca19XaLUWWLfu5GqE2V7CyFD18QSrSaopgThFPWuwduBngc2nuWj
	Lr6EL4taazWCVn6aJ0dw+IeE0FMVc0v5FV/VfsUyAGH6E2ey+EIC4G+5C
X-Google-Smtp-Source: AGHT+IEGexjH8dYn9o9me0q6RAJ9TtuH4f/CO/gMThBwiYTHLjj8jgJoXz+1eCy3L4B5tpdAdhsYIw==
X-Received: by 2002:a17:903:1aed:b0:231:d0ef:e8fb with SMTP id d9443c01a7336-237e478a959mr2803075ad.10.1750637370543;
        Sun, 22 Jun 2025 17:09:30 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:ddd9:208b:60c1:4d15] ([2a00:79e0:2eb0:8:ddd9:208b:60c1:4d15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12423e3sm5497610a12.47.2025.06.22.17.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 17:09:29 -0700 (PDT)
Date: Sun, 22 Jun 2025 17:09:28 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    David Matlack <dmatlack@google.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Jork Loeser <jork.loeser@microsoft.com>, 
    Junaid Shahid <junaids@google.com>, Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from June 16, 2025
Message-ID: <ee353d62-2e4c-b69c-39e6-1d273bfb01a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_170932_585386_2196147E 
X-CRM114-Status: GOOD (  28.20  )
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
on Monday, June 16.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
There are no curent blockers fro LUO, Pasha noted that he was doing more
changes and added session support and the ability to track which fd's get
registered while the device is open and then get removed when they are
closed.  He also cleaned up the UAPI.

Pratyush said the memfd preservation code was almost ready to go, just
needing to update documentation.  This was being integrated with the
latest LUO series.  He also noted some changes for libluo and updates for
the test suite.  Once the tests and documentation are completed, there
shouldn't be any work left before the next series.  Pratyush noted this
should be ready by the end of this week.

----->o-----
Pasha started a discussion on liveupdated, a userspace daemon, to keep the
sessions alive so everybody can register and unregister the fds.  It may
even take strings from the callers so that the callers can associate
themselves with the specific fds after restore.  Pratyush was
experimenting with something similar and said it may make sense to add
this to libluo.

For systemd, we weren't sure if it was possible to prevent systemd from
killing one specific process during a graceful shutdown.  We'd want
liveupdated to survive the userspace shutdown.  We could theoretically
have a live update target that never kills everything, but would be
useful to discuss this with systemd folks.  liveupdated could even become
part of systemd itself.  Jason said that the way the systemd dependency
engine works that reboot isn't anything special so if the process is out
of reboot then this should work fine.

Pratyush noted liveupdated would be a critical component for using LUO.
He had been poking around and thought traditional sockets would be
sufficient for passing around the policies and determining which process
gets which fd.  Pasha said it should be self sustaining and not requiring
external storage.

----->o-----
Ben Chaney asked if the current support for memfd preservation supports
memory overcommit, i.e. swapped pages.  Pratyush said the current approach
does not support overcommit although it could be added (although it would
be complex).

I asked about the use cases for supporting overcommit for memfd
preservation.  Pratyush noted there are some databases that swap out part
of user memory and for these processes to come back up after kexec
quickly, they may want preservation even though it is outside the scope
of hypervisor live update.  Ben said they'd also likely use it if it were
available for live update.

----->o-----
We discussed token numbers and agreed that liveupdated would need to know
its own token number, perhaps a specific token number that specifies that
the process is liveupdated.  Pratyush noted in fdbox work that he allowed
userspace to specify the string rather than the kernel choosing the fd.

Pasha suggested letting the kernel control the token primarily so there
are no conflicts they can be controlled through liveupdated.  Pratyush
asked if liveupdated could always control the token numbers itself and
Pasha believed this to be reasonable.

Mike mentioned upstream feedback during code review of fdbox for fdstore.
He suggested there may be something in terms of approach that could be
leveraged there.  Pratyush noted that fdstore may allow the callers to
name the fds.  liveupdated can control the token itself and that seemed
aligned with the group; Pasha said this can be done in LUO v3.

Praveen Kumar asked about the fallback mechanism if liveupdated fails.
Since it is critical process, then live update would not be possible.  If
liveupdated is re-forked, then anybody who registered fds with it would
have to do this again.

----->o-----
I started talking about selftesting frameworks under tools/.  Pratyush
noted that he had tests but they lack qemu wrappers so you need to reboot
manually.

David Matlack noted that sent out the RFC for VFIO selftests[1] and he was
planning on sending out the actual v1 this week.

----->o-----
Update: the physical pool allocator topic that was mentioned for June 30
will instead be delayed until the next instance on July 14.

----->o-----
Next meeting will be on Monday, June 30 at 8am PDT (UTC-7), everybody is
welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - discuss potentially switching future meetings from 60 min -> 30 min
   now that a lot of development is underway
 - discuss current status of LUO and controlling the tokens, any blockers
   for upstream merge
 - discuss current status of memfd preservation, testing, and
   documentation
 - discuss liveupdated that is responsible for the fd's, the ioctls, and
   the state machine that interacts with LUO, and interaction with
   systemd
 - determine timelines for selftest framework for live updates and VFIO
   selftests
 - discuss status of LPC microconference acceptance
 - July 12: update on physical pool allocator that can be used to provide
   pages for hugetlb, guest_memfd, and memfds
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

[1] 
https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.com/

