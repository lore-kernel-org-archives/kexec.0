Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3C9C52D6F
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 06:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=17K6EPuSAawP1DdltYCShbeWhhBG15QDx3D+vL+66LM=; b=aMmQXj8nT1A4cq
	nXND91uZoSCgst9rvwKnud8xhFGVY9GWtLmgKQQbcyrFJs56/ttN1BwsKuEeEQYpqB9ZjPK1EVVEi
	AaU6DI4Tj5SDhO7FCdPVmjaTbx52WEtqsDaJlT2qgiKAwtRH7iHKLV+YMdTjBROfe41QgO1tqt4km
	5ZPqf5itYVrYIA8cAq7m0j7ZMfgLr6VOIhauI+w8WQGVWvqM9+f+oILnnqZXBtRFUatuihA37rQSk
	WHpFJmvea5081neioFo/FelUFo7lp4q05Zd5Mw6iR/4JZPWOSykvkOuAQa/HkKVPdWo8+77MaE3KH
	htRSu0n6PBm0SHl0VZiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sippz-0000000A2zT-3odE;
	Tue, 27 Aug 2024 06:37:55 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sippw-0000000A2r1-3taw
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 06:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7hvoZKt8KDniC16/zwNml85JaHiw3Nuh33M3Lqd0yuY=; t=1724740673; x=1725345473; 
	b=dvdOWC9wPvPY29HWas6rgcTRissxvT4yeLcXtheD5eMLc2hhbK/O1foM9XTCh9L+/Iy11m4sevJ
	en4T5Bb7w49Ca9sAmlNdPxtHjTU9A4ib2VAYlD66GzHvgx2IQIc2tZkyK1/QF/AsEE8/zoedy7inf
	uAdFJOLeJt+tel5P9gC55TatB7yDidN7z4XwMcntQazV1n0T8DALIoasiTKE3sDP5WqFTzHI/02yQ
	3veHrlALothe+VVKHoXrYvzZ6lPf+jRssPZzbdFrZpr9+g/7K8qJRf/Pt8Fl12khk5LquRr261mjv
	ALs3+9bs65bJJ4/lXNRDqrVFdLGF+A9JuMWw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sippT-00000001UP4-2QI3; Tue, 27 Aug 2024 08:37:23 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sippT-00000003ckf-1VoH; Tue, 27 Aug 2024 08:37:23 +0200
Message-ID: <f355e26eead641f5f281372aadf9dee7de19a4c7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Baoquan He <bhe@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Dave Vasilevsky
 <dave@vasilevsky.ca>, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org,  mpe@ellerman.id.au, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org,  Reimar =?ISO-8859-1?Q?D=F6ffinger?=
 <Reimar.Doeffinger@gmx.de>
Date: Tue, 27 Aug 2024 08:37:22 +0200
In-Reply-To: <Zs1wpHxfTcwKr517@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
	 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
	 <09c29a3c4879d4ce5d8b97fd60d8ba5e38bed979.camel@physik.fu-berlin.de>
	 <Zs1wpHxfTcwKr517@MiWiFi-R3L-srv>
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.191
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_233753_345157_A0766E41 
X-CRM114-Status: UNSURE (   8.54  )
X-CRM114-Notice: Please train this message.
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

On Tue, 2024-08-27 at 14:22 +0800, Baoquan He wrote:
> About why it's enabled by default, as Michael has explained in another
> thread, distros usualy needs to enable it by default because vmcore
> dumping is a very important feature on servers, even guest instances. 
> Even though kdump codes are enabled to built in, not providing
> crashkernel= value won't make vmcore dumping take effect, it won't cost
> system resources in that case.

OK, thanks for the explanation. But as we have found out in the mean time,
the assumption was wrong to enable it by default for all architectures as
some architectures cannot boot a crash dump kernel with their default bootloader
but only through kexec.

Can we have a follow-up patch to disable crash dump kernels where they're
not needed? I mean, not every platform supported by Linux is obviously a
x86-based or POWER-based server.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
