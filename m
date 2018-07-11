Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
References: <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
 <d801005a-5f7a-8fe4-a486-bc6443a406a3@arm.com>
 <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
 <3a05cd0e-466e-4fb6-a78a-4b363e21aaab@arm.com>
 <CACi5LpMJnFthKUJGfMWgDyMTM65oTtOvsRGCtMDjWP32qDptbQ@mail.gmail.com>
 <92ff5220-f863-4edc-bc9f-bd802d2efa9c@arm.com>
 <d5e01f4bedc649ff8a2ee17b17c1c33d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20180619085541.GB13984@arm.com>
 <6860c284f1c74faa95edd6cf866ec80d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20180619094045.GD13984@arm.com>
 <a720d91be20844cd9ed84728268300d9@HXTBJIDCEMVIW02.hxtcorp.net>
 <09260c7e-8b9d-bc3c-5bca-0fd75417f552@arm.com>
 <CACi5LpMoKP4eG5XhYe5hf5VC9MOY8KuHK=j0ujb8GFpyjAuAww@mail.gmail.com>
 <b0d40351-8d78-fd69-cc87-d5ea5eaabd2a@arm.com>
 <CACi5LpM2GV-vwcEGeCE20QW0PVmDcKnjz017sYBAwYRfZ24AzA@mail.gmail.com>
 <51cf54d6a19f4837b74218b000cc23bc@HXTBJIDCEMVIW02.hxtcorp.net>
 <CACi5LpMXpSWUP97R2VWjf==LdxPBCKTcpKjQjCs4j3Kz9SzYGg@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <cb5cf891-cf46-3afc-0c77-6667165caf7a@arm.com>
Date: Wed, 11 Jul 2018 14:24:08 +0100
MIME-Version: 1.0
In-Reply-To: <CACi5LpMXpSWUP97R2VWjf==LdxPBCKTcpKjQjCs4j3Kz9SzYGg@mail.gmail.com>
Content-Language: en-US
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "Jin,
 Yanjiang" <yanjiang.jin@hxt-semitech.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec <kexec-bounces@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Omar Sandoval <osandov@fb.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Bhupesh,

(CC: +Omar)

On 20/06/18 08:26, Bhupesh Sharma wrote:
> On Wed, Jun 20, 2018 at 7:46 AM, Jin, Yanjiang
> <yanjiang.jin@hxt-semitech.com> wrote:
>>> From: Bhupesh Sharma [mailto:bhsharma@redhat.com]
>>> On Tue, Jun 19, 2018 at 4:56 PM, James Morse <james.morse@arm.com> wrote:
>>>> I'm suggesting adding the contents of vmcoreinfo as a PT_NOTE section
>>>> of /proc/kcore's ELF header. No special knowledge necessary, any
>>>> elf-parser should be able to dump the values.

[..]
>>> I am working on fixes on the above lines for kernel and user-space tools (like
>>> makedumpfile, crash-utility and kexec-tools).
>>>
>>> I will post some RFC patches on the same lines (or come back in case I get stuck
>>> somewhere) shortly.

I spotted this series from Omar:
https://lkml.org/lkml/2018/7/6/866

Hopefully it does what you need?


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
