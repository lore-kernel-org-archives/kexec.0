Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4nR7-000289-Eo
 for kexec@lists.infradead.org; Wed, 27 Jan 2021 16:12:55 +0000
Received: by mail-ed1-x535.google.com with SMTP id dj23so3063187edb.13
 for <kexec@lists.infradead.org>; Wed, 27 Jan 2021 08:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
 <161176207403.2744652.12806246618808213171.b4-ty@kernel.org>
In-Reply-To: <161176207403.2744652.12806246618808213171.b4-ty@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 27 Jan 2021 11:12:15 -0500
Message-ID: <CA+CK2bBd-rKQAuxBSrBibdACvJHrrvLtKohjxEuXGciGUknB1g@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 00/18] arm64: MMU enabled kexec relocation
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
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Sasha Levin <sashal@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>, steve.capper@arm.com, Marc Zyngier <maz@kernel.org>, Selin Dag <selindag@gmail.com>, Jonathan Corbet <corbet@lwn.net>, kexec mailing list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, rfontana@redhat.com, Tyler Hicks <tyhicks@linux.microsoft.com>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Catalin Marinas <catalin.marinas@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 27, 2021 at 10:59 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, 25 Jan 2021 14:19:05 -0500, Pavel Tatashin wrote:
> > Changelog:
> > v10:
> >       - Addressed a lot of comments form James Morse and from  Marc Zyngier
> >       - Added review-by's
> >       - Synchronized with mainline
> >
> > [...]
>
> Applied the first 12 patches to arm64 (for-next/kexec), thanks!

Great, thank you. I will resend the rest of the series based on your gate.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
