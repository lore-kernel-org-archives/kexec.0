Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h21of-0008PK-8L
 for kexec@lists.infradead.org; Thu, 07 Mar 2019 22:48:42 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x27MiYnC120562
 for <kexec@lists.infradead.org>; Thu, 7 Mar 2019 17:48:36 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2r3a2sp571-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 07 Mar 2019 17:48:36 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Thu, 7 Mar 2019 22:48:35 -0000
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 07 Mar 2019 17:48:17 -0500
In-Reply-To: <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
 <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
Mime-Version: 1.0
Message-Id: <1551998897.31706.461.camel@linux.ibm.com>
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
To: Matthew Garrett <mjg59@google.com>, Justin Forbes <jforbes@redhat.com>
Cc: linux-efi <linux-efi@vger.kernel.org>, Nayna Jain <nayna@linux.ibm.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Seth Forshee <seth.forshee@canonical.com>, LSM List <linux-security-module@vger.kernel.org>, linux-integrity <linux-integrity@vger.kernel.org>

On Thu, 2019-03-07 at 14:44 -0800, Matthew Garrett wrote:
> On Thu, Mar 7, 2019 at 2:38 PM Justin Forbes <jforbes@redhat.com> wrote:
> > On Thu, Mar 7, 2019 at 4:29 PM Matthew Garrett <mjg59@google.com> wrote:
> >>
> >> On Mon, Nov 19, 2018 at 11:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >> >
> >> > The secure boot mode may not be detected on boot for some reason (eg.
> >> > buggy firmware).  This patch attempts one more time to detect the
> >> > secure boot mode.
> >>
> >> Do we have cases where this has actually been seen? I'm not sure what
> >> the circumstances are that would result in this behaviour.
> >
> >
> > We have never seen it in practice, though we only ever do anything with it with x86, so it is possible that some other platforms maybe?
> 
> I'm not sure that it buys us anything to check this in both the boot
> stub and the running kernel. If a platform *is* giving us different
> results, anything else relying on the information from the boot stub
> is also going to be broken, so we should do this centrally rather than
> in the IMA code.

I added this last attempt because I'm seeing this on my laptop, with
some older, buggy firmware.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
