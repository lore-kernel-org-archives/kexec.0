Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fEL1O-0008Ub-IH
 for kexec@lists.infradead.org; Thu, 03 May 2018 20:40:12 +0000
Received: by mail-it0-x243.google.com with SMTP id 144-v6so842118iti.5
 for <kexec@lists.infradead.org>; Thu, 03 May 2018 13:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87r2mso5up.fsf@xmission.com>
In-Reply-To: <87r2mso5up.fsf@xmission.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 03 May 2018 20:39:48 +0000
Message-ID: <CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
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
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, LSM List <linux-security-module@vger.kernel.org>, linux-integrity <linux-integrity@vger.kernel.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>

On Thu, May 3, 2018 at 1:13 PM Eric W. Biederman <ebiederm@xmission.com>
wrote:

> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> > In environments that require the kexec kernel image to be signed,
prevent
> > using the kexec_load syscall.  In order for LSMs and IMA to
differentiate
> > between kexec_load and kexec_file_load syscalls, this patch set adds a
> > call to security_kernel_read_file() in kexec_load_check().

> Having thought about it some more this justification for these changes
> does not work.  The functionality of kexec_load is already root-only.
> So in environments that require the kernel image to be signed just don't
> use kexec_load.  Possibly even compile kexec_load out to save space
> because you will never need it.  You don't need a new security hook to
> do any of that.  Userspace is a very fine mechanism for being the
> instrument of policy.

> If you don't trust userspace that needs to be spelled out very clearly.
> You need to talk about what your threat models are.

kexec_load gives root arbitrary power to modify the running kernel image,
including the ability to disable enforcement of module signatures. Given
that it weakens other security mechanisms that are designed to prevent root
from disabling them, it makes sense to allow the imposition of an
equivalent restriction.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
