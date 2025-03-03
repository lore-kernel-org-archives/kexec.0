Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C32C282D1
	for <kexec@archiver.kernel.org>; Mon,  3 Mar 2025 04:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jSwTz98KJxkNrhvDmMikiQIq7w0EbnaiUYR+WiVAYwg=; b=G5BvD/84N0agSQvZZaduw5knLb
	B19vOXRwamFXQ+PIvk2/G17GNTjCXduamObKOhY4pQC9J67rwrP3dm6UMf23eCYJo/5fyTEh89O23
	sscXWfQSnVWePPvUjaaKABRuD47hSP4foF3sblD8EOAfhRmCXSeNSHWCfVtuC2WI61r0fr6vB0ElS
	g9qsPuIQGoE2LWfBm4Hx4glJdFs98ZXAz+YH/1bnWY7TjnwdUhr2VqzSrOmgxWQsB8Nhsh5oY3OFN
	qoUFx0VZZBnkvgjOAcgkusjAZCgtXaaw985tE+HNSPVfaII8UIlMaV2rFSDqLcGrjw2AtKJWREHnJ
	pJZF3aJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1toxIw-0000000H9J9-3gY0;
	Mon, 03 Mar 2025 04:21:22 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1toxIu-0000000H9IR-1VkT
	for kexec@lists.infradead.org;
	Mon, 03 Mar 2025 04:21:21 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2237a32c03aso202505ad.1
        for <kexec@lists.infradead.org>; Sun, 02 Mar 2025 20:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740975679; x=1741580479; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jSwTz98KJxkNrhvDmMikiQIq7w0EbnaiUYR+WiVAYwg=;
        b=J5Y/DfOo+YGyEeLpfODp0Osaz94ogiqdMc7oUgZ5xGDL54R9/AN2khE4Y8JFfcFjyj
         GGSoV5/WhiJsblyTRIkRXlOliCEjaS8pHG/BeHVf9Cjjvu5ROigkIMpUFEFNAg6GkWW2
         hdP1/ZzIsluT6e2YFmml7Fd2xI1e2wb+ROBwL2qe14yYvhw3QxhzoWbntwtaDof7I5Ti
         L9PbUIhqL0miTkYXS7l5KQc7CLHNqIN85fJXrOgXRTrIe1rdpXKFI5EIeQ2UEooXlHGA
         SiQHNT6zhPgG3VgPWf74FiLlmpxXKLHjwnoTEeLdjva/AbRu32D74kejOzUhfnTEW9Ql
         7Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740975679; x=1741580479;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSwTz98KJxkNrhvDmMikiQIq7w0EbnaiUYR+WiVAYwg=;
        b=IuR3v0bydqQW3LMO4TrK10nkmxljk2sRSe8cCtwuTgtrcDR9MFi4sNI4o56YceJ4HQ
         pELm9YWIBG4ostNQrp/s4CQVHjRPuyyEIwhhqX4kOK4WYXyDDAN51UsTC/fWypxiOeVq
         Kdnafy6uW6JVt3Kge9ZZzg3Kedu7WGlei/nvB+20+IEgLHG2cFM1bkl/oBv7u17g4R5m
         MNRaLjjVKAeJPOku4AjnOXUB6HMgykIZnNfY+IZOerCPfYsceBdwWWMRFZ0WWiM7x4Ab
         4+zgkqhtTQ1mIjfqHWiaz3Co9S9OvClmL8x43e5TilLmVn7zvn5u5rg4sfOChTiI89ur
         s5xA==
X-Forwarded-Encrypted: i=1; AJvYcCUddbx8ZcfM/1HrvoWx4OcRm5qnidAXP8YbDOP8slbW0Bf4YDaM2yTSm+N/A62/0B9ey8ndkw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxv6Zl3ZKqNsWljsZ7Umx7lgjdRy8+aPQ8OvqtsilDgkKlkaZBT
	VoITg8AbZpdTZONCVlUBKiNtYImH4xSCfNRELVc3uJtjkdFy7KMI2UZbZMLcrA==
X-Gm-Gg: ASbGncsQr8FoPOad8jXSRW3aaNbNauRRfa88R/OPqHtZczxU7B/tnNZlaoO6beUtGF/
	kmVu4DpjgnsFjl9zGxzeOGNMqUj9RMlRhUOXbO0wG0yzSo6ifEANrbBmnodnyoaV4KyKqgCUL8+
	71SrKOgpC9ujpUvB1EbNMOqhMAgJhKSr2JHgFNC2UHnQay8i/KL3aZMZfbs6nLicMWCVelx/1Z1
	AfjjId0uw/xo5Vpgj6t5Q+wWKEMbQdvOZ8/pheaYadf5Cg1hz2goW//rhStGs029y7NrOfyIM1Y
	X00YVYHiR5OnKug6AIB90PFq/e/zE5sY6Ry9peBp8KLbGl8EEJ4/VuTBOVGKLdlNoaetH1LRLcb
	bT6l9y3HnTkTeUyKDuuHaiIYEqIu0E9YlgXot/yw=
X-Google-Smtp-Source: AGHT+IHTmDLjkL4kLc2K4ZyNgMK9wi9iHW9R9e1KRi5T48mrWugtz12tqUtkXco7ZpSBGpURw5rxJg==
X-Received: by 2002:a17:902:f68c:b0:215:aca2:dc04 with SMTP id d9443c01a7336-2238367038fmr3140475ad.26.1740975678929;
        Sun, 02 Mar 2025 20:21:18 -0800 (PST)
Received: from [2a00:79e0:2eb0:8:ab03:d519:56de:e7bb] ([2a00:79e0:2eb0:8:ab03:d519:56de:e7bb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736550edf72sm931936b3a.167.2025.03.02.20.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 20:21:18 -0800 (PST)
Date: Sun, 2 Mar 2025 20:21:17 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Alexander Graf <graf@amazon.com>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    Frank van der Linden <fvdl@google.com>, James Gowans <jgowans@amazon.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Junaid Shahid <junaids@google.com>, 
    Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
    Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
    Vipin Sharma <vipinsh@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    "Woodhouse, David" <dwmw@amazon.co.uk>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Hypervisor Live Update] Notes from February 24, 2025
Message-ID: <7154b857-01cf-a8c6-ea02-51d095bafabf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250302_202120_421798_94EFBB43 
X-CRM114-Status: GOOD (  32.07  )
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
on Monday, February 24.  Thanks for everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
We discussed the KHO v5 patch series that would be posted shortly.  Two
major changes were noted: decoupling of KHO activation from kexec load
(no KHO finalize stage triggered from userspace or kexec reboot), and
more dynamic internal representation of the tree that gets serialized
into the FDT at the end of the process.  The memory preservation
mechanism did not change.

Specifically, we were discussing the elements that were proposed for
sysfs: the activation interface, FDT blob, dt max, and scratch area
definitions.

Jason noted a general concern on all of the UAPIs that are being
developed and suggested scaling them back.  Mike noted also noted a
concern with the activation trigger: we may want it to represent the
state in the KHO state machine.  He also agreed with Jason that dt max
may want to be removed altogether.  The suggestion would be to hard code
for prototyping, Mike said this should not be in sysfs.

Mike noted that recent changes in KHO would do vmap and vmalloc in kexec
reboot.  Mike said that we need to have a point where state becomes
immutable and Jason suggested a simple read from sysfs, i.e. when you
read byte zero of the sysfs file the kernel would go and do the callback.
This could at least be used early in development.

----->o-----
Jason suggested that we agree on the FSM first because of
unpredictability with future changes, especially for UAPI.  I suggested
that we align this across stakeholders as soon as possible, especially
before going into v6 or v7 of KHO.  In this case, I was referring to both
state machines for the live update process as well as for activation.

Jason pushed to understand what the scope of the v5 that will be sent out
will be.  Is the objective to get some things merged as a foot in the
door, or is it something that is complete and does everything we intend
to do?  Mike suggested getting started with something that was minimal to
address concerns from devicetree and kexec communities.

Jason strongly suggested minimizing the UAPI in this case and relying on
the dt blob for now.  I suggested perhaps we should use debugfs for now
instead of relying on sysfs where we have more flexibility for changes.
Jason noted this may not be sysfs in the end anyway, we might have
different interfaces later.

Mike noted that Alex may have a strong opinion about this, but would
suspect that this is ok for debugfs.

----->o-----
Mike discussed playing around with hugetlb, Jason suggested causing the
fd's to round trip through the kexec.  If hugetlb is thrown into fdbox,
then this informs the kernel that this memory should be preserved.  This
would be similar for memfd.  Jason suggested against something like
guestmemfs and pointed in the direction of fdbox instead.

David Matlack asked what would be the point of the fdbox for things
already in a filesystem.  Jason noted this was for the concept of
creating the inode in the first place (could be an anonymous file
description), then we give it a label, and expect it to be there on the
other side of the kexec.  Instead of hugetlbfs, this might be a memfd
that supports 1GB hugepages; additionally, guest_memfd development has
been trying to untangle 1GB hugepages from guest_memfd in general.

We discussed what metadata should be preserved, independent of whether it
is regular memfd or guest_memfd.  The other side of the kexec would do
memfd_create() to restore the filesystem on the new kernel.

Pratyush took the AI to look at implementation on memfd.  Mike took the
AI to look at memory reservation.

----->o-----
I pivoted the discussion toward fdbox which ended up never being posted
upstream.  Pratyush provided the link to the most recent code:
https://github.com/agraf/linux-2.6/blob/kvm-kho-gmem-test/drivers/misc/fdbox.c
This work likely would need to be picked up to pursue upstream because
the current code has several TODO's.  (A struct miscdevice was called out
as curious.)

It was noted that it would be difficult to support memfd without
something like fdbox, so whether the fdbox code itself were upstreamed or
it becomes more generic from the work on memfd, the base support would
need to be provided somehow.

Mike and Jason suggested designing fdbox and then starting to use it for
memfd.  This would need to be aligned by stakeholders, including the UAPI
for fdbox.  Pratyush will be looking into fdbox or inventing something
similar while working on memfd.

We need to propose the fdbox design and UAPI.

----->o-----
David Matlack suggested a future topic: testing of the live update
process, including kexec and KHO.  It will be challenging to do full
integration testing with this, so low level selftests would be strongly
preferred as this becomes more mature.

----->o-----
Next meeting is scheduled for Monday, March 10 at 8am PDT (UTC-7).  Note
the time change due to Daylight Savings Time, this is now UTC-7 instead
of UTC-8.  I'll send a reminder on this mailing list.

Topics I think we should cover in the next meeting:

 - any objections to using debugfs as the initial interface for
   development and prototyping
 - update from Pratyush on implementation on memfd
 - update from Mike on implementation on memory reservation
 - design for fdbox and its use as a conceptual replacement for
   guestmemfs, gaining alignment within the group, and agreeing on its
   UAPI
 - decoupling 1GB pages for hugetlb, guest_memfd, and memfds and how fds
   can be added to an fdbox
 - establishing an FSM for all of the various states that are agreed upon
   with common language (when memory mappings can happen, what is
   disallowed at certain stages)
 - extending the above topic on a separate FSM for the entire live update
   process (what happens in brownout, blackout, shutdown, etc)
 - iommufd patch series (as well as qemu) from James
 - establishing an API for callbacks into drivers to serialize state
   during brownout
 - topics proposed by Pasha: reducing blackout window, relaxed
   serialization, and KHO activation requirements
 - implications of preserving vIOMMU state
 - testing methodology for these components, including selftests

Please let me know if you'd like to propose additional topics for
discussion, thank you!

