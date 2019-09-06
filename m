Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6JXR-0006VH-Js
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 19:04:59 +0000
Received: by mail-ed1-x541.google.com with SMTP id i8so7193964edn.13
 for <kexec@lists.infradead.org>; Fri, 06 Sep 2019 12:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-12-pasha.tatashin@soleen.com>
 <d53d973c-17dc-2f4f-c052-83d6df15b002@arm.com>
In-Reply-To: <d53d973c-17dc-2f4f-c052-83d6df15b002@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 6 Sep 2019 15:04:41 -0400
Message-ID: <CA+CK2bCSDEspfJZ9k_4nWmerQSatc9M_dVf4Jij5xUwTMbg29w@mail.gmail.com>
Subject: Re: [PATCH v3 11/17] arm64, trans_pgd: add PUD_SECT_RDONLY
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 6, 2019 at 11:21 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > Thre is PMD_SECT_RDONLY that is used in pud_* function which is confusing.
>
> Nit: There
>
> I bet it was equally confusing before before you moved it! Could you do this earlier in
> the series with the rest of the cleanup?
>
> With that,
> Acked-by: James Morse <james.morse@arm.com>

Will move it earlier.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
