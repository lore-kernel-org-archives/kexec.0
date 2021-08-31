Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mL4Cv-002Qk4-28
 for kexec@lists.infradead.org; Tue, 31 Aug 2021 13:53:50 +0000
Received: by mail-ed1-x52b.google.com with SMTP id u19so10262731edb.3
 for <kexec@lists.infradead.org>; Tue, 31 Aug 2021 06:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210616085118.1141101-1-omosnace@redhat.com>
 <CAPcyv4jvR8CT4rYODR5KUHNdiqMwQSwJZ+OkVf61kLT3JfjC_Q@mail.gmail.com>
 <CAFqZXNtuH0329Xvcb415Kar-=o6wwrkFuiP8BZ_2OQhHLqkkAg@mail.gmail.com>
In-Reply-To: <CAFqZXNtuH0329Xvcb415Kar-=o6wwrkFuiP8BZ_2OQhHLqkkAg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 31 Aug 2021 09:53:29 -0400
Message-ID: <CAHC9VhTGECM2p+Q8n48aSdfJzY6XrpXQ5tcFurjWc4A3n8Qxjg@mail.gmail.com>
Subject: Re: [PATCH v3] lockdown,selinux: fix wrong subject in some SELinux
 lockdown checks
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
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Linux Security Module list <linux-security-module@vger.kernel.org>, James Morris <jmorris@namei.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, X86 ML <x86@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-cxl@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>

On Tue, Aug 31, 2021 at 5:09 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sat, Jun 19, 2021 at 12:18 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > On Wed, Jun 16, 2021 at 1:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index 2acc6173da36..c1747b6555c7 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -568,7 +568,7 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
> > >         if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
> > >                 return false;
> > >
> > > -       if (security_locked_down(LOCKDOWN_NONE))
> > > +       if (security_locked_down(current_cred(), LOCKDOWN_NONE))
> >
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> >
> > ...however that usage looks wrong. The expectation is that if kernel
> > integrity protections are enabled then raw command access should be
> > disabled. So I think that should be equivalent to LOCKDOWN_PCI_ACCESS
> > in terms of the command capabilities to filter.
>
> Yes, the LOCKDOWN_NONE seems wrong here... but it's a pre-existing bug
> and I didn't want to go down yet another rabbit hole trying to fix it.
> I'll look at this again once this patch is settled - it may indeed be
> as simple as replacing LOCKDOWN_NONE with LOCKDOWN_PCI_ACCESS.

At this point you should be well aware of my distaste for merging
patches that have known bugs in them.  Yes, this is a pre-existing
condition, but it seems well within the scope of this work to address
it as well.

This isn't something that is going to get merged while the merge
window is open, so at the very least you've got almost two weeks to
sort this out - please do that.

-- 
paul moore
www.paul-moore.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
