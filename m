Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXl6j-00AnWS-IS
 for kexec@lists.infradead.org; Tue, 05 Oct 2021 14:07:51 +0000
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7E4BC3F31E
 for <kexec@lists.infradead.org>; Tue,  5 Oct 2021 14:07:45 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id
 d11-20020a50cd4b000000b003da63711a8aso20676451edj.20
 for <kexec@lists.infradead.org>; Tue, 05 Oct 2021 07:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
In-Reply-To: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
From: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date: Tue, 5 Oct 2021 16:07:27 +0200
Message-ID: <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Nick Kossifidis <mick@ics.forth.gr>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org, linux-riscv <linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Alexandre ghiti <alex@ghiti.fr>, rppt@kernel.org, geert+renesas@glider.be, Stephano Cetola <scetola@linuxfoundation.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>

On Tue, Oct 5, 2021 at 2:15 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> Hello all,
>
> I've uploaded my kexec-tools patches for riscv on github for
> testing/review before sending them upstream.
> https://github.com/riscv-collab/kexec-tools/tree/riscv
>
> Both kexec and kdump were tested on latest rv64 qemu, using for-next
> branch with this patch applied:
> https://patchwork.kernel.org/project/linux-riscv/patch/20211002122026.1451269-1-mick@ics.forth.gr/
>

I'll test that asap and review your patch too.

Thanks for your time Nick!

Alex

> Regards,
> Nick
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
