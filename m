Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h21qQ-0001Qw-7X
 for kexec@lists.infradead.org; Thu, 07 Mar 2019 22:50:31 +0000
Received: by mail-it1-x12d.google.com with SMTP id v2so18036191ith.3
 for <kexec@lists.infradead.org>; Thu, 07 Mar 2019 14:50:28 -0800 (PST)
MIME-Version: 1.0
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
 <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
 <1551998897.31706.461.camel@linux.ibm.com>
In-Reply-To: <1551998897.31706.461.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 7 Mar 2019 14:50:17 -0800
Message-ID: <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
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

On Thu, Mar 7, 2019 at 2:48 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> I added this last attempt because I'm seeing this on my laptop, with
> some older, buggy firmware.

Is the issue that it gives incorrect results on the first read, or is
the issue that it gives incorrect results before ExitBootServices() is
called? If the former then we should read twice in the boot stub, if
the latter then we should figure out a way to do this immediately
after ExitBootServices() instead.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
