Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0D0CAC582
	for <kexec@archiver.kernel.org>; Sun,  7 Sep 2025 01:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mb+Xc/Fhoa55OVesG0tBvrpUm1r+fHKYqn+NVCDgkGI=; b=DG+4lQle7qYAYjcSpPcqb9NNmr
	RSC2dWW3eof+oHs0aKhvsf9iSuV2PVPXLUS4jftlWdgKoMhbWV2/rbTCAb2GwZfSlvEgm1XqWfts8
	hsFa4CAjdCF7i+r+Q1w8XHunObOPzisQKpGknsBM4S7feRQHKwP9H10CNb/jVxagyf4VhZAM5bjaV
	2HyjEHZdvivOzrwukxwME+Q9Y77PWqK0UqjkJgjr1NPiSDcPhvHM4f+X3HZPTJJlWdA8lpkHwsKa9
	rM+/8x0mdYa6848FbQpxKHxXb5c3xr0EaRGQp6R9CmHUItkQWuGn10BAmwCj/W/BuoCkTDReVGPDO
	D7k8MxTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uv3tN-00000008jux-3r2T;
	Sun, 07 Sep 2025 01:08:29 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uv3tH-00000008juR-2v2l
	for kexec@lists.infradead.org;
	Sun, 07 Sep 2025 01:08:25 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-24cca557085so142395ad.1
        for <kexec@lists.infradead.org>; Sat, 06 Sep 2025 18:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757207302; x=1757812102; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mb+Xc/Fhoa55OVesG0tBvrpUm1r+fHKYqn+NVCDgkGI=;
        b=boSwt4M/ACS+Fu70la/LwnX9Rm3m5vKzRbebYWcign8M1MJ1Zyq0aV47OQJYO0qQbm
         Zho83wAGt7HiqsKZYxf5w+QOaEEk0Ggu09upayYmjqhZ0qWAU9cdEDz3SBfXw7motUAm
         MaRKW2vLgcXyqgGIeOUt6RjrYrIsdaOI3nxb78EaAfUvWNzCWK5LjlS4VV33oLqmX2Bn
         4hSrTH5QDuUKoidpSkIlkjAJWLZb17miKxxufQ8rJMXbv4sFQEFQes2CnsuTmblNGFYt
         jJcH50I2Y8BEGRScdoNOvDKoW3Ojsn9Jv/8JnPwD+C0al3lsOGyi8W/+HlGUFbVo0IHm
         m50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757207302; x=1757812102;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mb+Xc/Fhoa55OVesG0tBvrpUm1r+fHKYqn+NVCDgkGI=;
        b=MuML8gXCYcqlHh/sVHOgSYA8mzVd7wxOSU/AFC8hxYMV2kgZUymzefZLEl6FzZbTh5
         Yg7cDx8w3etzz6ceEsBgwr5sq9RG/WofPnRaM6peCZoWD5WqjJTdwIwJ3GBA727FTj9w
         LJP1fg4w7DDL0JcLnmVzmGmqgrRKauI7559GEeO25yt7G6oxp2IwkDtevKsIeib0EQkm
         4ezuslkA8sr4gGEq5DjDObEE+aEz8fEY06NmPnnNXoBKYUZbkTudFU2WTk7c1L6YNVl0
         lViWvQjeeshCqe93Q9BWOGXFjLKvxllcPNIkom/BcvDvKI83DZ4cWR+xzjnepu2owa7i
         GKnA==
X-Forwarded-Encrypted: i=1; AJvYcCXWgd8I3u+wBN6UE/RPCDIC8c9Lu5md9K4AELmrsodaIg1ixHTTyZreZIPyx8q5kE7pVkKJtQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YySQQZE1OJMBTLwenTAOkOlWo0L4tUzD3EqTfgAtFcgs7heZNt7
	OFt2HPLZDjT5zkGjgikEw4kq1aPk1dGumurv0AHXHGJf0SJ/gbgwaN2Ukfot6+tTiA==
X-Gm-Gg: ASbGncs4BK7rywV9JpydfurOss2h2SGvKOPKz1zR5BFKeQyKMIp6nCxzoa4UAii4lV6
	C35yO0tmtEcxy/q+8ChTCYhrpw2eqi97tmzUOM2eqF1uPOtSbQMajXv+0OxtqiN4cfb8vF+DiAu
	DzUBEe1rP2XdbiE9NAfG+dNoxmtvC9jTxuBNao2m3QGL/ifMDCjmJ54gbAOqpojDkGlYEAUXbkI
	YPqsOuDHE5fvUxdOofFATd11E1CPlJvVN7qajfhmPGr3zP+uE0nTnOPLJlbzqiyyRsGXmQxXtqr
	KXuGjgu271qg1IvLiGTnVn1Pr3FlAzujB/VnvXO0cfIPuDMjVvDgBFIyIS5n6BmPctl/rDIUTlF
	6Lvh3H8oFg7Lr1QDys/r0uuPQ6/myuhIoVNUSlaQruXbndv/aPJs3vpjVZmz1nrwIwj8fRT831J
	EweKQd97mn3UD4AG0DUUQZjkUX8Xx+rNeGTtEKZLb4ocuMsFPFAkt/Rr8tUM1v00F33g==
X-Google-Smtp-Source: AGHT+IFsuipR/DgiNICg4e4PuE3wa4KSpjdqnBxa/j9NLckSMg1RLjJgvs6aq56radYTICZ0438NfQ==
X-Received: by 2002:a17:903:1ce:b0:248:bac6:4fd8 with SMTP id d9443c01a7336-251753d8c2dmr2133515ad.15.1757207301592;
        Sat, 06 Sep 2025 18:08:21 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:3c1b:d276:de82:d12c] ([2a00:79e0:2eb0:8:3c1b:d276:de82:d12c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1589e505sm135481755ad.123.2025.09.06.18.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 18:08:20 -0700 (PDT)
Date: Sat, 6 Sep 2025 18:08:19 -0700 (PDT)
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
Subject: [Hypervisor Live Update] Notes from August 25, 2025
Message-ID: <eb24a22b-8fc0-efe1-9633-bdc7734eb13c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250906_180823_757264_CC6EB072 
X-CRM114-Status: GOOD (  27.61  )
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
on Monday, August 25.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
We discussed the feasibility of sharing the videos from this series of 
meetings as unlisted videos on YouTube.  All of the previous videos and 
summaries are available on our shared drive, which requires being added 
with your corporate or personal email.  After discussion, there did not 
seem to be interest either way in this so we decided to proceed with the 
shared drive as normal.

----->o-----
We got an update on the latest of LUO, Pasha was working on v4 that akpm 
requested based on upstream feedback and for rebase.  There were no 
additional updates for luod, but feedback continues to be received on the 
externally available design doc.

For KHO, there was discussion on making this entirely stateless and the 
format to be used as a result of that.  Idea was to use page tables and a 
bitmap at the bottom to specify the preserved pages.  Pratyush noted that 
he sent a similar proposal as this earlier so some ideas may be grabbed 
from there.  Jason Miu is working on this and noted that the proposal is 
similar to what Pratyush sent before, he said a draft implementation would 
be sent out by the end of next week.

Jason Gunthorpe asked about the staged approach to avoid retaining the 
page table information.  He was concerned about the circular notion of 
preserving page tables and then their page tables.  Pasha said that we'd 
preserve ~4MB or higher order for the buffers where the page tables would 
be allocated (shallow page tables); to preserve a 4MB page, we use pages 
from itself to create the high-order page table.  Jason Gunthorpe was 
concerned about being able to allocate such high-order pages.

----->o-----
Pratyush noted that there was some feedback on the memfd preservation 
patches and he planned on sending out a new series shortly.  Pasha said 
there was the 1GB limitation with the current series and he implemented an 
extension for that so he was planning to send that support to Pratyush 
offline.

----->o-----
We discussed luod and its implementation language, which turned out to be 
interesting.  Feedback from Mike Rapoport and Pratyush were to implement 
it in C.  There was general concern about some developers not knowing Rust 
well enough to implement in that language.  If implementation was going to 
start in the next couple weeks, we would want to settle on the 
implementation language.  As a result of the discussion, it was decided 
that the initial implementation would occur in C.

----->o-----
We shifted to discussing PCI preservation.  Chris Li noted that v2 would 
be scoped to only preserving the bus master bit and not doing any DMAs.  
He was looking to send out the next series of patches end of this week.  
Praveen Kumar asked if the hand over was part of this code, Chris 
clarified that it is not.  Jason asked how this would be tested, Chris 
said that he was going to be checking with a printk on the other side of 
the kexec.  Chris said his next step was likely to extend for a networking 
card that would allow the packet to keep being sent.

Jason suggested the next step might be to make VFIO work with noiommu and 
idx testing.  He suggested doing the IOMMU side last.

Vipin Sharma subsequently noted that he followed up internally and wanted 
to discuss interrupts being disabled and then blindly inserted into the 
guest after host kexec.  He said the PCI specification allows for masking 
the interrupt and there's a pending bit array that can optimize for what 
interrupts we are installing in the guest.  Jason suggested this might be 
done as a follow up but will be more complicated.

----->o-----
We moved on to a discussion from Chris Li about what he referred to as 
KSerial and this solicited a lot of feedback.  KSerial was a serialization 
protocol between two kernels, specifically structs between the old and new 
kernel.  He proposed depositing members of the struct into a wire format 
so that it's not tied to the kernel implementation that the new kernel 
would read from.

Jason provided some feedback that we will never want to serialize IOMMU 
groups, they should be discovered independently.  Same situation for a PCI 
structure pointing to a bus, which Jason also said we should not be 
serializing.  Pasha said the focus should be on the generic format for 
preserving anything, not specific to just PCI without using FDT (which 
should be read only).  Jason expressed a concern about very complex 
support that is not yet proven to be needed; Jason strongly suggested 
against preserving native C structs.

Pratyush asked about FDT and suggested there was a lot of boiler plate 
that you have to write to even get simple things validated.  Chris said 
this would indeed by additional developer burden.

----->o-----
Next meeting will be on Monday, September 8 at 8am PDT (UTC-7), everybody
is welcome: https://meet.google.com/rjn-dmzu-hgq

Topics for the next meeting:

 - update on latest status of LUO after v4 and next steps for merge into
   akpm's tree
 - any updates on luod based on internal and external feedbcck
 - update on making KHO stateless and preserving page tables, dependencies
   on high-order page allocations, any next steps
 - update on memfd preservation and status of 1GB limitation before
   integration into akpm's tree
 - update on the latest status of PCI preservation, registration, and
   initialization
 - any updates on VFIO with noiommu as a next step for preservation after
   Chris's v2
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

