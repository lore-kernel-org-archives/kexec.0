Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RdjVl-0007Ml-OW
 for kexec@lists.infradead.org; Thu, 22 Dec 2011 14:20:47 +0000
Date: Thu, 22 Dec 2011 09:19:53 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH] crash: s390x: Auto-detect the correct	MAX_PHYSMEM_BITS
 used in vmcore being analyzed
Message-ID: <6b79bab2-3679-4220-a98f-4e675fdc5226@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1324563305.2720.41.camel@br98xy6r>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, V Strivatsa <vatsa@linux.vnet.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, Crash-utility <crash-utility@redhat.com>



----- Original Message -----
> 
> Unfortunately Mahesh is currently not online. We still have some time
> because Martin's kernel patch that introduces the change will go into
> Linux version 3.3.
> 
> So perhaps you make your crash release without this patch.
> 
> Michael

Tell you what -- I'm going to make a hybrid patch, using Mahesh's
more understandable-yet-longer function, but with your verify_pfn()
and STRUCT_SIZE_INIT("mem_section") movement, along with a default
setting of 42 and a non-fatal WARNING message if things fail.
I'll verify it on RHEL5 and RHEL6.

If you want to change it later, that will be fine, too.

Thanks,
  Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
