Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dGndE-0005WS-BQ
 for kexec@lists.infradead.org; Fri, 02 Jun 2017 14:32:53 +0000
Received: by mail-pf0-f177.google.com with SMTP id n23so49670581pfb.2
 for <kexec@lists.infradead.org>; Fri, 02 Jun 2017 07:32:31 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
References: <cover.1495514291.git.panand@redhat.com> <59312080.1090906@arm.com>
 <CAKv+Gu--N4Pef6z=G4ePTgF3CcKhmmSfrvJBY-5p0CLL_PZ=3Q@mail.gmail.com>
 <CAFTCetS17w0-BJJzTfi8uNS67xos4MwJz3R=qdz2Oe7+fcXk3g@mail.gmail.com>
 <CAKv+Gu86EEFzVzG4h0f6sBk=ar4Ffv_KuNhyKNi_Zf7k3KvWcg@mail.gmail.com>
 <CAKv+Gu-0p6iWnY9fr67YrYUgiLwArwkNUKio-7XjT0uMafcQ-w@mail.gmail.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <2b80fca3-b462-a1b5-36db-e8b8b8fdc126@redhat.com>
Date: Fri, 2 Jun 2017 20:02:25 +0530
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-0p6iWnY9fr67YrYUgiLwArwkNUKio-7XjT0uMafcQ-w@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, James Morse <james.morse@arm.com>, Dave Young <dyoung@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Ard,

Thanks for all the inputs.

On Friday 02 June 2017 05:14 PM, Ard Biesheuvel wrote:
>> Alternatively, a SHA-256 implementation that uses movz/movk sequences
>> instead of ldr instructions to load the round constants would already
>> be 5x faster, given that we don't need page tables to enable the
>> I-cache.
> Actually, looking at the C code and the objdump of the kernel's
> sha256_generic driver, it is likely that it is already doing this, and
> none of the points I made actually make a lot of sense ...
>
> Pratyush: I assume you are already enabling the I-cache in the purgatory?

It's not enabled yet. But, I had tried first with enabling only I-cache, but 
that did not make much difference in execution time.

~Pratyush



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
