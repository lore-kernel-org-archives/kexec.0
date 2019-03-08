Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h2JfH-0002CQ-35
 for kexec@lists.infradead.org; Fri, 08 Mar 2019 17:52:12 +0000
Received: by mail-it1-x143.google.com with SMTP id 188so22576127itb.0
 for <kexec@lists.infradead.org>; Fri, 08 Mar 2019 09:52:10 -0800 (PST)
MIME-Version: 1.0
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
 <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
 <1551998897.31706.461.camel@linux.ibm.com>
 <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
 <1552052377.4134.23.camel@linux.ibm.com>
In-Reply-To: <1552052377.4134.23.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 8 Mar 2019 09:51:57 -0800
Message-ID: <CACdnJut3Y7CogvgtNsEcrEtA1WOxSb9OWP_wZ=3xNgCft2oeDw@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
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
Cc: linux-efi <linux-efi@vger.kernel.org>, Nayna Jain <nayna@linux.ibm.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Seth Forshee <seth.forshee@canonical.com>, LSM List <linux-security-module@vger.kernel.org>, Justin Forbes <jforbes@redhat.com>, linux-integrity <linux-integrity@vger.kernel.org>

On Fri, Mar 8, 2019 at 5:40 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2019-03-07 at 14:50 -0800, Matthew Garrett wrote:
> > Is the issue that it gives incorrect results on the first read, or is
> > the issue that it gives incorrect results before ExitBootServices() is
> > called? If the former then we should read twice in the boot stub, if
> > the latter then we should figure out a way to do this immediately
> > after ExitBootServices() instead.
>
> Detecting the secure boot mode isn't the problem.  On boot, I am
> seeing "EFI stub: UEFI Secure Boot is enabled", but setup_arch() emits
> "Secure boot could not be determined".
>
> In efi_main() the secure_boot mode is initially unset, so
> efi_get_secureboot() is called.  efi_get_secureboot() returns the
> secure_boot mode correctly as enabled.  The problem seems to be in
> saving the secure_boot mode for later use.

Hm. And this only happens on certain firmware versions? If something's
stepping on boot_params then we have bigger problems.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
