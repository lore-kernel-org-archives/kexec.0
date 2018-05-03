Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fEN4R-0004dh-4O
 for kexec@lists.infradead.org; Thu, 03 May 2018 22:51:28 +0000
Received: by mail-it0-x242.google.com with SMTP id t7-v6so3292506itf.0
 for <kexec@lists.infradead.org>; Thu, 03 May 2018 15:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87r2mso5up.fsf@xmission.com>
 <CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
 <876044l7tr.fsf@xmission.com>
In-Reply-To: <876044l7tr.fsf@xmission.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 03 May 2018 22:51:05 +0000
Message-ID: <CACdnJut4R-BQCYcT5_OuFezf8046-HmvvdEP4g7=ADgAW+qdeA@mail.gmail.com>
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

On Thu, May 3, 2018 at 2:59 PM Eric W. Biederman <ebiederm@xmission.com>
wrote:

> Matthew Garrett <mjg59@google.com> writes:
> > kexec_load gives root arbitrary power to modify the running kernel
image,
> > including the ability to disable enforcement of module signatures.

> No.  It does absolutely nothing to the running kernel image.
> Combined with reboot(..., LINUX_REBOOT_CMD_KEXE, ...) it does allow
> booting something different.  It is argubably a little more efficient
> than writing to a file to direct the bootloader to boot something
> different and then calling reboot.  But it is not fundamentally
> different.

It absolutely does - https://mjg59.dreamwidth.org/28746.html gives an
example. The payload just needs to return.

> > Given
> > that it weakens other security mechanisms that are designed to prevent
root
> > from disabling them, it makes sense to allow the imposition of an
> > equivalent restriction.

> Say what.  You are saying a lot of words without any specifics.  Not a
> specific threat mode.  Not which security mecahnisms you are worried
> about weakening.  Not what classes of problems you are trying to defend
> against.

I have a kernel configured with module.sig_enforce enabled - root is unable
to load kernel modules that are unsigned, and since sig_enforce is
bool_enable_only, root is unable to flip that back. Any number of security
models may be implemented with that assumption. However, root still has
access to kexec_load(), and can therefore kexec into a dummy payload that
flips that byte back to 0 and permits loading unsigned module code.

There may well be other mechanisms that permit root to gain arbitrary
ability to modify kernel code. My argument is that we should treat those as
bugs, not use their existence as a justification for leaving open known
cases.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
