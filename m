Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHELR-000c2D-4H
 for kexec@lists.infradead.org; Tue, 02 Mar 2021 23:22:26 +0000
Received: by mail-pl1-x634.google.com with SMTP id d11so12937093plo.8
 for <kexec@lists.infradead.org>; Tue, 02 Mar 2021 15:22:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20210302081909.GA28599@MiWiFi-R3L-srv>
References: <20210301174749.1269154-1-swboyd@chromium.org>
 <20210301174749.1269154-8-swboyd@chromium.org>
 <20210302081909.GA28599@MiWiFi-R3L-srv>
Subject: Re: [PATCH 7/7] kdump: Use vmlinux_build_id() to simplify
From: Stephen Boyd <swboyd@chromium.org>
Date: Tue, 02 Mar 2021 15:21:15 -0800
Message-ID: <161472727569.1478170.5291979496668341424@swboyd.mtv.corp.google.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Quoting Baoquan He (2021-03-02 00:19:09)
> On 03/01/21 at 09:47am, Stephen Boyd wrote:
> > -                             note_sec->n_hdr.n_descsz,
> > -                             BUILD_ID_MAX);
> > -                     return;
> > -             }
> > -             n_remain -= sizeof(struct elf_note) +
> > -                     ALIGN(note_sec->n_hdr.n_namesz, 4) +
> > -                     ALIGN(note_sec->n_hdr.n_descsz, 4);
> > +     const char *build_id = vmlinux_build_id();
> 
> It's strange that I can only see the cover letter and this patch 7,
> couldn't find the patch where vmlinux_build_id() is introduced in lkml.
> 

Hmm not sure. Maybe spam stuff? I will Cc you on the first patch for v2.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
