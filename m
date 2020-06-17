Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlLbr-0004am-Rd
 for kexec@lists.infradead.org; Wed, 17 Jun 2020 00:07:21 +0000
Received: by mail-lf1-x141.google.com with SMTP id d7so167266lfi.12
 for <kexec@lists.infradead.org>; Tue, 16 Jun 2020 17:07:18 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com.
 [209.85.208.171])
 by smtp.gmail.com with ESMTPSA id 144sm2980329lfm.87.2020.06.16.17.07.15
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 17:07:15 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id y11so641370ljm.9
 for <kexec@lists.infradead.org>; Tue, 16 Jun 2020 17:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkggDJEC4W9V6ijmPoE0-soKE7zBUWUiDLdCZArEsDo9vrQ@mail.gmail.com>
 <20200616222547.1979233-1-nivedita@alum.mit.edu>
In-Reply-To: <20200616222547.1979233-1-nivedita@alum.mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jun 2020 17:06:59 -0700
Message-ID: <CAHk-=wj_1mQmG5H4ZVcNudjhQyxTNTtni6hV1nTkEY2QQJzgAg@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: Add -fno-stack-protector
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
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Gabriel C <nix.or.die@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Borislav Petkov <bp@alien8.de>

On Tue, Jun 16, 2020 at 3:25 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> The purgatory Makefile removes -fstack-protector options if they were
> configured in, but does not currently add -fno-stack-protector.

I took this directly, since the build failure seems so annoying if you
happen to have an affected compiler and config.

Maybe that's not very common, but ..

              Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
