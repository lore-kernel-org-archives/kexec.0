Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4347CC5ACB3
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 10:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q96NKJBaw+zQhkmbXdaH1+NDXAmxQAEm4J1WsxD8+l0=; b=qK5KzMuCBr4D12
	SHMNFY3h1R3GehIK2n76cqZog2TUrctQL6J1C3AersQsvI5m5oTvsddRYoi9ss3JGQGP+L2M111+7
	iyw2GGBtzdkg6yYE3PK2FlJB2hKc0IepTU5JDsoa8hzUUjg6fBczLndBjWFYFdclOPN7ZCgK2cz+P
	Lyh4ZvutJe/kNQZfYY+pBmzBJNqbF7V8VYmvV3RhjwFFFjtVkBYtsR0pq63Y8mE60Bpb6Xa+sFJpC
	wR/mMlls/2C5T3hOOYFVLRbdAoJlnD4CB9pcyz8IhTyLJmHw+kiZz3yt0R++frYDXJ5MvNEivSRAC
	KNDGdIZZadI68ITWUi4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Nn1-00GEOm-03;
	Tue, 21 Nov 2023 10:15:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Nmy-00GENi-12
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 10:15:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700561726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eaq+2OyV91s1t6M0bC5vk0Dtry8ozGJ14NR0RM+C2uI=;
	b=isfJkb/MWVDZtRnnyI7CHOAfG9CIoPIgQ0D9QmnnC///KXg4SfTQ+zuq4i6AeLx5vhemQP
	BLjEDgs9ZkqqLCRhXW7kSWROY63JoHUakmenCEo/B9vUMRHQB/tAjoHkCTHb7SLpncEQa2
	zVJN0oXmZWPiFNOE3bKBNrVhIHB5ZQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-O-CmAiTLNsq8Y_QdiHiwyg-1; Tue, 21 Nov 2023 05:15:18 -0500
X-MC-Unique: O-CmAiTLNsq8Y_QdiHiwyg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC45884B105;
	Tue, 21 Nov 2023 10:15:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 16281492BFA;
	Tue, 21 Nov 2023 10:15:16 +0000 (UTC)
Date: Tue, 21 Nov 2023 18:15:13 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	ltao@redhat.com, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 00/14] x86/tdx: Add kexec support
Message-ID: <ZVyDMTrbPwe/0yRd@MiWiFi-R3L-srv>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
 <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box>
 <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
 <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_021528_429183_6A616141 
X-CRM114-Status: GOOD (  29.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/21/23 at 11:43am, Kirill A. Shutemov wrote:
> On Tue, Nov 21, 2023 at 02:41:08PM +0800, Baoquan He wrote:
> > > > 
> > > > Still failed. And I found the normal reboot does't work either. I will
> > > > do more testing tomorrow, e.g use the tdx-tools's own rhel9 kernel
> > > > config and rebuild, and update host kernel too.
> > 
> > I did more tests, resuls are summarized as below: 
> > 
> > 1) kexec reboot works, but always fallback to 1 cpu even though multiple
> > cpus are specified;
> 
> That's expected. Until you have new BIOS. See below.
> 
> > 2) kdump kernel need more crashkernel memory to boot up,
> >    crashkernel=512M works well in our case.
> 
> I guess it is due to SWIOTLB memory which requres at least 64M.
> 
> >  But it failed in vmcore
> >    saving process, either makedumpfile or cp can't access the 1st
> >    kernel's old memory;
> 
> Will look into it.
> 
> > 3) Normal reboot always failed;
> 
> It is expected. TD vCPUs are not resettable. So we need to destroy TD and
> construct a new one to emulate "reboot".
> 
> I guess we can try to add some glue on QEMU side to make reboot more
> seamless.
> 
> > My colleague Tao helped to double check this, he got the same testing result.
> > Plesae 
> > 1) what can we do to enable the multiple cpu support for kexec reboot?
> 
> You would need a patched BIOS image. I've hacked one[1] for my testing.
> But it only works if kernel runs in 4-level paging mode (specify no5lvl in
> kernel command line).
> 
> BIOS folks work on proper patch, but it is not ready yet.
> 
> [1] https://gist.github.com/kiryl/e1dc1719e0c990b3ceee5d8de8dbf332

Thanks a lot for explanations. Let's wait for it.

> 
> > 2) anything missing to allow makedumpfile/cp access 1st kernel's memory?
> 
> It worked before for us, but I have not checked for a while.
> 
> I expected you've dropped my "if (crash) return;" debug patch I asked you
> to tested before, right? If not, failure is expected.

Ah, my bad. I didn't actually.

Just now I rebuilt kernel and retested, vmcore saving works. Just when
it finished kdump work and tried to reboot, the rebooting failed because
cpus are not resettable like kexec reboot does. Not sure if this is seen
in your test.
> 
> > 3) not sure if this is particular case on the system we tested on.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
