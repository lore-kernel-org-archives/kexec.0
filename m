Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE74AC43334
	for <kexec@archiver.kernel.org>; Sun, 26 Jun 2022 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1IJ8ZPlIS/pqQ360M+eEOg/FqIWRquXxrdvU0onePr8=; b=2mj/hjd4C9UXqS
	vpQEpAT4t+Cuhw4TcR56Gas5I2dLvB/S1jIVTV9SHYO6zC8O6GGdHiK8d/4OniC2014tVT6r8JNH2
	dvr0SfIr0GYo7U7wuVCTvgCVuNVpnGLsCUpUjSbeW9Pb/0iws/To/y5UD84oXgFkmP0emjW+MSYMo
	vOUhmuz1SxK2y6tXVOLORFmDb8Ejg1b/JBToxZuDYrqP/sPWUlR6M8wk+hPeGqg9ALrG5c/6QDMeJ
	vo81nQ8LyKscVtGZc8KGN8C+xJHd+sz/f8s+hra5PGAunpmkH/GkqN1HhCreJFNluRlY37aoJljpr
	KTdQFb2unTDLeaKtQt1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5Plr-00BGdo-2k; Sun, 26 Jun 2022 10:45:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5Pln-00BGc5-Ti
	for kexec@lists.infradead.org; Sun, 26 Jun 2022 10:45:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656240334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6InSV56Wmf/Ott/MhJFHAADQ4Uv/vbzwSYycypoeAmU=;
	b=KGHUo4VXOvfGNCE09P3s2QdatZ7Knyol/DpP8UIzLBuoT4urV/hWTi2gXbbb5/uihfPR7k
	qBMOGHGq5MqkR/nXzzS08YhU8NcjYD9N3dBKbx5gYjBnX6/iwctHM3VPsWe+2ISG5MAswl
	70+pWTk8+9rrSlAKPdKQaS32CyN8E7c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-slomwFmrMKqalepE5Ds0-Q-1; Sun, 26 Jun 2022 06:45:30 -0400
X-MC-Unique: slomwFmrMKqalepE5Ds0-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04D3D1C01B23;
	Sun, 26 Jun 2022 10:45:30 +0000 (UTC)
Received: from localhost (ovpn-12-101.pek2.redhat.com [10.72.12.101])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 26EF91415108;
	Sun, 26 Jun 2022 10:45:28 +0000 (UTC)
Date: Sun, 26 Jun 2022 18:45:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-rt-users@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Message-ID: <Yrg4xW0oBoVv5D1R@MiWiFi-R3L-srv>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrUTsJiIQb583fKy@MiWiFi-R3L-srv>
 <xhsmhsfnu5giq.mognet@vschneid.remote.csb>
 <Yrg25MZNqt+h1FCB@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yrg25MZNqt+h1FCB@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_034536_091196_88388980 
X-CRM114-Status: GOOD (  19.72  )
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

On 06/26/22 at 06:37pm, Baoquan He wrote:
> On 06/24/22 at 02:37pm, Valentin Schneider wrote:
> > On 24/06/22 09:30, Baoquan He wrote:
> > > On 06/20/22 at 12:15pm, Valentin Schneider wrote:
> > >> @@ -94,14 +94,20 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >>  	/*
> > >>  	 * Because we write directly to the reserved memory region when loading
> > >>  	 * crash kernels we need a mutex here to prevent multiple crash kernels
> > >> -	 * from attempting to load simultaneously, and to prevent a crash kernel
> > >> -	 * from loading over the top of a in use crash kernel.
> > >> -	 *
> > >> -	 * KISS: always take the mutex.
> > >> +	 * from attempting to load simultaneously.
> > >>  	 */
> > >>  	if (!mutex_trylock(&kexec_mutex))
> > >>  		return -EBUSY;
> > >
> > > So kexec_mutex is degenerated to only avoid simultaneous loading,
> > > should we rename to reflect that?, e.g kexec_load_mutex.
> > >
> > 
> > It's also serializing crash_get_memory_size() and crash_shrink_memory();
> > more generally it should still be the preferred serialization mechanism as
> > it's a "proper" lock visible by instrumentation, the atomic variable is a
> > side character for the NMI case.
> 
> You are right. I only checked the code comment in this place. Then this
> patch looks good to me, thx.
> 
> Acked-by: Baoquan He <bhe@redhat.com>

OK, just saw Eric's comment after I replied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
