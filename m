Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UZkvA-0008WL-4A
 for kexec@lists.infradead.org; Tue, 07 May 2013 16:39:21 +0000
Date: Tue, 7 May 2013 12:37:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/4] kdump: Allow ELF header creation in new kernel
Message-ID: <20130507163701.GA14403@redhat.com>
References: <1367845799-29125-1-git-send-email-holzheu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1367845799-29125-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Mon, May 06, 2013 at 03:09:55PM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> For s390 we want to use /proc/vmcore for our SCSI stand-alone
> dump (zfcpdump). We have support where the first HSA_SIZE bytes are
> saved into a hypervisor owned memory area (HSA) before the kdump
> kernel is booted. When the kdump kernel starts, it is restricted
> to use only HSA_SIZE bytes.
> 

Hi Michael,

Hatayama is changing /proc/vmcore interface to support mmap(). Can you
please rebase your changes on top of those patches.

http://thread.gmane.org/gmane.linux.kernel/1477622

Secondly, I think /proc/vmcore does not have to know whether elf
headers are in old memory or new memory. Given that s390 is taking
a deviation, so it now becomes an arch specific detail. Can't we
just create few arch specific helper functions to retrieve and free
elf headers.

- arch_get_crash_headers()
	- All arch except return elfcorehdr_add except s390.
- arch_read_crash_header_data()
	- All arch just call into read_from_oldmem() except s390. We
  	  can provide a generic implementation in /proc/vmcore.c so
	  all other arch can use that generic implementation.  Or
	  use symbol override trick.
- arch_free_crash_headers()
	- All arch do nothing except s390 which can reclaim the memory
 	  for elf headers prepared. Generic code has parsed/copied the
	  headers by now.

What do you think? Above 3 calls should solve the problem and allow
arch to handle elf headers differently. And generic implementation
still keeps common logic for processing headers.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
