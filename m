Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R3R0K-0006zu-4F
	for kexec@lists.infradead.org; Tue, 13 Sep 2011 11:18:17 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
	Tue, 13 Sep 2011 12:14:32 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8DBF7dl1048608
	for <kexec@lists.infradead.org>; Tue, 13 Sep 2011 21:15:07 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8DBGnEX026836
	for <kexec@lists.infradead.org>; Tue, 13 Sep 2011 21:16:49 +1000
Message-ID: <4E6F3B9D.7060305@linux.vnet.ibm.com>
Date: Tue, 13 Sep 2011 16:46:45 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: makedumpfile: Add erased information in compressed kdump file
	and ELF formatted dumpfile
References: <682646784.634954.1315851890438.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <682646784.634954.1315851890438.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Reinhard <BUENDGEN@de.ibm.com>

On 09/12/2011 11:54 PM, Dave Anderson wrote:
> 
> Hi Mahesh,
> 
> Now that this feature is in makedumpfile-1.4.0, I presume that you
> have crash utility "warning" patches underway?

Yup. I am working on it, will post the patches very soon.

> 
> Also, can you confirm that compressed or kdumps with (or without)
> eraseinfo data can still be handled with no problem by the current
> version of the crash utility?  I'm not talking about the ramifications
> of whatever kernel data may have been erased, but whether the changes to
> the dumpfile headers could cause a problem.  I'm presuming that the
> compressed kdump eraseinfo data would be invisible to an older version
> of crash, and that ELF kdump eraseinfo would just show up as an (unused)
> ELF note -- but I just want to make sure. 

Yes. The changes to dumpfile header and addition of eraseinfo data/ELF
note will not cause any problems with older crash version. With the
current version of crash the ELF kdump eraseinfo note would show up as
below:

Elf64_Nhdr:
               n_namesz: 10 ("ERASEINFO")
               n_descsz: 56
                 n_type: 0 (?)
                         2065736172650000 72616a5f64657263
                         697320656d616e2e 650a36353220657a
                         656e692065736172 736f746f72705f74
                         303120657a697320

Thanks,
-Mahesh.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
