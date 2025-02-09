Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6945DC021A0
	for <kexec@archiver.kernel.org>; Sun,  9 Feb 2025 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4gjXaQBLaw4NUMDsntEFs7TEopqGWrY+9/yjxC8/Zts=; b=PdstkMx1tBmu4ExehKlCR0IBSF
	yPod684kH3mPbLic095tH9aw1Vhf7p3jcdfXgrwrm5tgdrJr5QufrwYDiLaxGW3DJYlVYqHsOAgsT
	tC5JN9DAum+gjnmIm0ZWbQ7L27egrgaH+/PENLVaHYlhlIGuB8QVr8FA2dm+wbPU+hV+g86I6Dp9u
	fvitCbTYyLjgqR8bl+LrnfOsC7EzGuTgn8Jr62KVRc4CgLDve3IRD9kkz8LO7r58r/xUT1TB7gsI9
	Vr1g9rk1CaxlWNFMEp7wKQ5H96nXG49I31RGKNF5kHnjJsTEFs0wVjwlfjCR7xuIOMOpuPFKeJ36K
	1ZPAySsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1th2Hw-0000000EJX5-0QrQ;
	Sun, 09 Feb 2025 08:03:36 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgv7E-0000000DmB0-03kf
	for kexec@lists.infradead.org;
	Sun, 09 Feb 2025 00:24:05 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-46fa7678ef3so32512271cf.1
        for <kexec@lists.infradead.org>; Sat, 08 Feb 2025 16:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1739060643; x=1739665443; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gjXaQBLaw4NUMDsntEFs7TEopqGWrY+9/yjxC8/Zts=;
        b=ZLOTcZmLS2vJZsKGm2QEnZhDc5Qfj8x8wHrp334YyIqkIfIjBaw2x/RCR4/erVR4EB
         ZuC/R5jnfqoBoMXeryCs23TT001Vg5gXEk3JARTmQw9cYWg4g9GeG8fSoLCWZLXGNI03
         9ibJbD1onuuefZuWn+E4WbYjdr08MSt2iETJiQgUK2/3BxYeceQpUW+1kuV8wBPeGioy
         ZWsDpkUSj9yQgFh4SyZn0fNNePKyAQTNpMc4RZIIgmIuDatCwJYVtESzqOsyLT8cWjae
         7JK3SPIB33v8uTG0yJ/PSWqGXU6fGO8UMAO8cHiYUb6lEl+rdcDHpFCiJf1FFQ9+BU7R
         0uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739060643; x=1739665443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gjXaQBLaw4NUMDsntEFs7TEopqGWrY+9/yjxC8/Zts=;
        b=cBUQneng+8KRZXeBgTjLPqxxHec1X0xWme0TFC110AbF1DmclFHTrkJQF6mRl0JAgZ
         eRqQ2YQie+FYGLlXKkyFyOLjIXKEkV+Cb2eJjqXgGfGqWmj2awMqhNNRBfFp0w7ECMIB
         BcyQ+qtXfRMeOZ7iAx0QPoWF4YBKt2//8VCz9EGiX7lxN6BMxg1PQqBURxhXASOEJI05
         H4pR1S39oblzRgfq+vBz0LUX8JzaNq3AjHRMA6SsQIj1e01K/r4guVV7E/8Dt41SNtmf
         6nO+0Vjqiws3VG3CItDCh2orwhRl1BGjn7UU7ujPEQ2dBRzO7wQ9MZLrfxVc/4v4g1de
         ps6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO7mAKCSV4eoIVyDIDCoeusy9PpYImJK2rTk8VYjn2HXBp9i/cImd0BCfFi2+9QMQ2XKD3Rg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywwk3mpZvnoK8PN09ZyOqmZsDqY/B5r8zinRFfAkiwEKoRC1+98
	t9fK0aVYTsYn9qf2NJyca8/TYTPd7rnkMqwZEVLLkFhxnWqjxi4s2CY7Tuo/ebSE4bhg4eDq8KS
	HZpaj+lQ0K6djffvS3jmDmjIQUPxBJajkwI8OHg==
X-Gm-Gg: ASbGncsMjO30TihQidc+Uhy2tQnAReHHbwg270TwSnzMzxpp6qgwHzVqcQm9j2H5/N5
	rGlP/tXWpbIvqHPojMFHp0CcFdV3dgRhNS2xLLl9eGspRWmkQRoNew6GD2O5ceB/3TKtIaw==
X-Google-Smtp-Source: AGHT+IEWLXbbE35/NH7CqFs9Aene/KOrNSHj6kBiOSxP6T7AhYHyVwGrjMz5VAE9dQe0u6W8V5wpkpW0r78/dGV9jWk=
X-Received: by 2002:a05:622a:1195:b0:460:8e3b:6790 with SMTP id
 d75a77b69052e-47167c10096mr111860501cf.48.1739060642643; Sat, 08 Feb 2025
 16:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <20250206162939.a1f86fb835f1eeb7ed73ff1c@linux-foundation.org>
 <CA+CK2bD6204AKWGOgzLMiMsnVZ=tk+DGc+VWgi3RVt2byaLJJA@mail.gmail.com> <Z6a1kxR2GlQoepgI@MiWiFi-R3L-srv>
In-Reply-To: <Z6a1kxR2GlQoepgI@MiWiFi-R3L-srv>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 8 Feb 2025 19:23:25 -0500
X-Gm-Features: AWEUYZm4sw7r0YqYCsAlTqJTyIoFI_gwgSC8Xqrde5SyZs_ybRNGci9xB-WlypE
Message-ID: <CA+CK2bDgP2DfsfVAhQhFhBiNJFUS1n17oX9KgC1JFXAk76j01Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	Andy Lutomirski <luto@kernel.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Eric Biederman <ebiederm@xmission.com>, 
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	changyuanl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250208_162404_046755_DC6ABAEE 
X-CRM114-Status: GOOD (  29.68  )
X-Mailman-Approved-At: Sun, 09 Feb 2025 00:03:34 -0800
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

On Fri, Feb 7, 2025 at 8:38=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 02/06/25 at 08:28pm, Pasha Tatashin wrote:
> > On Thu, Feb 6, 2025 at 7:29=E2=80=AFPM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > On Thu,  6 Feb 2025 15:27:40 +0200 Mike Rapoport <rppt@kernel.org> wr=
ote:
> > >
> > > > This a next version of Alex's "kexec: Allow preservation of ftrace =
buffers"
> > > > series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazo=
n.com),
> > > > just to make things simpler instead of ftrace we decided to preserv=
e
> > > > "reserve_mem" regions.
> > > >
> > > > The patches are also available in git:
> > > > https://git.kernel.org/rppt/h/kho/v4
> > > >
> > > >
> > > > Kexec today considers itself purely a boot loader: When we enter th=
e new
> > > > kernel, any state the previous kernel left behind is irrelevant and=
 the
> > > > new kernel reinitializes the system.
> > >
> > > I tossed this into mm.git for some testing and exposure.
> > >
> > > What merge path are you anticipating?
> > >
> > > Review activity seems pretty thin thus far?
> >
> > KHO is going to be discussed at the upcoming lsfmm, we are also
> > planning to send v5 of this patch series (discussed with Mike
> > Rapoport) in a couple of weeks. It will include enhancements needed
> > for the hypervisor live update scenario:
>
> So is this V4 still a RFC if v5 will be sent by plan? Should we hold the
> reviewing until v5? Or this series is a infrustructure building, v5 will
> add more details as you listed as below. I am a little confused.

We will modify the existing patches and send as v5 because some
interfaces are going to be changed*.

Otherwise, v5 will make KHO a lot more flexible as it will allow to
use the tree all the time while the system is running instead of only
once during the activation phase.

* Changing interfaces  is optional, but decision whether to change
will be discussed at Hypervisor Live Update on Feb 10th:
https://lore.kernel.org/all/26a4b7ca-93a6-30e2-923b-f551ced03d62@google.com=
/

>
> >
> > 1. Allow nodes to be added to the KHO tree at any time
> > 2. Remove "activate" (I will also send a live update framework that
> > provides the activate functionality).
> > 3. Allow serialization during shutdown.
> > 4. Decouple KHO from kexec_file_load(), as kexec_file_load() should
> > not be used during live update blackout time.
> > 5. Enable multithreaded serialization by using hash-table as an
> > intermediate step before conversion to FDT.
>

