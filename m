Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hfWAN-0000pn-VA
 for kexec@lists.infradead.org; Mon, 24 Jun 2019 21:06:21 +0000
Received: by mail-io1-xd41.google.com with SMTP id i10so535056iol.13
 for <kexec@lists.infradead.org>; Mon, 24 Jun 2019 14:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com>
 <20190621064340.GB4528@localhost.localdomain>
 <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
 <20190624015206.GB2976@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190624015206.GB2976@dhcp-128-65.nay.redhat.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 24 Jun 2019 14:06:00 -0700
Message-ID: <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
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
To: Dave Young <dyoung@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Linux API <linux-api@vger.kernel.org>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, LSM List <linux-security-module@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>

On Sun, Jun 23, 2019 at 6:52 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 06/21/19 at 01:18pm, Matthew Garrett wrote:
> > I don't think so - we want it to be possible to load images if they
> > have a valid signature.
>
> I know it works like this way because of the previous patch.  But from
> the patch log "When KEXEC_SIG is not enabled, kernel should not load
> images", it is simple to check it early for !IS_ENABLED(CONFIG_KEXEC_SIG) &&
> kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)  instead of depending
> on the late code to verify signature.  In that way, easier to
> understand the logic, no?

But that combination doesn't enforce signature validation? We can't
depend on !IS_ENABLED(CONFIG_KEXEC_SIG_FORCE) because then it'll
enforce signature validation even if lockdown is disabled.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
