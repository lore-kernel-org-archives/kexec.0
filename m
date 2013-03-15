Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGZmo-0005jA-9o
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 18:55:26 +0000
Date: Fri, 15 Mar 2013 14:55:24 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <403993482.8327924.1363373724432.JavaMail.root@redhat.com>
In-Reply-To: <20130315150754.GA12758@debian70-amd64.local.net-space.pl>
Subject: Re: [PATCH 0/2] crash: Bundle of fixes for Xen
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org, crash-utility@redhat.com



----- Original Message -----
> Hi,
> 
> Here is next bundle of fixes for crash Xen support:
>   - xen: Improve calculation of beginning of virtual address space,
>   - xen: Fix console buffer content length calculation.
> 
> All patches were tested with Xen versions up to latest unstable.
> 
> Daniel
> 

Works for me -- queued for crash-6.1.5.

Thanks,
  Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
