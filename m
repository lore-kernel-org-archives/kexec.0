Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kqtav-00041J-Qe
	for kexec@lists.infradead.org; Fri, 17 Oct 2008 17:58:38 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m9HHwbQu026549
	for <kexec@lists.infradead.org>; Fri, 17 Oct 2008 13:58:37 -0400
Received: from mail02.corp.redhat.com (zmail02.collab.prod.int.phx2.redhat.com
	[10.5.5.42])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m9HHwbMt024352
	for <kexec@lists.infradead.org>; Fri, 17 Oct 2008 13:58:37 -0400
Date: Fri, 17 Oct 2008 13:58:36 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1101712308.1611161224266316866.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
In-Reply-To: <964791790.1610871224266288310.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
Subject: kexec/kdump produces incomplete dump files with kernel 2.6.20 +
	CONFIG_HIGHMEM64G
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>


> Well, without following the thread, I had a similar error and in my
> case it was that PAE was missing in the capture kernel. That's why I
> asked. I think that is wrong here, but I still wanted to mention that
> case (and I don't have time to read all the mails related to that topic
> in the crash mailing list, sorry).
>
> Regards,
> Bernhard

Well that makes perfect sense -- the upper bit gets stripped in
the 32-bit PTE and the wrong location gets mapped.  I was looking
at the fs/vmcore.c code for something to that effect, and I just
presumed his capture kernel was PAE.  Looking back at the thread,
the only thing I see is this:

  "my "capture kernel" is just the standard Ubuntu kernel
   (with 1G kernel / 3G user)."

Whatever that means... 

So Kevin, that's the first thing to check.

Thanks Bernhard,
  Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
