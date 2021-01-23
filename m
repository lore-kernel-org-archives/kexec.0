Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l36i7-00005H-Ep
 for kexec@lists.infradead.org; Sat, 23 Jan 2021 00:23:28 +0000
Received: by mail-ed1-x531.google.com with SMTP id n6so8518455edt.10
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2021 16:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-6-pasha.tatashin@soleen.com>
 <d19f4bc5-ad5b-5dad-0d50-271817b6c9aa@arm.com>
In-Reply-To: <d19f4bc5-ad5b-5dad-0d50-271817b6c9aa@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 22 Jan 2021 19:22:50 -0500
Message-ID: <CA+CK2bB41z-0+KDHmwbgpS8x071B69asP9dfN4oU=ME6GqNs2w@mail.gmail.com>
Subject: Re: [PATCH v9 05/18] arm64: trans_pgd: pass NULL instead of init_mm
 to *_populate functions
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, rfontana@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Selin Dag <selindag@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

> Acked-by: James Morse <james.morse@arm.com>

Thank you for the review.
Pasha

>
>
> Thanks,
>
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
