Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKRr1-0005PG-IF
 for kexec@lists.infradead.org; Tue, 15 Oct 2019 18:47:33 +0000
Received: by mail-ed1-x544.google.com with SMTP id c4so19023149edl.0
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2019 11:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
 <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
 <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
 <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
In-Reply-To: <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 15 Oct 2019 14:47:18 -0400
Message-ID: <CA+CK2bBVcE91YbJx1f_BkNqbD03wGLNtyane7PjCnEu8i_cH2Q@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, jean-philippe@linaro.org, arnd@arndb.de, Masahiro Yamada <yamada.masahiro@socionext.com>, sboyd@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, zohar@linux.ibm.com, prsriva <prsriva@linux.microsoft.com>, takahiro.akashi@linaro.org, duwe@lst.de, bauerman@linux.ibm.com, allison@lohutok.net, linux-integrity@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>

> I think the UEFI persistent-memory-reservations thing is a better fit for this [0][1].

Hi James,

Thank you for your thought. As I understand you propose the to use the
existing method as such:
1. Use the existing kexec ABI to pass reservation from kernel to
kernel using EFI the same as is done for GICv3 tables.
2. Allow this memory to be reservable only during first Linux boot via
EFI memory reserve
3. Allow to have this memory pre-reserved by firmware or to be
embedded into device tree.

A question I have is how to tell that a reserved region is reserved
for IMA use. With GICv3 it is done by reading the registers, finding
the interrupt tables memory, and check that the memory ranges are
indeed pre-reserved.

Is there a way to name memory with the current ABI that you think is acceptable?

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
