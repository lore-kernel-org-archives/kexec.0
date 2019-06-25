Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hfaXP-0005Qy-QS
 for kexec@lists.infradead.org; Tue, 25 Jun 2019 01:46:25 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5P1fn1c059674
 for <kexec@lists.infradead.org>; Mon, 24 Jun 2019 21:46:22 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tb66urm5u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 24 Jun 2019 21:46:22 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Tue, 25 Jun 2019 02:46:20 +0100
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 24 Jun 2019 21:46:03 -0400
In-Reply-To: <CACdnJuvE-MbD42AJTrio=0RaN8SaWo-RHHt21z=3an1vtjTFhA@mail.gmail.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com>
 <20190621064340.GB4528@localhost.localdomain>
 <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
 <20190624015206.GB2976@dhcp-128-65.nay.redhat.com>
 <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
 <1561411657.4340.70.camel@linux.ibm.com>
 <CACdnJuvE-MbD42AJTrio=0RaN8SaWo-RHHt21z=3an1vtjTFhA@mail.gmail.com>
Mime-Version: 1.0
Message-Id: <1561427163.4340.98.camel@linux.ibm.com>
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
To: Matthew Garrett <mjg59@google.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Linux API <linux-api@vger.kernel.org>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, LSM List <linux-security-module@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Dave Young <dyoung@redhat.com>

On Mon, 2019-06-24 at 17:02 -0700, Matthew Garrett wrote:
> On Mon, Jun 24, 2019 at 2:27 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > I agree with Dave.  There should be a stub lockdown function to
> > prevent enforcing lockdown when it isn't enabled.
> 
> Sorry, when what isn't enabled? If no LSMs are enforcing lockdown then
> the check will return 0. The goal here is for distributions to be able
> to ship a kernel that has CONFIG_KEXEC_SIG=y, CONFIG_KEXEC_SIG_FORCE=n
> and at runtime be able to enforce a policy that requires signatures on
> kexec payloads.

Never mind, the call can't be moved earlier.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
