Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14937C61D94
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zYDy6LXCKsdJQx0s+sovKVHmAosVKtXBviJLEv1+ayE=; b=ctLtU/662yA010
	UL/dGcSFJUiuDa9y78l8Ovl9TruhCauAreVpSa/IyJn6bl6qXwIqkbmrpQSNWA5zmHk0TpQx7YfQs
	m5tcwhaIjhpkmdZ6ZiB44QtA5s9Il1jIis5B7gsiqK86BViPL2uumPOjhTxpUzb8tkX18IB3gamFj
	0XUBBSabe48+7qYpVe++Q5fK5dHaIGt9k4/QUm4Nzvyz8N0RgvDiITVrYjlMfVukKa18eMyVOwexu
	twu5M4bWPOs9P9ffzP1rIJw94P+lDjt7vgea/Cige8ckmCLnsiDUvPCSl8S402J7olLr1RzqQXboB
	eYb6C1N0Ac858nBo7Krg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5QCw-00GjpL-0l;
	Tue, 21 Nov 2023 12:50:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5QCs-00GjnH-0D
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 12:50:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700571011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ROag+VmLCtyBTs9acg1WAJvLy3sMpjYtnMNYFyigFHQ=;
	b=a6wbvU7h596p0hzvPe+7cONVsSnH0ozOmUxKwQndkvuhXnTibilpx5YBIrglQU53bgMVYb
	DKAKZ8SEr15G119mVAHTbHb+NyLyqhrD4Sru1C2f+XGfJ0U/hR3FZfk1ZbcIWuYnD76fkM
	5YfpFyruqOEaM053/+DT5n7rOFj9pW4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-5cWuSWm2Ox2TstUXPkD42g-1; Tue, 21 Nov 2023 07:50:08 -0500
X-MC-Unique: 5cWuSWm2Ox2TstUXPkD42g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DA19852AC8;
	Tue, 21 Nov 2023 12:50:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 70282492BE0;
	Tue, 21 Nov 2023 12:50:06 +0000 (UTC)
Date: Tue, 21 Nov 2023 20:50:03 +0800
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
Message-ID: <ZVyne10VpRR1Kpkk@MiWiFi-R3L-srv>
References: <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
 <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box>
 <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
 <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
 <ZVyDMTrbPwe/0yRd@MiWiFi-R3L-srv>
 <20231121104011.jfe6fzmxgl7onlfi@box.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121104011.jfe6fzmxgl7onlfi@box.shutemov.name>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_045022_295329_4078729D 
X-CRM114-Status: GOOD (  16.37  )
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

On 11/21/23 at 01:40pm, Kirill A. Shutemov wrote:
> On Tue, Nov 21, 2023 at 06:15:13PM +0800, Baoquan He wrote:
> > > > 2) anything missing to allow makedumpfile/cp access 1st kernel's memory?
> > > 
> > > It worked before for us, but I have not checked for a while.
> > > 
> > > I expected you've dropped my "if (crash) return;" debug patch I asked you
> > > to tested before, right? If not, failure is expected.
> > 
> > Ah, my bad. I didn't actually.
> > 
> > Just now I rebuilt kernel and retested, vmcore saving works. Just when
> > it finished kdump work and tried to reboot, the rebooting failed because
> > cpus are not resettable like kexec reboot does. Not sure if this is seen
> > in your test.
> 
> Yes. It is the same reboot limitation I've mentioned before.

I see, thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
