Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398C8EB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vFHsWK2xtmUKOjP2E1VwrNWWtECPKIqae98ZpGiW4aY=; b=pxpS+HipIHleed
	pJcawyBnpsOLXIlle7X7Rsk/Ha14Kqux04XRA+S61eKcWB0skLXLge3z6gwEOB8OeH2GE9wguQkGG
	nWWlfqTuUyIEXIqdQ10Y0WbiWiIKFqikpcdILW6Xrxe9LVsd40G4JdYwhnKEX1izzbs5iNFbOv/Xl
	fHyIQ95icCaG85txFn3+VolMPfUHDG1O5z7TPJgHiyU1s3oKWyTGaSNn1ZrgYmMI4+60uUqPNHnKl
	1tHTUiaHe4br1AJejhpH8Xb6XQHmJh0U+4g/ZqqfTy+Q+DyfLXyqbiV4/6gHfghRplgLG7Mw4o03D
	6nxkZuhkN8fRqcWDK9Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHh1q-0041mZ-1C;
	Fri, 07 Jul 2023 08:41:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHh1n-0041lo-2a
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 08:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688719282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBR9f0r6qj9T/laRL93krURZPm3hZ8Dm5t8S9yrOV30=;
	b=F5hTGzHyObxTPFMzjWMGdIicSbG2zeLiZufCjbOe8i+SIk3iSlEvZ961wCnhEXyOU3nFe6
	082oJcI4rGjMFxvbjc+sdSAgVixCZfFwZmNKTwaq1CSEnioNQSxZfpaOoX0dJDze6RNVgm
	+XWNZMoF0J0JEfxGjCR8MfwkK1TAIb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-mseXw9BVPAa9SLtaA0G1vQ-1; Fri, 07 Jul 2023 04:41:17 -0400
X-MC-Unique: mseXw9BVPAa9SLtaA0G1vQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2C5680027F;
	Fri,  7 Jul 2023 08:41:16 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4DE1200B402;
	Fri,  7 Jul 2023 08:41:15 +0000 (UTC)
Date: Fri, 7 Jul 2023 16:41:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Joerg Roedel <jroedel@suse.de>
Cc: Tao Liu <ltao@redhat.com>, thomas.lendacky@amd.com,
	Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, michael.roth@amd.com
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZKfPqK+lqK6zly2w@MiWiFi-R3L-srv>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
 <ZKfLYG_4DANc_i5r@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZKfLYG_4DANc_i5r@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_014123_913830_4B0CF1F6 
X-CRM114-Status: GOOD (  15.38  )
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

On 07/07/23 at 10:22am, Joerg Roedel wrote:
> On Fri, Jul 07, 2023 at 12:23:59PM +0800, Baoquan He wrote:
> > I am wondering why we don't detect the cpu type and return early inside
> > sev_enable() if it's Intel cpu.
> > 
> > We can't rely on CONFIG_AMD_MEM_ENCRYPT to decide if the code need be
> > executed or not because we usually enable them all in distros.
> 
> Looking at the code in head_64.S, by the time sev_enable() runs the SEV
> bit should already be set in sev_status. Maybe use that to detect
> whether SEV is enabled and bail out early?

Makes sense to me. Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
