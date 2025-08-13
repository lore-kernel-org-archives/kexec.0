Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA52C87FCF
	for <kexec@archiver.kernel.org>; Wed, 13 Aug 2025 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yNVE6wsMC8x7hacYqMkArJqlP3u73DUjInfZebo80YI=; b=XN2sZ3ITYAgTxH/hw3NK+Do8Yd
	4v/xoDg8wnejJHuEXMwcOylv3GqvCSbEYqqgUfP+5rp1B3dBcjIRo2Z6/HINeD4gdECLTg9nhYQeo
	+Avu3t0JnTD3VX+1/Ii0HZSlNsRnkbCJtPWR2BPJbmxhAaWvbkVOtCOD2M4pRUkHzdXPkWzt85kcf
	6r0+lpocDwvJ8RfwOT+uYOg0PtEF+ELCT7TVXhB7BV0cBx1+JDvm0MBT2xJWtD3AogP4k4gwG6PrU
	LcZ+Dxnw09nIYtIePdRDAJMUYqLioWxa5LVBMi96F589h8VDz0or+6odmqUI94GBhIzYu2jYY5qYt
	juA7xfAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umAJG-0000000DbfS-2XuP;
	Wed, 13 Aug 2025 12:10:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um9Qv-0000000DUZw-17ua
	for kexec@lists.infradead.org;
	Wed, 13 Aug 2025 11:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755083656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNVE6wsMC8x7hacYqMkArJqlP3u73DUjInfZebo80YI=;
	b=SFWjPF+Tjlp3BINEsgMlxN2V49RstL6FMutoHuMcB9O4JkVCQCLGQHAbN52vUiCA4g1xI2
	M8Veq1wZKtfyCw6GjZ9Ot6XStzq0rPB7TVGiJPFDazo02yzzj/q+f+ZrDDgiz7UNcQeRAj
	Ibrf4xydlDek42i5O1UlI0VEe+iE3kc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-4Pp8IIsdO9WiKTWHKKqYIA-1; Wed,
 13 Aug 2025 07:14:12 -0400
X-MC-Unique: 4Pp8IIsdO9WiKTWHKKqYIA-1
X-Mimecast-MFC-AGG-ID: 4Pp8IIsdO9WiKTWHKKqYIA_1755083650
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1FC61800291;
	Wed, 13 Aug 2025 11:14:09 +0000 (UTC)
Received: from localhost (unknown [10.72.112.177])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0043630001A1;
	Wed, 13 Aug 2025 11:14:07 +0000 (UTC)
Date: Wed, 13 Aug 2025 19:14:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com, elver@google.com,
	snovitoll@gmail.com
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv>
References: <20250812124941.69508-1-bhe@redhat.com>
 <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
 <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_041417_388801_7B137CE4 
X-CRM114-Status: GOOD (  29.35  )
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

On 08/12/25 at 07:14pm, Andrey Konovalov wrote:
> On Tue, Aug 12, 2025 at 6:57 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > On Tue, Aug 12, 2025 at 2:49 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > Currently only hw_tags mode of kasan can be enabled or disabled with
> > > kernel parameter kasan=on|off for built kernel. For kasan generic and
> > > sw_tags mode, there's no way to disable them once kernel is built.
> > > This is not convenient sometime, e.g in system kdump is configured.
> > > When the 1st kernel has KASAN enabled and crash triggered to switch to
> > > kdump kernel, the generic or sw_tags mode will cost much extra memory
> > > for kasan shadow while in fact it's meaningless to have kasan in kdump
> > > kernel.
> > >
> > > So this patchset moves the kasan=on|off out of hw_tags scope and into
> > > common code to make it visible in generic and sw_tags mode too. Then we
> > > can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> > > kasan.
> >
> > Hi Baoquan,
> >
> > Could you clarify what are you trying to achieve by disabling
> > Generic/SW_TAGS KASAN via command-line? Do you want not to see any
> > KASAN reports produced? Or gain back the performance?
> >
> > Because for the no reports goal, it would be much easier to add a
> > command-line parameter to silent the reports.
> >
> > And the performance goal can only be partially achieved, as you cannot
> > remove the compiler instrumentation without rebuilding the kernel.
> > (What are the boot times for KASAN_GENERIC=n vs KASAN_GENERIC=y +
> > kasan=off vs KASAN_GENERIC=y btw?)
> >

Thanks a lot for checking this.

> 
> Ah, you don't want the shadow memory for kdump, sorry, I somehow missed that.

Yeah, for kdump kernel, the shadow is a heavy burden, and most
importantly kasan is useless for kdump. We don't want to capture a
kernel memory bug through kdump kernel running becuase kdump is a
debugging mechanism.

> 
> I'm not familiar with the internals of kdump, but would it be
> possible/reasonable to teach kdump to ignore the KASAN shadow region?

Yes, we can teach kdump to do that. Then people may hate those conditional
check "if (is_kdump_kernel())" being added in kasan code. E.g even
though we skip kasan_init(), we still need to check is_kdump_kernel()
in kasan_populate_vmalloc(), right? 

Combined with the existing kasan_arch_is_ready(), it will make kasan code
ugly. I planned to add kasan_enabled() via static key
kasan_flag_enabled, then it can also easily remove kasan_arch_is_ready()
cleanly.


