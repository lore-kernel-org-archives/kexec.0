Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Mtjdl-0006CG-Du
	for kexec@lists.infradead.org; Fri, 02 Oct 2009 15:01:54 +0000
Date: Fri, 02 Oct 2009 23:01:41 +0800 (CST)
Message-Id: <20091002.230141.35229507.caiqian@redhat.com>
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
From: CAI Qian <caiqian@redhat.com>
In-Reply-To: <394279530.1283331254493445641.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
References: <667155093.1283251254493414370.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<394279530.1283331254493445641.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: anderson@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, nhorman@redhat.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, caiqian@redhat.com

From: Dave Anderson <anderson@redhat.com>
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
Date: Fri, 2 Oct 2009 10:24:05 -0400 (EDT)

> 
> ----- "Dave Anderson" <anderson@redhat.com> wrote:
> 
>> ----- "CAI Qian" <caiqian@redhat.com> wrote:
>> 
>> > From: CAI Qian <caiqian@redhat.com>
>> > Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
>> > Date: Fri, 02 Oct 2009 19:26:44 +0800 (CST)
>> >
>> > > Cced the crash utility maintainer.
>> > >
>> > > BZ filed -- https://bugzilla.redhat.com/show_bug.cgi?id=526749
>> > >
>> > >> It does make -d 16 works without errors. However, the crash utility
>> > >> failed to read it (the log attached), but the full VMCore is working
>> > >> fine there.
>> > >>
>> > >> crash: page excluded: kernel virtual address: ffffffff819f1764 type: "tss_struct ist array"
>> >
>> 
>> I believe that the "tss_struct" issue is a crash bug if in fact it works
>> OK with a full vmcore.  I'll look at the vmlinux/vmcores from the BZ.
> 
> Definitely a crash utility bug -- I'll fix it in the next upstream release.
> 
> Dave
> 

After applied the patch, the problem has gone, and I can analyze the
VMCore without any problem so far.

Thanks Ken'ichi and Dave for the fixes!
CAI Qian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
