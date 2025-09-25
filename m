Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F13BCAC5B7
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 09:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FqFc/l0lv6kkrs3vt2G7hHGHYhW0rm+CgKz2b5qB4kw=; b=P5HwJ65XaRe53xFR1XvI2Ry0Ls
	D/9x2uMat7hAC0mzZBtvaob478STdPTrCs3XQ8VlnkC5ylfKPdefQX+wfL31+4VAtNiSisjBJEmzB
	QUF9Q2q+FcZi7DFvk3HA99ajq120WFCVJjo27pMUAR0bJwr66boRuBy5lTRrl+ebad6TIBvxOTuTH
	HSrxBzEoTKu/ewrjsqonSuglnfWF8WCyYGHLhNdgE+60R/fURJecE6vlMr8Gqv5rEsXaCLgQ+yEWl
	o9syP3Ms8koQWGI4ksGQU27skZgXNTgzoXTxndZC9n9dS8vj+qA1PAIjbpY7obvPY/D0EH5nxMmHf
	BXIooYnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1iN0-00000007g0G-0bNg;
	Thu, 25 Sep 2025 09:34:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1iMw-00000007fuf-249E
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 09:34:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758792869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FqFc/l0lv6kkrs3vt2G7hHGHYhW0rm+CgKz2b5qB4kw=;
	b=Tpo7x4dEgW+N1rZgDD6SPwHIEVBlOnVODHpx8GRW+oRm4TWfZojYJdRgIuLtLgDX5T2Xfe
	ErVpLphU/G1DQgxZd16WxISjSYaMkLs2kHkKpojkcy9o0tp17wlAI8AP+y2DzsVRLGVFAo
	KDcvZNdDQIfeTjidB7ehKVtovgaoCqo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-tW05hkKwPOyh9bZGYxAYfw-1; Thu, 25 Sep 2025 05:34:25 -0400
X-MC-Unique: tW05hkKwPOyh9bZGYxAYfw-1
X-Mimecast-MFC-AGG-ID: tW05hkKwPOyh9bZGYxAYfw_1758792864
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5786084a857so307492e87.1
        for <kexec@lists.infradead.org>; Thu, 25 Sep 2025 02:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792864; x=1759397664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqFc/l0lv6kkrs3vt2G7hHGHYhW0rm+CgKz2b5qB4kw=;
        b=GhZDaPjI2O05v8qyULMPxPXK06qrD8aaJphU1oih8tNQgQe67M4Ii81RRYh4kGrEIb
         Bc3eN0GPEKiUMd7prTMa71wLFPhCT3yy29+vxG5jeXt30mpaFifys2Bcvm40dFM0vm7k
         7lgMKwxVviZExnxWrcS1paJIUSwIfKmpxWIDm1VsQB/WA9Xl/4W0s5jeAU5ryNJzIH6o
         52abw1TxTQEFNB53wt13m5M9BFSVCTpK17svrd44aveYbGVwLfNUEGPXvZG30vElr5qj
         7xpocFGdk3+1Dyl+RosHoLR9L/Uy7XeGkgXcCQWrJt9gRAcDO1+iSKhmOnnW7sU572d+
         A7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUX69lXh0ketb0sh9NHGVNcJFVxc0ID1DcD0eTRQ8AeObcPWLebOMRzsQghT9Vsu7edyUG+oQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzYUTo7pi5CQaDpFx7sMtzi05lgX28/999V5QjdTpB/fhyFRWWb
	w0FRFxUkXlmyF+xXEhtw0+1fNNfQHuxQk91kex7X4DRLy5BdjE6W+CAaZyk/5qvzgnGjQ+IpzLT
	r6eX21+gc6k4LVYT9VIgWKTDqz7ollD0ewiJ5WEJ1o2j/TEoEFUsO9dd51eQTEO1oEOuuFfmfHa
	2mijNRaVeW2Jn8VKWbxgC8NTQnqWpcvd7dXh8B
X-Gm-Gg: ASbGncuoKNclLnkmqplApIRTuFDEVu9JMaxyNXL1D6f4ryp6One91OxpVhpWTnQ2hmX
	xErmNoefe0Lfcpr6P3UWptnUgpVJhrtsk51XjkXD6WrsZk6GjehFUyvkDdRf+Q1xlrHdt1UaQrs
	mthAwEEy8nA+j/Sf6+cOMRoQ==
X-Received: by 2002:a05:6512:1193:b0:55f:503c:d328 with SMTP id 2adb3069b0e04-582d2f27963mr862486e87.36.1758792864161;
        Thu, 25 Sep 2025 02:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu1PpCJj949dhYt6ggEABSLBSKYaILK32nwsruKqogE39ZxF7apLrPcm5YPtSe77HkaUe9bhia/AjWuwfDaBI=
X-Received: by 2002:a05:6512:1193:b0:55f:503c:d328 with SMTP id
 2adb3069b0e04-582d2f27963mr862478e87.36.1758792863692; Thu, 25 Sep 2025
 02:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250925063241.337897-1-youling.tang@linux.dev>
 <CALu+AoTauqunUunsnpSX6_pn08PAcr=tpkzWiNJ1cOTR9-8vVA@mail.gmail.com> <1a04d38f-b231-483b-8a10-0d66a82b6e3d@linux.dev>
In-Reply-To: <1a04d38f-b231-483b-8a10-0d66a82b6e3d@linux.dev>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 25 Sep 2025 17:34:14 +0800
X-Gm-Features: AS18NWAdbMNiS4auNjlVyz52HyO5pcKULQGuM3U_3v3dj6PtYkdEwGAJT5FgouQ
Message-ID: <CALu+AoSk0VcyuT+YRYAh9gU3hnRLoqK-=P7OZA8y0_vkQZ-URA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Remove the "mem=" parameter when using the
 --reuse-cmdline option in kdump operation
To: Youling Tang <youling.tang@linux.dev>
Cc: Simon Horman <horms@kernel.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, 
	Huacai Chen <chenhuacai@kernel.org>, Youling Tang <tangyouling@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GSccWa8NaWun099ry1y4H0zFh75Lt2Pcb461tRz3uiY_1758792864
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_023430_607361_F4C36AAB 
X-CRM114-Status: GOOD (  25.81  )
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

On Thu, 25 Sept 2025 at 17:26, Youling Tang <youling.tang@linux.dev> wrote:
>
> Hi, Dave
>
> On 9/25/25 17:11, Dave Young wrote:
> > Hi Youling,
> >
> > On Thu, 25 Sept 2025 at 14:33, Youling Tang <youling.tang@linux.dev> wrote:
> >> From: Youling Tang <tangyouling@kylinos.cn>
> >>
> >> During kdump operations, the capture kernel cannot reuse the "mem="
> >> parameter from the production kernel. The "mem=" parameter is used
> >> to specify the available memory range for the kernel. Reusing the
> >> "mem=" memory range may destroy the production environment.
> >>
> >> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> >> ---
> >>   kexec/kexec.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kexec/kexec.c b/kexec/kexec.c
> >> index c9e4bcb..fadf986 100644
> >> --- a/kexec/kexec.c
> >> +++ b/kexec/kexec.c
> >> @@ -1256,8 +1256,10 @@ char *get_command_line(void)
> >>                  *p = '\0';
> >>
> >>          remove_parameter(line, "BOOT_IMAGE");
> >> -       if (kexec_flags & KEXEC_ON_CRASH)
> >> +       if (kexec_flags & KEXEC_ON_CRASH) {
> >>                  remove_parameter(line, "crashkernel");
> >> +               remove_parameter(line, "mem=");
> >> +       }
> > People can remove it from the kdump load scripts instead if it is not
> > useful. I do not suggest removing other cmdline in c code.  The
> > crashkernel is a special one which is fine.
> Removing it in scripts is also acceptable. However, reusing the
> production kernel's
> "mem=" parameter will inevitably damage the production environment. In
> my view,
> modifying it in C code can achieve a permanent solution (avoiding the
> need to
> modify kdump services for each distribution, and also applicable to
> non-kdump
> services scenarios where commands are executed directly).

But the param is a general one, not specific for kexec, people can use
it in their own way, eg. use less memory to boot a machine for debug
purposes.   This is why I suggest doing it in scripts and
distributions.

The two kdump related param, crashkernel and elfcorehdr are special anyway.

>
> Thanks,
> Youling.
> >>          return line;
> >>   }
> >> --
> >> 2.48.1
> >>
> >>
> > Thanks
> > Dave
> >
>


