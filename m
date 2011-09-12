Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R3BBj-00064O-Da
	for kexec@lists.infradead.org; Mon, 12 Sep 2011 18:25:00 +0000
Date: Mon, 12 Sep 2011 14:24:50 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <682646784.634954.1315851890438.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20110906154452.GA18186@in.ibm.com>
Subject: Re: makedumpfile: Add erased information in compressed kdump file
	and ELF formatted dumpfile
MIME-Version: 1.0
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
To: mahesh@linux.vnet.ibm.com
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

Now that this feature is in makedumpfile-1.4.0, I presume that you
have crash utility "warning" patches underway?

Also, can you confirm that compressed or kdumps with (or without)
eraseinfo data can still be handled with no problem by the current
version of the crash utility?  I'm not talking about the ramifications
of whatever kernel data may have been erased, but whether the changes to
the dumpfile headers could cause a problem.  I'm presuming that the
compressed kdump eraseinfo data would be invisible to an older version
of crash, and that ELF kdump eraseinfo would just show up as an (unused)
ELF note -- but I just want to make sure. 

Thanks,
  Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
