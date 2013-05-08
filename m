Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ua6IV-0003ua-1R
 for kexec@lists.infradead.org; Wed, 08 May 2013 15:28:51 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 8 May 2013 16:25:23 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id A52161B0805D
 for <kexec@lists.infradead.org>; Wed,  8 May 2013 16:28:22 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r48FSCCn43516028
 for <kexec@lists.infradead.org>; Wed, 8 May 2013 15:28:12 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r48FSMK5010628
 for <kexec@lists.infradead.org>; Wed, 8 May 2013 11:28:22 -0400
Date: Wed, 8 May 2013 17:28:20 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] kdump: Allow ELF header creation in new kernel
Message-ID: <20130508172820.77075d23@holzheu>
In-Reply-To: <20130507163701.GA14403@redhat.com>
References: <1367845799-29125-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130507163701.GA14403@redhat.com>
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
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

Hello Vivek,

On Tue, 7 May 2013 12:37:01 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, May 06, 2013 at 03:09:55PM +0200, Michael Holzheu wrote:
> > Hello Vivek,
> > 
> > For s390 we want to use /proc/vmcore for our SCSI stand-alone
> > dump (zfcpdump). We have support where the first HSA_SIZE bytes are
> > saved into a hypervisor owned memory area (HSA) before the kdump
> > kernel is booted. When the kdump kernel starts, it is restricted
> > to use only HSA_SIZE bytes.
> > 
> 
> Hi Michael,
> 
> Hatayama is changing /proc/vmcore interface to support mmap(). Can you
> please rebase your changes on top of those patches.
> 
> http://thread.gmane.org/gmane.linux.kernel/1477622

Fine, we will do that.
 
> Secondly, I think /proc/vmcore does not have to know whether elf
> headers are in old memory or new memory. Given that s390 is taking
> a deviation, so it now becomes an arch specific detail. Can't we
> just create few arch specific helper functions to retrieve and free
> elf headers.
> 
> - arch_get_crash_headers()
> 	- All arch except return elfcorehdr_add except s390.
> - arch_read_crash_header_data()
> 	- All arch just call into read_from_oldmem() except s390. We
>   	  can provide a generic implementation in /proc/vmcore.c so
> 	  all other arch can use that generic implementation.  Or
> 	  use symbol override trick.
> - arch_free_crash_headers()
> 	- All arch do nothing except s390 which can reclaim the memory
>  	  for elf headers prepared. Generic code has parsed/copied
> the headers by now.
> 
> What do you think? Above 3 calls should solve the problem and allow
> arch to handle elf headers differently. And generic implementation
> still keeps common logic for processing headers.

Ok, we will try that. There might be a problem that our ELF notes
content is also in the new kernel memory. But also for that there be a
solution.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
