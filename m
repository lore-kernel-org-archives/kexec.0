Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92C3C531DC
	for <kexec@archiver.kernel.org>; Fri, 23 Aug 2024 18:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kQ4mHCu2pkY7tTFwiO4ZpxfiAMO9TAAWBpqVtCHjdsc=; b=xXCUZhwKk79rtr
	lNJHj880oA/VlgsewaT6G2QeehJpiundALAeQLgkwkg7SFMtovvvCLdGtTYl/IGVUbmAsyTnTOVea
	QEF82jibatDJMPcwWign7hP/Urb2VuACgrYsM62Up/tO6CKZJoxx3xsnu8vJqu1eUCUIP7DzdApIZ
	amsxhwU9l9prDL3f4w8tIp7YxocROMSi44SGUL8PrKw+fO4wlYyQJXoeH2nRbebjauJ3tWcGmOwy7
	gwxEjpOjjyGzSV5x2zS03PsMeznB3GRgGFABEY09JmA1sa1z7oiEeBFhos0x6Ma0fPWk06LctGl3D
	1L8oy8SPWDt6OTeca47w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shYqS-00000000H7L-31A1;
	Fri, 23 Aug 2024 18:17:08 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shYqO-00000000H0r-3A3K
	for kexec@lists.infradead.org;
	Fri, 23 Aug 2024 18:17:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lF3IGhVEk01uLE12Kfo9B/+81jxDEguey7tV3Pj8R54=; t=1724437024; x=1725041824; 
	b=JFAesgr26FzjDfQNgnTdar8cP63Yt/eIxJSx4dAqZkDJLhY777ZxPUChEo1ITmvRn7RvVj5wO5X
	GUKTqDra/hF3VbA7xk2A3j/DDYjED1QgzETXeAKlEZ7E3qHOGvWmZCwQhjmkvl52xA65rYwiNi1NK
	g9RIBMUOrv1adhSBsxBJdZButUx+/fhpVPTEKkZGdR23j6PlXDm8q2/hp875llTF3h63aBtn6WDPT
	ACNFLfjiLu7zzxuszJiKjtJeJy48gf/JDN/oF1OzoO9WUi7anIoGV0kZH8og2CB001nqE816Q+rig
	TtXUc+1pEQq6wHP0BlPfUbnvYnZIuwsKptDQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1shYpw-00000002CKl-2SPB; Fri, 23 Aug 2024 20:16:36 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1shYpw-00000003fE3-1W3A; Fri, 23 Aug 2024 20:16:36 +0200
Message-ID: <09c29a3c4879d4ce5d8b97fd60d8ba5e38bed979.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Dave Vasilevsky
	 <dave@vasilevsky.ca>
Cc: bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
  mpe@ellerman.id.au, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org,  Reimar =?ISO-8859-1?Q?D=F6ffinger?=
 <Reimar.Doeffinger@gmx.de>
Date: Fri, 23 Aug 2024 20:16:35 +0200
In-Reply-To: <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
	 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.191
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_111704_959747_4617E3E1 
X-CRM114-Status: UNSURE (   7.50  )
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

Hi Geert,

On Fri, 2024-08-23 at 15:13 +0200, Geert Uytterhoeven wrote:
> IMHO CRASH_DUMP should just default to n, like most kernel options, as
> it enables non-trivial extra functionality: the kernel source tree has
> more than 100 locations that check if CONFIG_CRASH_DUMP is enabled.

I guess we should then revert that part of Baoquan's original patch.

> What is so special about CRASH_DUMP, that it should be enabled by
> default?

Let's ask Baoquan who made the original change to enable CRASH_DUMP by default.

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
