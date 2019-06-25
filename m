Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hfYv5-0003NG-SH
 for kexec@lists.infradead.org; Tue, 25 Jun 2019 00:02:45 +0000
Received: by mail-io1-xd41.google.com with SMTP id j6so47951ioa.5
 for <kexec@lists.infradead.org>; Mon, 24 Jun 2019 17:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com>
 <20190621064340.GB4528@localhost.localdomain>
 <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
 <20190624015206.GB2976@dhcp-128-65.nay.redhat.com>
 <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
 <1561411657.4340.70.camel@linux.ibm.com>
In-Reply-To: <1561411657.4340.70.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 24 Jun 2019 17:02:29 -0700
Message-ID: <CACdnJuvE-MbD42AJTrio=0RaN8SaWo-RHHt21z=3an1vtjTFhA@mail.gmail.com>
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
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Linux API <linux-api@vger.kernel.org>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, LSM List <linux-security-module@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Dave Young <dyoung@redhat.com>

On Mon, Jun 24, 2019 at 2:27 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> I agree with Dave.  There should be a stub lockdown function to
> prevent enforcing lockdown when it isn't enabled.

Sorry, when what isn't enabled? If no LSMs are enforcing lockdown then
the check will return 0. The goal here is for distributions to be able
to ship a kernel that has CONFIG_KEXEC_SIG=y, CONFIG_KEXEC_SIG_FORCE=n
and at runtime be able to enforce a policy that requires signatures on
kexec payloads.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
