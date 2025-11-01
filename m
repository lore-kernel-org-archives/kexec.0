Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF5BCCF9F8
	for <kexec@archiver.kernel.org>; Sat,  1 Nov 2025 23:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9/E0WGv1nNLr0QHf8SUrmzyKi+YvfP6z/hFCykkZxzY=; b=HEdyMHypfI5o7DVW4CNMK26hQa
	X28j7yYe/0rQgObvUlvrcVzX930mBwM0TsYYv3/GfQgfB/KN/jNn8riuq9byGv/yo1szREdKqJz6C
	czs6mNVhxhcC5CaWS3o/cAU1XIyFOFRsgzPrK5ETgq29lbuuakg97Mi+rD+MFFE3nJTPj+mKSV1cK
	KGoF5gsTkurCJjhcChW8QOBBjTchb5AYOVuX6QlMZdHF5B78ve6dJ8qUAzlHSWWmp7JVxCVZ39rRx
	uXfPdgs1yl0OLSwLEZJUVIE8q67AhpTi+dUj58MLEhMiMffe+22tLaoWgOFVgfR2aDwHQqECisfmv
	ed0Q2sNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFL7u-000000089xN-3Woz;
	Sat, 01 Nov 2025 23:35:19 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFL7m-000000089wm-3n5C
	for kexec@lists.infradead.org;
	Sat, 01 Nov 2025 23:35:12 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-27eeafd4882so233355ad.0
        for <kexec@lists.infradead.org>; Sat, 01 Nov 2025 16:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762040109; x=1762644909; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9/E0WGv1nNLr0QHf8SUrmzyKi+YvfP6z/hFCykkZxzY=;
        b=Qik5eUuVV9F/U/YCpBtWsd7yz4T0+awTwz2hYJqk7d3ljqW6urYfXlk8mmZfB6Tqaf
         2+ZXAomkgFWV6V3/Wzvqs3Pwsg1MHtuE+WJmt9fYYCPOMVvHGfy6OKUYuo6lpsOZ8zMO
         Jzb6DeNemjlFYnrhpD1WE/llnbvcsH7RT4VXm2I2HRqFgGhDMQuGKld3d1pYEi6w15KE
         KNuYpv1tVhlUCbfwk+e4l338VobqYcpoYQHf4NvfWPjtWf0LsSoCVXBDPtF2Ks+hBYdK
         XH7B/5kCqR7S+83B4E+bg/qui6kCmaZrlqhjN1pPhtYF+uVQnJfyR6pOMAcqYrF+AmLO
         gVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762040109; x=1762644909;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9/E0WGv1nNLr0QHf8SUrmzyKi+YvfP6z/hFCykkZxzY=;
        b=IOIxcQ+BFJurozg67yuCgl4OM1xOqAh/C85zsGlZIrezzhneX9vyOvEarn5Q7rqESU
         CzHwJ2qzyvXV7ZC9Lf1UEF9QdWmIma5pt2bxN/F0MO7cU+4ZrVNPiaWXvIG67ySXUndJ
         By7cvU0PcWppENBKzLOD4dnw96EAD6k0L8aRiKyfvROfNcYWQ8U4RrEcQtxVwrLOx4VO
         HYJ3Pp/zMpHUvYyl+dushhlc/SpVANvUyW8DgftFJScMf8ffxgxQ4K74+i250aRifVhY
         4C9tJJHlrvKhlN5s/Lhc6cr/6OG9rhzEBZlDkfzHcdeNK1PBN9rxN1aAD1PTt0lKmE2M
         D6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuQyXuD/IpU9eK82qcRESU1+QgnFz+OjCPggbGSSu/Gq4zGk/ULjBosNVdR03rblwT2Bz3eQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5zc9Bv1LgSOKuCzWMji41NpIuExqFAhMHXHrECYmthUjbunjb
	5WdWnqT8KOyNOmusFYxVkLv5El8ZOC28O3KhulbyigvvsWCpGkdGpc2VoY3BlCiVRA==
X-Gm-Gg: ASbGnctORaPCGeHiBlONJCsPo2PuhSmiS+xXtY+uNBuOVxXq8hKNbWMzTtDackIrieF
	ldr5iKMYJme48Ng2XvFZgzAxPzh807VKyB7H3yop/446/CJNKMzpjd/YD6VPcs5Kv+5OvBDJTqy
	cG5cmNo298AZP9R81LTcPaEVHY2dUafS50Nw4annfq380dI9cOWlhrrIzlWyiqmSnI6cLol736D
	DrUfiz6W35M/YS7jNPVwj3KQXqX904RqmvqTez/jpn3PVTvFazpZJbtEkRgWJMTnc9t4xVAbSay
	74UM8ZU84BjQeBCCJxulRem81uaJE1I4dwd10EUII8uRe/2kOA0cb36SGQ93Ld2W2ljJqkWtyH2
	+AW8jXQ4OtvyF/QjW6PmWZwLXxho+Jiq35pK8hI8J2ujrNbWfWo92acVb9LLSXs29TH+pXGSAd6
	bvbloU44xjKf95c0IUMoP8ZwCs1OmHbDDP21pXHlcdIR0or8JYO7FFkIdjFClpr6JufviVLurti
	id76DBrl6YPF6yH85S5DoSON+Qh5XDXnEdS4pfLuQ==
X-Google-Smtp-Source: AGHT+IEgMLSpidpLn4EmEnPXsZydRPUhGLJ3IE7xOOEurckkpUMnihEKZNkc9Lqt1xK89NmR2Gl9NQ==
X-Received: by 2002:a17:902:ec8e:b0:274:1a09:9553 with SMTP id d9443c01a7336-29554bb5d5cmr4197895ad.6.1762040108930;
        Sat, 01 Nov 2025 16:35:08 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:61f6:625a:7108:5b62] ([2a00:79e0:2eb0:8:61f6:625a:7108:5b62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982117sm6245553b3a.15.2025.11.01.16.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 16:35:08 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:35:07 -0700 (PDT)
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
Subject: [Hypervisor Live Update] Notes from October 20, 2025
Message-ID: <734e26d2-ac5f-47be-331c-40e9b535ce55@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251101_163510_994361_134025FB 
X-CRM114-Status: GOOD (  34.41  )
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
on Monday, October 20.  Thanks to everybody who was involved!

These notes are intended to bring people up to speed who could not attend 
the call as well as keep the conversation going in between meetings.

----->o-----
I thought this instance of the meeting would be short and I turned out to 
be very wrong :)

We touched on the discussion from the previous instance regarding the fd 
dependency checking and this happening at the time of preserve rather than 
prepare, Pasha noted that the discussion continued upstream afterwards on 
the mailing list.  The biggest change would be that the order is going to 
be enforced by the user.  The preserve function itself is the heavy 
lifting now; the freeze and prepare are more for sanity checking.

David Matlack asked how the global states wuld work since that's outside 
the fd.  Pasha said the subsystem will be there but there will be another 
mechanism that follows the lifecycle of fds of a specific type; example is 
if a session has an fd of a specific type then it will follow the 
lifecycle of the aggregate.  This will be supported in v5. 

----->o-----
Pasha updated that he had sent the KHO patches that provide the groundwork 
for LUO.  Last week he also sent a KHO memory corruption fix.  Once those 
patches are merged, he will send LUO v5.  He was targeting sending the 
next series of changes before the next biweekly sync.

----->o-----
Vipin Sharma sent out RFC patches for VFIO and was looking for feedback 
from the group in the next instance of the meeting.  Jason was providing 
feedback on the upstream mailing list already.

----->o-----
We shifted to discussing the main topic of the day which was iommu 
persistence from Samiullah.  His slides are available on the shared drive.

There was general alignment with what should be included in the next 
series upstream.  His demonstrator so far included iommufd, iommu core, 
and iommu driver patches but was just preserving root tables.  He also 
proposed hot swap.  There was lots of discussion upstream around selection 
of HWPT to be preserved, preserved HWPT and iommu domain lifecycle, fd 
dependencies, and LUO finish.

Pasha noted that LUO finish can now fail which Jason asked about.  Pasha 
said if the fd hasn't replaced the hardware page table then finish would 
have to fail.

Sami noted that the HWPTs are also restored and associated with the 
preserved iommu domains and this would be done when the fd is retrieved.  
We can't restore the domain during the probe but there is no mechanism to 
have the HWPTs to be created during the boot time.  Jason said during 
probe time you put the domains back with placeholders so the iommu core 
has some understanding what the translation is.

----->o-----
During the discussion for hotswap, Sami noted that once all the preserved 
devices have their iommu domains hot swapped, we can destroy the restored 
iommu domains that are not being used.  Jason said that once the iommu 
domains are rehydrated back into an fd that they should have the normal 
lifecycle of a hardware page table in an fd.  So they will be destroyed 
when the hardware page table is destroyed when the fd closes it or the VMM 
asks it to be destroyed.  Jason noted that the VMM needs the id so that it 
can be destroyed.

Jason suggested restoring the hardware page table pointers inside the 
devices that represent the currently attached hardware page table and this 
is done when you bring back the iommufd.  We should likely retain a list 
for each hardware page table the list of which VFIO device objects are 
linked to it and this all needs to be brought back.  Or an alternative may 
be to serialize the devices.  IOMMU needs the VFIO devices and this needs 
careful orchestration.

Pasha suggested that since we have the session and sessions have specific 
orders, the things without any dependencies that were preserved first and 
things with dependencies were preserved last.  The kernel could call 
restore on everything from lowest to highest.  Jason said there needs to 
be a two step process: the struct file needs to be brought back before you 
fill it.  VFIO needs the iommufd to be filled before it can auto bind 
before it can complete its restoration.

Sami suggested if we don't restore the HWPT until we have all the 
information, even if it closes it goes back to the state that it was in 
and we would consider the iommufd not fully restored until it is.  Jason 
suggested that would require adding an iommufd ioctl to restore individual 
sub objects: restoring a HWPT that was with this tag and give back the id; 
the restore would only be possible if the VFIO devices are already present 
inside the iommufd.

----->o-----
When discussing LUO finish, Pasha suggested we need a way to discard a 
session if it hasn't been reclaimed or there are exceptions.  If the VM 
never is restored then we will have lingering session that need to be 
somehow discarded.  Jason suggested all objects are brought back to 
userspace before you can encounter an error.  If there are problems up to 
that point, then the cleanest way to address this is with another kexec.

Jason stressed the need for another kexec as a big hammer to be able to do 
recovery and cleanup.  For example, if there are 10 VMs and one did not 
restore, do another live update to clean up the lingering VM.

----->o-----
Next meeting will be on Monday, November 3 at 8am PST (UTC-8), everybody
is welcome: https://meet.google.com/rjn-dmzu-hgq

NOTE!!!  Daylight Savings Time has ended in the United States, so please
check your local time carefully:

Time zones

PST (UTC-8)             8:00am
MST (UTC-7)             9:00am
CST (UTC-6)             10:00am
EST (UTC-5)             11:00am
Rio de Janeiro (UTC-3)  1:00pm
London (UTC)            4:00pm
Berlin (UTC+1)          5:00pm
Moscow (UTC+3)          7:00pm
Dubai (UTC+4)           8:00pm
Mumbai (UTC+5:30)       9:30pm
Singapore (UTC+8)       12:00am Tuesday
Beijing (UTC+8)         12:00am Tuesday
Tokyo (UTC+9)           1:00am Tuesday
Sydney (UTC+11)         3:00am Tuesday
Auckland (UTC+13)       5:00am Tuesday

Topics for the next meeting:

 - update on the status of stateless KHO RFC patches that should simplify
   LUO support
 - update on LUO v5 and patch series sent upstream after KHO changes and
   fixes are staged
 - VFIO RFC patch feedback based on the series sent to the mailing list a
   couple weeks ago
 - follow up on the status of iommu persistence and any addtional
   discussion from last time
 - update on memfd preservation, vmalloc support, and 1GB limitation 
 - discuss deferred struct page initialization and deferring when KHO is
   enabled
 - discuss guest_memfd preservation use cases for Confidential Computing
   and any current work happening on it, including overlap with memfd
   preservation being worked on by Pratyush
   + discuss any use cases for Confidential Computing where folios may
     need to be split after being marked as preserved during brown out
 - later: testing methodology to allow downstream consumers to qualify
   that live update works from one version to another
 - later: reducing blackout window during live update

Please let me know if you'd like to propose additional topics for
discussion, thank you!

