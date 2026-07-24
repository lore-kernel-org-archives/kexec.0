Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5091C531FA
	for <kexec@archiver.kernel.org>; Fri, 24 Jul 2026 08:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6w2iaDqIpFP8RzG62DRjCZ0o1bpE8b3mkLq3700xaI=; b=IOLmk+KS/2+ACvabuFNT5YxWJE
	EH2yO9wVbmFVEzrRsl5A3I+jEyQ+HTa/lEtYIkc4xKykEaQY/yDthXfCO/L78NXftfyZ5u3XA5pIe
	EQHb2/RmQMF3aoPppbMZNhN7y8ibeIgTug2YwbPAAWLifAGdhA5q7R4hRhC+RFNBOytS8ce1JpQ6q
	zwwrsUFiHgORF9cDjHOfEvXL1V0ub+xzbFLiWebkZUGqRJH5L3/p8oOTL+9YduF/zMLMAHQcXgqUG
	Td0bE53F+ExUPWTwskdSAcVHG0n/WQ8RgJqtbI9lCs+Wk6Di4FssF8lAIVamxlCVXCDxKWN1XJr54
	BmjHBeBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnBAF-0000000Fo1h-3BEW;
	Fri, 24 Jul 2026 08:21:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnBAC-0000000Fo0v-2Vd7
	for kexec@lists.infradead.org;
	Fri, 24 Jul 2026 08:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784881306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6w2iaDqIpFP8RzG62DRjCZ0o1bpE8b3mkLq3700xaI=;
	b=Swwy5Pt14CIf36VnHMwiGaVka0QGot9n+4/FbwFwf+iM6PnycCYJPknACQemhbEOUZeume
	2KD6XiGK7OuATAlHuyh6OH0KsJnQ0qeDBAs1hWcD1AF9T//Uh2g8mjHqPGrdbUwOjFtEbl
	iHAY7ad2cTtFDBGDQwDuCVkoYR835cg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-vdipYOc6ObmxHfGBOhG0NQ-1; Fri, 24 Jul 2026 04:21:44 -0400
X-MC-Unique: vdipYOc6ObmxHfGBOhG0NQ-1
X-Mimecast-MFC-AGG-ID: vdipYOc6ObmxHfGBOhG0NQ_1784881304
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930a098ea19so11635785a.1
        for <kexec@lists.infradead.org>; Fri, 24 Jul 2026 01:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784881304; x=1785486104;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R6w2iaDqIpFP8RzG62DRjCZ0o1bpE8b3mkLq3700xaI=;
        b=CIUVoL1NPL6hC/1SJFf7xlzpnPDkJezIlzaMjM8NhEoN4GWrN3V+EVBhnK+DbhnY3Y
         BfIxr9Ml0M17wae4IDIvBl7RXgDSDW8QvFyDRonqfAJA5XWeo1l306ZZNrAfC5qD6GMp
         d4U27TAJJ7w1yuFq6Mpb9j0rUf3bkz1GiOXmuhzE+vaHOA2UCxms7y20wavKS5+wo2UU
         LhK6g10WpVfcSf3KLeKbLE51qA6Y7F3+fmSUjiDyhMBEJtZXY25bfG5dPEm/Fnpdffsn
         hhVCrCe3dgMyycQnE0g5NRxKAHFuMejpnDUF96W9CqyDzPLccpcbyMSKLlg1zHBUALr6
         OATA==
X-Forwarded-Encrypted: i=1; AHgh+RopBeBjhZ/w8prBw5koUQCqlKZY1puh3yflpMEyydV3+avBsTRoZA7omutAoql1jyAFdVPCFg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyWHtVNOn9wCcrrOjjF6xVh54+vmoJxq8uYj57eSudbeHe4pcJs
	9959Bx0tvEHePTPOpidANkMxZ/78bwnO0tlg8SZ/VNt85phyc+LNzLUmu90ioqJ4wQGihtfzGda
	48H4AjmhDg5l+ygWqi9DiVwrWJbagaw7gJqEwO4uW5b27ZwheX0LFlUDnw6k1i5CtnqD+HifrRP
	GbriWyfl0xqhvXT67cKOcTDIQs1V3k4FvgpanI
X-Gm-Gg: AR+sD13Frz9E1BsDbeBDlUqsqzAbhOCbRoYpUCUElA5mt50+CI7CLBc31OSHpCf4Ksp
	EHyRUZj8x3jYbA2FEo5zAH6HsSO14z8o4OGSAiksI5Crep/jGKyGvGFsa4ptmkA3i76H13tcLUK
	Xjy6anDsPhCTxLDWGUwMXUkHNWM4WCujuh6jlkscGlrGQBoketc8B/B9pS
X-Received: by 2002:a05:622a:13d3:b0:51a:8c99:1f0d with SMTP id d75a77b69052e-5283df3e6acmr56348241cf.60.1784881303728;
        Fri, 24 Jul 2026 01:21:43 -0700 (PDT)
X-Received: by 2002:a05:622a:13d3:b0:51a:8c99:1f0d with SMTP id
 d75a77b69052e-5283df3e6acmr56347861cf.60.1784881303160; Fri, 24 Jul 2026
 01:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
 <akybBoCAm-kJbfHL@kernel.org> <20260720091927.GA1736709@horms.kernel.org>
 <al4X300UObXawEIJ@kernel.org> <al4yeHrkDHFoo6A0@MiWiFi-R3L-srv>
 <al5cbYMD18UbKe-6@telecaster> <al9gnbT5S0ALDieg@MiWiFi-R3L-srv> <MRWPR09MB802232B51C8299CF750B14978FC02@MRWPR09MB8022.eurprd09.prod.outlook.com>
In-Reply-To: <MRWPR09MB802232B51C8299CF750B14978FC02@MRWPR09MB8022.eurprd09.prod.outlook.com>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 24 Jul 2026 20:21:06 +1200
X-Gm-Features: AUfX_mzM2Esm_vgIK4dSyGCOmrk37RuBTaquqJpKja8Y0Uar-Vj9nUEWBeZ2VbY
Message-ID: <CAO7dBbVoygCT245OvjZNDeg9b0qCZ5NZd_MNSAiELAZNEDf8-Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] vmcore-tasks: export per-task metadata to vmcoreinfo
To: Pnina Feder <PNINA.FEDER@mobileye.com>
Cc: Baoquan He <baoquan.he@linux.dev>, Omar Sandoval <osandov@osandov.com>, 
	Mike Rapoport <rppt@kernel.org>, Simon Horman <horms@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Dave Young <ruirui.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Alexandre Ghiti <alex@ghiti.fr>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-debuggers@vger.kernel.org" <linux-debuggers@vger.kernel.org>, 
	Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>, 
	Gregory Greenman <Gregory.Greenman@mobileye.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IPTsuyutTM9UqxgEWDPZzUfAQkBF6_LMgwM2x0gWDCw_1784881304
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_012148_705196_C673A5AB 
X-CRM114-Status: GOOD (  50.29  )
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

On Fri, Jul 24, 2026 at 1:05=E2=80=AFAM Pnina Feder <PNINA.FEDER@mobileye.c=
om> wrote:
>
> > On 07/20/26 at 10:35am, Omar Sandoval wrote:
> > > On Mon, Jul 20, 2026 at 10:40:43PM +0800, Baoquan He wrote:
> > > > On 07/20/26 at 03:43pm, Mike Rapoport wrote:
> > > > > Hi Simon,
> > > > >
> > > > > On Mon, Jul 20, 2026 at 10:19:27AM +0100, Simon Horman wrote:
> > > > > > On Tue, Jul 07, 2026 at 09:21:58AM +0300, Mike Rapoport wrote:
> > > > > > > On Tue, Jun 23, 2026 at 12:14:26AM +0300, Pnina Feder wrote:
> > > > > > > > This series extends vmcoreinfo with struct offsets and size=
s
> > > > > > > > needed by the vmcore-tasks userspace tool to extract
> > > > > > > > per-task state from a vmcore dump without requiring kernel =
debug symbols (DWARF/BTF).
> > > > > > > >
> > > > > > > > The vmcore-tasks tool reads /proc/vmcore (or a saved vmcore
> > > > > > > > file) and reconstructs, for each task:
> > > > > > > >   - task name, pid, state, flags
> > > > > > > >   - VMA list (start, end, flags, backing file)
> > > > > > > >   - user register state (saved on the kernel stack at kerne=
l entry)
> > > > > > > >   - user-space backtrace with VMA/filename mapping
> > > > > > > >   - kernel dmesg buffer
> > > > > > > >
> > > > > > > > This provides a lightweight post-mortem crash analysis
> > > > > > > > capability for production environments where full debug inf=
o
> > > > > > > > (DWARF/BTF) is not available.
> > > > > > > >
> > > > > > > > The companion userspace tool is submitted to kexec-tools:
> > > > > > > >   Suspicious Link - Removed
> > > > > > >
> > > > > > > Sorry for the delay, this fell between the cracks somehow.
> > > > > > >
> > > > > > > The kernel side looks fine overall, but to merge it there
> > > > > > > should be an agreement from the userspace side maintainers
> > > > > > > that vmcore-tasks is something they are wishing to accept.
> > > > > >
> > > > > > Hi Mike, all,
> > > > > >
> > > > > > Sorry for the extended delay.
> > > > > >
> > > > > > I will send some minor feedback to the user-space tool patchset
> > > > > > but overall, yes, this is something I would be happy to accept.
> > > > > >
> > > > > > I don't want to create a chicken-and-egg type problem here.
> > > > > > But it's probably worth mentioning that usually features hit th=
e
> > > > > > kernel before the corresponding code is accepted into
> > > > > > kexec-tools.
> > > > >
> > > > > Sorry if I wasn't clear.
> > > > >
> > > > > I didn't mean that the feature should be merged into kexec-tools
> > > > > before merging the kernel bits. I just wanted to make sure there'=
s
> > > > > no fundamental issue from kexec-tools perspective.
> > > > >
> > > > > > Let me know how you would like to proceed.
> > > > >
> > > > > I'm going to wait for Baoquan's review and once that's done I'll
> > > > > pick up the kernel bits.
> > > >
> > > > Oh, sorry, I just noticed this series, but a quick look give me a
> > > > hint of 'No, I don't like it.' We have had Crash utility, Drgn, now
> > > > a new one comes up. I have some concerns to Pnina:
> > > >
> > > > 1. Exporting maple tree internals (maple_node, maple_range_64,
> > > >    maple_arange_64, maple_metadata) as vmcoreinfo ABI is problemati=
c.
> > > >    These are private implementation details, not stable structures =
like
> > > >    task_struct. Any refactoring of the maple tree will silently bre=
ak
> > > >    the userspace tool.
> > > >
> > > > 2. Without DWARF/BTF, the debugging scope is inherently limited =E2=
=80=94 no
> > > >    kernel stack backtrace, no symbol resolution, no variable access=
.
> > > >    That's essentially "ps + /proc/PID/maps" from a vmcore. Have you
> > > >    considered enabling CONFIG_DEBUG_INFO_BTF on your platforms inst=
ead?
> > > >    BTF is compact (typically < 1 MB) and would give drgn full acces=
s
> > > >    without needing vmlinux debug packages. That seems like a better
> > > >    return-on-investment than maintaining ~40 new vmcoreinfo exports=
.
> > > >
> > > > 3. Beyond the technical concerns, I wonder about adoption. vmcore-t=
asks
> > > >    targets a fairly narrow use case =E2=80=94 platforms without DWA=
RF/BTF, where
> > > >    you still have vmcore but can't ship vmlinux. Is Mobileye curren=
tly
> > > >    the only consumer? Are you guys already using it widely and full=
y?
> > > >    If this lands but doesn't see broader uptake, the ~40 exports ri=
sk
> > > >    becoming dead weight in vmcoreinfo =E2=80=94 nobody actively use=
s them, but
> > > >    kernel changes still need to keep them consistent, or they silen=
tly
> > > >    rot and give users wrong results.
> > > >
> > > > Regards,
> > > > Baoquan
> > >
> > > (Adding linux-debuggers mailing list).
> > >
> > > I agree with all of Baoquan's points here, with a couple of notes:
> > >
> > > 1. drgn's BTF support is currently a work in progress, but it's shapi=
ng
> > >    up well: https://github.com/osandov/drgn/pull/625.
> > > 2. makedumpfile is also gaining BTF extension support:
> > >    Suspicious Link - Removed
> > >    It's lighter-weight than drgn while still being much more general
> > >    than this series.
> >
> > Thanks for adding the information, very helpful.
>
> Hi,
>
> Thanks everyone for the feedback and the suggestions.
>
> I'll take a look at using BTF with vmcore-tasks and evaluate whether it c=
an replace most of the vmcoreinfo exports.
>
> Our use case requires analyzing the vmcore on the crash kernel itself, wi=
th very limited storage available, so using drgn together with a full vmlin=
ux is not practical for us.

I guess you can ship a makedumpfile and a few extensions to your
system, which shouldn't be too large. You can code a makedumpfile
extension to utilize BTF info(If your kernel already enabled it) to
iterate tasks and dump the needed information out, please see [1],
though it is used for ease some data from vmcore, but enough for print
any information.

[1]: https://github.com/makedumpfile/makedumpfile/blob/master/extensions/er=
ase_sample.c

Thanks,
Tao Liu
>
> Thanks,
> Pnina


