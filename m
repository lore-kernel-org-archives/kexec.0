Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vkt3T-00019M-OP
 for kexec@lists.infradead.org; Mon, 25 Nov 2013 10:06:12 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 25 Nov 2013 10:05:49 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 91E2417D805A
 for <kexec@lists.infradead.org>; Mon, 25 Nov 2013 10:05:34 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAPA4J8J66519042
 for <kexec@lists.infradead.org>; Mon, 25 Nov 2013 10:04:19 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAPA4VJF005308
 for <kexec@lists.infradead.org>; Mon, 25 Nov 2013 03:04:31 -0700
Date: Mon, 25 Nov 2013 11:04:28 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
Message-ID: <20131125110428.4bae2fe7@holzheu>
In-Reply-To: <87txf4y304.fsf@xmission.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <8761rl73s7.fsf@xmission.com> <20131122015518.GA31921@redhat.com>
 <87txf4y304.fsf@xmission.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com

On Fri, 22 Nov 2013 05:34:03 -0800
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Vivek Goyal <vgoyal@redhat.com> writes:

> >> There is also a huge missing piece of this in that your purgatory is not
> >> checking a hash of the loaded image before jumping too it.  Without that
> >> this is a huge regression at least for the kexec on panic case.  We
> >> absolutely need to check that the kernel sitting around in memory has
> >> not been corrupted before we let it run very far.
> >
> > Agreed. This should not be hard. It is just a matter of calcualting
> > digest of segments. I will store it in kimge and verify digest again
> > before passing control to control page. Will fix it in next version.
> 
> Nak.  The verification needs to happen in purgatory. 
> 
> The verification needs to happen in code whose runtime environment is
> does not depend on random parts of the kernel.  Anything else is a
> regression in maintainability and reliability.

Hello Vivek,

Just to be sure that you have not forgotten the following s390 detail:

On s390 we first call purgatory with parameter "0" for doing the
checksum test. If this fails, we can have as backup solution our
traditional stand-alone dump. In case tha checksum test was ok,
we call purgatory a second time with parameter "1" which then
starts kdump.

Could you please ensure that this mechanism also works after
your rework.

Best Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
