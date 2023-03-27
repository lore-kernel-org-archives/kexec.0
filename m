Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62B7C7619A
	for <kexec@archiver.kernel.org>; Mon, 27 Mar 2023 01:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HwYWr9FBjudw+i0dYBlkkHAMbSyMkVBqc2sd0P4kfyk=; b=n0itXFB18KY/wj
	xGqcV0CCSILzWIUS4okcgQiMco8TAWvTj7vaXSrE2+qgJhUdN9RVoic4hX09xH4rWddMRW1XdHTJL
	Ff0pQRbuq9Rh6GwYm8X/OuLvsollAvylr473dnSGfTA+RNSVLakAcf5jveiMFHmdpLmw0BmVFfwgb
	aT1cV986VGmD/oSd5lg2bRHWUslXzhTCooeYYiQG4x4eiyZSDYbl0UUcFUzQZi5KiI9ouuvVxcmqA
	KAmfsDgH8SxORNR3nfoWd4KoXsERyqqIulUX2QIeyHkRYvuh943FRfLcl6fWY1V9GHH+t6ggR7Gov
	RzHthcM1iBtUut4TW9NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgbmP-009Td2-0y;
	Mon, 27 Mar 2023 01:36:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgbmM-009TcX-1p
	for kexec@lists.infradead.org;
	Mon, 27 Mar 2023 01:36:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679880965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IktNct0hYpmTWd/fwL1kpmhcQhHYgYPZqfJwKXiT4HI=;
	b=YcShOyo73GhqJR0G7rn5i8pvTlxyU7/6PKZltqoYSewCrcrSfmfgU7vzK+EwAvZGQaVYD5
	rP7tSlWMLFVKf77GWXF6UXLxj3YCrcXRAW3q0nZ5EsDxq+gYZNHjXXimc688lt7fbZddXu
	57eEW+6fUeRC2x0mqhDWRvK5qTzNqRI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-ynQ_l6U9NCWBMxerBON6IA-1; Sun, 26 Mar 2023 21:36:01 -0400
X-MC-Unique: ynQ_l6U9NCWBMxerBON6IA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37A291C05149;
	Mon, 27 Mar 2023 01:36:00 +0000 (UTC)
Received: from localhost (ovpn-12-88.pek2.redhat.com [10.72.12.88])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E5F62166B26;
	Mon, 27 Mar 2023 01:35:58 +0000 (UTC)
Date: Mon, 27 Mar 2023 09:35:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Message-ID: <ZCDy+nsjPsi/Lllh@MiWiFi-R3L-srv>
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
 <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
 <20230325192524.wetlbycbcsxc4plk@box>
 <b16bcda0-f190-7849-cbbb-412d328c8806@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b16bcda0-f190-7849-cbbb-412d328c8806@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_183610_702915_702DFED3 
X-CRM114-Status: GOOD (  30.93  )
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

On 03/26/23 at 10:01am, Dave Hansen wrote:
> On 3/25/23 12:25, Kirill A. Shutemov wrote:
> > On Sat, Mar 25, 2023 at 09:25:36AM -0700, Dave Hansen wrote:
> >> On 3/25/23 09:01, Kirill A. Shutemov wrote:
> >>> The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
> >>> secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
> >>> it has woken up.
> >> ...
> >>> +int arch_kexec_load(void)
> >>> +{
> >>> +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> >>> +		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
> >>> +		return -EOPNOTSUPP;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>
> >> So, let's put all this together:
> >>
> >> 1. TDX implementations use MADT for wakeup exclusively right now (but
> >>    are not necessarily _required_ to do so forever)
> >> 2. MADT doesn't support CPU offlining
> >> 3. kexec() requires offlining
> >>
> >> Thus, current TDX implementations can't support TDX guests.  This
> >> *doesn't* say that TDX will always use the MADT for wakeups.
> >>
> >> Yet, the check you have here is for TDX and *not* for the MADT.
> > 
> > As I described in the commit message there are more than MADT that is
> > required to get kexec in TDX guest.
> 
> I kinda think we should do both.
> 
> Let's make sure that all systems that depend on MADT wakeups can't
> kexec() until the ACPI folks work out what to do there.
> 
> Separately, let's either fix or *mark* the kexec()-incompatible pieces
> that *ARE* specific to TDX.
> 
> >> That seems wrong.
> >>
> >> Let's say SEV or arm64 comes along and uses the MADT for their guests.
> >> They'll add another arch_kexec_load(), with a check for *their* feature.
> >>
> >> This all seems like you should be disabling kexec() the moment the MADT
> >> CPU wakeup is used instead of making it based on TDX.
> > 
> > I guess we can go this path if you are fine with taking CR4.MCE and shared
> > memory reverting patches (they require some rework, but I can get them
> > into shape quickly). After that we can forbid kexec on machines with MADT
> > if nr_cpus > 1.
> 
> This goes back to what I asked before: is anyone actually going to *use*
> a single-processor system that wants to kexec()?  If not, let's not
> waste the time to introduce code that is just going to bitrot.  Just
> mark it broken and move on with life.

Now we have two API for kexec: kexec_load and kexec_file_load. They can
be used to do kexec reboot, or crash dumping. For crash dumping, we
usually only use one cpu to do the vmcore dumping. At least on our
Fedora/centos-stream/RHEL, we do like this with kernel parameter
'nr_cpus=1' added by default. Unless people explicitly remove the
'nr_cpus=1' restriction or set nr_cpus= to other number to persue
multithread dumping in kdump kernel.

So I think Kirill's idea looks good. Means on TDX guest kexec reboot
will be forbid, while crash dumping will function normally.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
