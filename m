Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88142C47258
	for <kexec@archiver.kernel.org>; Wed, 31 Jan 2024 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P9v3mOklBaaBFLTLaiERPTWS+jtqKfLImuyaNe2dLoc=; b=aaJ7OePcUO0KPr
	Ia/n79LaWXugnzfeCo8DE+HkybvMtPS3e4qy5qNq/dQt/FP9H2Sj9+Gyr/8DQrB2EQVjGWKhQei/d
	CbwBiPihEB82iiDkirqfdxGqo9PRAiSHaUdE3cQmSG9b28nSawqvv2CNZpDaHQYOP4niW1K4h5mkM
	j1m8d4ctvblwZKqxzEKWB5UgqkUD1sADECsC3z19qB4vNv1+dIQcgP4U8/dx0d189VWA/0hj13a9X
	BmM3iulPvMPHhOX1QgclQzyqKw6pEij3O74zpbjX6rPaUpmv1JZ0SFQ0o+mNffjXulJmgZpywqLyb
	Ly0iw2gLJt4pZR9z3p4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVCRX-00000004Bv4-40IP;
	Wed, 31 Jan 2024 15:24:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVCRV-00000004Btg-1OAM
	for kexec@lists.infradead.org;
	Wed, 31 Jan 2024 15:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706714640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShXEhsnOf4Qa8k8iTBTenpYOXlavsQuWnbVyMIJ1hzA=;
	b=f9i1p7WG+VYZcMv7GLJqB+KMVKHgmp4b119IgCiaL1su2l5Jdl2pyPyduGxnQhN1rgh1hz
	+toUgL6LXAoJaP73pU7YPp8peKm2JUSGY9+CWY2jJiKfl6jBr2i06wrc5eXFatKndPUf5c
	8c5YYAUfLr30OwzD1na8F54xcvacjXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-DXhB-mCfPv-1sXMqsS7BtQ-1; Wed, 31 Jan 2024 10:23:55 -0500
X-MC-Unique: DXhB-mCfPv-1sXMqsS7BtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4853F185A784;
	Wed, 31 Jan 2024 15:23:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 32C088B;
	Wed, 31 Jan 2024 15:23:53 +0000 (UTC)
Date: Wed, 31 Jan 2024 23:23:50 +0800
From: Baoquan He <bhe@redhat.com>
To: "Huang, Kai" <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Message-ID: <ZbpmBulaR7eft/CE@MiWiFi-R3L-srv>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
 <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
 <ZbpBbAkPxQZ6gHoE@MiWiFi-R3L-srv>
 <5d91fc11-0b3b-40f0-872d-abdbb4038f76@suse.com>
 <BL1PR11MB5978633DF36A69F8020818E1F77C2@BL1PR11MB5978.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5978633DF36A69F8020818E1F77C2@BL1PR11MB5978.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_072401_462641_B893AF53 
X-CRM114-Status: GOOD (  14.88  )
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

On 01/31/24 at 01:07pm, Huang, Kai wrote:
> > > Runtime disabling kexec looks better than at cmpile time, esp for
> > > distros. While from above patch, making using of kexec_load_disabled
> > > to achive the runtime disabling may not be so good. Because we have a
> > > front door to enable it through:
> > >
> > > /proc/sys/kernel/kexec_load_disabled
> > 
> > AFAIU it can't be enabled via this sysctl because the handler for it expects
> > only 1 to be written to it:
> > 
> >       2                 .proc_handler   = proc_dointvec_minmax,
> > 
> >       1                 .extra1         = SYSCTL_ONE,
> > 
> >    994                  .extra2         = SYSCTL_ONE,
> > 
> 
> This is also my understanding.  
> 
> The documentation also says once it is turned to disable we cannot turn back again:
> 
> kexec_load_disable
> ===================
> 
> A toggle indicating if the syscalls ``kexec_load`` and
> ``kexec_file_load`` have been disabled.
> This value defaults to 0 (false: ``kexec_*load`` enabled), but can be
> set to 1 (true: ``kexec_*load`` disabled).
> Once true, kexec can no longer be used, and the toggle cannot be set
> back to false.

you are quite right, I have never noticed this, thanks.

Then then mentioned patch looks good to me.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
