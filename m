Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zm3pn-0007mE-Gn
 for kexec@lists.infradead.org; Tue, 13 Oct 2015 17:58:00 +0000
Received: from zmail15.collab.prod.int.phx2.redhat.com
 (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
 by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9DHvbCS053315
 for <kexec@lists.infradead.org>; Tue, 13 Oct 2015 13:57:37 -0400
Date: Tue, 13 Oct 2015 13:57:36 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <919387907.71013933.1444759056336.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.7843.1444755674.1751.kexec@lists.infradead.org>
References: <mailman.7843.1444755674.1751.kexec@lists.infradead.org>
Subject: Re: [PATCH V5] makedumpfile: exclude page structures of non-dumped
 pages
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

----- Original Message -----
> 
> Applies to the development branch as of 10/13/2015.
> 
> This patch adds a -e option to makedumpfile.
> The -e option excludes kernel pages that contain nothing but kernel page
> structures for pages that are not being included in the dump.

... [ cut ] ...

> 
> The only disadvantage is that various options of the crash 'kmem' command (that
> walk lists of page structures) will not work.
> Version 7.0.9 of crash is already patched to issue a warning about such commands
> when the dump is flagged DUMP_DH_EXCLUDED_VMEMMAP.

Just to clarify -- crash-7.0.9 added support for printing warnings if DUMP_DH_COMPRESSED_INCOMPLETE
is set in compressed kdump dumpfile headers, (and DUMP_ELF_INCOMPLETE flags in kdump ELF headers).
But it will not issue any warnings w/respect to missing page strucures.

You're going to file an associated DUMP_DH_EXCLUDED_VMEMMAP patch to the crash-utility
mailing list if/when this makedumpfile patch gets accepted, correct?

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
