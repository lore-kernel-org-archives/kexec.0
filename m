Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVnSF-00CwQg-Gs
 for kexec@lists.infradead.org; Thu, 30 Sep 2021 04:13:56 +0000
Received: by mail-lf1-x12e.google.com with SMTP id i4so19820388lfv.4
 for <kexec@lists.infradead.org>; Wed, 29 Sep 2021 21:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210929124900.GE21631@willie-the-truck>
In-Reply-To: <20210929124900.GE21631@willie-the-truck>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 30 Sep 2021 00:13:17 -0400
Message-ID: <CA+CK2bB+9LWNKYoFWpSTuJLEtf6Hcp7cBu95eLRAw3quoCucXw@mail.gmail.com>
Subject: Re: [PATCH v17 00/15] arm64: MMU enabled kexec relocation
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
Cc: James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Selin Dag <selindag@gmail.com>, Tyler Hicks <tyhicks@linux.microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com

On Wed, Sep 29, 2021 at 8:49 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Sep 16, 2021 at 07:13:10PM -0400, Pasha Tatashin wrote:
> > Changelog:
> > v17:
> >       - Merged with 5.15-rc1 as requested by Catalin Marinas
> >       - Added Tested-by: Pingfan Liu <piliu@redhat.com>
>
> This looks pretty good to me. I've left some minor comments on a few of the
> patches, but other than those I'd like to try getting these queued for
> 5.16.

Thanks Will, I will send the updated series tomorrow.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
