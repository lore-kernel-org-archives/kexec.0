Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mL49N-002Ped-75
 for kexec@lists.infradead.org; Tue, 31 Aug 2021 13:50:09 +0000
Received: by mail-ed1-x529.google.com with SMTP id j13so21583427edv.13
 for <kexec@lists.infradead.org>; Tue, 31 Aug 2021 06:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210616085118.1141101-1-omosnace@redhat.com>
 <CAHC9VhSr2KpeBXuyoHR3_hs+qczFUaBx0oCSMfBBA5UNYU+0KA@mail.gmail.com>
 <CAFqZXNvJtMOfLk-SLt2S2qt=+-x8fm9jS3NKxFoT0_5d2=8Ckg@mail.gmail.com>
In-Reply-To: <CAFqZXNvJtMOfLk-SLt2S2qt=+-x8fm9jS3NKxFoT0_5d2=8Ckg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 31 Aug 2021 09:49:50 -0400
Message-ID: <CAHC9VhRdh0uTBur8PHOR4bL38rQozatO7J2fwEzZiLwRXLL7fg@mail.gmail.com>
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
Cc: Linux Security Module list <linux-security-module@vger.kernel.org>, James Morris <jmorris@namei.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, bpf <bpf@vger.kernel.org>, network dev <netdev@vger.kernel.org>, kexec@lists.infradead.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Michael Ellerman <mpe@ellerman.id.au>

On Tue, Aug 31, 2021 at 5:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Can we move this forward somehow, please?

As mentioned previously, I can merge this via the SELinux tree but I
need to see some ACKs from the other subsystems first, not to mention
some resolution to the outstanding questions.

-- 
paul moore
www.paul-moore.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
