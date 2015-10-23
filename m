Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZplC6-00014k-A7
 for kexec@lists.infradead.org; Fri, 23 Oct 2015 22:52:18 +0000
Received: from zmail15.collab.prod.int.phx2.redhat.com
 (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
 by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id t9NMptLe012050
 for <kexec@lists.infradead.org>; Fri, 23 Oct 2015 18:51:55 -0400
Date: Fri, 23 Oct 2015 18:51:55 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1614308760.81805248.1445640715281.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.119.1445632877.1639.kexec@lists.infradead.org>
References: <mailman.119.1445632877.1639.kexec@lists.infradead.org>
Subject: Re: [PATCH V6] makedumpfile: exclude page structures of non-dumped
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
                                 done)
> 
> The only disadvantage is that various options of the crash 'kmem' command that
> walk lists of page structures) will not work.
> Version 7.0.9 of crash is already patched to issue a warning about such commands
> when the dump is flagged DUMP_DH_EXCLUDED_VMEMMAP.

No it does not.  

There is a warning if the dumpfile is marked DUMP_DH_COMPRESSED_INCOMPLETE,
but it will not recognize missing page structures.  Please remember to post
a patch to the crash utility mailing list to support DUMP_DH_EXCLUDED_VMEMMAP.

Thanks,
  Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
