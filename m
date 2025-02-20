Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A8DC36007
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzKDKoVrBDUrsawz8VsqQN0RmxEUxc5SPjjl/Dgx0g8=; b=y/fgDjpN04jW8XE0AEw932XVFo
	RUOHRqp+bhlBXYgIxeiq8K/kMH111jLtaZiNPs61HoDr8vI1smRB4lyu0hl8ars8lcxrh5hGjFdwg
	7KL8n5/60j9UzBORq2pAm+QPx7iRbRx6KzbbgafxkkQmOVP3MgClb8zUxaOnkWTHOn4aA6ZDnPIYM
	LNU1YWLz9yt9vX0eaHvJNCCBz1jRqe26+xOjp70Cl33ntQoc9dtt61KhypwPGPiZ5Uq1Zoj2kmQ/j
	CY4jVNl+qcJy9IqL1yV77j3EBn4nfwK1/WAQDkVOCrLMFq3Z+pVBxHvbVX7CjRypmz4Nrz8NnCN+2
	q1gL0FsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRw-0000000CTwv-0wTf;
	Thu, 20 Mar 2025 15:04:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkvh8-0000000GCSg-0Q1b
	for kexec@lists.infradead.org;
	Thu, 20 Feb 2025 01:49:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740016181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzKDKoVrBDUrsawz8VsqQN0RmxEUxc5SPjjl/Dgx0g8=;
	b=Xl8stvCRHHs5T7+/2MYST64lxsakvEkgxgW+nAftL9xm2dEXQ4VWizBCWGGh5fk+aez6Ye
	AtaqY7JFIGo+/EWRvXIkHce/9wdRBYqH1Tkd3TkZRY8iZZ9jgxmtipoI7JJkuJIkDfaJfr
	xdnSfsKYemu3916QaL0Y9Xvuj2GEdyg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-xw5LH_SnMOm8_AOFeO9LZQ-1; Wed, 19 Feb 2025 20:49:39 -0500
X-MC-Unique: xw5LH_SnMOm8_AOFeO9LZQ-1
X-Mimecast-MFC-AGG-ID: xw5LH_SnMOm8_AOFeO9LZQ_1740016179
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2a6b4b2d4so10046925ab.2
        for <kexec@lists.infradead.org>; Wed, 19 Feb 2025 17:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740016179; x=1740620979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzKDKoVrBDUrsawz8VsqQN0RmxEUxc5SPjjl/Dgx0g8=;
        b=cMQjD5DT7PDP59z/kSiwjDRK3bcFxjF3hKCTpxkBEyHLiqg1NXh0B8PR7XlwrB531B
         wP1vcqyFXaJuCxSflpfqAW/DYg8FwP9zLpFX5NAfjjdR0pmoz6aZuYddeN2wfZxDhFir
         p5Xs6f202zZHi/TK+CMGequfBXGjr2UL/mg13kSowUrcjcnhSeiDXKm7srTs7aPeJEPG
         5lSQz0GhxVM8mCcyrvqY6ljo54esGsZRvNCmJFfJwOe5W53XEpkOWUoyNaE26xdhrCSj
         gbUlRBGlj+xP8YRlEu2UxPcVcEZVjSDnpEtDUVO4y8AkGe61ow4pQBPCvXX+0hz+YTZ6
         ICRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5d/swtjBM4vDQeR/W71PrbbnmP3abXjFpxQ51ia0XNIn90F8VfazoXa5fUbzzlXo7w1AAHw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3XwQHhmr0yj7wiLxUOiysQVBrlz6UMgp0AIEuV4985ui9KXun
	axR7A/BQ1ugKzFvs+6EVfX6a4tdWW+LOhV9osoTkb8HbJXmjeZK+WsBW1ad+wHaBBBScZtlt/2I
	f+dfEzMAkPAHkUvEht+uM7wN+5rXmveh3iXRCoO0A6q0AzLO7rnmq4kg0mcRcjFZl59iRxD76gz
	nIt5BlJW6OsSI24RQlGOA1sOXlWFrELblF
X-Gm-Gg: ASbGncvbzt5QnC06Wn2/EWKwhC1SS3Mjg0EhIPPTHEcTmV1sLZ+Lo1bACsfYGMbV/In
	HNSVWOOMYtuY6ZWHDpDH/MmpgzOfavS168f3Gysc8e0xmtgtMHfv+bXfjSFxrjzk=
X-Received: by 2002:a92:cd8b:0:b0:3cf:ceac:37e1 with SMTP id e9e14a558f8ab-3d2807b90afmr166598505ab.11.1740016178791;
        Wed, 19 Feb 2025 17:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHua4N3hMkedgyAywjDxkxVa1LR4pC25UZ/n6ciTidS6+LPrXCE4QkVj5KAidqXqI09qUbwPkqRyqNWoJszBts=
X-Received: by 2002:a92:cd8b:0:b0:3cf:ceac:37e1 with SMTP id
 e9e14a558f8ab-3d2807b90afmr166598175ab.11.1740016178479; Wed, 19 Feb 2025
 17:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
 <Z7WJD6eBLuIRnLwk@kernel.org> <CALu+AoSaEthfed1NOYPiQgm_g-dhibVMRAp0+=_+9qTT4_x=tg@mail.gmail.com>
 <d8c43707-65a2-4176-85e2-acdb4c9d16ad@amazon.com>
In-Reply-To: <d8c43707-65a2-4176-85e2-acdb4c9d16ad@amazon.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 20 Feb 2025 09:49:52 +0800
X-Gm-Features: AWEUYZnow-BFw9b6Uwj9RQ5_fBga9ll51qxXSJUam_iT6jbFDfi-PA1-cJgL388
Message-ID: <CALu+AoR0BbmbZeOkLU55OpD8kxGsVnFs+pXgEC9Y_MpB4=GMvQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Alexander Graf <graf@amazon.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	Philipp Rudo <prudo@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QJO_OzkASl5_Ke2mn1Rii8FacmAS6f_aFoeQve6VLNw_1740016179
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_174942_204240_048E2117 
X-CRM114-Status: GOOD (  33.62  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

On Wed, 19 Feb 2025 at 21:55, Alexander Graf <graf@amazon.com> wrote:
>
>
> On 19.02.25 13:49, Dave Young wrote:
> > On Wed, 19 Feb 2025 at 15:32, Mike Rapoport <rppt@kernel.org> wrote:
> >> On Mon, Feb 17, 2025 at 11:19:45AM +0800, RuiRui Yang wrote:
> >>> On Thu, 6 Feb 2025 at 21:34, Mike Rapoport <rppt@kernel.org> wrote:
> >>>> == Limitations ==
> >>>>
> >>>> Currently KHO is only implemented for file based kexec. The kernel
> >>>> interfaces in the patch set are already in place to support user space
> >>>> kexec as well, but it is still not implemented it yet inside kexec tools.
> >>>>
> >>> What architecture exactly does this KHO work fine?   Device Tree
> >>> should be ok on arm*, x86 and power*, but how about s390?
> >> KHO does not use device tree as the boot protocol, it uses FDT as a data
> >> structure and adds architecture specific bits to the boot structures to
> >> point to that data, very similar to how IMA_KEXEC works.
> >>
> >> Currently KHO is implemented on arm64 and x86, but there is no fundamental
> >> reason why it wouldn't work on any architecture that supports kexec.
> > Well,  the problem is whether there is a way to  add dtb in the early
> > boot path,  for X86 it is added via setup_data,  if there is no such
> > way I'm not sure if it is doable especially for passing some info for
> > early boot use.  Then the KHO will be only for limited use cases.
>
>
> Every architecture has a platform specific way of passing data into the
> kernel so it can find its command line and initrd. S390x for example has
> struct parmarea. To enable s390x, you would remove some of its padding
> and replace it with a KHO base addr + size, so that the new kernel can
> find the KHO state tree.

Ok, thanks for the info,  I cced s390 people maybe they can provide inputs.

Other than the arch concern,   I'm not so excited about the KHO
because for kexec reboot there is a fundamental problem which makes us
(Red Hat kexec/kdump team) can not full support it in RHEL
distribution, that is the stability due to drivers usually do not
implement the  device shutdown method or not well tested.   From time
to time we see weird bugs,  could be malfunctioned devices or memory
corruption caused by ongoing DMA etc.   Also no way for the time being
to make some graphic/drm drivers work ok after a kexec reboot, it
might happen to work by luck but also not stable.

So I personally think that improving the above concern is more
important than introducing more features to utilize kexec reboot.

>
>
> Alex
>
>


