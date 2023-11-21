Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589F8C61D88
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qepjdlx+XUzY8WZ5r8KDnfQ/3QXFXN48IwvnMkmZyDc=; b=l+U4Vzj23F6GxQ
	GmNvcGKshGVH9S9AWe76/PArNFzmIfMxoU1Ay73tsmxSAdcd17BAhkXKOk80dCYpY2eSf0g4qwa84
	21lyql/4Km8vtVQYKDBlH47F9vema7LnFhwKSZ4Hsa/gLc6INbZKwV3KB8yzZaqh5kBPuTSXFS9QU
	0XaxHOwuWDXDysHxxqZXkya4K86VsnB80GU9SkGjcSh5cBOZRuEa7ti1nDqehOsNZ9+wDc/EQx4pE
	ep9o3vN8r3o25hOcFyswc5CzIDNh/edfADSIIkvAwX/Q9cdOJHiqhi7qBMdkG1pXVH08JT7cxtOyp
	7854gTyfrKvrPQbXxUtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5OB3-00GIDD-2L;
	Tue, 21 Nov 2023 10:40:21 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5OB1-00GIBz-1D
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 10:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563219; x=1732099219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NaeYZlAyfEszL4Mboch+ASOVeF+qoSwNlJCREj7p544=;
  b=QtBAvQF1N/6b4zhZN5Yy1IH45XKEH7PjCA+poYYUxzy3lFiwELbrOy0v
   Lr1T8YLl6Zewso53fIHP+CnY1ABCUOW0EqUp8PVr0k6Z9+a0MJkinnR3S
   yiXT/0RTznxVRo0z63FOu5g+rMgVNeXkoUo5CZmX8MZh+ScuLuJLY3cGW
   jYgIYaxu3UAYI+3VB3WmJBw6tDQphM60eI8rCYbckZ94L8neS9MqHjIhI
   wae2+RudB2/ayX3r//q9QxTfkIWF4p2A62j6lgdy9sGYnP41z9kzbp6s8
   C6bCIvvGxTjN4yYmDrJvZ4/bAU0nf9FjXe45hQa+CsEGpFUQC8dPl7Jv4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371987303"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371987303"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:40:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14872307"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:40:14 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id DDCE010A36E; Tue, 21 Nov 2023 13:40:11 +0300 (+03)
Date: Tue, 21 Nov 2023 13:40:11 +0300
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
Message-ID: <20231121104011.jfe6fzmxgl7onlfi@box.shutemov.name>
References: <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
 <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box>
 <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
 <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
 <ZVyDMTrbPwe/0yRd@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZVyDMTrbPwe/0yRd@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_024019_427856_167FA379 
X-CRM114-Status: GOOD (  13.57  )
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

On Tue, Nov 21, 2023 at 06:15:13PM +0800, Baoquan He wrote:
> > > 2) anything missing to allow makedumpfile/cp access 1st kernel's memory?
> > 
> > It worked before for us, but I have not checked for a while.
> > 
> > I expected you've dropped my "if (crash) return;" debug patch I asked you
> > to tested before, right? If not, failure is expected.
> 
> Ah, my bad. I didn't actually.
> 
> Just now I rebuilt kernel and retested, vmcore saving works. Just when
> it finished kdump work and tried to reboot, the rebooting failed because
> cpus are not resettable like kexec reboot does. Not sure if this is seen
> in your test.

Yes. It is the same reboot limitation I've mentioned before.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
