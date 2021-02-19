Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDB7O-0004t3-Ti
 for kexec@lists.infradead.org; Fri, 19 Feb 2021 19:07:12 +0000
Received: by mail-ej1-x634.google.com with SMTP id jt13so15565678ejb.0
 for <kexec@lists.infradead.org>; Fri, 19 Feb 2021 11:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20210215185908.257724-1-pasha.tatashin@soleen.com>
 <20210215185908.257724-2-pasha.tatashin@soleen.com>
 <20210219175341.GC6352@willie-the-truck>
In-Reply-To: <20210219175341.GC6352@willie-the-truck>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 19 Feb 2021 14:06:31 -0500
Message-ID: <CA+CK2bBpXyobT=rjVtY_pFhug4RcveGk_XB4zDBTX=vZBOkaLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kexec: move machine_kexec_post_load() to public
 interface
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
Cc: kexec mailing list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, Tyler Hicks <tyhicks@linux.microsoft.com>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Feb 19, 2021 at 12:53 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Feb 15, 2021 at 01:59:08PM -0500, Pavel Tatashin wrote:
> > machine_kexec_post_load() is called after kexec load is finished. It must
> > be declared in public header not in kexec_internal.h
>
> Could you provide a log of what goes wrong without this patch, please?
>
> > Reported-by: kernel test robot <lkp@intel.com>
>
> Do you have a link to the report, or did it not go to the list?

Hi Will,

https://lore.kernel.org/linux-arm-kernel/202102030727.gqTokACH-lkp@intel.com/

It is also linked in the cover letter.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
