Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3QTM-0007f6-2o
 for kexec@lists.infradead.org; Mon, 11 Mar 2019 19:20:29 +0000
Received: by mail-io1-xd42.google.com with SMTP id b6so5121272iog.0
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2019 12:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
 <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
 <1551998897.31706.461.camel@linux.ibm.com>
 <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
 <1552052377.4134.23.camel@linux.ibm.com>
 <CACdnJut3Y7CogvgtNsEcrEtA1WOxSb9OWP_wZ=3xNgCft2oeDw@mail.gmail.com>
 <1552323292.6100.45.camel@linux.ibm.com>
In-Reply-To: <1552323292.6100.45.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 11 Mar 2019 12:20:11 -0700
Message-ID: <CACdnJustD1fvBYsE=zHE85ZSrKwpArW=_jhRDyhDngdDRNOXJA@mail.gmail.com>
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

On Mon, Mar 11, 2019 at 9:55 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Fri, 2019-03-08 at 09:51 -0800, Matthew Garrett wrote:
> > Hm. And this only happens on certain firmware versions? If something's
> > stepping on boot_params then we have bigger problems.
>
> I was seeing this problem before and after updating the system
> firmware on my laptop last summer.  If updating the firmware had
> resolved the problem, I wouldn't have included this patch.

Ah, sorry, when you said that you saw this with older firmware I
thought that meant that newer firmware fixed it. What machine are you
testing on?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
