Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5039CCA0EDB
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=emH/9/qIpMML7VwyXCdOqP+butuG+Y1J3ry+obz5qAU=; b=pq3AGDWcTB2tvARwwyZBViop7d
	piNUwjpqcRF4QM9UrF19zYyyFsc4hVUbKfQcGSiQjzUOU/HsjxBC/eEaP0pJ0mcdmJe+CsPQg5brR
	gFygH+ujCgTfjTKhTqO3kcFc0rxstqHLpU7Aj0paqb2qO8dPsf0MW2kxJArmfO4abFX4whlgWht5p
	E2M71FMkxVpKZ+UPbyMUNyfbzgfc1A+t7VK+Eyd0aEUb8EDmFRU2eyXfAO/TcojAMnWEpSUvnT4HJ
	oG+9HLUufSlBdOGdkyAsvlQi6m9Zz+duxGn7JCWOjOuXeMeRcxy5WkBiy5EsyC8zOiagEz47Wprws
	TOZtNhVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulufy-0000000Bqie-2MJE;
	Tue, 12 Aug 2025 19:28:50 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulsaW-0000000BWrA-3suI
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 17:15:06 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3b8de193b60so3238089f8f.0
        for <kexec@lists.infradead.org>; Tue, 12 Aug 2025 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018903; x=1755623703; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emH/9/qIpMML7VwyXCdOqP+butuG+Y1J3ry+obz5qAU=;
        b=nJUTUBXXMStAODrXNBq0mD5bi8D23VGCqsHGHTUCRMuQLrSyS2XxibyO2nMqytq7j9
         J8ut5GWBx8+oaDzNDN/zVd4qFAB+VXyWiK+JLUJtWglRTPyprvojRizo/qnxrfOhHATj
         nZ5/zmg3Yy4vEbrbnxIrtIQs8EZvDw9G/gZFKvE1VDmzCCGPep6OC7QLs13ald4YFTG7
         IT/VtfBYKf6TB/dVoY8GbF/cER66xpK5vp+Xj7mnD4LNcxr7EmP7/+2Tt/rzL7RrzgDA
         3RndCT3EPQyX5uicxKw8dkGhptxaTWG2gtdse6865EVGYbadIyjEaK9hEFqtZe61vzii
         J1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018903; x=1755623703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emH/9/qIpMML7VwyXCdOqP+butuG+Y1J3ry+obz5qAU=;
        b=JxaghmZG/vTqVGvqYwGEYlZlgo2WV/TzUjlZADcvXxhHj//u5OcjotK25VkJ6MYZ2R
         m6szuFRmsVbKZewIklrsGRjALIaqFHr1cF677n+v5ih1pF1k/mSo2mxWhzu5bWyhO+Ny
         mB2m4oq8ZLN2/4sZ8Ytp5JUj9+/m/Mo2qK39hvD+LAvd2Or+jGQy3XARl4bFUCJayKRn
         ItdVleXjzV1cxxX7ejQJcTmOMSUjmZpnzFSHrjaPgvcbR7IIbG1tTEiMTzj9XNWnk4Cv
         nQTQtWYIkfg0+Q0EQuwUOIl4gP+ObQUVNh+KOdjsAHp/w9l/bL/kwhQjjWNXTn+nE9Qq
         cvtg==
X-Forwarded-Encrypted: i=1; AJvYcCUtzMjvvmM8ee4+IqhiFBRodWChG2wUWEdWo96wbYk3jDzIIobSSsw3d32LzYxROU2Bth9mzQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw88UlqmqolMvNzAxHRhKnwKmA0A1I8/eXPytz/PNS/flizo6yW
	0x9XV5gSt/chkldc7uy2ba9YzzGUbKC2D7Hug14ZHEL2eXYmqxQOCYNU3cNeDQtWmVGw6g6ztuD
	WuNmA1/VaU56cYnM5nrAc7Q9cvwBDB/o=
X-Gm-Gg: ASbGnctGd12g4iZb+C6uJg5J9ZtylLsEbbzhotkpuw9lsPYI/MjYdQiWoGYEcaYfcPz
	NprVE6i3I5mnXIJLyOdSwWDBZzim4bMw2uWaty0zqlK/eWoBQHvWIoXVJ2p0cIeAaYe7W9iWST0
	j3Pgv7hCynhNEHh4h7QSAj2dFhEnkFsdR64Y1KcUEvAklAqrQ3tpjAh/fXoY+cxaxwnYInUZ6Q7
	Xsh3UbJKg==
X-Google-Smtp-Source: AGHT+IGscrYxQbMP7OG5PufoX/l5kbYx6BXGvLE32aEZsthI+SSXhiJax8zZreBUwk0pOZEPsu00PUEuLZoC4WM5glQ=
X-Received: by 2002:a05:6000:2386:b0:3b7:7489:3ddb with SMTP id
 ffacd0b85a97d-3b91730553amr137411f8f.34.1755018903312; Tue, 12 Aug 2025
 10:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250812124941.69508-1-bhe@redhat.com> <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
In-Reply-To: <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 12 Aug 2025 19:14:52 +0200
X-Gm-Features: Ac12FXxbfIp4CjdMiDbk99JZKDZitEGnh3AeOJx4PqX8F5dQQ1jZuZRm61N9EdU
Message-ID: <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	elver@google.com, snovitoll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_101504_967472_0A93B412 
X-CRM114-Status: GOOD (  22.83  )
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

On Tue, Aug 12, 2025 at 6:57=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Tue, Aug 12, 2025 at 2:49=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote=
:
> >
> > Currently only hw_tags mode of kasan can be enabled or disabled with
> > kernel parameter kasan=3Don|off for built kernel. For kasan generic and
> > sw_tags mode, there's no way to disable them once kernel is built.
> > This is not convenient sometime, e.g in system kdump is configured.
> > When the 1st kernel has KASAN enabled and crash triggered to switch to
> > kdump kernel, the generic or sw_tags mode will cost much extra memory
> > for kasan shadow while in fact it's meaningless to have kasan in kdump
> > kernel.
> >
> > So this patchset moves the kasan=3Don|off out of hw_tags scope and into
> > common code to make it visible in generic and sw_tags mode too. Then we
> > can add kasan=3Doff in kdump kernel to reduce the unneeded meomry cost =
for
> > kasan.
>
> Hi Baoquan,
>
> Could you clarify what are you trying to achieve by disabling
> Generic/SW_TAGS KASAN via command-line? Do you want not to see any
> KASAN reports produced? Or gain back the performance?
>
> Because for the no reports goal, it would be much easier to add a
> command-line parameter to silent the reports.
>
> And the performance goal can only be partially achieved, as you cannot
> remove the compiler instrumentation without rebuilding the kernel.
> (What are the boot times for KASAN_GENERIC=3Dn vs KASAN_GENERIC=3Dy +
> kasan=3Doff vs KASAN_GENERIC=3Dy btw?)
>
> Thank you!

Ah, you don't want the shadow memory for kdump, sorry, I somehow missed tha=
t.

I'm not familiar with the internals of kdump, but would it be
possible/reasonable to teach kdump to ignore the KASAN shadow region?

