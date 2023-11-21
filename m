Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCF0C54FB9
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ba7sW9V/CpEKSj7bbrPia0IIdqG/Hsk332oAHo7iLwM=; b=VjjQ7JBxAaVOv0
	Iv9gL0DCF4xiR0RWgn7R468AoMEEYvioihgdLa6ykdtlMzk+GuqeFVNx6jZ8y1jFri1I5zfJLuRcZ
	s/Rtk0GKEZYl/9R2Qf1bWN+Wvr038Q0DVYVW/pZuFId1mIIMvvXG/dk2tj8zyvBW5WhipVT5+Al0Z
	4G0tbJgDLcljxv8WERcjuc60xsSCrG8iGymwLPQ3jb/+g91fJSrgtv0gUpOWdBirt3pwCONUNW5pt
	mQRQ6tvJmZRPfOqPfjehxTgYkg9HtuAdN86PSNpiC/wXdkMNW88Ub2NQDmvF5qA6W/oAqcDs3DhVc
	6vx9NUWE+RwTZTpn2Mig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5MM0-00G2E7-0q;
	Tue, 21 Nov 2023 08:43:32 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5MLx-00G2DW-1I
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 08:43:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700556209; x=1732092209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZvXdjvxl4OFx/rOJ2HyXP09UhjsWaOEHhJzpQc00a48=;
  b=UARFsCrhdYAPYobrf/vdJAMkYTykIoklMxBiWUmGFYtul/HQLb7Sflww
   9JpfG1iD0B9Yeqv3cP6AO80B98KBeH2P7wHnZ7QwRkPvu50Scpwq3aRPe
   qrlDZlaZFVCe3Bo7n6NoGCtUG6vyJsWVSmeewK+1CnXlsOMpDKvpYSyZX
   1M+qlJxQv2KCTnI08J5BVJ8FYR2CO/k9Nufx/jCi3d1j5lDhy5ojbaG2I
   KqEKefi3DMVptn4MN8t7n/znpo5mFvkkQCEk198qchR5Td5Ve+Kus1fHh
   oryrh1TS9X41+6sGWMhRSD8h/qvV1WG9ATTct4RlGb/UPpGX0bLXYPk4/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4919955"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4919955"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:43:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097998545"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1097998545"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:43:24 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 7AD2510A36E; Tue, 21 Nov 2023 11:43:21 +0300 (+03)
Date: Tue, 21 Nov 2023 11:43:21 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
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
Message-ID: <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
 <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box>
 <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_004329_450338_DEDC982D 
X-CRM114-Status: GOOD (  19.77  )
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

On Tue, Nov 21, 2023 at 02:41:08PM +0800, Baoquan He wrote:
> > > 
> > > Still failed. And I found the normal reboot does't work either. I will
> > > do more testing tomorrow, e.g use the tdx-tools's own rhel9 kernel
> > > config and rebuild, and update host kernel too.
> 
> I did more tests, resuls are summarized as below: 
> 
> 1) kexec reboot works, but always fallback to 1 cpu even though multiple
> cpus are specified;

That's expected. Until you have new BIOS. See below.

> 2) kdump kernel need more crashkernel memory to boot up,
>    crashkernel=512M works well in our case.

I guess it is due to SWIOTLB memory which requres at least 64M.

>  But it failed in vmcore
>    saving process, either makedumpfile or cp can't access the 1st
>    kernel's old memory;

Will look into it.

> 3) Normal reboot always failed;

It is expected. TD vCPUs are not resettable. So we need to destroy TD and
construct a new one to emulate "reboot".

I guess we can try to add some glue on QEMU side to make reboot more
seamless.

> My colleague Tao helped to double check this, he got the same testing result.
> Plesae 
> 1) what can we do to enable the multiple cpu support for kexec reboot?

You would need a patched BIOS image. I've hacked one[1] for my testing.
But it only works if kernel runs in 4-level paging mode (specify no5lvl in
kernel command line).

BIOS folks work on proper patch, but it is not ready yet.

[1] https://gist.github.com/kiryl/e1dc1719e0c990b3ceee5d8de8dbf332

> 2) anything missing to allow makedumpfile/cp access 1st kernel's memory?

It worked before for us, but I have not checked for a while.

I expected you've dropped my "if (crash) return;" debug patch I asked you
to tested before, right? If not, failure is expected.

> 3) not sure if this is particular case on the system we tested on.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
